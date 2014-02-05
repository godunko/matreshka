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
with XSD_To_Ada.Encoder_2;

package body XSD_To_Ada.Utils is

   use XML.Schema.Complex_Type_Definitions;
   use XSD_To_Ada.Writers;
   use all type League.Strings.Universal_String;

   LF : constant Wide_Wide_Character := Ada.Characters.Wide_Wide_Latin_1.LF;

   procedure Generate_Complex_Type
     (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
      XS_Term      : XML.Schema.Terms.XS_Term;
      Mapping      : XSD_To_Ada.Mappings.Mapping;
      Type_Name    : League.Strings.Universal_String;
      Min_Occurs   : Boolean;
      Max_Occurs   : in out Boolean;
      Writer       : in out Writers.Writer);

   procedure Generate_Type
     (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
      XS_Term      : XML.Schema.Terms.XS_Term;
      Mapping      : XSD_To_Ada.Mappings.Mapping;
      Type_Name    : League.Strings.Universal_String;
      Max_Occurs   : in out Boolean;
      Min_Occurs   : in out Boolean;
      Writer       : in out Writers.Writer;
      Writer_types : in out Writers.Writer);

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
         return "Add_Separator ERROR";
         --         raise Constraint_Error with "Add_Separator ERROR";
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

         XSD2Ada.Analyzer.Create_Node_Vector
           (XS_Object.To_Type_Definition,
            Node_Vector,
            Mapping,
            1, (False, 1));
      end loop;

      for J in 1 .. Simple_Types.Length loop
         XS_Object := Simple_Types.Item (J);
         Type_D    := XS_Object.To_Type_Definition;

         XSD2Ada.Analyzer.Create_Node_Vector
           (Type_D,
            Node_Vector,
            Mapping,
            1, (False, 1));
      end loop;

      XSD2Ada.Analyzer.Create_Element_Type (Model, Node_Vector, Mapping);
      Print_Payloads (Node_Vector, "", Payload_Writer, Mapping);

      Ada.Wide_Wide_Text_IO.Create (File_Type, Out_File, "Vector");

      for Index in 1 .. Natural (Node_Vector.Length) loop
         Ada.Wide_Wide_Text_IO.Put
           (File_Type,
            "Name = "
            & Node_Vector.Element (Index).Type_Def
               .Get_Name.To_Wide_Wide_String);

         Ada.Wide_Wide_Text_IO.Put
           (File_Type,
            "; TYPE = "
            & XML.Schema.Type_Category'Wide_Wide_Image
              (Node_Vector.Element (Index).Type_Def.Get_Type_Category));

         Ada.Wide_Wide_Text_IO.Put
           (File_Type,
            "; Min ="
            & Boolean'Wide_Wide_Image (Node_Vector.Element (Index).Min));

         Ada.Wide_Wide_Text_IO.Put
           (File_Type,
            "; Max ="
            & Boolean'Wide_Wide_Image (Node_Vector.Element (Index).Max));

         Ada.Wide_Wide_Text_IO.Put
           (File_Type,
            "; Choice "
            & Boolean'Wide_Wide_Image (Node_Vector.Element (Index).Choice));

         Ada.Wide_Wide_Text_IO.Put
           (File_Type,
            "; Anonym_Name <"
            & Node_Vector.Element (Index).Anonym_Name.To_Wide_Wide_String
            & ">");

         Ada.Wide_Wide_Text_IO.Put_Line
           (File_Type,
            "; Element_Name <"
            & Node_Vector.Element (Index).Element_Name.To_Wide_Wide_String
            & ">");
      end loop;

      Node_Vector.Clear;

      for J in 1 .. Element_Declarations.Length loop
         Type_D :=
           Element_Declarations.Item
             (J).To_Element_Declaration.Get_Type_Definition;

         if XSD2Ada.Analyzer.Has_Element_Session (Type_D)
           or Type_D.Get_Name.To_UTF_8_String = "OpenSession"
         then
            XSD2Ada.Analyzer.Create_Node_Vector
              (Type_D,
               Node_Vector,
               Mapping,
               1, (False, 1),
               Element_Declarations.Item (J).Get_Name);
         end if;
      end loop;

      Put_Header (Encoder_Full_Writer);
      XSD_To_Ada.Encoder_2.Generate_Package_Header (Encoder_Full_Writer);

      Writers.P
        (Encoder_Spec_Writer,
         "with XML.SAX.Writers;" & LF
         & "with League.Strings;" & LF
         & "with Web_Services.SOAP.Payloads.Encoders;" & LF & LF
         & "package Encoder is"  & LF & LF
         & "   function Image (Item : Boolean) return League.Strings."
         & "Universal_String;"
         & LF);

      XSD_To_Ada.Encoder_2.Print_Type_Title
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
              & Gen_Type_Line
                 ("     new Ada.Containers.Vectors "
                    & "(Positive, "
                    & Add_Separator (Type_D_Name).To_Wide_Wide_String
                    & ");",
                  7)
              & LF & LF
              & Gen_Type_Line
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
     (Self   : in out XSD_To_Ada.Writers.Writer;
      Name   : Wide_Wide_String) is
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

   -------------------
   -- Gen_Type_Line --
   -------------------

   function Gen_Type_Line
     (Str : Wide_Wide_String := "";
      Tab : Natural := 0) return Wide_Wide_String
   is
      use type League.Characters.Universal_Character;
      use Ada.Strings.Wide_Wide_Unbounded;
      use Ada.Strings.Wide_Wide_Maps;

      US      : constant League.Strings.Universal_String
        := League.Strings.To_Universal_String (Str);
      US_New : League.Strings.Universal_String;

      Tab_Count : Natural := Tab;
   begin
      if US.Length > 79 then
         for J in 1 .. US.Length loop
            if US.Element (J) = ' '
              and then
                (US.Element (J + 1) = '('
                 or US.Element (J + 1) = ':')
            then
               US_New.Append (Wide_Wide_Character'Val (10));

               for Count in 1 .. Tab loop
                  US_New.Append (" ");
               end loop;

               US_New.Append (US.Element (J));

            elsif US.Element (J) = ' '
              and then US.Element (J + 1) = 'i'
              and then US.Element (J + 2) = 's'
              and then US.Element (J + 3) = ' '
            then
               US_New.Append (Wide_Wide_Character'Val (10));
               Tab_Count := Tab_Count + 2;

               for Count in 1 .. Tab_Count loop
                  US_New.Append (" ");
               end loop;

               US_New.Append (US.Element (J));
            else
               US_New.Append (US.Element (J));
            end if;
         end loop;

         return US_New.To_Wide_Wide_String;
      else
         return Str;
      end if;
   end Gen_Type_Line;

   ---------------------------
   -- Generate_Complex_Type --
   ---------------------------

   procedure Generate_Complex_Type
     (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
      XS_Term      : XML.Schema.Terms.XS_Term;
      Mapping      : XSD_To_Ada.Mappings.Mapping;
      Type_Name    : League.Strings.Universal_String;
      Min_Occurs   : Boolean;
      Max_Occurs   : in out Boolean;
      Writer       : in out Writers.Writer) is
   begin
      if Min_Occurs
        and then not Max_Occurs
      then
         Writers.N
           (Writer,
            "      "
            & Add_Separator (XS_Term.Get_Name)
            & " : "
            & "Optional_" & Add_Separator (Type_D.Get_Name));
      else
         Writers.N
           (Writer,
            "      "
            & Add_Separator (XS_Term.Get_Name)
            & " : "
            & Type_Name.To_Wide_Wide_String);
      end if;

      if Max_Occurs and then not XSD_To_Ada.Mappings.Is_Type_In_Map
        (Mapping, Type_D.Get_Name)
      then
         Max_Occurs := False;
         Writers.P (Writer, "_Vector;");
      else
         Writers.P (Writer, ";");
      end if;
   end Generate_Complex_Type;

   --------------------------
   -- Generate_Simple_Type --
   --------------------------

   procedure Generate_Simple_Type
     (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
      XS_Term      : XML.Schema.Terms.XS_Term;
      Type_Name    : League.Strings.Universal_String;
      Min_Occurs   : in out Boolean;
      Max_Occurs   : Boolean;
      Writer       : in out Writers.Writer;
      Writer_types : in out Writers.Writer)
   is
      use League.Strings;
   begin
      if Min_Occurs
--        and then not Max_Occurs
      then
         if not Is_Type_In_Optional_Vector (XS_Term.Get_Name) then
            Writers.P
              (Writer_types,
               "   type Optional_"
               & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
               & " is record" & LF
               & "     Is_Set : Boolean := False;" & LF
               & "     Value : "
               & Type_Name.To_Wide_Wide_String
               & ";" & LF
               & "   end record;" & LF);
         end if;

         Writers.P
           (Writer,
            "      "
            & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
            & " : Optional_"
            & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
            & ";");

         Min_Occurs := False;
      else
         if Max_Occurs then
            Writers.P
              (Writer_types,
               "   package " & Add_Separator (Type_D.Get_Name)
               & "_Vector is" & LF
               &  "     new Ada.Containers.Vectors" & LF
               & "       (Positive, "
               & Type_Name.To_Wide_Wide_String & "," & LF
               & "       ""="" => ICTS.Types.""="");" & LF);

            Writers.P
              (Writer,
               "      "
               & Add_Separator (XS_Term.Get_Name)
               & " : "
               & Add_Separator (Type_D.Get_Name) & "_Vector.Vector;");
         else
            Writers.P
              (Writer,
               "      "
               & Add_Separator (XS_Term.Get_Name)
               & " : "
               & Type_Name & ";");
         end if;
      end if;
   end Generate_Simple_Type;

   -------------------
   -- Generate_Type --
   -------------------

   procedure Generate_Type
     (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
      XS_Term      : XML.Schema.Terms.XS_Term;
      Mapping      : XSD_To_Ada.Mappings.Mapping;
      Type_Name    : League.Strings.Universal_String;
      Max_Occurs   : in out Boolean;
      Min_Occurs   : in out Boolean;
      Writer       : in out Writers.Writer;
      Writer_types : in out Writers.Writer) is
   begin
      case Type_D.Get_Type_Category is
         when XML.Schema.Complex_Type =>
            Generate_Complex_Type
              (Type_D,
               XS_Term,
               Mapping,
               Type_Name,
               Min_Occurs,
               Max_Occurs,
               Writer);

         when XML.Schema.Simple_Type =>
            Generate_Simple_Type
              (Type_D,
               XS_Term,
               Type_Name,
               Min_Occurs,
               Max_Occurs,
               Writer,
               Writer_types);

         when XML.Schema.None =>
            Ada.Wide_Wide_Text_IO.Put_Line
             (Ada.Wide_Wide_Text_IO.Standard_Error, "NONE!!!");
      end case;
   end Generate_Type;

   --------------------------------
   -- Is_Type_In_Optional_Vector --
   --------------------------------

   function Is_Type_In_Optional_Vector
     (Type_Name : League.Strings.Universal_String)
      return Boolean is
   begin
      if Optional_Vector.Index (Type_Name) = 0 then
         Optional_Vector.Append (Type_Name);
         return False;
      end if;

      return True;
   end Is_Type_In_Optional_Vector;

   --------------------
   -- Print_Payloads --
   --------------------

   procedure Print_Payloads
    (Node_Vector : XSD2Ada.Analyzer.Items;
     Indent      : Wide_Wide_String;
     Writer      : in out XSD_To_Ada.Writers.Writer;
     Mapping     : XSD_To_Ada.Mappings.Mapping)
   is
      US_Response         : League.Strings.Universal_String;
      Payload_Writer      : XSD_To_Ada.Writers.Writer;
      Payload_Type_Writer : XSD_To_Ada.Writers.Writer;

      Type_D : XML.Schema.Type_Definitions.XS_Type_Definition;

      Discriminant_Type : League.Strings.Universal_String;
      Vector_Name       : League.Strings.Universal_String;

   begin
      for Current of Node_Vector loop
         if not Current.Type_Def.Is_Simple_Type_Definition then
            Type_D := Current.Type_Def;

            Discriminant_Type.Clear;

            if Current.Choice then
               Discriminant_Type := League.Strings.From_UTF_8_String ("_Case");
            end if;

            if Type_D.Get_Name.Is_Empty then
               Vector_Name.Clear;
               Vector_Name.Append (Current.Anonym_Name);
               Vector_Name.Append ("_Anonym");
               Vector_Name.Append (Discriminant_Type);

            else
               Vector_Name := Type_D.Get_Name;
            end if;

            Ada.Wide_Wide_Text_IO.Put_Line
             (Ada.Wide_Wide_Text_IO.Standard_Error,
              Indent
                & Natural'Wide_Wide_Image (Node_Vector.Find_Index (Current))
                & "; START Print_Type_Title Type_D="
                & Type_D.Get_Name.To_Wide_Wide_String
                & Current.Anonym_Name.To_Wide_Wide_String);

            Ada.Wide_Wide_Text_IO.Put_Line
             (Ada.Wide_Wide_Text_IO.Standard_Error,
              "Min " & Boolean'Wide_Wide_Image (Current.Min));

            Ada.Wide_Wide_Text_IO.Put_Line
             (Ada.Wide_Wide_Text_IO.Standard_Error,
              "Max " & Boolean'Wide_Wide_Image (Current.Max));

            Ada.Wide_Wide_Text_IO.Put_Line
             (Ada.Wide_Wide_Text_IO.Standard_Error,
              "Choice " & Boolean'Wide_Wide_Image (Current.Choice));

            Ada.Wide_Wide_Text_IO.Put_Line
             (Ada.Wide_Wide_Text_IO.Standard_Error,
              "Anonym_Name <" & Current.Anonym_Name.To_Wide_Wide_String & ">");

            Ada.Wide_Wide_Text_IO.Put_Line
             (Ada.Wide_Wide_Text_IO.Standard_Error,
              "Element_Name <"
                & Current.Element_Name.To_Wide_Wide_String
                & ">");

            if Type_D.Get_Name.Length > 10 then
               US_Response :=
                 Type_D.Get_Name.Slice
                  (Type_D.Get_Name.Length - 7, Type_D.Get_Name.Length);
            end if;

            if not Current.Max
              and then not Current.Min
              and then Current.Element_Name.Is_Empty
              and then Current.Type_Def.Is_Complex_Type_Definition
            then
               if not Current.Anonym_Name.Is_Empty then
                  Writers.P
                   (Payload_Writer,
                    "   type "
                      & Add_Separator (Current.Anonym_Name)
                      & "_Anonym"
                      & Discriminant_Type
                      & " is record");

                  XSD_To_Ada.Utils.Print_Type_Definition
                   (Type_D,
                    Indent & "   ",
                    Payload_Writer, Payload_Type_Writer,
                    Type_D.Get_Name,
                    Current.Anonym_Name,
                    Current.Element_Name,
                    Mapping);

                  Writers.P (Payload_Writer, "   end record;" & LF);

               else
                  if Type_D.Get_Name.Length > 10
                    and US_Response.To_UTF_8_String = "Response"
                  then
                     if not Current.Element_Name.Is_Empty then
                        Writers.N
                         (Payload_Writer,
                          "   type "
                            & Add_Separator (Current.Element_Name)
                            & " is" & LF
                            & "     new Web_Services.SOAP.Payloads."
                            & "Abstract_SOAP_Payload with" & LF
                            & "     record" & LF
                            & "     "
                            & Add_Separator (Type_D.Get_Name)
                            & LF
                            & "      : ");

                        Writers.P
                         (Payload_Writer,
                          (XSD_To_Ada.Mappings.Ada_Type_Qualified_Name
                            (Mapping, Type_D.Get_Name)));
                        Writers.P (Payload_Writer, "     end record;" & LF);

                        Gen_Access_Type
                         (Payload_Writer,
                          Add_Separator
                           (Current.Element_Name).To_Wide_Wide_String);

                     else
                        XSD_To_Ada.Utils.Gen_Proc_Header
                         (Payload_Writer,
                          Add_Separator (Type_D.Get_Name).To_Wide_Wide_String);

                        Writers.P
                         (Payload_Writer,
                          "   type "
                            & Add_Separator
                               (Type_D.Get_Name.To_Wide_Wide_String)
                            & " is" & LF
                            & "     new Web_Services.SOAP.Payloads."
                            & "Abstract_SOAP_Payload with" & LF
                            & "     record");

                        XSD_To_Ada.Utils.Print_Type_Definition
                         (Type_D,
                          Indent & "   ",
                          Payload_Writer, Payload_Type_Writer,
                          Type_D.Get_Name,
                          Current.Anonym_Name,
                          Current.Element_Name,
                          Mapping);

                        Writers.P (Payload_Writer, "     end record;" & LF);

                        XSD_To_Ada.Utils.Gen_Access_Type
                         (Payload_Writer,
                          Add_Separator (Type_D.Get_Name.To_Wide_Wide_String));
                     end if;

                     US_Response.Clear;

                  else
                     if XSD2Ada.Analyzer.Has_Element_Session (Type_D) then
                        XSD_To_Ada.Utils.Gen_Proc_Header
                         (Payload_Writer,
                          Add_Separator (Type_D.Get_Name).To_Wide_Wide_String);

                        Writers.P
                         (Payload_Writer,
                          "   type "
                            & Add_Separator (Type_D.Get_Name)
                            & " is" & LF
                            & "     new Web_Services.SOAP.Payloads."
                            & "Abstract_SOAP_Payload"
                            & LF
                            & "   with record");

                        XSD_To_Ada.Utils.Print_Type_Definition
                         (Type_D,
                          Indent & "   ",
                          Payload_Writer,
                          Payload_Type_Writer,
                          Type_D.Get_Name,
                          Current.Anonym_Name,
                          Current.Element_Name,
                          Mapping);

                        Writers.P (Payload_Writer, "   end record;" & LF);

                     else
                        if Type_D.Get_Base_Type.Get_Name.To_Wide_Wide_String
                             = "anyType"
                        then
                           Writers.P
                            (Payload_Writer,
                             "   type "
                               & Add_Separator (Type_D.Get_Name)
                               & " is" & LF
                               & "     new Web_Services.SOAP.Payloads."
                               & "Abstract_SOAP_Payload" & LF
                               & "   with record" & LF
                               & "     null;" & LF
                               & "   end record;" & LF);

                           XSD_To_Ada.Utils.Gen_Access_Type
                            (Payload_Writer,
                             Add_Separator
                              (Type_D.Get_Name).To_Wide_Wide_String);

                        else
                           Writers.P
                            (Payload_Writer,
                             "   type "
                               & Add_Separator (Type_D.Get_Name)
                               & " is record");

                           XSD_To_Ada.Utils.Print_Type_Definition
                            (Type_D.To_Type_Definition,
                             Indent & "   ",
                             Payload_Writer,
                             Payload_Type_Writer,
                             Type_D.Get_Name,
                             Current.Anonym_Name,
                             Current.Element_Name,
                             Mapping);

                           Writers.P (Payload_Writer, "   end record;" & LF);
                        end if;
                     end if;
                  end if;
               end if;

            elsif not Current.Element_Name.Is_Empty then
               if Current.Element_Name.Length > 10 then
                  US_Response :=
                   Current.Element_Name.Slice
                    (Current.Element_Name.Length - 7,
                     Current.Element_Name.Length);
               end if;

               if Current.Type_Def.Get_Name.Is_Empty then
                  if Current.Element_Name.Length > 10
                    and US_Response.To_UTF_8_String = "Response"
                  then
                     Writers.P
                      (Writer,
                       "   type "
                         & Add_Separator (Current.Element_Name)
                         & " is" & LF
                         & "     new Web_Services.SOAP.Payloads."
                         & "Abstract_SOAP_Payload with" & LF
                         & "     record" & LF
                         & "     "
                         & Add_Separator (Type_D.Get_Name)
                         & LF
                         & "      : Payloads."
                         & Add_Separator (Type_D.Get_Name)
                         & ";");

                     Writers.P (Writer, "     end record;" & LF);

                     Gen_Access_Type
                      (Writer,
                       Add_Separator
                        (Current.Element_Name).To_Wide_Wide_String);

                  else
                     if XSD2Ada.Analyzer.Has_Element_Session (Type_D) then
                        Writers.P
                         (Payload_Writer,
                          "   type "
                            & Add_Separator (Current.Element_Name)
                            & " is" & LF
                            & "     new Web_Services.SOAP.Payloads."
                            & "Abstract_SOAP_Payload"
                            & LF
                            & "   with record");

                        XSD_To_Ada.Utils.Print_Type_Definition
                         (Type_D,
                          Indent & "   ",
                          Payload_Writer,
                          Payload_Type_Writer,
                          Type_D.Get_Name,
                          Current.Anonym_Name,
                          Current.Element_Name,
                          Mapping);

                        Writers.P (Payload_Writer, "   end record;" & LF);

                     else
                        Writers.P
                         (Payload_Writer,
                          "   type "
                            & Add_Separator (Current.Element_Name)
                            & " is record");

                        XSD_To_Ada.Utils.Print_Type_Definition
                         (Type_D,
                          Indent & "   ",
                          Payload_Writer,
                          Payload_Type_Writer,
                          Type_D.Get_Name,
                          Current.Anonym_Name,
                          Current.Element_Name,
                          Mapping);

                        Writers.P (Payload_Writer, "   end record;" & LF);
                     end if;
                  end if;
               else
                  if Current.Element_Name.Length > 10
                    and US_Response.To_Wide_Wide_String = "Response"
                  then
                     Writers.P
                      (Writer,
                       "   type "
                         & Add_Separator (Current.Element_Name)
                         & " is" & LF
                         & "      new Web_Services.SOAP.Payloads."
                         & "Abstract_SOAP_Payload with" & LF
                         & "     record" & LF
                         & "     "
                         & Add_Separator (Type_D.Get_Name)
                         & LF & "       : "
                         & XSD_To_Ada.Mappings.Ada_Type_Qualified_Name
                            (Mapping, Type_D.Get_Name)
                         & ";" & LF
                         & "     end record;" & LF);

                     Gen_Access_Type
                      (Writer,
                       Add_Separator
                        (Current.Element_Name).To_Wide_Wide_String);

                  else
                     if XSD2Ada.Analyzer.Has_Element_Session
                         (Type_D.To_Type_Definition)
                     then
                        Writers.P
                         (Writer,
                          "   type "
                            & Add_Separator (Current.Element_Name)
                            & " is" & LF
                            & "     new Payloads."
                            & Add_Separator (Current.Type_Def.Get_Name)
                            & LF
                            & "   with null record;" & LF);
                     else
                        if Type_D.Get_Base_Type.Get_Name.To_Wide_Wide_String
                             = "anyType"
                        then
                           Writers.P
                            (Writer,
                             "   type "
                               & Add_Separator (Current.Element_Name)
                               & " is" & LF
                               & "     new Web_Services.SOAP.Payloads."
                               & "Abstract_SOAP_Payload" & LF
                               & "   with record" & LF
                               & "     null;" & LF
                               & "   end record;" & LF);

                           XSD_To_Ada.Utils.Gen_Access_Type
                            (Writer,
                             Add_Separator
                              (Current.Element_Name).To_Wide_Wide_String);

                        else
                           Writers.P
                            (Writer,
                             "   type "
                               & Add_Separator (Current.Element_Name)
                               & " is record" & LF
                               & "     "
                               & Add_Separator (Current.Type_Def.Get_Name)
                               & " : Payloads."
                               & Add_Separator (Current.Type_Def.Get_Name)
                               & ";" & LF
                               & "   end record;" & LF);
                        end if;
                     end if;
                  end if;
               end if;

            elsif Current.Min then
               declare
                  Type_Name : League.Strings.Universal_String;

               begin
                  if Type_D.Get_Name.Is_Empty then
                     Type_Name :=
                       Current.Anonym_Name & "_Anonym" & Discriminant_Type;

                  else
                     Type_Name := Type_D.Get_Name & Discriminant_Type;
                  end if;

                  Writers.P
                   (Payload_Writer,
                    "   type Optional_"
                      & Add_Separator (Type_Name)
                      & " is record"
                      & LF
                      & "     Is_Set : Boolean := False;"
                      & LF
                      & "     Value : "
                      & XSD_To_Ada.Mappings.Ada_Type_Qualified_Name
                         (Mapping, Type_Name)
                      & ";"
                      & LF
                      & "   end record;"
                      & LF);
               end;

            elsif Current.Max then
               Writers.P
                (Payload_Writer,
                 "   package "
                   & Add_Separator (Vector_Name)
                   & "_Vectors is" & LF
                   & "     new Ada.Containers.Vectors" & LF
                   & "      (Positive, "
                   & Add_Separator (Vector_Name) & ");" & LF & LF
                   & Gen_Type_Line
                      ("   subtype "
                         & Add_Separator (Vector_Name).To_Wide_Wide_String
                         & "_Vector is "
                         & Add_Separator (Vector_Name).To_Wide_Wide_String
                         & "_Vectors.Vector;",
                       3)
                   & LF);
            end if;

            Writer.N (Payload_Type_Writer.Text);
            Writer.N (Payload_Writer.Text);

            Payload_Type_Writer.Text.Clear;
            Payload_Writer.Text.Clear;
            US_Response.Clear;
         end if;
      end loop;

      Ada.Wide_Wide_Text_IO.Put_Line
       (Ada.Wide_Wide_Text_IO.Standard_Error, Indent & "END Print_Type_Title");
   end Print_Payloads;

   ---------------------------
   -- Print_Type_Definition --
   ---------------------------

   procedure Print_Type_Definition
    (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
     Indent       : Wide_Wide_String;
     Writer       : in out Writers.Writer;
     Writer_types : in out Writers.Writer;
     Name         : League.Strings.Universal_String;
     Anonym_Name  : League.Strings.Universal_String;
     Element_Name : League.Strings.Universal_String;
     Mapping      : XSD_To_Ada.Mappings.Mapping;
     Is_Max_Occur : Boolean := False;
     Is_Min_Occur : Boolean := False)
   is
      use type XML.Schema.Type_Definitions.XS_Type_Definition;

      procedure Print_Term
       (XS_Term      : XML.Schema.Terms.XS_Term;
        Indent       : Wide_Wide_String := "";
        Writer       : in out Writers.Writer;
        Writer_types : in out Writers.Writer;
        Name         : League.Strings.Universal_String;
        Map          : XSD_To_Ada.Mappings.Mapping);

      XS_Particle    : XML.Schema.Particles.XS_Particle;
      XS_Term        : XML.Schema.Terms.XS_Term;
      XS_Base        : XML.Schema.Type_Definitions.XS_Type_Definition;

      CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;

      Choice     : Boolean := False;
      Add_Choise : Boolean := False;
      Add_Anonym : Boolean := False;
      Max_Occurs : Boolean := False;
      Min_Occurs : Boolean := False;

      Name_Kind   : League.Strings.Universal_String;
      Name_Case   : League.Strings.Universal_String;
      Anonym_Vector : League.Strings.Universal_String;

      Anonym_Kind : Writers.Writer;

      Vector_Package : Writers.Writer;

      ----------------
      -- Print_Term --
      ----------------

      procedure Print_Term
       (XS_Term      : XML.Schema.Terms.XS_Term;
        Indent       : Wide_Wide_String := "";
        Writer       : in out Writers.Writer;
        Writer_types : in out Writers.Writer;
        Name         : League.Strings.Universal_String;
        Map          : XSD_To_Ada.Mappings.Mapping)
      is
         use type XML.Schema.Model_Groups.Compositor_Kinds;

         XS_Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
         XS_List        : XML.Schema.Object_Lists.XS_Object_List;
         XS_Particle    : XML.Schema.Particles.XS_Particle;
         Decl           :
           XML.Schema.Element_Declarations.XS_Element_Declaration;
         Type_D         : XML.Schema.Type_Definitions.XS_Type_Definition;
         Type_Name      : League.Strings.Universal_String;

         Optional_Type : League.Strings.Universal_String :=
           League.Strings.Empty_Universal_String;
      begin

         if Is_Min_Occur then
            Optional_Type :=
              League.Strings.To_Universal_String ("Payloads.Optional_");
         end if;

         Now_Term_Level := Now_Term_Level + 1;

         if XS_Term.Is_Model_Group then
            XS_Model_Group := XS_Term.To_Model_Group;
            XS_List := XS_Model_Group.Get_Particles;

            if XS_Model_Group.Get_Compositor =
              XML.Schema.Model_Groups.Compositor_Choice
            then
               Choice := True;

               if Is_Max_Occur then
                  Writers.N
                   (Writer,
                    Gen_Type_Line
                     ("      "
                        & Add_Separator (Name).To_Wide_Wide_String
                        & " : "
                        & Optional_Type.To_Wide_Wide_String
                        & Add_Separator (Name).To_Wide_Wide_String
                        & "_Case",
                      8));

                  Create_Vector_Package
                   (League.Strings.To_Universal_String
                     (Name.To_Wide_Wide_String
                        & "_"
                        & Decl.Get_Name.To_Wide_Wide_String & "Case"),
                    Mapping,
                    Writer,
                    Vector_Package);
               else
                  Writers.P
                   (Writer,
                    Gen_Type_Line
                     ("      "
                        & Add_Separator (Name).To_Wide_Wide_String
                        & " : "
                        & Optional_Type.To_Wide_Wide_String
                        & Add_Separator (Name).To_Wide_Wide_String
                        & "_Case;",
                      8));
               end if;

               if Is_Min_Occur then
                  Writers.P
                    (Vector_Package,
                     "   type Optional_" & Add_Separator (Name)
                     & "_Case is record"
                     & LF
                     & "     Is_Set : Boolean := False;" & LF
                     & "     Value  : Payloads." & Add_Separator (Name)
                     & "_Case;" & LF
                     & "   end record;" & LF);
               end if;

               Name_Kind.Append
                 ("   type " & Add_Separator (Name) & "_Kind is"
                  & LF &  "     (");

               Name_Case.Append
                 ("   type "
                  & Add_Separator (Name) & "_Case" & LF
                  & "     (Kind : " & Add_Separator (Name) & "_Kind" & LF
                  & "      := "
                  & Add_Separator (Name)
                  & "_Kind'First) is record" & LF
                  & "      case Kind is" & LF);

               Add_Choise := True;
            end if;

            if Anonyn_Vector (Now_Term_Level - 1).Term_State
              and not Choice
            then
               declare
                  Vector_Symbol : League.Strings.Universal_String :=
                    League.Strings.Empty_Universal_String;
               begin
                  if Is_Max_Occur then
                     Vector_Symbol := League.Strings.To_Universal_String ("s");
                  end if;

                  Writers.P
                    (Anonym_Kind,
                     "   type "
                     & XSD_To_Ada.Utils.Add_Separator (Name)
                     & "_Anonym is record");

                  Writers.P
                   (Writer,
                    Gen_Type_Line
                     ("      "
                        & Add_Separator (Name).To_Wide_Wide_String
                        & " : "
                        & Optional_Type.To_Wide_Wide_String
                        & Add_Separator (Name).To_Wide_Wide_String
                        & "_Anonym"
                        & Vector_Symbol.To_Wide_Wide_String
                        & ";",
                      8));

                  if Is_Max_Occur then
                     Anonym_Vector.Append
                      ("   package "
                         & Add_Separator (Name)
                         & "_Anonyms_Vectors is" & LF
                         & "     new Ada.Containers.Vectors" & LF
                         & "        (Positive, "
                         & Add_Separator (Name) & "_Anonym);"
                         & LF & LF
                         & Gen_Type_Line
                            ("   subtype "
                               & Add_Separator (Name).To_Wide_Wide_String
                               & "_Anonyms is "
                               & Add_Separator (Name).To_Wide_Wide_String
                               & "_Anonyms_Vectors.Vector;",
                             5)
                         & LF & LF);
                  end if;

                  if Is_Min_Occur then
                     Anonym_Vector.Append
                       ("   type Optional_"
                        & XSD_To_Ada.Utils.Add_Separator (Name)
                        & "_Anonym" & Vector_Symbol.To_Wide_Wide_String
                        & " is record" & LF
                        & "     Is_Set : Boolean := False;" & LF
                        & "     Value  : "
                        & XSD_To_Ada.Utils.Add_Separator (Name)
                        & "_Anonym"
                        & Vector_Symbol.To_Wide_Wide_String
                        & ";" & LF
                        & "   end record;"
                        & LF);
                  end if;
               end;
               Add_Anonym := True;
            end if;

            for J in 1 .. XS_List.Get_Length loop
               Ada.Wide_Wide_Text_IO.Put
                (Ada.Wide_Wide_Text_IO.Standard_Error, Indent);

               XS_Particle := XS_List.Item (J).To_Particle;

               Min_Occurs := False;

               if XS_Particle.Get_Max_Occurs.Unbounded then
                  Max_Occurs := True;
               else
                  if XS_Particle.Get_Max_Occurs.Value > 1 then
                     Max_Occurs := True;

                     if Choice then
                        Writers.P
                         (Writer,
                          Gen_Type_Line
                           ("      "
                              & Add_Separator (Name).To_Wide_Wide_String
                              & " : "
                              & Add_Separator (Name).To_Wide_Wide_String
                              & "_Cases;",
                            8));
                     end if;
                  else
                     Max_Occurs := False;
                  end if;
               end if;

               if XS_Particle.Get_Min_Occurs = 0 then
                  Min_Occurs := True;
               end if;

               Print_Term
                (XS_Particle.Get_Term,
                 Indent & "   ",
                 Writer,
                 Writer_types,
                 Name,
                 Map);

               if J /=  XS_List.Get_Length and Choice then
                  Name_Kind.Append
                    ("," & Wide_Wide_Character'Val (10) & "      ");
               end if;
            end loop;

            Choice := False;

         elsif XS_Term.Is_Element_Declaration then

            Decl := XS_Term.To_Element_Declaration;
            Type_D := Decl.Get_Type_Definition;

            Type_Name :=
              Map.Ada_Type_Qualified_Name
                (Type_D.Get_Name);

            if Type_D.Get_Name.Is_Empty then

               Anonyn_Vector (Now_Term_Level).Term_State := True;

               declare
                  Anonym_Vector : League.Strings.Universal_String;
                  Anonym_Optional_US : League.Strings.Universal_String;
                  Anonym_Discriminant_Type : League.Strings.Universal_String;
               begin

                  if Type_D.To_Complex_Type_Definition.Get_Particle.Get_Term
                    .To_Model_Group.Get_Compositor =
                      XML.Schema.Model_Groups.Compositor_Choice
                  then
                     Anonym_Discriminant_Type :=
                       League.Strings.From_UTF_8_String ("_Case");
                  else
                     Anonym_Discriminant_Type :=
                       League.Strings.Empty_Universal_String;
                  end if;

                  if Max_Occurs then
                     Anonym_Vector :=
                       League.Strings.To_Universal_String ("_Vector");
                  end if;

                  if Min_Occurs and not Max_Occurs then
                     Anonym_Optional_US :=
                       League.Strings.To_Universal_String ("Optional_");
                  end if;

                  if Choice then
                     Name_Kind.Append
                      (Add_Separator (XS_Term.Get_Name) & "_Case");

                     Name_Case.Append
                      ("        when "
                         & Add_Separator (XS_Term.Get_Name).To_Wide_Wide_String
                         & "_Case =>" & LF
                         & Gen_Type_Line
                            ("           "
                               & Add_Separator
                                  (XS_Term.Get_Name).To_Wide_Wide_String
                               & " : Payloads."
                               & Add_Separator
                                  (XS_Term.Get_Name).To_Wide_Wide_String
                               & "_Anonym;",
                             15)
                         & LF);
                  else
                     Writers.P
                       (Writer,
                        "      "
                        & Add_Separator (XS_Term.Get_Name)
                        & " : "
                        & Anonym_Optional_US
                        & Add_Separator (Name & "_" & XS_Term.Get_Name)
                        & "_Anonym"
                        & Anonym_Discriminant_Type
                        & Anonym_Vector
                        & ";");
                  end if;
               end;

               Add_Anonym := False;
            end if;

            if Choice
              and then not Type_D.Get_Name.Is_Empty
            then
               Name_Kind.Append (Add_Separator (XS_Term.Get_Name) & "_Case");

               if Min_Occurs then

                  if not Is_Type_In_Optional_Vector (Type_Name) then
                     Writers.P
                       (Writer_types,
                        "   type Optional_"
                        & XSD_To_Ada.Utils.Add_Separator (Type_Name)
                        & " is record" & LF
                        & "     Is_Set : Boolean := False;" & LF
                        & "     Value : "
                        & Type_Name.To_Wide_Wide_String
                        & ";" & LF
                        & "   end record;" & LF);
                  end if;

                  Name_Case.Append
                   ("        when "
                      & Add_Separator (XS_Term.Get_Name).To_Wide_Wide_String
                      & "_Case =>"
                      & LF
                      & Gen_Type_Line
                         ("           "
                            & Add_Separator
                               (XS_Term.Get_Name).To_Wide_Wide_String
                            & " : "
                            & "Optional_"
                            & Type_Name.To_Wide_Wide_String
                            & ";",
                          15)
                     & LF);
               else
                  Name_Case.Append
                   ("        when "
                      & Add_Separator (XS_Term.Get_Name).To_Wide_Wide_String
                      & "_Case =>"
                      & LF
                      & Gen_Type_Line
                         ("           "
                            & Add_Separator (XS_Term.Get_Name)
                               .To_Wide_Wide_String
                            & " : "
                            & Type_Name.To_Wide_Wide_String
                            & ";",
                          15)
                      & LF);
               end if;
            end if;

            if Type_D.Get_Name.To_UTF_8_String /= ""
              and then not Anonyn_Vector (Now_Term_Level - 2).Term_State
              and then not Choice
            then
               Generate_Type
                 (Type_D,
                  XS_Term,
                  Mapping,
                  Type_Name,
                  Max_Occurs,
                  Min_Occurs,
                  Writer,
                  Writer_types);
            end if;

            if Anonyn_Vector (Now_Term_Level - 2).Term_State
              and not Choice
            then
               Generate_Type
                 (Type_D,
                  XS_Term,
                  Mapping,
                  Type_Name,
                  Max_Occurs,
                  Min_Occurs,
                  Anonym_Kind,
                  Writer_types);
            end if;
         end if;
         Now_Term_Level := Now_Term_Level - 1;
      end Print_Term;

   begin
      XS_Base := Type_D.Get_Base_Type;

      if XS_Base.Get_Type_Category in
        XML.Schema.Complex_Type .. XML.Schema.Simple_Type
        and XS_Base /= Type_D
      then
         Ada.Wide_Wide_Text_IO.Put_Line
           (Ada.Wide_Wide_Text_IO.Standard_Error, Indent & " is new");

         Writers.P
          (Writer,
           Gen_Type_Line
            ("     "
               & Add_Separator (XS_Base.Get_Name).To_Wide_Wide_String
               & " : Payloads."
               & Add_Separator (XS_Base.Get_Name).To_Wide_Wide_String
               & ";", 5));
      end if;

      case Type_D.Get_Type_Category is
         when XML.Schema.Complex_Type =>
            CTD := Type_D.To_Complex_Type_Definition;

            if CTD.Get_Content_Type in Element_Only | Mixed then
               XS_Particle := CTD.Get_Particle;
               XS_Term := XS_Particle.Get_Term;

               Ada.Wide_Wide_Text_IO.Put_Line
                (Ada.Wide_Wide_Text_IO.Standard_Error,
                 Indent
                 & "Complex_Type :"
                 & Type_D.Get_Name.To_Wide_Wide_String);

               if Name.To_UTF_8_String /= "" then
                  Print_Term
                   (XS_Term,
                    Indent & "   ",
                    Writer,
                    Writer_types,
                    Add_Separator (Name),
                    Mapping);

               else
                  if not Anonym_Name.Is_Empty then
                     Print_Term
                      (XS_Term,
                       Indent & "   ",
                       Writer,
                       Writer_types,
                       Add_Separator (Anonym_Name),
                       Mapping);

                  elsif not Element_Name.Is_Empty then
                     Print_Term
                      (XS_Term,
                       Indent & "   ",
                       Writer,
                       Writer_types,
                       Add_Separator (Element_Name),
                       Mapping);
                  end if;
               end if;

               Ada.Wide_Wide_Text_IO.Put_Line
                (Ada.Wide_Wide_Text_IO.Standard_Error,
                 Indent
                   & "End Complex_Type :"
                   & Type_D.Get_Name.To_Wide_Wide_String);
            end if;

         when XML.Schema.Simple_Type =>
            Ada.Wide_Wide_Text_IO.Put
             (Ada.Wide_Wide_Text_IO.Standard_Error,
              Indent & "Simple_Type : " & Type_D.Get_Name.To_Wide_Wide_String);

         when XML.Schema.None =>
            Ada.Wide_Wide_Text_IO.Put_Line
             (Ada.Wide_Wide_Text_IO.Standard_Error, Indent & "NONE!!!");
      end case;

      if Add_Anonym then
         Writers.P
           (Writer_types,
            Anonym_Kind.Text.To_Wide_Wide_String
            & "   end record;" & LF);

         Writers.P (Writer_types, Anonym_Vector);

         Anonym_Kind.Text.Clear;
      end if;

      if Add_Choise then
         Writer_types.N (Name_Kind);
         Writer_types.P (");");
         Writer_types.P;

         Writer_types.N (Name_Case);
         Writer_types.P ("      end case;");
         Writer_types.P ("   end record;");
         Writer_types.P;

         Name_Kind.Clear;
         Name_Case.Clear;
         Add_Choise := False;
      end if;

      Writers.N (Writer_types, Vector_Package.Text);
   end Print_Type_Definition;

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

end XSD_To_Ada.Utils;
