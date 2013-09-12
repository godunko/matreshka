------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               XML Processor                              --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2013, Vadim Godunko <vgodunko@gmail.com>                     --
-- All rights reserved.                                                     --
--                                                                          --
-- Redistribution and use in source and binary forms, with or without       --
-- modification, are permitted provided that the following conditions       --
-- are met:                                                                 --
--                                                                          --
--  * Redistributions of source code must retain the above copyright        --
--    notice, this list of conditions and the following disclaimer.         --
--                                                                          --
--  * Redistributions in binary form must reproduce the above copyright     --
--    notice, this list of conditions and the following disclaimer in the   --
--    documentation and/or other materials provided with the distribution.  --
--                                                                          --
--  * Neither the name of the Vadim Godunko, IE nor the names of its        --
--    contributors may be used to endorse or promote products derived from  --
--    this software without specific prior written permission.              --
--                                                                          --
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS      --
-- "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT        --
-- LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    --
-- A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT     --
-- HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,   --
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED --
-- TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR   --
-- PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF   --
-- LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING     --
-- NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS       --
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.             --
--                                                                          --
------------------------------------------------------------------------------
--  $Revision: 3559 $ $Date: 2012-12-07 13:08:31 +0200 (Пт., 07 дек. 2012) $
------------------------------------------------------------------------------

with Ada.Text_IO;
with Ada.Strings.Wide_Wide_Fixed;
with Ada.Strings.Wide_Wide_Maps;
with Ada.Strings.Wide_Wide_Unbounded;
with League.Strings;

with XML.SAX.Input_Sources.Streams.Files;
with XML.SAX.Simple_Readers;

with XML.Schema.Model_Groups;
with XML.Schema.Objects.Particles;
with XML.Schema.Objects.Terms.Model_Groups;
with XML.Schema.Object_Lists;
with XML.Schema.Complex_Type_Definitions;
with XML.Schema.Simple_Type_Definitions;
with XML.Schema.Element_Declarations;
with XML.Schema.Objects.Type_Definitions.Complex_Type_Definitions;
use XML.Schema.Objects.Type_Definitions.Complex_Type_Definitions;

with XSD_To_Ada.Mappings;
with XSD_To_Ada.Mappings_XML;
with League.String_Vectors;
with XML.Schema.Named_Maps;

with XML.Schema.Models;
with XML.Schema.Objects;
with XSD_To_Ada.Writers;
use XSD_To_Ada.Writers;

package body XSD_To_Ada.Utils is

   function Add_Separator
     (Text : Wide_Wide_String) return Wide_Wide_String
   is
      subtype Upper_Char_List  is Wide_Wide_Character range 'A' .. 'Z';
      subtype Lower_Char_List is Wide_Wide_Character range 'a' .. 'z';

      US_Text    : League.Strings.Universal_String;
      Uper_Count : Natural := 0;
   begin

      if Text = "" then
         return "Add_Separator ERROR";
--         raise Constraint_Error with "Add_Separator ERROR";
      end if;

      US_Text.Append (Text (Text'First));

      for J in 2 .. Text'Length - 1 loop
         if Text (J + 1) in Upper_Char_List then
            Uper_Count := Uper_Count + 1;
         end if;

         if Text (J) in Lower_Char_List
             and then Text (J + 1) in Upper_Char_List
         then
            US_Text.Append (Text (J));
            US_Text.Append ('_');
            Uper_Count := 0;
         elsif Uper_Count > 1
                and then Text (J) in Upper_Char_List
                and then Text (J + 2) in Lower_Char_List
         then
            US_Text.Append (Text (J));
            US_Text.Append ('_');
            Uper_Count := 0;
         else
            US_Text.Append (Text (J));
         end if;
      end loop;

      US_Text.Append (Text (Text'Last));
--      Ada.Text_IO.Put_Line (US_Text.To_UTF_8_String);
      return US_Text.To_Wide_Wide_String;

   end Add_Separator;

   procedure Create_Simple_Type
     (Model  : XML.Schema.Models.XS_Model;
      Writer : in out XSD_To_Ada.Writers.Writer)
   is
      Namespace : constant League.Strings.Universal_String
        := League.Strings.To_Universal_String
          ("http://www.actforex.com/iats");

      XS_Object : XML.Schema.Objects.XS_Object;
      STD       : XML.Schema.Simple_Type_Definitions.XS_Simple_Type_Definition;
      XS_Base   : XML.Schema.Type_Definitions.XS_Type_Definition;
      Type_D    : XML.Schema.Type_Definitions.XS_Type_Definition;

      Simple_Types : constant XML.Schema.Named_Maps.XS_Named_Map :=
        Model.Get_Components_By_Namespace
          (Object_Type => XML.Schema.Simple_Type,
           Namespace   => Namespace);

   begin
      for J in 1 .. Simple_Types.Length loop
         XS_Object := Simple_Types.Item (J);
         Type_D    := XS_Object.To_Type_Definition;
         XS_Base   := Type_D.Get_Base_Type;

         STD := XS_Object.To_Simple_Type_Definition;

         declare
            List : constant League.String_Vectors.Universal_String_Vector
              := STD.Get_Lexical_Enumeration;
         begin

            if List.Is_Empty then
               XSD_To_Ada.Writers.P
                 (Writer,
                  "type " &
                    XSD_To_Ada.Utils.Add_Separator
                    (XS_Object.Get_Name.To_Wide_Wide_String) & " is new "
                  & XSD_To_Ada.Utils.Add_Separator
                    (XS_Base.Get_Name.To_Wide_Wide_String)
                  & ";" & Wide_Wide_Character'Val (10));
            else
               XSD_To_Ada.Writers.N
                 (Writer,
                  "type " &
                    XSD_To_Ada.Utils.Add_Separator
                    (XS_Object.Get_Name.To_Wide_Wide_String) & " is (");

               for J in 1 .. List.Length loop
                  Ada.Text_IO.Put (" Enum: ");
                  Ada.Text_IO.Put_Line (List.Element (J).To_UTF_8_String);

                  if J /= List.Length then
                     XSD_To_Ada.Writers.N
                       (Writer,
                        League.Strings.To_Lowercase
                          (List.Element (J)).To_Wide_Wide_String & ", ");
                  else
                     XSD_To_Ada.Writers.N
                       (Writer,
                        League.Strings.To_Lowercase
                          (List.Element (J)).To_Wide_Wide_String);
                  end if;

               end loop;
               XSD_To_Ada.Writers.P (Writer, ");");
               XSD_To_Ada.Writers.P (Writer);
            end if;
         end;
      end loop;
   end Create_Simple_Type;

   procedure Create_Complex_Type (Model  : XML.Schema.Models.XS_Model)
   is
      Namespace : constant League.Strings.Universal_String
        := League.Strings.To_Universal_String
          ("http://www.actforex.com/iats");

      XS_Object : XML.Schema.Objects.XS_Object;
      XS_Object_2 : XML.Schema.Objects.XS_Object;
      Type_D    : XML.Schema.Type_Definitions.XS_Type_Definition;

      CTD : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;

      Complex_Types : constant XML.Schema.Named_Maps.XS_Named_Map :=
        Model.Get_Components_By_Namespace
          (Object_Type => XML.Schema.Complex_Type,
           Namespace   => Namespace);

      Payload_Writer          : XSD_To_Ada.Writers.Writer;
      Payload_Type_Writer     : XSD_To_Ada.Writers.Writer;

      US_Response : League.Strings.Universal_String;

      maxOccurs : Boolean := False;
      Is_Vector  : Boolean := False;

      Current_Out_File : Ada.Text_IO.File_Type;

      procedure Print_Type_Definition
        (Type_D : XML.Schema.Type_Definitions.XS_Type_Definition;
         Vector_Type : in out Boolean;
         Name : Wide_Wide_String);

      ---------------------------
      -- Print_Type_Definition --
      ---------------------------

      procedure Print_Type_Definition
        (Type_D : XML.Schema.Type_Definitions.XS_Type_Definition;
         Vector_Type : in out Boolean;
         Name : Wide_Wide_String)
      is
         use type XML.Schema.Type_Definitions.XS_Type_Definition;

         XS_Particle    : XML.Schema.Objects.Particles.XS_Particle;
         XS_Term        : XML.Schema.Objects.Terms.XS_Term;
         CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;

         procedure Print_Term
           (XS_Term : XML.Schema.Objects.Terms.XS_Term;
            Has_Max_Occurs  : in out Boolean;
            Name : Wide_Wide_String);

         procedure Print_Term
           (XS_Term : XML.Schema.Objects.Terms.XS_Term;
            Has_Max_Occurs  : in out Boolean;
            Name : Wide_Wide_String)
         is
            use type XML.Schema.Objects.Terms.Model_Groups.Compositor_Kinds;

            XS_Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
            XS_List        : XML.Schema.Object_Lists.XS_Object_List;
            XS_Particle    : XML.Schema.Objects.Particles.XS_Particle;
            Decl : XML.Schema.Element_Declarations.XS_Element_Declaration;
         begin

            if XS_Term.Is_Model_Group then
               XS_Model_Group := XS_Term.To_Model_Group;
               XS_List := XS_Model_Group.Get_Particles;

               Has_Max_Occurs := False;

               for J in 1 .. XS_List.Get_Length loop
                  XS_Particle := XS_List.Item (J).To_Particle;

                  if XS_Particle.Get_Max_Occurs.Unbounded then
                     Has_Max_Occurs := True;
                  else
                     if XS_Particle.Get_Max_Occurs.Value > 1 then
                        Has_Max_Occurs := True;
                     end if;
                  end if;

                  Print_Term (XS_Particle.Get_Term, Has_Max_Occurs, Name);
               end loop;
            elsif XS_Term.Is_Element_Declaration then
               Decl   := XS_Term.To_Element_Declaration;

               Print_Type_Definition
                 (Decl.Get_Type_Definition, Has_Max_Occurs, Name);
            end if;
         end Print_Term;

      begin
         if Type_D.Get_Name.To_Wide_Wide_String = Name and Vector_Type then
            Is_Vector := True;
         end if;

         case Type_D.Get_Type_Category is
            when XML.Schema.Complex_Type =>
               CTD := Type_D.To_Complex_Type_Definition;

               if CTD.Get_Content_Type in Element_Only | Mixed then
                  XS_Particle := CTD.Get_Particle;
                  XS_Term := XS_Particle.Get_Term;

                  Print_Term (XS_Term, maxOccurs, Name);
               end if;
            when XML.Schema.Simple_Type | XML.Schema.None =>
               null;
         end case;
      end Print_Type_Definition;
   begin

      Writers.P
        (Payload_Writer,
         Wide_Wide_Character'Val (10)
         & "with Ada.Containers;"
         & Wide_Wide_Character'Val (10)
         & "with League.Strings;"
         & Wide_Wide_Character'Val (10)
         & "with Ada.Containers.Vectors;"
         & Wide_Wide_Character'Val (10)
         & "with Ada.Strings.Unbounded;"
         & Wide_Wide_Character'Val (10) & Wide_Wide_Character'Val (10)
         & "package Payload is"
         & Wide_Wide_Character'Val (10) & Wide_Wide_Character'Val (10)
         & "   subtype Seconds_Since_Midnight is Natural range 0 .. 86_400;"
         & Wide_Wide_Character'Val (10) & Wide_Wide_Character'Val (10)
         & "   type Decimal_String is new Ada.Strings.Unbounded.Unbounded_String;"
         & Wide_Wide_Character'Val (10)
         & "   Null_Decimal : constant Decimal_String :="
         & Wide_Wide_Character'Val (10)
         & "     Decimal_String (Ada.Strings.Unbounded.Null_Unbounded_String);"
         & Wide_Wide_Character'Val (10) & Wide_Wide_Character'Val (10)
         & "   type Rate_String is new Ada.Strings.Unbounded.Unbounded_String;"
         & Wide_Wide_Character'Val (10)
         & "   Null_Rate : constant Rate_String :="
         & Wide_Wide_Character'Val (10)
         & "     Rate_String (Ada.Strings.Unbounded.Null_Unbounded_String);"
         & Wide_Wide_Character'Val (10) & Wide_Wide_Character'Val (10));

      Map :=
        XSD_To_Ada.Utils.Read_Mapping
          (League.Strings.To_Universal_String ("./mapping.xml"));

      for J in 1 .. Complex_Types.Length loop
         Types_Table (J).Table_Name := Complex_Types.Item (J).Get_Name;
         Types_Table (J).Table_State := True;
      end loop;

      for J in 1 .. Complex_Types.Length loop
         XS_Object := Complex_Types.Item (J);

         Print_Type_Title
           (XS_Object.To_Type_Definition,
            Payload_Writer,
            Payload_Type_Writer);
      end loop;

      Ada.Text_IO.Create
        (Current_Out_File, Ada.Text_IO.Out_File, "./Payload.ads");
      Ada.Text_IO.Put_Line
        (Current_Out_File, Payload_Type_Writer.Text.To_UTF_8_String);
      Ada.Text_IO.Put_Line
        (Current_Out_File, Payload_Writer.Text.To_UTF_8_String);
      Ada.Text_IO.Close (Current_Out_File);
   end Create_Complex_Type;

   ---------------
   -- Find_Type --
   ---------------

   function Find_Type
     (Type_D_Name : League.Strings.Universal_String;
      Map         : XSD_To_Ada.Mappings_XML.Mapping_XML)
      return League.Strings.Universal_String
   is
   begin
      for j in 1 .. Map.Map_Vector.Length loop
         if Type_D_Name.To_UTF_8_String =
           Map.Map_Vector.Element (J).To_UTF_8_String
         then
            return Map.Ada_Vector.Element (J);
         end if;
      end loop;

      return League.Strings.To_Universal_String
        (XSD_To_Ada.Utils.Add_Separator
           (Type_D_Name.To_Wide_Wide_String));
   end Find_Type;

   ---------------------
   -- Gen_Access_Type --
   ---------------------

   procedure Gen_Access_Type
     (Self   : in out XSD_To_Ada.Writers.Writer;
      Name   : Wide_Wide_String) is
   begin
      Writers.N
        (Self,
         "   type " & Name & "_Access is access all "
         & Wide_Wide_Character'Val (10)
         & "      " & Name & "'Class;");
   end Gen_Access_Type;

   ----------------
   --  Gen_Line  --
   ----------------

   procedure Gen_Line
     (Self : in out XSD_To_Ada.Writers.Writer; Str : Wide_Wide_String := "") is
      use Ada.Strings.Wide_Wide_Unbounded;
      use Ada.Strings.Wide_Wide_Maps;

      Set : constant Wide_Wide_Character_Set := "or"
        (To_Set (Span => ('(', '(')),
         "or" (To_Set (Span => ('.', '.')), To_Set (Span => (' ', ' '))));

      S   : Unbounded_Wide_Wide_String := To_Unbounded_Wide_Wide_String (Str);
      L   : Natural;
      Tab : constant Wide_Wide_String
        (1 .. Index_Non_Blank (S) + 2) := (others => ' ');

      In_Comment : Boolean := False;

      procedure Put (Txt : Wide_Wide_String);

      ---------
      -- Put --
      ---------

      procedure Put (Txt : Wide_Wide_String) is
         use Ada.Strings.Wide_Wide_Fixed;
      begin
         if In_Comment then
            Self.P (Tab (Tab'First .. Tab'Last - 2) & "--  " & Txt
                    (Index_Non_Blank (Txt) .. Txt'Last));
         else
            In_Comment := Index (Txt, "--") >= 1;
            Self.P (Txt);
         end if;
      end Put;

   begin
      if Length (S) > 79 then
         loop
            L := Index
              (S, Set, Positive'Min (79, Length (S)),
               Ada.Strings.Inside, Ada.Strings.Backward);
            exit when L < 1;

            if Element (S, L) = '.'
              and then L + 3 <= Length (S)
              and then Slice (S, L + 1, L + 3) = "all"
            then
               L := Index
                 (S, Set, L - 1, Ada.Strings.Inside, Ada.Strings.Backward);
               exit when L < 1;
            end if;

            if Element (S, L) = ' ' then
               Put (Slice
                    (S, 1, Index_Non_Blank (S, L - 1, Ada.Strings.Backward)));

            elsif Element (S, L) = '(' then
               L := L - 1;
               Put
                 (Slice
                    (S, 1, Index_Non_Blank (S, L, Ada.Strings.Backward)));

            else
               Put (Slice (S, 1, L));
            end if;

            S := To_Unbounded_Wide_Wide_String
                  (Tab & Slice (S, L + 1, Length (S)));
            exit when Length (S) < 80;
         end loop;

         if S /= Null_Unbounded_Wide_Wide_String then
            Put (To_Wide_Wide_String (S));
         end if;

      else
         Self.P (To_Wide_Wide_String (S));
      end if;
   end Gen_Line;

   ---------------------
   -- Gen_Proc_Header --
   ---------------------

   procedure Gen_Proc_Header
     (Self   : in out XSD_To_Ada.Writers.Writer;
      Name   : Wide_Wide_String;
      Offset : Positive := 3)
   is
      D : constant Wide_Wide_String (1 .. Name'Length + 6) := (others => '-');
      O : constant Wide_Wide_String (1 .. Offset) := (others => ' ');
   begin

      if D'Length > 76 then
         return;
      end if;

      Gen_Line (Self, O & D);
      Gen_Line (Self, O & "-- " & Name & " --");
      Gen_Line (Self, O & D);
      Gen_Line (Self);
   end Gen_Proc_Header;

   --------------
   -- New_Line --
   --------------

   procedure New_Line (Self : in out XSD_To_Ada.Writers.Writer) is
   begin
      Self.P ("");
   end New_Line;

   ----------------------
   -- Print_Type_Title --
   ----------------------

   procedure Print_Type_Title
     (Type_D              : XML.Schema.Type_Definitions.XS_Type_Definition;
      Writer      : in out XSD_To_Ada.Writers.Writer;
      Type_Writer : in out XSD_To_Ada.Writers.Writer)
   is
      Is_Record   : Boolean := False;

      US_Response : League.Strings.Universal_String;

      Payload_Writer      : XSD_To_Ada.Writers.Writer;
      Payload_Type_Writer : XSD_To_Ada.Writers.Writer;
   begin

      Ada.Text_IO.Put_Line ("START Print_Type_Title");

      for J in 1 .. Types_Table'Last loop
         if Type_D.Get_Name.To_UTF_8_String = Types_Table (J).Table_Name.To_UTF_8_String
           and then Types_Table (J).Table_State
         then

            Types_Table (J).Table_State := False;

            if Type_D.Get_Name.Length > 10 then
               US_Response := League.Strings.Slice
                 (Type_D.Get_Name,
                  Type_D.Get_Name.Length - 7,
                  Type_D.Get_Name.Length);
            end if;

            if Type_D.Get_Name.Length > 10
              and
                US_Response.To_UTF_8_String = "Response"
            then
               XSD_To_Ada.Utils.Gen_Proc_Header
                 (Payload_Writer,
                  XSD_To_Ada.Utils.Add_Separator
                    (Type_D.Get_Name.To_Wide_Wide_String));

               Writers.P
                 (Payload_Writer,
                  "   type "
                  & XSD_To_Ada.Utils.Add_Separator
                    (Type_D.Get_Name.To_Wide_Wide_String)
                  & " is new Abstract_IATS_Responce with"
                  & Wide_Wide_Character'Val (10)
                  & "     record");

               XSD_To_Ada.Utils.Print_Type_Definition
                 (Type_D,
                  "",
                  Payload_Writer, Payload_Type_Writer,
                  Type_D.Get_Name,
                  False,
                  Map,
                  Types_Table);

               Writers.P
                 (Payload_Writer, "     end record;"
                  & Wide_Wide_Character'Val (10));

               XSD_To_Ada.Utils.Gen_Access_Type
                 (Payload_Writer,
                  XSD_To_Ada.Utils.Add_Separator
                    (Type_D.Get_Name.To_Wide_Wide_String));
               US_Response.Clear;
            else
               XSD_To_Ada.Utils.Print_Type_Session
                 (Type_D.To_Type_Definition, "", Session_Bool);

               if Session_Bool then
                  XSD_To_Ada.Utils.Gen_Proc_Header
                    (Payload_Writer,
                     XSD_To_Ada.Utils.Add_Separator
                       (Type_D.Get_Name.To_Wide_Wide_String));

                  Writers.P
                    (Payload_Writer,
                     "   type "
                     & XSD_To_Ada.Utils.Add_Separator
                       (Type_D.Get_Name.To_Wide_Wide_String)
                     & " is new Abstract_IATS_Responce"
                     & Wide_Wide_Character'Val (10)
                     & "   with record");

                  XSD_To_Ada.Utils.Print_Type_Definition
                    (Type_D,
                     "",
                     Payload_Writer, Payload_Type_Writer,
                     Type_D.Get_Name, False, Map,
                     Types_Table);

                  Writers.P (Payload_Writer, "   end record;");
               else
                  Is_Record := True;

                  Writers.N
                    (Payload_Writer,
                     "   type "
                     & XSD_To_Ada.Utils.Add_Separator
                       (Type_D.Get_Name.To_Wide_Wide_String) & " ");

                  XSD_To_Ada.Utils.Print_Type_Definition
                    (Type_D.To_Type_Definition,
                     "",
                     Payload_Writer, Payload_Type_Writer,
                     Type_D.Get_Name,
                     Is_Record,
                     Map,
                     Types_Table);

                  Writers.P (Payload_Writer, "   end record;");

--                 maxOccurs := False;
--
--                 for J in 1 .. Complex_Types.Length loop
--                    XS_Object_2 := Complex_Types.Item (J);
--
--                    Print_Type_Definition
--                      (XS_Object_2.To_Type_Definition,
--                       maxOccurs,
--                       XS_Object.Get_Name.To_Wide_Wide_String);
--                 end loop;
--
--                 if Is_Vector then
--                    Writers.P
--                      (NON_Session_Writer,
--                       "   package "
--                       & XSD_To_Ada.Utils.Add_Separator
--                         (XS_Object.Get_Name.To_Wide_Wide_String)
--                       & "s_Vectors is "
--                       & Wide_Wide_Character'Val (10)
--                       & "     new Ada.Containers.Vectors (Positive, "
--                       & XSD_To_Ada.Utils.Add_Separator
--                         (XS_Object.Get_Name.To_Wide_Wide_String)
--                       & ");");
--                    Writers.P (NON_Session_Writer);
--
--                    Writers.P
--                      (NON_Session_Writer,
--                       "   subtype "
--                       & XSD_To_Ada.Utils.Add_Separator
--                         (XS_Object.Get_Name.To_Wide_Wide_String) & "s is "
--                       & XSD_To_Ada.Utils.Add_Separator
--                         (XS_Object.Get_Name.To_Wide_Wide_String)
--                       & "s_Vectors.Vector;");
--                    Writers.P (NON_Session_Writer);
--                 end if;
--                 Is_Vector := False;
--                 Is_Record := False;
              end if;
            end if;

            Writer.P (Payload_Type_Writer.Text);
            Writer.P (Payload_Writer.Text);
         end if;
         Session_Bool := False;
         US_Response.Clear;
         end loop;

      Ada.Text_IO.Put_Line ("END Print_Type_Title");
   end Print_Type_Title;

   ---------------------------
   -- Print_Type_Definition --
   ---------------------------

   procedure Print_Type_Definition
     (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
      Indent       : String := "";
      Writer       : in out Writers.Writer;
      Writer_types : in out Writers.Writer;
      Name         : League.Strings.Universal_String;
      Is_Record    : Boolean := False;
      Map          : XSD_To_Ada.Mappings_XML.Mapping_XML;
      Table        : in out Types_Table_Type_Array)
   is
      use type XML.Schema.Type_Definitions.XS_Type_Definition;

      XS_Particle    : XML.Schema.Objects.Particles.XS_Particle;
      XS_Term        : XML.Schema.Objects.Terms.XS_Term;
      XS_Base        : XML.Schema.Type_Definitions.XS_Type_Definition;

      CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;
      STD  : XML.Schema.Simple_Type_Definitions.XS_Simple_Type_Definition;

      Choice : Natural := 0;
      Now_Add : Boolean := False;
      Add_Choise : Boolean := False;
      Add_Anonym : Boolean := False;

      Anonym_Type : Boolean := False;

      Name_Kind   : League.Strings.Universal_String;
      Name_Case   : League.Strings.Universal_String;
      Anonym_Kind : League.Strings.Universal_String;
      Vectop_US   : League.Strings.Universal_String;

      ----------------
      -- Print_Term --
      ----------------

      procedure Print_Term
        (XS_Term      : XML.Schema.Objects.Terms.XS_Term;
         Indent       : String := "";
         Writer       : in out Writers.Writer;
         Writer_types : in out Writers.Writer;
         Name         : League.Strings.Universal_String;
         Map          : XSD_To_Ada.Mappings_XML.Mapping_XML;
         Table        : in out Types_Table_Type_Array)
      is
         use type XML.Schema.Objects.Terms.Model_Groups.Compositor_Kinds;

         XS_Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
         XS_List        : XML.Schema.Object_Lists.XS_Object_List;
         XS_Particle    : XML.Schema.Objects.Particles.XS_Particle;
         Decl           : XML.Schema.Element_Declarations.XS_Element_Declaration;

         Type_D         : XML.Schema.Type_Definitions.XS_Type_Definition;
         Type_Name : League.Strings.Universal_String;
      begin
         Ada.Text_IO.Put (Indent);
         Ada.Text_IO.Put_Line ("Type " & XS_Term.Get_Type'Img);
         Ada.Text_IO.Put (Indent);
         Ada.Text_IO.Put_Line ("XS_Term.Get_Name =" & XS_Term.Get_Name.To_UTF_8_String);

         if XS_Term.Is_Model_Group then
            XS_Model_Group := XS_Term.To_Model_Group;
            XS_List := XS_Model_Group.Get_Particles;
            Ada.Text_IO.Put (Indent);
            Ada.Text_IO.Put_Line (XS_Model_Group.Get_Compositor'Img);

            if XS_Model_Group.Get_Compositor =
              XML.Schema.Objects.Terms.Model_Groups.Compositor_Choice then
               Choice := 1;
            end if;

            if Anonym_Type and Choice = 0 then
               Writers.P
                 (Writer,
                  "      "
                  & XSD_To_Ada.Utils.Add_Separator
                    (Name.To_Wide_Wide_String) & " : "
                  & XSD_To_Ada.Utils.Add_Separator
                    (Name.To_Wide_Wide_String) & "_Anonym;");

               Anonym_Kind.Append
                 ("   type "
                  & XSD_To_Ada.Utils.Add_Separator
                    (Name.To_Wide_Wide_String) & "_Anonym is record"
                  & Wide_Wide_Character'Val (10));
               Add_Anonym := True;
            end if;

            if Choice = 1 and not Now_Add then

               Name_Kind.Append
                 ("   type "
                  & XSD_To_Ada.Utils.Add_Separator
                    (Name.To_Wide_Wide_String) & "_Kind is "
                  & Wide_Wide_Character'Val (10) &  "     (");

               Name_Case.Append
                 ("   type "
                  & XSD_To_Ada.Utils.Add_Separator
                    (Name.To_Wide_Wide_String) & "_Case "
                  & Wide_Wide_Character'Val (10)
                  & "     (Kind : "
                  & XSD_To_Ada.Utils.Add_Separator
                    (Name.To_Wide_Wide_String) & "_Kind "
                    & Wide_Wide_Character'Val (10)
                  & "      := "
                  & XSD_To_Ada.Utils.Add_Separator
                      (Name.To_Wide_Wide_String)
                  & "_Kind'First) is record"
                  & Wide_Wide_Character'Val (10)
                  & "      case Kind is"
                  & Wide_Wide_Character'Val (10));

               Writers.P
                 (Writer,
                  "      "
                  & XSD_To_Ada.Utils.Add_Separator
                    (Name.To_Wide_Wide_String) & " : "
                  & XSD_To_Ada.Utils.Add_Separator
                    (Name.To_Wide_Wide_String) & "_Case;");

               Now_Add := True;
               Add_Choise := True;
            end if;

            for J in 1 .. XS_List.Get_Length loop
               Ada.Text_IO.Put (Indent);
               XS_Particle := XS_List.Item (J).To_Particle;

               Print_Term
                 (XS_Particle.Get_Term,
                  Indent & "   ", Writer, Writer_types, Name, Map,
                  Table);

               if J /=  XS_List.Get_Length and Choice = 1 then
                  Name_Kind.Append
                    (", " & Wide_Wide_Character'Val (10) & "      ") ;
               end if;
            end loop;

            Choice := 0;

         elsif XS_Term.Is_Element_Declaration then
            Decl := XS_Term.To_Element_Declaration;
            Type_D := Decl.Get_Type_Definition;

            Type_Name := Find_Type (Type_D.Get_Name, Map);

            if Type_D.Get_Name.To_UTF_8_String = "" then
               Anonym_Type := True;
               Print_Type_Definition
                 (Type_D, Indent & "   ", Writer, Writer_types,
                  League.Strings.To_Universal_String
                    (Name.To_Wide_Wide_String & "_" & Decl.Get_Name.To_Wide_Wide_String),
                  False,
                  Map,
                  Table);

               Anonym_Type := False;
               Add_Anonym := False;
            end if;

            if Choice = 1 then

               for j in 1 .. Table'Last loop
                  if Type_D.Get_Name.To_Wide_Wide_String =
                    Table (J).Table_Name.To_Wide_Wide_String
                    and Table (J).Table_State
                  then
                     XSD_To_Ada.Utils.Print_Type_Title
                       (Type_D,
                        Writer_types,
                        Writer_types);
                     exit;
                  end if;
               end loop;

               Name_Kind.Append
                 (League.Strings.To_Universal_String
                    (XSD_To_Ada.Utils.Add_Separator
                       (XS_Term.Get_Name.To_Wide_Wide_String)));
               Name_Case.Append
                 ("        when "
                  & XSD_To_Ada.Utils.Add_Separator
                    (XS_Term.Get_Name.To_Wide_Wide_String) & " =>"
                  & Wide_Wide_Character'Val (10)
                  & "           "
                  & XSD_To_Ada.Utils.Add_Separator
                    (XS_Term.Get_Name.To_Wide_Wide_String)
                  & " : "
                  & Type_Name.To_Wide_Wide_String & ";"
                  & Wide_Wide_Character'Val (10));
            end if;

            if Type_D.Get_Name.To_UTF_8_String /= ""
              and not Anonym_Type
              and Choice = 0
            then
               case Type_D.Get_Type_Category is
               when XML.Schema.Complex_Type =>

                  for j in 1 .. Table'Last loop
                     if Type_Name.To_Wide_Wide_String =
                       XSD_To_Ada.Utils.Add_Separator
                         (Table (J).Table_Name.To_Wide_Wide_String)
                       and Table (J).Table_State
                     then
                        XSD_To_Ada.Utils.Print_Type_Title
                          (Type_D,
                           Writer_types,
                           Writer_types);
                        exit;
                     end if;
                  end loop;

                  Writers.P
                    (Writer,
                     "      "
                     & XSD_To_Ada.Utils.Add_Separator
                       (XS_Term.Get_Name.To_Wide_Wide_String)
                     & " : Payload."
                     & Type_Name.To_Wide_Wide_String & ";");
               when XML.Schema.Simple_Type =>
                  Writers.P
                    (Writer,
                     "      "
                     & XSD_To_Ada.Utils.Add_Separator
                       (XS_Term.Get_Name.To_Wide_Wide_String)
                     & " : "
                     & Type_Name.To_Wide_Wide_String & ";");
               when XML.Schema.None =>
                  Ada.Text_IO.Put_Line (Indent & "NONE!!!");
               end case;
            end if;

            if Anonym_Type and Choice = 0 then
               case Type_D.Get_Type_Category is
               when XML.Schema.Complex_Type =>

                  for j in 1 .. Table'Last loop
                     if Type_Name.To_Wide_Wide_String =
                       XSD_To_Ada.Utils.Add_Separator
                         (Table (J).Table_Name.To_Wide_Wide_String)
                       and Table (J).Table_State
                     then
                        XSD_To_Ada.Utils.Print_Type_Title
                          (Type_D,
                           Writer_types,
                           Writer_types);
                        exit;
                     end if;
                  end loop;

                  Anonym_Kind.Append
                    ("      "
                     & XSD_To_Ada.Utils.Add_Separator
                       (XS_Term.Get_Name.To_Wide_Wide_String)
                     & " : Payload."
                     & Type_Name.To_Wide_Wide_String & ";"
                     & Wide_Wide_Character'Val (10));

               when XML.Schema.Simple_Type =>
                  Anonym_Kind.Append
                    ("      "
                     & XSD_To_Ada.Utils.Add_Separator
                       (XS_Term.Get_Name.To_Wide_Wide_String) & " : "
                     & Type_Name.To_Wide_Wide_String & ";"
                     & Wide_Wide_Character'Val (10));

               when XML.Schema.None =>
                  Ada.Text_IO.Put_Line (Indent & "NONE!!!");
               end case;
            end if;
         end if;
      end Print_Term;

   begin
      XS_Base := Type_D.Get_Base_Type;
      if Is_Record then
         Writers.P (Writer, " is record");
      end if;

      case Type_D.Get_Type_Category is
         when XML.Schema.Complex_Type =>
            CTD := Type_D.To_Complex_Type_Definition;

            if CTD.Get_Content_Type in Element_Only | Mixed then
               Ada.Text_IO.Put_Line
                 (Indent & "Complex_Type " & Type_D.Get_Name.To_UTF_8_String);
               XS_Particle := CTD.Get_Particle;
               XS_Term := XS_Particle.Get_Term;

               Print_Term
                 (XS_Term, Indent & "   ", Writer, Writer_types, Name, Map,
                  Table);

             Ada.Text_IO.Put_Line (Indent & "End Complex_Type");
            end if;

         when XML.Schema.Simple_Type =>
            Ada.Text_IO.Put
              (Indent & "Simple_Type : " & Type_D.Get_Name.To_UTF_8_String);
            STD := Type_D.To_Simple_Type_Definition;

         when XML.Schema.None =>
            Ada.Text_IO.Put_Line (Indent & "NONE!!!");
      end case;

      if XS_Base.Get_Type_Category in
        XML.Schema.Complex_Type .. XML.Schema.Simple_Type
        and XS_Base /= Type_D  --  This is to filter predefined types
      then
         Ada.Text_IO.Put_Line (Indent & " is new");
         Print_Type_Definition
           (XS_Base,
            Indent & "   ",
            Writer, Writer_types, Name, False, Map,
            Table);
      end if;

      if Add_Choise then
         Writers.P
           (Writer_types,
            Name_Kind.To_Wide_Wide_String &  ");"
            & Wide_Wide_Character'Val (10));

         Writers.P
           (Writer_types,
            Name_Case.To_Wide_Wide_String
            & "      end case;" & Wide_Wide_Character'Val (10)
            & "   end record;");

         Name_Kind.Clear;
         Name_Case.Clear;
         Now_Add := False;
         Add_Choise := False;
      end if;

      if Add_Anonym then
      Writers.P
           (Writer_types,
            Anonym_Kind.To_Wide_Wide_String
            & "   end record;"
            & Wide_Wide_Character'Val (10));
         Anonym_Kind.Clear;
      end if;
      Choice := 0;
   end Print_Type_Definition;

   -------------------
   -- Print_Type_Session --
   -------------------

   procedure Print_Type_Session
     (Type_D : XML.Schema.Type_Definitions.XS_Type_Definition;
      Indent : String := "";
      Session : in out Boolean)
   is
      pragma Unreferenced (Indent);
      use type XML.Schema.Type_Definitions.XS_Type_Definition;

      XS_Particle    : XML.Schema.Objects.Particles.XS_Particle;
      XS_Term        : XML.Schema.Objects.Terms.XS_Term;
      XS_Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
      XS_List        : XML.Schema.Object_Lists.XS_Object_List;

      Decl : XML.Schema.Element_Declarations.XS_Element_Declaration;
      CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;
      STD  : XML.Schema.Simple_Type_Definitions.XS_Simple_Type_Definition;
   begin
      case Type_D.Get_Type_Category is
         when XML.Schema.Complex_Type =>
            CTD := Type_D.To_Complex_Type_Definition;

            if CTD.Get_Content_Type in Element_Only | Mixed then
               XS_Particle    := CTD.Get_Particle;
               XS_Term        := XS_Particle.Get_Term;
               XS_Model_Group := XS_Term.To_Model_Group;
               XS_List        := XS_Model_Group.Get_Particles;

               for J in 1 .. XS_List.Get_Length loop
                  XS_Particle := XS_List.Item (J).To_Particle;
                  XS_Term := XS_Particle.Get_Term;
                  Decl := XS_Term.To_Element_Declaration;

                  if Decl.Get_Name.To_UTF_8_String = "Session" then
                     Session := True;
                  end if;

                  Print_Type_Session
                    (Decl.Get_Type_Definition, "", Session_Bool);
               end loop;
            end if;

         when XML.Schema.Simple_Type =>
            STD := Type_D.To_Simple_Type_Definition;

         when XML.Schema.None =>
            null;
      end case;
   end Print_Type_Session;

   ----------------
   -- Put_Header --
   ----------------

   procedure Put_Header (Self : in out XSD_To_Ada.Writers.Writer) is
      Lin : constant Wide_Wide_String (1 .. 77) := (others => '-');
   begin
      Self.P (Lin);
      Self.P ("--  Copyright © 2013 ACTForex, Inc.");
      Self.P ("--  All rights reserved.");
      Self.P (Lin);
      Self.P
        ("--  This file is generated by pipe_api_generator, don't edit it.");
      Self.P (Lin);
      Self.P ("");
   end Put_Header;

   function Read_Mapping
     (File_Name : League.Strings.Universal_String)
      return XSD_To_Ada.Mappings_XML.Mapping_XML
   is
      Source  : aliased XML.SAX.Input_Sources.Streams.Files.File_Input_Source;
      Reader  : aliased XML.SAX.Simple_Readers.SAX_Simple_Reader;
      Handler : aliased XSD_To_Ada.Mappings_XML.Mapping_XML;
   begin
      Reader.Set_Content_Handler (Handler'Unchecked_Access);
      Source.Open_By_File_Name (File_Name);
      Reader.Parse (Source'Access);
      return Handler;
   end Read_Mapping;

end XSD_To_Ada.Utils;
