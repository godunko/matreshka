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

with XML.Schema.Model_Groups;
with XML.Schema.Objects.Particles;
with XML.Schema.Objects.Terms.Model_Groups;
with XML.Schema.Object_Lists;
with XML.Schema.Complex_Type_Definitions;
with XML.Schema.Simple_Type_Definitions;
with XML.Schema.Element_Declarations;
with XML.Schema.Objects.Type_Definitions.Complex_Type_Definitions;
use XML.Schema.Objects.Type_Definitions.Complex_Type_Definitions;

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
         raise Constraint_Error with "Add_Separator ERROR";
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
      Ada.Text_IO.Put_Line (US_Text.To_UTF_8_String);
      return US_Text.To_Wide_Wide_String;

   end Add_Separator;

   ---------------------
   -- Gen_Access_Type --
   ---------------------

   procedure Gen_Access_Type
     (Self   : in out XSD_To_Ada.Writers.Writer;
      Name   : Wide_Wide_String;
      Offset : Positive := 3)
   is
      O : constant Wide_Wide_String (1 .. Offset) := (others => ' ');
   begin
      Gen_Line
        (Self, O & " type " & Name & "is access all " & Name & "'Class;");
      Gen_Line (Self);
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

   ---------------------------
   -- Print_Type_Definition --
   ---------------------------

   procedure Print_Type_Definition
     (Type_D : XML.Schema.Type_Definitions.XS_Type_Definition;
      Indent : String := "")
   is
      use type XML.Schema.Type_Definitions.XS_Type_Definition;
      use type XML.Schema.Objects.Terms.Model_Groups.Compositor_Kins;

      XS_Particle    : XML.Schema.Objects.Particles.XS_Particle;
      XS_Term        : XML.Schema.Objects.Terms.XS_Term;
      XS_Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
      XS_List        : XML.Schema.Object_Lists.XS_Object_List;
      XS_Base        : XML.Schema.Type_Definitions.XS_Type_Definition;

      Decl : XML.Schema.Element_Declarations.XS_Element_Declaration;
      CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;
      STD  : XML.Schema.Simple_Type_Definitions.XS_Simple_Type_Definition;
   begin
      XS_Base := Type_D.Get_Base_Type;

      case Type_D.Get_Type_Category is
         when XML.Schema.Complex_Type =>
            CTD := Type_D.To_Complex_Type_Definition;

            if CTD.Get_Content_Type in Element_Only | Mixed then
               Ada.Text_IO.Put_Line (Indent & "Complex_Type");
               XS_Particle    := CTD.Get_Particle;
               XS_Term        := XS_Particle.Get_Term;
               XS_Model_Group := XS_Term.To_Model_Group;
               XS_List        := XS_Model_Group.Get_Particles;

               Ada.Text_IO.Put_Line
                 ("XS_Model_Group.Get_Compositor : "
                  & XS_Model_Group.Get_Compositor'Img);

               Ada.Text_IO.Put_Line
                 ("XS_List'Length = " & XS_List.Get_Length'Img);

               if XS_Model_Group.Get_Compositor
                 = XML.Schema.Objects.Terms.Model_Groups.Compositor_Choice
               then
                  Ada.Text_IO.Put_Line
                    ("Get_Compositor " & XS_Model_Group.Get_Compositor'Img);
                  Ada.Text_IO.Put_Line ("START CHOICE");

                  for J in 1 .. XS_List.Get_Length loop
                     Ada.Text_IO.Put (Indent);
                     XS_Particle := XS_List.Item (J).To_Particle;
                     XS_Term := XS_Particle.Get_Term;
                     Ada.Text_IO.Put ((J'Img));
                     Ada.Text_IO.Put (' ');
                     Ada.Text_IO.Put_Line (XS_Term.Get_Type'Img);
                     Decl := XS_Term.To_Element_Declaration;

                     Ada.Text_IO.Put_Line
                       ("Decl:" & Decl.Get_Name.To_UTF_8_String);

                     Print_Type_Definition
                       (Decl.Get_Type_Definition, Indent & "   ");
                  end loop;
                  Ada.Text_IO.Put_Line ("END CHOICE");
               else
                  for J in 1 .. XS_List.Get_Length loop
                     Ada.Text_IO.Put (Indent);
                     XS_Particle := XS_List.Item (J).To_Particle;
                     XS_Term := XS_Particle.Get_Term;
                     Ada.Text_IO.Put ((J'Img));
                     Ada.Text_IO.Put (' ');
                     Ada.Text_IO.Put_Line (XS_Term.Get_Type'Img);
                     Decl := XS_Term.To_Element_Declaration;

                     Ada.Text_IO.Put_Line
                       ("Decl:" & Decl.Get_Name.To_UTF_8_String);

                     Print_Type_Definition
                       (Decl.Get_Type_Definition, Indent & "   ");
                  end loop;
               end if;

               Ada.Text_IO.Put_Line (Indent & "End Complex_Type");
            end if;
         when XML.Schema.Simple_Type =>
            Ada.Text_IO.Put_Line (Indent & "Simple_Type");
            STD := Type_D.To_Simple_Type_Definition;

            if XS_Base.Get_Type_Category in
              XML.Schema.Complex_Type .. XML.Schema.Simple_Type
              and XS_Base /= Type_D  --  This is to filter predefined types
            then
               Ada.Text_IO.Put_Line
                 (Type_D.Get_Name.To_UTF_8_String
                  & " : "
                  & XS_Base.Get_Name.To_UTF_8_String);
            end if;

         when XML.Schema.None =>
            Ada.Text_IO.Put_Line (Indent & "NONE!!!");
      end case;

      if XS_Base.Get_Type_Category in
        XML.Schema.Complex_Type .. XML.Schema.Simple_Type
        and XS_Base /= Type_D  --  This is to filter predefined types
      then
         Ada.Text_IO.Put_Line (Indent & " is new");
         Print_Type_Definition
           (XS_Base, Indent & "   " & XS_Base.Get_Name.To_UTF_8_String & ";");
      end if;
   end Print_Type_Definition;

   ---------------------------
   -- Print_Type_Definition_Resp --
   ---------------------------

   procedure Print_Type_Definition_Resp
     (Type_D    : XML.Schema.Type_Definitions.XS_Type_Definition;
      Indent    : String := "";
      Writer    : in out Writers.Writer;
      Is_Record : Boolean := False)
   is
      use type XML.Schema.Type_Definitions.XS_Type_Definition;
      use type XML.Schema.Objects.Terms.Model_Groups.Compositor_Kins;
      use type XML.Schema.Extended_XML_Schema_Component_Type;

      XS_Particle    : XML.Schema.Objects.Particles.XS_Particle;
      XS_Term        : XML.Schema.Objects.Terms.XS_Term;
      XS_Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
      XS_List        : XML.Schema.Object_Lists.XS_Object_List;
      XS_Base        : XML.Schema.Type_Definitions.XS_Type_Definition;

      Decl : XML.Schema.Element_Declarations.XS_Element_Declaration;
      CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;
      STD  : XML.Schema.Simple_Type_Definitions.XS_Simple_Type_Definition;

      procedure Print_Responce_Choise
        (Type_D : XML.Schema.Type_Definitions.XS_Type_Definition);

      ---------------------------
      -- Print_Responce_Choise --
      ---------------------------

      procedure Print_Responce_Choise
        (Type_D : XML.Schema.Type_Definitions.XS_Type_Definition) is
      begin
         case Type_D.Get_Type_Category is
            when XML.Schema.Complex_Type =>
               CTD := Type_D.To_Complex_Type_Definition;
               Writers.P
                 (Writer,
                  XSD_To_Ada.Utils.Add_Separator
                    (Type_D.Get_Name.To_Wide_Wide_String) & ";");

            when XML.Schema.Simple_Type =>
               STD := Type_D.To_Simple_Type_Definition;
               Writers.P (Writer,
                          XSD_To_Ada.Utils.Add_Separator
                            (Type_D.Get_Name.To_Wide_Wide_String) & ";");

            when XML.Schema.None =>
               null;
         end case;
      end Print_Responce_Choise;

   begin
      Ada.Text_IO.Put_Line ("NAME:" & Type_D.Get_Name.To_UTF_8_String);

      XS_Base := Type_D.Get_Base_Type;

      case Type_D.Get_Type_Category is
         when XML.Schema.Complex_Type =>

            Ada.Text_IO.Put_Line ("Complex_Type");
            Count := Count + 1;

            CTD := Type_D.To_Complex_Type_Definition;
            if Count = 2 and Type_D.Get_Name.To_UTF_8_String /= "" then
               Writers.P
                 (Writer,
                  XSD_To_Ada.Utils.Add_Separator
                    (Type_D.Get_Name.To_Wide_Wide_String) & ";");
            end if;

            if CTD.Get_Content_Type in Element_Only | Mixed then
               XS_Particle    := CTD.Get_Particle;
               XS_Term        := XS_Particle.Get_Term;
               XS_Model_Group := XS_Term.To_Model_Group;
               XS_List        := XS_Model_Group.Get_Particles;

               if XS_Model_Group.Get_Compositor
                 = XML.Schema.Objects.Terms.Model_Groups.Compositor_Choice
--                 and Count = 1
               then
                  Ada.Text_IO.Put_Line ("START CHOICE");
                  Writers.N (Writer, "START CHOICE");
                  for J in 1 .. XS_List.Get_Length loop
                     Ada.Text_IO.Put (Indent);
                     XS_Particle := XS_List.Item (J).To_Particle;
                     XS_Term := XS_Particle.Get_Term;
                     Decl := XS_Term.To_Element_Declaration;

                     Ada.Text_IO.Put
                       ("Decl:" & Decl.Get_Name.To_UTF_8_String & " : ");

                     Writers.N
                       (Writer,
                        "    when "
                        & XSD_To_Ada.Utils.Add_Separator
                          (Decl.Get_Name.To_Wide_Wide_String)
                        & " => " & Wide_Wide_Character'Val (10)
                        & "      "
                        & XSD_To_Ada.Utils.Add_Separator
                          (Decl.Get_Name.To_Wide_Wide_String) & " : ");
                     Print_Responce_Choise
                       (Decl.Get_Type_Definition);
                  end loop;
                  Writers.N
                    (Writer, "   end case;" & Wide_Wide_Character'Val (10));

                  Writers.N (Writer, "END CHOICE");
                  Ada.Text_IO.Put_Line ("END CHOICE");
               else

                  if Is_Record then
                     Writers.P (Writer, "is record");
                  end if;

                  for J in 1 .. XS_List.Get_Length loop
                     XS_Particle := XS_List.Item (J).To_Particle;
                     XS_Term := XS_Particle.Get_Term;
                     Decl := XS_Term.To_Element_Declaration;

                     if Count < 2 then
                        Ada.Text_IO.Put
                          ("Decl:" & Decl.Get_Name.To_UTF_8_String & " : ");

                        Writers.N
                          (Writer,
                           "      "
                           & XSD_To_Ada.Utils.Add_Separator
                             (Decl.Get_Name.To_Wide_Wide_String)
                           & " : ");
                     end if;

                     Ada.Text_IO.Put_Line
                       ("XS_List " & Decl.Get_Name.To_UTF_8_String
                        & " : " & Count'Img);

                     Print_Type_Definition_Resp
                       (Decl.Get_Type_Definition, Indent & "   ", Writer);
                  end loop;
               end if;
               Count := Count - 1;
            end if;

         when XML.Schema.Simple_Type =>
            STD := Type_D.To_Simple_Type_Definition;

            Ada.Text_IO.Put_Line ("Simple_Type");

            if Count < 2 then
               Ada.Text_IO.Put_Line (Type_D.Get_Name.To_UTF_8_String);
               Writers.P (Writer,
                          XSD_To_Ada.Utils.Add_Separator
                            (Type_D.Get_Name.To_Wide_Wide_String) & ";");
            end if;

         when XML.Schema.None =>
            Ada.Text_IO.Put_Line (Indent & "NONE!!!");
      end case;
   end Print_Type_Definition_Resp;

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

end XSD_To_Ada.Utils;
