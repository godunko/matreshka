------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               XML Processor                              --
--                                                                          --
--                              Tools Component                             --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2013-2014, Vadim Godunko <vgodunko@gmail.com>                --
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
--  $Revision$ $Date$
------------------------------------------------------------------------------
with Ada.Characters.Wide_Wide_Latin_1;
with Ada.Strings.Wide_Wide_Fixed;
with Ada.Strings.Wide_Wide_Maps;
with Ada.Strings.Wide_Wide_Unbounded;
with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with League.Characters;

with XML.Schema.Complex_Type_Definitions;
with XML.Schema.Element_Declarations;
with XML.Schema.Model_Groups;
with XML.Schema.Named_Maps;
with XML.Schema.Objects;
with XML.Schema.Object_Lists;
with XML.Schema.Particles;
with XML.Schema.Simple_Type_Definitions;

with Generator.Units.Ada_Units;
with XSD2Ada.Encoder;

with XSD_To_Ada.Payloads;

package body XSD_To_Ada.Utils is

   use XML.Schema.Complex_Type_Definitions;
   use XSD_To_Ada.Writers;
   use all type League.Strings.Universal_String;

   LF : constant Wide_Wide_Character := Ada.Characters.Wide_Wide_Latin_1.LF;

   procedure Put_Header (Unit : in out Generator.Units.Ada_Units.Ada_Unit);
   --  Outputs file's title

   procedure Create_Package_Name
    (Unit : in out Generator.Units.Ada_Units.Ada_Unit);

   procedure Create_Enumeration_Simple_Type
    (Model : XML.Schema.Models.XS_Model;
     Unit  : in out Generator.Units.Ada_Units.Ada_Unit);

   function "+"
     (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   function Add_Separator
     (Text : Wide_Wide_String) return Wide_Wide_String;

   -------------------
   -- Add_Separator --
   -------------------

   function Add_Separator
     (Text : Wide_Wide_String) return Wide_Wide_String
   is
      subtype Upper_Char_List  is Wide_Wide_Character range 'A' .. 'Z';
      subtype Lower_Char_List is Wide_Wide_Character range 'a' .. 'z';

      US_Text    : League.Strings.Universal_String;
      Uper_Count : Natural := 0;
   begin

      if Text = "" then
         return "";
      end if;

      US_Text.Append (Text (Text'First));

      for J in 2 .. Text'Length - 1 loop

         if Text (J) in Upper_Char_List
           and then Text (J - 1) in Upper_Char_List
         then
            Uper_Count := Uper_Count + 1;
         end if;

         if Text (J) in Lower_Char_List
           and then Text (J - 1) in Lower_Char_List
         then
            Uper_Count := 0;
         end if;

         if Text (J) in Lower_Char_List
             and then Text (J + 1) in Upper_Char_List
         then
            US_Text.Append (Text (J));
            US_Text.Append ("_");
            Uper_Count := 0;

         elsif Uper_Count > 1
           and then J + 2 <= Text'Last
           and then Text (J) in Upper_Char_List
           and then Text (J + 2) in Lower_Char_List
         then
            US_Text.Append (Text (J));

            US_Text.Append ("_");
            Uper_Count := 0;
         else
            US_Text.Append (Text (J));
         end if;
      end loop;

      US_Text.Append (Text (Text'Last));

      return US_Text.To_Wide_Wide_String;
   end Add_Separator;

   -------------------
   -- Add_Separator --
   -------------------

   function Add_Separator
    (Text : League.Strings.Universal_String)
       return League.Strings.Universal_String is
   begin
      return
        League.Strings.To_Universal_String
         (Add_Separator (Text.To_Wide_Wide_String));
   end Add_Separator;

   -------------------------
   -- Create_Complex_Type --
   -------------------------

   procedure Create_Complex_Type
    (Model   : XML.Schema.Models.XS_Model;
     Mapping : XSD_To_Ada.Mappings.Mapping)
   is
      XS_Object : XML.Schema.Objects.XS_Object;
      Type_D    : XML.Schema.Type_Definitions.XS_Type_Definition;

      Complex_Types : constant XML.Schema.Named_Maps.XS_Named_Map :=
        Model.Get_Components_By_Namespace
          (Object_Type => XML.Schema.Complex_Type,
           Namespace   => Namespace);

      Element_Declarations : constant XML.Schema.Named_Maps.XS_Named_Map
        := Model.Get_Components_By_Namespace
          (Object_Type => XML.Schema.Element_Declaration,
           Namespace   => Namespace);

      Simple_Types : constant XML.Schema.Named_Maps.XS_Named_Map :=
        Model.Get_Components_By_Namespace
          (Object_Type => XML.Schema.Simple_Type,
           Namespace   => Namespace);

      Payload_Spec        : Generator.Units.Ada_Units.Ada_Unit;
      Payload_Writer      : XSD_To_Ada.Writers.Writer;
      Encoder_Writer      : XSD_To_Ada.Writers.Writer;
      Encoder_Full_Writer : XSD_To_Ada.Writers.Writer;
      Encoder_Spec_Writer : XSD_To_Ada.Writers.Writer;
      Encoder_Names_Writer : XSD_To_Ada.Writers.Writer;

      Node_Vector : XSD2Ada.Analyzer.Items;

      Tag_Vector : League.String_Vectors.Universal_String_Vector;

      File_Type : Ada.Wide_Wide_Text_IO.File_Type;

   begin
      Put_Header (Payload_Spec);
      Create_Package_Name (Payload_Spec);
      Create_Enumeration_Simple_Type (Model, Payload_Spec);

      for J in 1 .. Complex_Types.Length loop
         XS_Object := Complex_Types.Item (J);

         for J in 1 .. Anonyn_Vector'Last loop
            Anonyn_Vector (J).Print_State := False;
            Anonyn_Vector (J).Term_State := False;
         end loop;

         XSD2Ada.Analyzer.Create_Type_Node
           (XS_Object.To_Type_Definition, Node_Vector);
      end loop;

      for J in 1 .. Simple_Types.Length loop
         XS_Object := Simple_Types.Item (J);
         Type_D    := XS_Object.To_Type_Definition;

         XSD2Ada.Analyzer.Create_Type_Node
           (Type_D, Node_Vector);
      end loop;

      XSD2Ada.Analyzer.Create_Element_Nodes (Model, Node_Vector);
      XSD_To_Ada.Payloads.Print_Payloads (Node_Vector, Payload_Writer, Mapping);

      Node_Vector.Clear;

      for J in 1 .. Element_Declarations.Length loop
         Type_D :=
           Element_Declarations.Item
             (J).To_Element_Declaration.Get_Type_Definition;

         if Has_Element_Session (Type_D)
           or Type_D.Get_Name.To_UTF_8_String = "OpenSession"
         then
            XSD2Ada.Analyzer.Create_Element_Node
              (Element_Declarations.Item (J).To_Element_Declaration,
               Node_Vector);
         end if;
      end loop;

      Put_Header (Encoder_Full_Writer);
      XSD2Ada.Encoder.Generate_Package_Header (Encoder_Full_Writer);

      Writers.P
        (Encoder_Spec_Writer,
         "with XML.SAX.Writers;" & LF
         & "with League.Strings;" & LF
         & "with Web_Services.SOAP.Payloads.Encoders;" & LF & LF
         & "package Encoder is"  & LF & LF
         & "   function Image (Item : Boolean) return League.Strings."
         & "Universal_String;"
         & LF);

      XSD2Ada.Encoder.Print_Type_Title
        (Node_Vector,
         "",
         Encoder_Writer,
         Encoder_Spec_Writer,
         Encoder_Names_Writer,
         Tag_Vector,
         Mapping);

      Encoder_Full_Writer.N (Encoder_Names_Writer.Text);
      Encoder_Full_Writer.N (Encoder_Writer.Text);
      Encoder_Full_Writer.P ("   begin");

      for Index in 1 .. Tag_Vector.Length loop
         Writers.P
           (Encoder_Full_Writer,
            ("   Web_Services.SOAP.Payloads.Encoders.Registry.Register"));

         Writers.P (Encoder_Full_Writer,
                    ("     (Payloads."
                     & Add_Separator (Tag_Vector.Element (Index))
                     & "'Tag,"));

         Writers.P
           (Encoder_Full_Writer,
            ("        "
             & Add_Separator (Tag_Vector.Element (Index))
             & "_Encoder'Tag);"));
      end loop;

      Encoder_Full_Writer.N ("end Encoder;");
      Encoder_Spec_Writer.N ("end Encoder;");

      Writers.N (Payload_Writer, "end Payloads;");
      Payload_Spec.Save;

      Ada.Wide_Wide_Text_IO.Put_Line (Payload_Writer.Text.To_Wide_Wide_String);
      Ada.Wide_Wide_Text_IO.Put_Line
        (Encoder_Full_Writer.Text.To_Wide_Wide_String);
      Ada.Wide_Wide_Text_IO.Put_Line
        (Encoder_Spec_Writer.Text.To_Wide_Wide_String);
   end Create_Complex_Type;

   ------------------------------------
   -- Create_Enumeration_Simple_Type --
   ------------------------------------

   procedure Create_Enumeration_Simple_Type
     (Model : XML.Schema.Models.XS_Model;
      Unit  : in out Generator.Units.Ada_Units.Ada_Unit)
   is

      XS_Object : XML.Schema.Objects.XS_Object;
      STD       : XML.Schema.Simple_Type_Definitions.XS_Simple_Type_Definition;

      Simple_Types : constant XML.Schema.Named_Maps.XS_Named_Map :=
        Model.Get_Components_By_Namespace
          (Object_Type => XML.Schema.Simple_Type,
           Namespace   => Namespace);

   begin
      for J in 1 .. Simple_Types.Length loop
         XS_Object := Simple_Types.Item (J);

         STD := XS_Object.To_Simple_Type_Definition;

         declare
            List : constant League.String_Vectors.Universal_String_Vector
              := STD.Get_Lexical_Enumeration;
         begin
            if not List.Is_Empty then
               Unit.New_Line;
               Unit.Put_Line
                ("   type " & Add_Separator (XS_Object.Get_Name) & " is");
               Unit.Put (+"    (");

               for J in 1 .. List.Length loop
                  if J /= 1 then
                     Unit.Put_Line (+",");
                     Unit.Put (+"     ");
                  end if;

                  Unit.Put (List.Element (J).To_Simple_Lowercase);
                  --  XXX Why literal name is converted to lowercase?
               end loop;

               Unit.Put_Line (+");");
            end if;
         end;
      end loop;
   end Create_Enumeration_Simple_Type;

   -------------------------
   -- Create_Package_Name --
   -------------------------

   procedure Create_Package_Name
    (Unit : in out Generator.Units.Ada_Units.Ada_Unit) is
   begin
      Unit.Set_Section (Generator.Units.Ada_Units.Unit_Declaration_Section);
      Unit.New_Line;
      Unit.Put_Line (+"package Payloads is");

      --  XXX Temporary stuff to generate compilable code for IATS project.

      Unit.Add_With (+"Ada.Strings.Unbounded");
      Unit.New_Line;
      Unit.Put_Line
       (+"   type Decimal_String is"
          & " new Ada.Strings.Unbounded.Unbounded_String;");
      Unit.New_Line;
      Unit.Put_Line (+"   Null_Decimal : constant Decimal_String");
      Unit.Put_Line
       (+"     := Decimal_String"
          & " (Ada.Strings.Unbounded.Null_Unbounded_String);");

      Unit.Add_With (+"Ada.Strings.Unbounded");
      Unit.New_Line;
      Unit.Put_Line
       (+"   type Rate_String is new Ada.Strings.Unbounded.Unbounded_String;");
      Unit.New_Line;
      Unit.Put_Line (+"   Null_Rate : constant Rate_String");
      Unit.Put_Line
       (+"     := Rate_String"
          & " (Ada.Strings.Unbounded.Null_Unbounded_String);");

      Unit.Add_With (+"Interfaces");
      Unit.New_Line;
      Unit.Put_Line (+"   type TimeT is new Interfaces.Unsigned_64;");

      Unit.New_Line;
      Unit.Put_Line (+"   type Diagnosis_Code is range 0 .. 2 ** 32 - 1;");

      --  XXX Additional 'with's to be able to compile generated code for test
      --  project.

      Unit.Add_With (+"Ada.Containers.Vectors");
      Unit.Add_With (+"ICTS.Currencies");
      Unit.Add_With (+"ICTS.Forex");
      Unit.Add_With (+"ICTS.Types");
      Unit.Add_With (+"ICTSClient.Types");
      Unit.Add_With (+"League.Strings");
      Unit.Add_With (+"Web_Services.SOAP.Payloads");
   end Create_Package_Name;

   ------------------------
   -- Create_Simple_Type --
   ------------------------

   procedure Create_Simple_Type
     (Model  : XML.Schema.Models.XS_Model;
      Writer : in out XSD_To_Ada.Writers.Writer)
   is
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
               Writer.P
                 ("type "
                  & XSD_To_Ada.Utils.Add_Separator (XS_Object.Get_Name)
                  & " is new "
                  & XSD_To_Ada.Utils.Add_Separator (XS_Base.Get_Name)
                  & ";" & LF);
            else
               Writer.N
                 ("type " &
                    XSD_To_Ada.Utils.Add_Separator (XS_Object.Get_Name)
                  & " is (");

               for J in 1 .. List.Length loop
                  if J /= List.Length then
                     Writer.N (List.Element (J).To_Lowercase);
                     Writer.N (", ");
                  else
                     Writer.N (List.Element (J).To_Lowercase);
                     Writer.P (");");
                     Writer.P;
                  end if;
               end loop;
            end if;
         end;
      end loop;
   end Create_Simple_Type;

   ---------------------------
   -- Create_Vector_Package --
   ---------------------------

   procedure Create_Vector_Package
    (Type_D_Name  : League.Strings.Universal_String;
     Mapping      : XSD_To_Ada.Mappings.Mapping;
     Writer       : in out Writers.Writer;
     Writer_types : in out Writers.Writer)
   is
      Added_Vector_Type : Boolean := False;
   begin
      Added_Vector_Type := True;

      for J in 1 .. Is_Vector_Type.Length loop
         if Type_D_Name.To_UTF_8_String
           = Is_Vector_Type.Element (J).To_UTF_8_String
         then
            Added_Vector_Type := False;

            if not Mapping.Is_Type_In_Map (Type_D_Name) then
               Writers.N (Writer, "s");
            end if;

            exit;
         else
            Added_Vector_Type := True;
         end if;
      end loop;

      if Added_Vector_Type then
          Writers.P
           (Writer_types,
            "   package "
              & Add_Separator (Type_D_Name) & "_Vectors is" & LF
              & Split_Line
                 ("     new Ada.Containers.Vectors "
                    & "(Positive, "
                    & Add_Separator (Type_D_Name).To_Wide_Wide_String
                    & ");",
                  7)
              & LF & LF
              & Split_Line
                 ("   subtype "
                    & Add_Separator (Type_D_Name).To_Wide_Wide_String
                    & "s is "
                    & Add_Separator (Type_D_Name).To_Wide_Wide_String
                    & "_Vectors.Vector;",
                  5)
              & LF);

         Is_Vector_Type.Append (Type_D_Name);

         if not Mapping.Is_Type_In_Map (Type_D_Name) then
            Writers.N (Writer, "s");
         end if;
      end if;

      Writers.P (Writer, ";");
   end Create_Vector_Package;

   ---------------------
   -- Gen_Access_Type --
   ---------------------

   procedure Gen_Access_Type
    (Self : in out XSD_To_Ada.Writers.Writer;
     Name : League.Strings.Universal_String) is
   begin
      Writers.N
        (Self,
         "   type " & Name & "_Access is access all"
         & Wide_Wide_Character'Val (10)
         & "      " & Name & "'Class;"
         & Wide_Wide_Character'Val (10) & Wide_Wide_Character'Val (10));
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

   -------------------------
   -- Has_Element_Session --
   -------------------------

   function Has_Element_Session
     (Type_D : XML.Schema.Type_Definitions.XS_Type_Definition) return Boolean
   is
      use type XML.Schema.Type_Definitions.XS_Type_Definition;

      XS_Particle    : XML.Schema.Particles.XS_Particle;
      XS_Term        : XML.Schema.Terms.XS_Term;
      XS_Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
      XS_List        : XML.Schema.Object_Lists.XS_Object_List;

      Decl : XML.Schema.Element_Declarations.XS_Element_Declaration;
      CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;
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
                     return True;
                  end if;

                  return Has_Element_Session (Decl.Get_Type_Definition);
               end loop;
            end if;

         when XML.Schema.Simple_Type =>
            null;

         when XML.Schema.None =>
            null;
      end case;

      return False;
   end Has_Element_Session;

   ---------------
   -- Is_Choice --
   ---------------

   function Is_Choice
     (Type_D : XML.Schema.Type_Definitions.XS_Type_Definition) return Boolean
   is
      use type XML.Schema.Model_Groups.Compositor_Kinds;
   begin
      if Type_D.To_Complex_Type_Definition.Get_Content_Type in
         Element_Only | Mixed
        and then Type_D.To_Complex_Type_Definition.Get_Particle.Get_Term
                   .To_Model_Group.Get_Compositor =
                      XML.Schema.Model_Groups.Compositor_Choice
      then
         return True;
      else
         return False;
      end if;
   end Is_Choice;

   ----------------
   -- Put_Header --
   ----------------

   procedure Put_Header (Self : in out XSD_To_Ada.Writers.Writer) is
      Lin : constant Wide_Wide_String (1 .. 77) := (others => '-');
   begin
      Self.P (Lin);
      Self.P
        ("--  This file is generated by xsd_to_ada_generator, don't edit it.");
      Self.P (Lin);
      Self.P ("");
   end Put_Header;

   ----------------
   -- Put_Header --
   ----------------

   procedure Put_Header (Unit : in out Generator.Units.Ada_Units.Ada_Unit) is
   begin
      Unit.Set_Section (Generator.Units.Ada_Units.Unit_Header_Section);
      Unit.Put_Line
       (+"-------------------------------------------------------------------"
           & "-----------");
      Unit.Put_Line
       (+"--  This file is generated by xsd_to_ada_generator, don't edit it.");
      Unit.Put_Line
       (+"-------------------------------------------------------------------"
           & "-----------");
   end Put_Header;

   ----------------
   -- Split_Line --
   ----------------

   function Split_Line
     (Str : Wide_Wide_String := "";
      Tab : Natural := 0)
      return Wide_Wide_String
   is

      US      : League.Strings.Universal_String
        := League.Strings.To_Universal_String (Str);
      US_New : League.Strings.Universal_String;

      Tab_Count : Natural := Tab;

      procedure Trim
        (US        : in out League.Strings.Universal_String;
         US_New    : in out League.Strings.Universal_String;
         Tab_Count : in out Natural);

      procedure Trim
        (US        : in out League.Strings.Universal_String;
         US_New    : in out League.Strings.Universal_String;
         Tab_Count : in out Natural)
      is
         use type League.Characters.Universal_Character;

         Temp_US : constant League.Strings.Universal_String
           := US.Slice (1, 79 - Tab_Count);
      begin

         for J in reverse 1 .. Temp_US.Length loop
            if (Temp_US.Element (J) = ' '
                and then Temp_US.Element (J + 1) = ':'
                and then J /= 1)
              or (Temp_US.Element (J) = '('
                  and then J /= 1)
              or (J + 3 < Temp_US.Length
                  and then Temp_US.Element (J) = ' '
                  and then Temp_US.Element (J + 1) = 'i'
                  and then Temp_US.Element (J + 2) = 's'
                  and then Temp_US.Element (J + 3) = ' ')
              or (J + 2 < Temp_US.Length
                  and then Temp_US.Element (J) = ' '
                  and then Temp_US.Element (J + 1) = '/'
                  and then Temp_US.Element (J + 2) = '=')
              or (J /= 1
                  and then J + 1 < Temp_US.Length
                  and then Temp_US.Element (J) = '.'
                  and then Temp_US.Element (J + 1) /= '.')
            then
               Tab_Count := Tab_Count + 2;
               US_New.Append (Temp_US.Slice (1, J - 1));
               US_New.Append (LF);

               for Count in 1 .. Tab_Count loop
                  US_New.Append (" ");
               end loop;

               US := US.Slice (J, US.Length);
               exit;
            end if;
         end loop;
      end Trim;

   begin
      for Count in 1 .. Tab_Count loop
         US_New.Append (" ");
      end loop;

      if US.Length + Tab_Count < 79 then
         US_New.Append (US);
         return US_New.To_Wide_Wide_String;
      end if;

      loop
         if US.Length + Tab > 79 then
            Trim (US, US_New, Tab_Count);
         else
            US_New.Append (US);
            return US_New.To_Wide_Wide_String;
         end if;
      end loop;
   end Split_Line;

   ----------------
   -- Split_Line --
   ----------------

   function Split_Line
     (Str : League.Strings.Universal_String;
      Tab : Natural := 0)
      return Wide_Wide_String is
   begin
      return Split_Line (Str.To_Wide_Wide_String, Tab);
   end Split_Line;

end XSD_To_Ada.Utils;
