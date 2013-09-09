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

   ----------------
   -- Print_Term --
   ----------------

   procedure Print_Term
     (XS_Term : XML.Schema.Objects.Terms.XS_Term;
      Indent  : String := "";
      Writer  : in out Writers.Writer;
      Writer_types    : in out Writers.Writer;
      Name    : League.Strings.Universal_String)
   is
      use type XML.Schema.Objects.Terms.Model_Groups.Compositor_Kinds;

      XS_Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
      XS_List        : XML.Schema.Object_Lists.XS_Object_List;
      XS_Particle    : XML.Schema.Objects.Particles.XS_Particle;
      Decl           : XML.Schema.Element_Declarations.XS_Element_Declaration;

      Type_D         : XML.Schema.Type_Definitions.XS_Type_Definition;

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
               "      " & Name.To_Wide_Wide_String & " : "
               & Name.To_Wide_Wide_String & "_Anonym;");

            Anonym_Kind.Append
              ("   type " & Name.To_Wide_Wide_String & "_Anonym is record"
              & Wide_Wide_Character'Val (10));
            Add_Anonym := True;
         end if;

         if Choice = 1 and not Now_Add then

            Name_Kind.Append ("   type " & Name.To_Wide_Wide_String & "_Kind (");

            Name_Case.Append
              ("   type " & Name.To_Wide_Wide_String
               & "_Case (Kind : " & Name.To_Wide_Wide_String & "_Kind) is record"
               & Wide_Wide_Character'Val (10)
               & "      case Kind is"
               & Wide_Wide_Character'Val (10));

            Writers.P
              (Writer,
               "      " & Name.To_Wide_Wide_String & " : "
               & Name.To_Wide_Wide_String & "_Case;");

            Now_Add := True;
            Add_Choise := True;
         end if;

         for J in 1 .. XS_List.Get_Length loop
            Ada.Text_IO.Put (Indent);
            XS_Particle := XS_List.Item (J).To_Particle;

            Print_Term
              (XS_Particle.Get_Term, Indent & "   ", Writer, Writer_types, Name);

            if J /=  XS_List.Get_Length and Choice = 1 then
               Name_Kind.Append (", ");
            end if;
         end loop;

         Choice := 0;

      elsif XS_Term.Is_Element_Declaration then
         Decl := XS_Term.To_Element_Declaration;
         Type_D := Decl.Get_Type_Definition;

         if Type_D.Get_Name.To_UTF_8_String = "" then
            Anonym_Type := True;
            Print_Type_Definition
              (Type_D, Indent & "   ", Writer, Writer_types,
               League.Strings.To_Universal_String
                 (Name.To_Wide_Wide_String & "_" & Decl.Get_Name.To_Wide_Wide_String));
            Anonym_Type := False;
            Add_Anonym := False;
         end if;

         if Choice = 1 then
            Name_Kind.Append (XS_Term.Get_Name);
            Name_Case.Append
              ("        when " & XS_Term.Get_Name.To_Wide_Wide_String & " =>"
               & Wide_Wide_Character'Val (10)
               & "           " & XS_Term.Get_Name.To_Wide_Wide_String
               & " : "
               & Type_D.Get_Name.To_Wide_Wide_String & ";"
               & Wide_Wide_Character'Val (10));
         end if;

         if Type_D.Get_Name.To_UTF_8_String /= ""
           and not Anonym_Type
           and Choice = 0
         then
            Writers.P
              (Writer,
               "      " & XS_Term.Get_Name.To_Wide_Wide_String
               & " : "
               & Type_D.Get_Name.To_Wide_Wide_String & ";");
         end if;

         if Anonym_Type and Choice = 0 then
            Anonym_Kind.Append
               ("      " & XS_Term.Get_Name.To_Wide_Wide_String
               & " : "
                & Type_D.Get_Name.To_Wide_Wide_String & ";"
               & Wide_Wide_Character'Val (10));
         end if;
      end if;
   end Print_Term;

   ---------------------------
   -- Print_Type_Definition --
   ---------------------------

   procedure Print_Type_Definition
     (Type_D : XML.Schema.Type_Definitions.XS_Type_Definition;
      Indent : String := "";
      Writer : in out Writers.Writer;
      Writer_types    : in out Writers.Writer;
      Name   : League.Strings.Universal_String;
      Is_Record : Boolean := False)
   is
      use type XML.Schema.Type_Definitions.XS_Type_Definition;

      XS_Particle    : XML.Schema.Objects.Particles.XS_Particle;
      XS_Term        : XML.Schema.Objects.Terms.XS_Term;
      XS_Base        : XML.Schema.Type_Definitions.XS_Type_Definition;

      CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;
      STD  : XML.Schema.Simple_Type_Definitions.XS_Simple_Type_Definition;
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
                 (Indent & "Complex_Type "
                  & Type_D.Get_Name.To_UTF_8_String);
               XS_Particle := CTD.Get_Particle;
               XS_Term := XS_Particle.Get_Term;

               Print_Term
                 (XS_Term, Indent & "   ", Writer, Writer_types, Name);

               Ada.Text_IO.Put_Line (Indent & "End Complex_Type");
            end if;

         when XML.Schema.Simple_Type =>
            Ada.Text_IO.Put (Indent & "Simple_Type : " & Type_D.Get_Name.To_UTF_8_String);
            STD := Type_D.To_Simple_Type_Definition;

         when XML.Schema.None =>
            Ada.Text_IO.Put_Line (Indent & "NONE!!!");
      end case;

      if XS_Base.Get_Type_Category in
        XML.Schema.Complex_Type .. XML.Schema.Simple_Type
        and XS_Base /= Type_D  --  This is to filter predefined types
      then
         Ada.Text_IO.Put_Line (Indent & " is new");
         Print_Type_Definition (XS_Base, Indent & "   ", Writer, Writer_types, Name);
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
            & "   end record;" & Wide_Wide_Character'Val (10));

         Name_Kind.Clear;
         Name_Case.Clear;
         Now_Add := False;
         Add_Choise := False;
      end if;

      if Add_Anonym then
      Writers.P
           (Writer_types,
            Anonym_Kind.To_Wide_Wide_String
            & "   end record;" & Wide_Wide_Character'Val (10));
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

end XSD_To_Ada.Utils;
