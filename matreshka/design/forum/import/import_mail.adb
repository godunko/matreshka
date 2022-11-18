with Ada.Containers.Hashed_Maps;
with Ada.Streams.Stream_IO;
with Ada.Wide_Wide_Text_IO;

with Interfaces;

with GNAT.OS_Lib;

with League.Application;
with League.Base_Codecs;
with League.Calendars.ISO_8601;
with League.Characters.Latin;
with League.Holders;
with League.JSON.Documents;
with League.JSON.Objects;
with League.JSON.Values;
with League.Stream_Element_Vectors;
with League.Strings.Internals;
with League.Strings;
with League.Strings.Hash;
with League.String_Vectors;
with League.Text_Codecs;

with XML.SAX.Attributes;
with XML.SAX.Content_Handlers;
with XML.SAX.Input_Sources.Streams.Files;
with XML.SAX.Simple_Readers;

with SQL.Options;
with SQL.Databases;
with SQL.Queries;

with Matreshka.Internals.SQL_Drivers.PostgreSQL.Factory;

with Matreshka.Internals.Strings;
with Matreshka.Internals.Text_Codecs;
with Matreshka.Internals.Unicode;

with OPM.Stores;
with AWFC.Accounts.Users.Stores;

with Forum.Topics.References;
with Forum.Forums;
with Forum.Categories.References;
with Forum.Posts.References;

with HTML_Handlers;

procedure Import_Mail is

   function "+"
     (Text : Wide_Wide_String) return League.Strings.Universal_String
      renames League.Strings.To_Universal_String;

   function "**"
     (Left, Right : League.Strings.Universal_String) return Boolean;
   --  Case insensetive comparison operator

   function Read_File
     (Name : League.Strings.Universal_String)
      return League.Strings.Universal_String;

   function Unpack_JSON
     (Text : League.Strings.Universal_String)
      return League.Strings.Universal_String;

   function Unpack_JSON
     (Text : League.Strings.Universal_String;
      Key  : Wide_Wide_String)
      return League.Strings.Universal_String;

   function Unescape_XML_Entities
     (Text : League.Strings.Universal_String)
      return League.Strings.Universal_String;

   function Strinp_Carriage_Return
     (Text : League.Strings.Universal_String)
      return League.Strings.Universal_String;

   function Decode_Quoted_Printable
     (Encoding : League.Strings.Universal_String;
      Piece    : League.Strings.Universal_String)
            return League.Strings.Universal_String;

   function Format_HTML
     (Text : League.Strings.Universal_String)
      return League.Strings.Universal_String;

   function Replace_Placeholders
     (Text : League.Strings.Universal_String)
      return League.Strings.Universal_String;

   Placeholder : constant Wide_Wide_Character :=
     Wide_Wide_Character'Val (16#FFFD#);

   ----------
   -- "**" --
   ----------

   function "**"
     (Left, Right : League.Strings.Universal_String) return Boolean
   is
      use type League.Strings.Universal_String;
   begin
      return Left.To_Lowercase = Right.To_Lowercase;
   end "**";

   -----------------------------
   -- Decode_Quoted_Printable --
   -----------------------------

   function Decode_Quoted_Printable
     (Encoding : League.Strings.Universal_String;
      Piece    : League.Strings.Universal_String)
            return League.Strings.Universal_String
   is
      use type League.Characters.Universal_Character;

      Codec : constant League.Text_Codecs.Text_Codec :=
        League.Text_Codecs.Codec (Encoding);

      Bytes : League.Stream_Element_Vectors.Stream_Element_Vector;
      Index : Positive := 1;
      Item  : Ada.Streams.Stream_Element;
   begin
      while Index <= Piece.Length loop
         case Piece.Element (Index).To_Wide_Wide_Character is
            when '=' =>
               if Piece.Element (Index + 1) = League.Characters.Latin.Line_Feed
                 or else Piece.Element (Index + 1) =
                            League.Characters.Latin.Carriage_Return
               then
                  Index := Index + 2;
               else
                  Item := Ada.Streams.Stream_Element'Wide_Wide_Value
                    ("16#"
                     & Piece.Slice
                       (Index + 1, Index + 2).To_Wide_Wide_String
                     & "#");

                  Bytes.Append (Item);
                  Index := Index + 3;
               end if;
            when '_' =>
               Item := 16#20#;
               Bytes.Append (Item);
               Index := Index + 1;

            when others =>
               Item := Wide_Wide_Character'Pos
                 (Piece.Element (Index).To_Wide_Wide_Character);

               Bytes.Append (Item);
               Index := Index + 1;
         end case;

      end loop;

      return Codec.Decode (Bytes);
   end Decode_Quoted_Printable;

   -----------------
   -- Format_HTML --
   -----------------

   function Format_HTML
     (Text : League.Strings.Universal_String)
      return League.Strings.Universal_String
   is

      Output : Ada.Wide_Wide_Text_IO.File_Type;
      Arg_0  : aliased String := "--dropdtd";
      Arg_1  : aliased String := "--html";
      Arg_2  : aliased String := "--xmlout";
      Arg_3  : aliased String := "--output";
      Arg_4  : aliased String := "/tmp/msg.xml";
      Arg_5  : aliased String := "/tmp/msg.html";
      Args   : constant GNAT.OS_Lib.String_List :=
        (Arg_0'Unchecked_Access,
         Arg_1'Unchecked_Access,
         Arg_2'Unchecked_Access,
         Arg_3'Unchecked_Access,
         Arg_4'Unchecked_Access,
         Arg_5'Unchecked_Access);
      Ok : Boolean;

      Source  : aliased HTML_Handlers.My_Source;
      Reader  : aliased XML.SAX.Simple_Readers.Simple_Reader;
      Handler : aliased HTML_Handlers.HTML_Handler;

   begin
      Ada.Wide_Wide_Text_IO.Create
        (File => Output,
         Name => Arg_5,
         Form => "WCEM=8");
      Ada.Wide_Wide_Text_IO.Put_Line (Output, Text.To_Wide_Wide_String);
      Ada.Wide_Wide_Text_IO.Close (Output);

      GNAT.OS_Lib.Spawn ("/usr/bin/xmllint", Args, Ok);

      pragma Assert (Ok);

      Reader.Set_Content_Handler (Handler'Unchecked_Access);

      Source.Open_By_File_Name (League.Strings.From_UTF_8_String (Arg_4));
      Reader.Parse (Source'Access);

      return Handler.Result;
   end Format_HTML;

   ---------------
   -- Read_File --
   ---------------

   function Read_File
     (Name : League.Strings.Universal_String)
      return League.Strings.Universal_String
   is
      use Interfaces;
      use type Matreshka.Internals.Unicode.Code_Point;

      Buffer  : Ada.Streams.Stream_Element_Array (1 .. 1024);
      Last    : Ada.Streams.Stream_Element_Offset;
      File    : Ada.Streams.Stream_IO.File_Type;
      Data    : Matreshka.Internals.Strings.Shared_String_Access
        := Matreshka.Internals.Strings.Shared_Empty'Access;
      Factory : constant Matreshka.Internals.Text_Codecs.Decoder_Factory
        := Matreshka.Internals.Text_Codecs.Decoder
          (Matreshka.Internals.Text_Codecs.MIB_UTF8);
      Decoder : Matreshka.Internals.Text_Codecs.Abstract_Decoder'Class
        := Factory (Matreshka.Internals.Text_Codecs.Raw);

   begin
      Ada.Streams.Stream_IO.Open
        (File, Ada.Streams.Stream_IO.In_File, Name.To_UTF_8_String);

      while not Ada.Streams.Stream_IO.End_Of_File (File) loop
         Ada.Streams.Stream_IO.Read (File, Buffer, Last);
         Decoder.Decode_Append (Buffer (Buffer'First .. Last), Data);
      end loop;

      Ada.Streams.Stream_IO.Close (File);

      if Decoder.Is_Error then
         Matreshka.Internals.Strings.Dereference (Data);

         raise Constraint_Error with "mailformed UTF-8 file";
      end if;

      return League.Strings.Internals.Wrap (Data);
   end Read_File;

   --------------------------
   -- Replace_Placeholders --
   --------------------------

   function Replace_Placeholders
     (Text : League.Strings.Universal_String)
      return League.Strings.Universal_String
   is
      function Get_Next_Char return Wide_Wide_Character;
      procedure Open_Input;

      Index : Positive := 1;
      Input : League.Strings.Universal_String;

      -------------------
      -- Get_Next_Char --
      -------------------

      function Get_Next_Char return Wide_Wide_Character is
         Result : Wide_Wide_Character;
      begin
         while Index <= Input.Length loop
            Result := Input (Index).To_Wide_Wide_Character;
            Index := Index + 1;

            exit when Wide_Wide_Character'Pos (Result) > 127;
         end loop;

         return Result;
      end Get_Next_Char;

      ----------------
      -- Open_Input --
      ----------------

      procedure Open_Input is
         Text : constant League.Strings.Universal_String :=
           Read_File (League.Application.Arguments.Element (2));
      begin
         Input := Unpack_JSON (Text, "messageBody");
      end Open_Input;

      Result : League.Strings.Universal_String;
      Char   : Wide_Wide_Character;
   begin
      if Text.Index (Placeholder) = 0 then
         return Text;
      end if;

      Open_Input;

      for J in 1 .. Text.Length loop
         Char := Text.Element (J).To_Wide_Wide_Character;

         if Wide_Wide_Character'Pos (Char) <= 127 then
            Result.Append (Char);
         elsif Char = Placeholder then
            Result.Append (Get_Next_Char);
         else
            Result.Append (Get_Next_Char);
            Result.Append (Get_Next_Char);
         end if;

      end loop;

      return Result;
   end Replace_Placeholders;

   ----------------------------
   -- Strinp_Carriage_Return --
   ----------------------------

   function Strinp_Carriage_Return
     (Text : League.Strings.Universal_String)
      return League.Strings.Universal_String
   is
      List   : constant League.String_Vectors.Universal_String_Vector :=
        Text.Split (League.Characters.Latin.Carriage_Return);
   begin
      return List.Join ("");
   end Strinp_Carriage_Return;

   ---------------------------
   -- Unescape_XML_Entities --
   ---------------------------

   function Unescape_XML_Entities
     (Text : League.Strings.Universal_String)
      return League.Strings.Universal_String
   is
      Result : League.Strings.Universal_String;
      List   : constant League.String_Vectors.Universal_String_Vector :=
        Text.Split ('&');
   begin
      for J in 1 .. List.Length loop
         declare
            Piece : constant League.Strings.Universal_String
              := List.Element (J);
         begin
            if Piece.Starts_With ("lt;") then
               Result.Append ("<");
               Result.Append (Piece.Slice (4, Piece.Length));
            elsif Piece.Starts_With ("gt;") then
               Result.Append (">");
               Result.Append (Piece.Slice (4, Piece.Length));
            elsif Piece.Starts_With ("quot;") then
               Result.Append ("""");
               Result.Append (Piece.Slice (6, Piece.Length));
            elsif Piece.Starts_With ("#39;") then
               Result.Append ("'");
               Result.Append (Piece.Slice (5, Piece.Length));
            else
               Result.Append ("&");
               Result.Append (Piece);
            end if;
         end;
      end loop;

      return Result;
   end Unescape_XML_Entities;

   -----------------
   -- Unpack_JSON --
   -----------------

   function Unpack_JSON
     (Text : League.Strings.Universal_String;
      Key  : Wide_Wide_String)
      return League.Strings.Universal_String
   is
      D : constant League.JSON.Documents.JSON_Document :=
        League.JSON.Documents.From_JSON (Text);
      O : constant League.JSON.Objects.JSON_Object := D.To_JSON_Object;
      V : constant League.JSON.Values.JSON_Value := O.Value
        (League.Strings.To_Universal_String ("ygData"));
      V2 : constant League.JSON.Values.JSON_Value := V.To_Object.Value
        (League.Strings.To_Universal_String (Key));
   begin
      return V2.To_String;
   end Unpack_JSON;

   -----------------
   -- Unpack_JSON --
   -----------------

   function Unpack_JSON
     (Text : League.Strings.Universal_String)
      return League.Strings.Universal_String
   is
      --  https://groups.yahoo.com/api/v1/groups/ada_ru/messages/7320/raw
   begin
      return Unpack_JSON (Text, "rawEmail");
   end Unpack_JSON;

   package Messages is
      type Message is tagged private;

      type Message_Array is array (Positive range <>) of Message;

      function Read_Message
        (Text : League.Strings.Universal_String) return Message;

      function Header
        (Self : Message;
         Name : League.Strings.Universal_String)
         return League.Strings.Universal_String;
      --  Only first header is returned if there are more then one with
      --  given name

      function Header
        (Self  : Message;
         Name  : League.Strings.Universal_String;
         Field : League.Strings.Universal_String)
         return League.Strings.Universal_String;
      --  The same but return only one field of header

      function Get_Body_As_Text
        (Self : Message) return League.Strings.Universal_String;

      function Nested_Parts
        (Self     : Message;
         Boundary : League.Strings.Universal_String)
         return Message_Array;

      function Decode_Base64_Body
        (Self     : Message)
         return League.Stream_Element_Vectors.Stream_Element_Vector;

   private
      package Maps is new Ada.Containers.Hashed_Maps
        (Key_Type        => League.Strings.Universal_String,
         Element_Type    => League.Strings.Universal_String,
         Hash            => League.Strings.Hash,
         Equivalent_Keys => League.Strings."=",
         "="             => League.Strings."=");

      type Message is tagged record
         Headers : Maps.Map;
         Text    : League.Strings.Universal_String;
      end record;

   end Messages;

   package Mails is
      type Mail is tagged record
         From        : League.Strings.Universal_String;
         Date        : League.Calendars.Date_Time;
         In_Reply_To : League.Strings.Universal_String;
         Message_Id  : League.Strings.Universal_String;
         Subject     : League.Strings.Universal_String;
         Text        : League.Strings.Universal_String;
      end record;

      function Read_Mail (Text : League.Strings.Universal_String) return Mail;
   end Mails;

   package body Mails is

      function To_Date
        (Text : League.Strings.Universal_String)
         return League.Calendars.Date_Time;

      ---------------
      -- Read_Mail --
      ---------------

      function Read_Mail
        (Text : League.Strings.Universal_String) return Mail
      is
         use type League.Strings.Universal_String;

         Text_HTML : constant League.Strings.Universal_String :=
           +"text/html";
         Text_Plain : constant League.Strings.Universal_String :=
           +"text/plain";
         Multipart_Alternative : constant League.Strings.Universal_String :=
           +"multipart/alternative";
         Multipart_Mixed : constant League.Strings.Universal_String :=
           +"multipart/mixed";
         Multipart_Related : constant League.Strings.Universal_String :=
           +"multipart/related";
         Content_Type : constant League.Strings.Universal_String :=
           +"Content-Type";
         Content_Transfer_Encoding : constant League.Strings.Universal_String
           := +"Content-Transfer-Encoding";
         Base_64 : constant League.Strings.Universal_String := +"base64";
         Seven_Bit : constant League.Strings.Universal_String := +"7bit";
         Eight_Bit : constant League.Strings.Universal_String := +"8bit";
         Quoted_Printable : constant League.Strings.Universal_String :=
           +"quoted-printable";

         Root    : constant Messages.Message := Messages.Read_Message (Text);
         CT      : constant League.Strings.Universal_String :=
           Root.Header (Content_Type, +"");
         CTE      : constant League.Strings.Universal_String :=
           Root.Header (Content_Transfer_Encoding);
         Charset : constant League.Strings.Universal_String :=
           Root.Header (Content_Type, +"charset");
         Result  : Mail;
      begin
         Result.From := Root.Header (+"From");
         Result.Date := To_Date (Root.Header (+"Date"));
         Result.In_Reply_To := Root.Header (+"In-Reply-To");
         Result.Message_Id := Root.Header (+"Message-ID");
         Result.Subject := Root.Header (+"Subject");

         if Result.In_Reply_To.Is_Empty then
            declare
               List : constant League.String_Vectors.Universal_String_Vector :=
                 Root.Header (+"References").Split (' ');
            begin
               if List.Length > 0 then
                  Result.In_Reply_To := List.Element (1);
               end if;
            end;
         end if;

         if CT ** Text_Plain or CT.Is_Empty then
            if CTE = Base_64 then
               declare
                  Codec : constant League.Text_Codecs.Text_Codec :=
                    League.Text_Codecs.Codec (Charset);
                  Bytes : constant League.Stream_Element_Vectors
                    .Stream_Element_Vector
                      := Root.Decode_Base64_Body;
               begin
                  Result.Text := Codec.Decode (Bytes);
               end;
            elsif CTE ** Quoted_Printable then
               Result.Text :=
                 Decode_Quoted_Printable (Charset, Root.Get_Body_As_Text);

            elsif CTE = Seven_Bit then
               Result.Text := Root.Get_Body_As_Text;

            elsif CTE.Is_Empty or else CTE ** Eight_Bit then
               Result.Text := Root.Get_Body_As_Text;
               --  Bogus encoding in yahoo
               Result.Text := Replace_Placeholders (Result.Text);
            else
               raise Constraint_Error
                 with "Unknown CTE " & CTE.To_UTF_8_String;
            end if;
         elsif CT = Multipart_Alternative
           or else CT ** Multipart_Mixed
           or else CT = Multipart_Related
         then
            declare
               Boundary : constant League.Strings.Universal_String :=
                 Root.Header (+"Content-Type", +"boundary");
               Parts : constant Messages.Message_Array
                 := Root.Nested_Parts (Boundary);
            begin
               for J in Parts'Range loop
                  if Parts (J).Header (Content_Type, +"") = Text_Plain then
                     declare
                        CTE : constant League.Strings.Universal_String :=
                          Parts (J).Header (Content_Transfer_Encoding);
                        Charset : League.Strings.Universal_String :=
                          Parts (J).Header (Content_Type, +"charset");
                     begin
                        if Charset.Is_Empty then
                           Charset.Append ("utf-8");
                        end if;

                        if CTE = Eight_Bit
                          or else CTE = Seven_Bit
                          or else CTE.Is_Empty
                        then
                           --  Bogus encoding in yahoo
                           Result.Text.Append (Parts (J).Get_Body_As_Text);

                        elsif CTE = Base_64 then
                           declare
                              Codec : constant League.Text_Codecs.Text_Codec :=
                                League.Text_Codecs.Codec (Charset);
                              Bytes : constant League.Stream_Element_Vectors
                                .Stream_Element_Vector
                                  := Parts (J).Decode_Base64_Body;
                           begin
                              Result.Text.Append
                                (Strinp_Carriage_Return
                                   (Codec.Decode (Bytes)));
                           end;
                        elsif CTE = Quoted_Printable then
                           Result.Text.Append
                             (Strinp_Carriage_Return
                                (Decode_Quoted_Printable
                                     (Charset, Parts (J).Get_Body_As_Text)));

                        else
                           raise Constraint_Error with
                             "Unknown CTE: " & CTE.To_UTF_8_String;
                        end if;
                     end;
                  end if;
               end loop;
            end;
         elsif CT = Text_HTML then
            if CTE = Eight_Bit then
               Result.Text := Root.Get_Body_As_Text;
               --  Bogus encoding in yahoo
               Result.Text := Replace_Placeholders (Result.Text);
               Result.Text := Format_HTML (Result.Text);
            else
               raise Constraint_Error
                 with "Unknown CTE " & CTE.To_UTF_8_String;
            end if;
         else
            raise Constraint_Error with
              "Unknown Content-Type: " & CT.To_UTF_8_String;
         end if;

         return Result;
      end Read_Mail;

      -------------
      -- To_Date --
      -------------

      function To_Date
        (Text : League.Strings.Universal_String)
         return League.Calendars.Date_Time
      is
         use League.Calendars.ISO_8601;
         use type League.Calendars.Date_Time;

         Month_List : constant League.Strings.Universal_String
           := +"  JanFebMarAprMayJunJulAugSepNovOctDec";

         List : League.String_Vectors.Universal_String_Vector :=
           Text.Split (' ');

         Result         : League.Calendars.Date_Time;
         Time_Zone_Sign : Wide_Wide_Character;
         Time_Zone_Hour : Hour_Number;
         Time_Zone_Min  : Minute_Number;
         Time_Zone_Off  : League.Calendars.Time;
         Year           : Year_Number;
         Month          : Month_Number;
         Day            : Day_Number;
         Hour           : Hour_Number;
         Minute         : Minute_Number;
         Second         : Second_Number;
      begin
         --  Text example: Fri, 14 Jun 2002 12:52:22 +0300

         if List.Length = 5 then  -- Absent day of week
            List.Insert (1, League.Strings.Empty_Universal_String);
         end if;

         Year := Year_Number'Wide_Wide_Value
           (List.Element (4).To_Wide_Wide_String);

         Month := Month_Number (Month_List.Index (List.Element (3)) / 3);

         Day := Day_Number'Wide_Wide_Value
           (List.Element (2).To_Wide_Wide_String);

         Time_Zone_Hour := Hour_Number'Wide_Wide_Value
           (List.Element (6).Slice (2, 3).To_Wide_Wide_String);

         Time_Zone_Min := Minute_Number'Wide_Wide_Value
           (List.Element (6).Tail_From (4).To_Wide_Wide_String);

         Time_Zone_Sign := List.Element (6) (1).To_Wide_Wide_Character;

         List := List.Element (5).Split (':');

         Hour := Hour_Number'Wide_Wide_Value
           (List.Element (1).To_Wide_Wide_String);

         Minute := Minute_Number'Wide_Wide_Value
           (List.Element (2).To_Wide_Wide_String);

         Second := Second_Number'Wide_Wide_Value
           (List.Element (3).To_Wide_Wide_String);

         Time_Zone_Off :=
           Create (Year, Month, Day, Time_Zone_Hour, Time_Zone_Min, 0, 0)
           - Create (Year, Month, Day, 0, 0, 0, 0);

         Result := Create (Year, Month, Day, Hour, Minute, Second, 0);

         if Time_Zone_Sign = '+' then
            Result := Result - Time_Zone_Off;
         else
            Result := Result - Time_Zone_Off;
         end if;

         return Result;
      end To_Date;
   end Mails;

   package body Messages is

      function Decode_Header
        (Text : League.Strings.Universal_String)
         return League.Strings.Universal_String;

      ------------------------
      -- Decode_Base64_Body --
      ------------------------

      function Decode_Base64_Body
        (Self     : Message)
         return League.Stream_Element_Vectors.Stream_Element_Vector
      is
         List : constant League.String_Vectors.Universal_String_Vector :=
           Self.Text.Split (League.Characters.Latin.Line_Feed);
      begin
         return League.Base_Codecs.From_Base_64 (List.Join (""));
      end Decode_Base64_Body;

      -------------------
      -- Decode_Header --
      -------------------

      function Decode_Header
        (Text : League.Strings.Universal_String)
         return League.Strings.Universal_String
      is
         function Decode_B
           (Encoding : League.Strings.Universal_String;
            Piece    : League.Strings.Universal_String)
            return League.Strings.Universal_String;

         --------------
         -- Decode_B --
         --------------

         function Decode_B
           (Encoding : League.Strings.Universal_String;
            Piece    : League.Strings.Universal_String)
            return League.Strings.Universal_String
         is
            Codec : constant League.Text_Codecs.Text_Codec :=
              League.Text_Codecs.Codec (Encoding);
            Bytes : constant League.Stream_Element_Vectors
              .Stream_Element_Vector
                := League.Base_Codecs.From_Base_64 (Piece);
         begin
            return Codec.Decode (Bytes);
         end Decode_B;

         Start    : constant League.Strings.Universal_String := +"=?";
         Stop     : constant League.Strings.Universal_String := +"?=";
         Result   : League.Strings.Universal_String;
         Next     : Positive := 1;
         Pos      : Natural;
         Encoding : League.Strings.Universal_String;
      begin
         loop
            Pos := Text.Index (Next, Start);
            exit when Pos = 0;

            Result.Append (Text.Slice (Next, Pos - 1));
            Next := Text.Index (Pos + 2, "?");
            Encoding := Text.Slice (Pos + 2, Next - 1);
            Pos := Text.Index (Next + 3, Stop);

            if Text (Next + 1).To_Wide_Wide_Character in 'b' | 'B' then
               Result.Append
                 (Decode_B (Encoding, Text.Slice (Next + 3, Pos - 1)));
            elsif Text (Next + 1).To_Wide_Wide_Character in 'q' | 'Q' then
               Result.Append
                 (Decode_Quoted_Printable
                    (Encoding, Text.Slice (Next + 3, Pos - 1)));
            else
               raise Constraint_Error with "Unknown header encoding";
            end if;

            Next := Pos + 2;
         end loop;

         Result.Append (Text.Slice (Next, Text.Length));

         return Result;
      end Decode_Header;

      ----------------------
      -- Get_Body_As_Text --
      ----------------------

      function Get_Body_As_Text
        (Self : Message) return League.Strings.Universal_String is
      begin
         return Self.Text;
      end Get_Body_As_Text;

      function Header
        (Self : Message;
         Name : League.Strings.Universal_String)
         return League.Strings.Universal_String
      is
         Found : constant Maps.Cursor := Self.Headers.Find (Name.To_Lowercase);
      begin
         if Maps.Has_Element (Found) then
            return Maps.Element (Found);
         else
            return League.Strings.Empty_Universal_String;
         end if;
      end Header;

      ------------
      -- Header --
      ------------

      function Header
        (Self  : Message;
         Name  : League.Strings.Universal_String;
         Field : League.Strings.Universal_String)
         return League.Strings.Universal_String
      is
         function Dequote (Text : League.Strings.Universal_String)
           return League.Strings.Universal_String;

         function Trim (Text : League.Strings.Universal_String)
           return League.Strings.Universal_String;

         -------------
         -- Dequote --
         -------------

         function Dequote (Text : League.Strings.Universal_String)
           return League.Strings.Universal_String is
         begin
            if Text.Starts_With ("""") and Text.Ends_With ("""") then
               return Text.Slice (2, Text.Length - 1);
            else
               return Text;
            end if;
         end Dequote;

         ----------
         -- Trim --
         ----------

         function Trim (Text : League.Strings.Universal_String)
           return League.Strings.Universal_String
         is
            Result : League.Strings.Universal_String := Text;
         begin
            while Result.Ends_With (" ") loop
               Result := Result.Head (Result.Length - 1);
            end loop;

            return Result;
         end Trim;

         Key   : League.Strings.Universal_String := Field;
         Value : constant League.Strings.Universal_String
           := Self.Header (Name);
         List  : constant League.String_Vectors.Universal_String_Vector :=
           Value.Split (';');
      begin
         if Value.Is_Empty then
            return Value;
         end if;

         Key.Append ("=");

         for J in 1 .. List.Length loop
            declare
               Line : League.Strings.Universal_String := List.Element (J);
            begin
               while Line.Starts_With (" ") loop
                  Line := Line.Tail_From (2);
               end loop;

               if Field.Is_Empty and Line.Index ("=") = 0 then
                  return Line;
               elsif not Field.Is_Empty and Line.Starts_With (Key) then
                  return Trim (Dequote (Line.Tail_From (Key.Length + 1)));
               end if;
            end;
         end loop;

         return League.Strings.Empty_Universal_String;
      end Header;

      ------------------
      -- Nested_Parts --
      ------------------

      function Nested_Parts
        (Self     : Message;
         Boundary : League.Strings.Universal_String)
         return Message_Array
      is
         use type League.Strings.Universal_String;

         function Count_Nested_Parts return Natural;
         procedure Read
           (Msg  : out Message;
            Next : in out Positive);

         Stopper : constant League.Strings.Universal_String :=
           League.Characters.Latin.Line_Feed.To_Wide_Wide_Character
             & "--" & Boundary;
         Starter : constant League.Strings.Universal_String :=
           "--" & Boundary & League.Characters.Latin.Line_Feed;

         ------------------------
         -- Count_Nested_Parts --
         ------------------------

         function Count_Nested_Parts return Natural is
            Result : Natural := 0;
            Next   : Natural := 0;
         begin
            loop
               Next := Self.Text.Index (Next + 1, Starter);

               if Next = 0 then
                  exit;
               else
                  Result := Result + 1;
               end if;
            end loop;

            return Result;
         end Count_Nested_Parts;

         ----------
         -- Read --
         ----------

         procedure Read
           (Msg  : out Message;
            Next : in out Positive)
         is
            From : constant Positive :=
              Self.Text.Index (Next, Starter) + Starter.Length;
            To   : constant Positive := Self.Text.Index (From, Stopper);
         begin
            Msg := Read_Message (Self.Text.Slice (From, To));
            Next := To;
         end Read;

         Result : Message_Array (1 .. Count_Nested_Parts);
         Next   : Positive := 1;
      begin
         for J in Result'Range loop
            Read (Result (J), Next);
         end loop;

         return Result;
      end Nested_Parts;

      ------------------
      -- Read_Message --
      ------------------

      function Read_Message
        (Text : League.Strings.Universal_String) return Message
      is
         Tab    : constant Wide_Wide_String :=
           (1 => League.Characters.Latin.Character_Tabulation
            .To_Wide_Wide_Character);

         Result : Message;
         Name   : League.Strings.Universal_String;
         Value  : League.Strings.Universal_String;
         List   : constant League.String_Vectors.Universal_String_Vector :=
           Text.Split (League.Characters.Latin.Line_Feed);
      begin
         for J in 1 .. List.Length loop
            declare
               Line : constant League.Strings.Universal_String
                 := List.Element (J);
            begin
               if Line.Starts_With (" ")  --  Continuation of header
                 or else Line.Starts_With (Tab)
               then
                  Value.Append (Line.Slice (2, Line.Length));

                  goto Continue;
               elsif J > 1 and then not Result.Headers.Contains (Name) then
                  Value := Decode_Header (Value);
                  Result.Headers.Insert (Name, Value);
               end if;

               if Line.Is_Empty then
                  Result.Text := List.Slice (J + 1, List.Length).Join
                    (League.Characters.Latin.Line_Feed);

                  exit;
               end if;

               Name := Line.Head (Line.Index (':') - 1).To_Lowercase;
               Value := Line.Tail_From (Name.Length + 2);

               if Value.Starts_With (" ") then
                  Value := Value.Tail_From (2);
               end if;

               <<Continue>>
            end;
         end loop;

         return Result;
      end Read_Message;

   end Messages;

   package Storage is
      procedure Get_User
        (From : League.Strings.Universal_String;
         User : out AWFC.Accounts.Users.User_Access);

      procedure Get_Topic
        (In_Reply_To : League.Strings.Universal_String;
         Message_Id  : League.Strings.Universal_String;
         Date        : League.Calendars.Date_Time;
         Subject     : League.Strings.Universal_String;
         User        : AWFC.Accounts.Users.User_Access;
         Topic       : out Forum.Topics.References.Topic);

      procedure Put_Post
        (Topic : Forum.Topics.References.Topic;
         User  : AWFC.Accounts.Users.User_Access;
         Date  : League.Calendars.Date_Time;
         Text  : League.Strings.Universal_String);

   end Storage;

   -------------
   -- Storage --
   -------------

   package body Storage is

      F  : Forum.Forums.Forum;
      C  : Forum.Categories.References.Category;

      function Strip_User_Name
        (Name : League.Strings.Universal_String)
         return League.Strings.Universal_String;

      ---------------
      -- Get_Topic --
      ---------------

      procedure Get_Topic
        (In_Reply_To : League.Strings.Universal_String;
         Message_Id  : League.Strings.Universal_String;
         Date        : League.Calendars.Date_Time;
         Subject     : League.Strings.Universal_String;
         User        : AWFC.Accounts.Users.User_Access;
         Topic       : out Forum.Topics.References.Topic) is
      begin
         if In_Reply_To.Is_Empty then
            Topic := F.Create_Topic
              (User          => User,
               Category      => C,
               Title         => Subject,
               Description   => League.Strings.Empty_Universal_String,
               Creation_Time => Date);

         else
            declare
               Q : SQL.Queries.SQL_Query
                 := F.Engine.Get_Database.Query
                   (League.Strings.To_Universal_String
                      ("SELECT topic_identifier from import_topics WHERE "
                       & "message_id = :id"));

               Id    : Forum.Topics.Topic_Identifier;
               Found : Boolean;
            begin
               Q.Bind_Value
                 (League.Strings.To_Universal_String (":id"),
                  League.Holders.To_Holder (In_Reply_To));

               Q.Execute;

               if Q.Next then
                  Id := Forum.Topics.Topic_Identifier_Holders.Element
                    (Q.Value (1));

                  F.Get_Topic
                    (Category   => C.Identifier,
                     Identifier => Id,
                     Value      => Topic,
                     Found      => Found);

                  pragma Assert (Found);
               else
                  --  Fallback to Get_Topic with In_Reply_To = ""
                  Get_Topic
                    (User        => User,
                     In_Reply_To => League.Strings.Empty_Universal_String,
                     Message_Id  => Message_Id,
                     Date        => Date,
                     Subject     => Subject,
                     Topic       => Topic);

                  return;
               end if;
            end;
         end if;

         --  Save message-id to topic mapping in DB
         declare
            Q : SQL.Queries.SQL_Query
              := F.Engine.Get_Database.Query
                (League.Strings.To_Universal_String
                   ("INSERT INTO import_topics (message_id, topic_identifier)"
                    & " VALUES (:id, :topic)"));

         begin
            Q.Bind_Value
              (League.Strings.To_Universal_String (":id"),
               League.Holders.To_Holder (Message_Id));
            Q.Bind_Value
              (League.Strings.To_Universal_String (":topic"),
               Forum.Topics.Topic_Identifier_Holders.To_Holder
                 (Topic.Identifier));
            Q.Execute;
         end;
      end Get_Topic;

      --------------
      -- Get_User --
      --------------

      procedure Get_User
        (From : League.Strings.Universal_String;
         User : out AWFC.Accounts.Users.User_Access)
      is
         use type AWFC.Accounts.Users.User_Access;

         User_Store : AWFC.Accounts.Users.Stores.User_Store'Class
           renames AWFC.Accounts.Users.Stores.User_Store'Class
             (F.Engine.Get_Store
                (AWFC.Accounts.Users.User'Tag).all);

         Email : constant League.Strings.Universal_String :=
           Strip_User_Name (From);
      begin
         User := User_Store.Incarnate (Email);

         if User = null then
            User := User_Store.Create (Email);
         end if;
      end Get_User;

      --------------
      -- Put_Post --
      --------------

      procedure Put_Post
        (Topic : Forum.Topics.References.Topic;
         User  : AWFC.Accounts.Users.User_Access;
         Date  : League.Calendars.Date_Time;
         Text  : League.Strings.Universal_String)
      is
         Post : Forum.Posts.References.Post;
      begin
         Post := F.Create_Post
           (User          => User,
            Topic         => Topic,
            Text          => Text,
            Creation_Time => Date);
      end Put_Post;

      ---------------------
      -- Strip_User_Name --
      ---------------------

      function Strip_User_Name
        (Name : League.Strings.Universal_String)
         return League.Strings.Universal_String
      is
         From : constant Natural := Name.Index ("<");
         To   : constant Natural := Name.Index (">");
      begin
         if From > 0 and To > 0 then
            return Name.Slice (From + 1, To - 1);
         else
            return Name;
         end if;
      end Strip_User_Name;

      O     : SQL.Options.SQL_Options;
      Found : Boolean;
      Id    : Forum.Categories.Category_Identifier;
      Aux   : OPM.Stores.Store_Access;
   begin
      O.Set
        (League.Strings.To_Universal_String ("dbname"),
         League.Strings.To_Universal_String ("forum"));
      F.Initialize (League.Strings.To_Universal_String ("POSTGRESQL"), O);

      Aux := new AWFC.Accounts.Users.Stores.User_Store
        (F.Engine'Unchecked_Access);
      Aux.Initialize;

      Found := Forum.Categories.Decode (+"1", Id);
      F.Get_Category (Id, C, Found);
   end Storage;

   Value : League.Strings.Universal_String :=
     League.Application.Arguments.Element (1);

   type String_Convertor is access function
     (Text : League.Strings.Universal_String)
      return League.Strings.Universal_String;

   String_Convertors : constant array (Positive range <>) of String_Convertor
     := (Read_File'Access,
         Unpack_JSON'Access,
         Strinp_Carriage_Return'Access,
         Unescape_XML_Entities'Access);
begin
   for Conv of String_Convertors loop
      Value := Conv (Value);
   end loop;

   Ada.Wide_Wide_Text_IO.Put_Line (Value.To_Wide_Wide_String);

   declare
      Msg   : constant Mails.Mail := Mails.Read_Mail (Value);
      Topic : Forum.Topics.References.Topic;
      User  : AWFC.Accounts.Users.User_Access;
   begin
      Storage.Get_User
        (From => Msg.From,
         User => User);

      Storage.Get_Topic
        (User        => User,
         In_Reply_To => Msg.In_Reply_To,
         Message_Id  => Msg.Message_Id,
         Date        => Msg.Date,
         Subject     => Msg.Subject,
         Topic       => Topic);

      Storage.Put_Post
        (User  => User,
         Topic => Topic,
         Date  => Msg.Date,
         Text  => Msg.Text);

      Ada.Wide_Wide_Text_IO.Put_Line (Msg.Text.To_Wide_Wide_String);
   end;
end Import_Mail;
