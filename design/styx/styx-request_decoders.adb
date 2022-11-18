with Ada.Text_IO;
with League.Strings;
with Interfaces;

with Styx.Messages.Attaches;
with Styx.Messages.Authes;
with Styx.Messages.Clunks;
with Styx.Messages.Opens;
with Styx.Messages.Reads;
with Styx.Messages.Stats;
with Styx.Messages.Versions;
with Styx.Messages.Walks;

package body Styx.Request_Decoders is

   ------------
   -- Decode --
   ------------

   procedure Decode
     (Self    : Decoder;
      Stream  : access Ada.Streams.Root_Stream_Type'Class;
      Command : out Styx.Messages.Request_Access;
      Success : out Boolean)
   is
      procedure Get_String
        (Value : out League.Strings.Universal_String;
         Ok    : out Boolean);

      ----------------
      -- Get_String --
      ----------------

      procedure Get_String
        (Value : out League.Strings.Universal_String;
         Ok    : out Boolean)
      is
         use type Ada.Streams.Stream_Element_Count;

         Length : Ada.Streams.Stream_Element_Count;
      begin
         Styx.Messages.Byte_Count'Read
           (Stream, Styx.Messages.Byte_Count (Length));

         if Length > 20 then
            Ok := False;
            return;
         elsif Length = 0 then
            Value.Clear;
            Ok := True;
            return;
         end if;

         declare
            Data : Ada.Streams.Stream_Element_Array (1 .. Length);
         begin
            Ada.Streams.Read (Stream.all, Data, Length);
            if Length /= Data'Last then
               Ok := False;
               return;
            end if;

            Value := Self.UTF_8.Decode (Data);
            Ok := True;
         exception
            when Constraint_Error =>
               Ok := False;
         end;
      end Get_String;

      Ok           : Boolean;
      Size         : Styx.Messages.Size;
      Message_Type : Ada.Streams.Stream_Element;
      Tag          : Styx.Messages.Message_Tag;
   begin
      Styx.Messages.Size'Read (Stream, Size);
      Ada.Streams.Stream_Element'Read (Stream, Message_Type);
      Styx.Messages.Message_Tag'Read (Stream, Tag);

      case Message_Type is
         when 100 =>
            declare
               C : constant Styx.Messages.Versions.Version_Request_Access :=
                 new Styx.Messages.Versions.Version_Request;
            begin
               C.Tag := Tag;
               Styx.Messages.Size'Read (Stream, C.MSize);
               Get_String (C.Version, Ok);
               Command := Styx.Messages.Request_Access (C);
               Success := Ok;
            end;

         when 102 =>
            declare
               C : constant Styx.Messages.Authes.Auth_Request_Access :=
                 new Styx.Messages.Authes.Auth_Request;
            begin
               C.Tag := Tag;
               Styx.Messages.FID'Read (Stream, C.Auth_FID);
               Get_String (C.User, Ok);

               if Ok then
                  Get_String (C.Tree, Ok);
               end if;

               Command := Styx.Messages.Request_Access (C);
               Success := Ok;
            end;

         when 104 =>
            declare
               C : constant Styx.Messages.Attaches.Attach_Request_Access :=
                 new Styx.Messages.Attaches.Attach_Request;
            begin
               C.Tag := Tag;
               Styx.Messages.FID'Read (Stream, C.FID);
               Styx.Messages.FID'Read (Stream, C.Auth_FID);
               Get_String (C.User, Ok);

               if Ok then
                  Get_String (C.Tree, Ok);
               end if;

               Command := Styx.Messages.Request_Access (C);
               Success := Ok;
            end;

         when 110 =>
            declare
               C : constant Styx.Messages.Walks.Walk_Request_Access :=
                 new Styx.Messages.WalkS.Walk_Request;
               Count : Styx.Messages.Byte_Count;
               Value : League.Strings.Universal_String;
            begin
               Ok := True;
               C.Tag := Tag;
               Styx.Messages.FID'Read (Stream, C.FID);
               Styx.Messages.FID'Read (Stream, C.New_FID);
               Styx.Messages.Byte_Count'Read (Stream, Count);
               for J in 1 .. Count loop
                  Get_String (Value, Ok);
                  exit when not Ok;
                  C.Names.Append (Value);
               end loop;

               Command := Styx.Messages.Request_Access (C);
               Success := Ok;
            end;

         when 112 =>
            declare
               use type Interfaces.Unsigned_8;
               C : constant Styx.Messages.Opens.Open_Request_Access :=
                 new Styx.Messages.Opens.Open_Request;
               Mode : Interfaces.Unsigned_8;
            begin
               C.Tag := Tag;
               Styx.Messages.FID'Read (Stream, C.FID);
               Interfaces.Unsigned_8'Read (Stream, Mode);
               C.Remove_On_Close := (Mode and 16#40#) /= 0;
               C.Trunc := (Mode and 16#10#) /= 0;
               C.Mode := Styx.Messages.Opens.Open_Mode'Val (Mode and 16#03#);
               Command := Styx.Messages.Request_Access (C);
               Success := True;
            end;

         when 116 =>
            declare
               C : constant Styx.Messages.Reads.Read_Request_Access :=
                 new Styx.Messages.Reads.Read_Request;
            begin
               C.Tag := Tag;
               Styx.Messages.FID'Read (Stream, C.FID);
               Interfaces.Unsigned_64'Read (Stream, C.Offset);
               Styx.Messages.Size'Read (Stream, C.Count);
               Command := Styx.Messages.Request_Access (C);
               Success := True;
            end;

         when 120 =>
            declare
               C : constant Styx.Messages.Clunks.Clunk_Request_Access :=
                 new Styx.Messages.ClunkS.Clunk_Request;
            begin
               C.Tag := Tag;
               Styx.Messages.FID'Read (Stream, C.FID);

               Command := Styx.Messages.Request_Access (C);
               Success := True;
            end;

         when 124 =>
            declare
               C : constant Styx.Messages.Stats.Stat_Request_Access :=
                 new Styx.Messages.Stats.Stat_Request;
            begin
               C.Tag := Tag;
               Styx.Messages.FID'Read (Stream, C.FID);

               Command := Styx.Messages.Request_Access (C);
               Success := True;
            end;

         when others =>
            Ada.Text_IO.Put_Line ("Message_Type:" & Message_Type'Img);
            Success := False;
      end case;
   end Decode;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Self : in out Decoder) is
   begin
      Self.UTF_8 := new League.Text_Codecs.Text_Codec'
        (League.Text_Codecs.Codec
           (League.Strings.To_Universal_String ("utf-8")));
   end Initialize;

end Styx.Request_Decoders;
