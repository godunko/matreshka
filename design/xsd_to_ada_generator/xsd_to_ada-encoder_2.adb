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
--  $Revision: 4279 $ $Date: 2013-11-19 14:27:35 +0200 (Вт., 19 нояб. 2013) $
------------------------------------------------------------------------------

with Ada.Characters.Wide_Wide_Latin_1;
with Ada.Wide_Wide_Text_IO;

with XML.Schema.Complex_Type_Definitions;
with XML.Schema.Element_Declarations;
with XML.Schema.Model_Groups;
with XML.Schema.Object_Lists;
with XML.Schema.Particles;

with XSD_To_Ada.Encoder; use XSD_To_Ada.Encoder;

package body XSD_To_Ada.Encoder_2 is

   use XML.Schema.Type_Definitions.Complex_Type_Definitions;
   use XSD_To_Ada.Writers;
   use type League.Strings.Universal_String;

   LF : constant Wide_Wide_Character := Ada.Characters.Wide_Wide_Latin_1.LF;

   ----------------
   -- Add_Indent --
   ----------------

   function Add_Indent
     (Spaces_Count : Integer)
      return League.Strings.Universal_String
   is
      Spaces : constant Wide_Wide_String (1 .. 30) := (others => ' ');
   begin
      return
        League.Strings.To_Universal_String (Spaces (1 .. Spaces_Count));
   end Add_Indent;

   ---------------------------
   -- Generate_Complex_Type --
   ---------------------------

   procedure Generate_Complex_Type
     (XS_Term     : XML.Schema.Terms.XS_Term;
      Writer      : in out Writers.Writer;
      Choice_Name : League.Strings.Universal_String;
      Base_Name   : League.Strings.Universal_String;
      Min_Occurs  : Boolean;
      Max_Occurs  : Boolean)
   is
      use League.Strings;

      Spaces_Count : constant Natural := 6;
      New_Spaces : Natural := 0;

      Optional : Boolean := False;
      Vector   : Boolean := False;

      Vector_Element_Marker       : League.Strings.Universal_String;
      Optional_Value_Marker       : League.Strings.Universal_String;
   begin
      if Min_Occurs
        and then not Max_Occurs
      then
         Optional := True;
         Optional_Value_Marker :=
           League.Strings.To_Universal_String (".Value");
      end if;

      if Max_Occurs then
         Vector := True;
         Vector_Element_Marker :=
           League.Strings.To_Universal_String (".Element (Index)");
      end if;

      if Optional then
         Writer.P
           (Add_Indent (Spaces_Count + New_Spaces) & "if Data."
            & Base_Name
            & Add_Separator (XS_Term.Get_Name)
            & ".Is_Set then");

         New_Spaces := New_Spaces + 3;
      end if;

      if Vector then
         Writer.P
           (Add_Indent (Spaces_Count + New_Spaces)
            & "for Index in 1 .. Natural (Data."
            & Base_Name.To_Wide_Wide_String
            & Add_Separator (XS_Term.Get_Name)
            & ".Length) loop");

         New_Spaces := New_Spaces + 3;
      end if;

      Writer.P
        (Gen_Type_Line
           ("Encode (Data."
            & Choice_Name.To_Wide_Wide_String
            & Base_Name.To_Wide_Wide_String
            & Add_Separator (XS_Term.Get_Name)
            & Optional_Value_Marker.To_Wide_Wide_String
            & Vector_Element_Marker.To_Wide_Wide_String
            & ",", New_Spaces + Spaces_Count) & LF
         & Add_Indent (New_Spaces) & "              Writer," & LF
         & Add_Indent (New_Spaces)
         & "              League.Strings.To_Universal_String ("""
         & XS_Term.Get_Name & """));");

      if Vector then
         New_Spaces := New_Spaces - 3;
         Writer.P (Add_Indent (Spaces_Count + New_Spaces) & "end loop;");
      end if;

      if Optional then
         New_Spaces := New_Spaces - 3;

         Writer.P (Add_Indent (Spaces_Count + New_Spaces) & "end if;");
      end if;

      Writer.P;

   end Generate_Complex_Type;

   -------------------------------------------------
   -- Generate_Overriding_Procedure_Encode_Header --
   -------------------------------------------------

   procedure Generate_Overriding_Procedure_Encode_Header
     (Writer          : in out Writers.Writer;
      Spec_Writer     : in out Writers.Writer;
      Procedures_Name : League.Strings.Universal_String;
      Tag_Vector      : in out League.String_Vectors.Universal_String_Vector;
      Is_AnyType      : Boolean := False)
   is
   begin

      Tag_Vector.Append (Procedures_Name);

      Spec_Writer.P
        ("   type " & Add_Separator (Procedures_Name) & "_Encoder is"
         & LF
         & "   limited new Web_Services.SOAP.Payloads.Encoders."
         & "SOAP_Payload_Encoder"
         & LF & "   with null record;"
         & LF & LF
         & "   overriding function Create"
         & LF
         & "     (Dummy : not null access Boolean) return"
         & LF
         & "      " & Add_Separator (Procedures_Name) & "_Encoder;"
         & LF & LF
         & "   overriding procedure Encode" & LF
         & "     (Self    : "
         & Add_Separator (Procedures_Name)
         & "_Encoder;" & LF
         & "      Message : Web_Services.SOAP.Payloads."
         & "Abstract_SOAP_Payload'Class;" & LF
         & "      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);"
         & LF);

      XSD_To_Ada.Utils.Gen_Proc_Header
        (Writer,
         XSD_To_Ada.Utils.Add_Separator (Procedures_Name));

      Writer.P
        ("   overriding function Create" & LF
         & "     (Dummy : not null access Boolean)" & LF
         & "      return " & Add_Separator (Procedures_Name) & "_Encoder"
         & LF
         & "   is" & LF
         & "     pragma Unreferenced (Dummy);" & LF
         & "   begin" & LF
         & "     return X : "
         & Add_Separator (Procedures_Name) & "_Encoder;"
         & LF
         & "   end Create;" & LF);

      if Is_AnyType then
         Writer.P
           ("   overriding procedure Encode" & LF
            & "     (Self    : "
            & Add_Separator (Procedures_Name)
            & "_Encoder;" & LF
            & "      Message : Web_Services.SOAP.Payloads."
            & "Abstract_SOAP_Payload'Class;" & LF
            & "      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)"
            & LF
            & "   is" & LF
            & "     pragma Unreferenced (Self, Message);"
            & LF & LF
            & "     use Payloads;"
            & LF & LF
            & "   begin" & LF
            & "      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);");
      else
         Writer.P
           ("   overriding procedure Encode" & LF
            & "     (Self    : "
            & Add_Separator (Procedures_Name)
            & "_Encoder;" & LF
            & "      Message : Web_Services.SOAP.Payloads."
            & "Abstract_SOAP_Payload'Class;" & LF
            & "      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)"
            & LF
            & "   is" & LF
            & "     pragma Unreferenced (Self);" & LF & LF
            & "     use Payloads;" & LF
            & "     Data : Payloads."
            & Add_Separator (Procedures_Name)  & LF
            & "       renames Payloads."
            & Add_Separator (Procedures_Name) & " (Message);"
            & LF & LF
            & "   begin" & LF
            & "      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);");
      end if;

      Writer.P (Write_Start_Element (Procedures_Name));
   end Generate_Overriding_Procedure_Encode_Header;

   procedure Generate_Package_Header
     (Payload_Writer : in out XSD_To_Ada.Writers.Writer) is
   begin
      Payload_Writer.N
        ("with Payloads;" & LF
         & "with ICTS.Forex;" & LF
         & "with Web_Services.SOAP.Payloads.Encoders.Registry;"
         & LF & LF
         & "pragma Style_Checks (""N"");"
         & LF & LF
         & "package body Encoder is"
         & LF & LF
         & "   IATS_URI : constant League.Strings.Universal_String :=" & LF
         & "     League.Strings.To_Universal_String"
         & " (""http://www.actforex.com/iats"");" & LF
         & "   IATS_Prefix : constant League.Strings.Universal_String :=" & LF
         & "     League.Strings.To_Universal_String (""iats"");"
         & LF & LF
         & "   function Image (Item : Boolean) return League.Strings."
         & "Universal_String is" & LF
         & "     begin" & LF
         & "       if Item then" & LF
         & "         return League.Strings.To_Universal_String (""true"");"
         & LF
         & "           else" & LF
         & "         return League.Strings.To_Universal_String (""false"");"
         & LF
         & "       end if;" & LF
         & "   end Image;");
   end Generate_Package_Header;

   --------------------------------------
   -- Generate_Procedure_Encode_Header --
   --------------------------------------

   procedure Generate_Procedure_Encode_Header
     (Writer          : in out Writers.Writer;
      Procedures_Name : League.Strings.Universal_String) is
   begin
      Writer.P
        ("   procedure Encode" & LF
         & "     (Data : "
         & Procedures_Name & ";"
         & LF
         & "      Writer : in out XML.SAX.Writers.SAX_Writer'Class;"
         & LF
         & "      Name : League.Strings.Universal_String);"
         & LF);

      Writer.P
        ("   procedure Encode" & LF
         & "     (Data : " & Procedures_Name & ";" & LF
         & "      Writer : in out XML.SAX.Writers.SAX_Writer'Class;" & LF
         & "      Name : League.Strings.Universal_String)" & LF
         & "   is" & LF
         & "      use Payloads;" & LF
         &"   begin");
   end Generate_Procedure_Encode_Header;

   --------------------------
   -- Generate_Simple_Type --
   --------------------------

   procedure Generate_Simple_Type
     (Type_D      : XML.Schema.Type_Definitions.XS_Type_Definition;
      XS_Term     : XML.Schema.Terms.XS_Term;
      Writer      : in out Writers.Writer;
      Choice_Name : League.Strings.Universal_String;
      Base_Name   : League.Strings.Universal_String;
      Min_Occurs  : Boolean;
      Max_Occurs  : Boolean)
   is
      use League.Strings;

      Optional_Value_Marker       : League.Strings.Universal_String;
   begin
      if Min_Occurs
        and then not Max_Occurs
      then
         Optional_Value_Marker :=
           League.Strings.To_Universal_String (".Value");

         Writer.P
           ("      if Data."
            & Choice_Name.To_Wide_Wide_String
            & Base_Name.To_Wide_Wide_String
            & Add_Separator (XS_Term.Get_Name)
            & ".Is_Set then");
      end if;

      if Max_Occurs then
         Writer.P
           ("      for Index in 1 .. Natural (Data."
            & Choice_Name.To_Wide_Wide_String
            & Base_Name.To_Wide_Wide_String
            & Add_Separator (XS_Term.Get_Name)
            & ".Length) loop");
      end if;

      Writer.N (Write_Start_Element (XS_Term.Get_Name));

      if Type_D.Get_Base_Type.Get_Name.To_UTF_8_String = "string" then

         if not Type_D.To_Simple_Type_Definition.Get_Lexical_Enumeration
           .Is_Empty
         then
            Writer.P
              (Gen_Type_Line
                 ("Writer.Characters (League.Strings.From_UTF_8_String (Data."
                  & Choice_Name.To_Wide_Wide_String
                  & Base_Name.To_Wide_Wide_String
                  & Add_Separator (XS_Term.Get_Name)
                  & Optional_Value_Marker.To_Wide_Wide_String
                  & "'Img));", 6)
               & LF & "  --  "
               & Add_Separator (Type_D.Get_Base_Type.Get_Name));
         else
            Writer.P
              (Gen_Type_Line
                 ("Writer.Characters (Data."
                  & Choice_Name.To_Wide_Wide_String
                  & Base_Name.To_Wide_Wide_String
                  & Add_Separator (XS_Term.Get_Name)
                  & Optional_Value_Marker.To_Wide_Wide_String
                  & ");", 6)
               & LF & "  --  "
               & Add_Separator (Type_D.Get_Base_Type.Get_Name));
         end if;

      elsif Type_D.Get_Base_Type.Get_Name.To_UTF_8_String = "decimal" then

         Writer.P
           ("      Writer.Characters" & LF
            & XSD_To_Ada.Encoder.Gen_Type_Line
              ("(League.Strings.From_UTF_8_String (To_String (Data."
               & Base_Name.To_Wide_Wide_String
               & Choice_Name.To_Wide_Wide_String
               & Add_Separator (XS_Term.Get_Name)
               & Optional_Value_Marker.To_Wide_Wide_String
               & ")));", 8)
            & LF & "  --  "
            & Type_D.Get_Base_Type.Get_Name);

      elsif Type_D.Get_Base_Type.Get_Name.To_UTF_8_String = "positiveInteger"
        or Type_D.Get_Base_Type.Get_Name.To_UTF_8_String = "unsignedShort"
      then
         Writer.P
           ("      Writer.Characters" & LF
            & XSD_To_Ada.Encoder.Gen_Type_Line
              ("(League.Strings.From_UTF_8_String (Data."
               & Base_Name.To_Wide_Wide_String
               & Choice_Name.To_Wide_Wide_String
               & Add_Separator (XS_Term.Get_Name)
               & Optional_Value_Marker.To_Wide_Wide_String
               & "'Img)", 8)
            & ");"
            & LF &  "  --  "
            & Add_Separator (Type_D.Get_Base_Type.Get_Name));

      elsif Type_D.Get_Base_Type.Get_Name.To_UTF_8_String = "boolean" then

         Writer.P
           ("      Writer.Characters (Image (Data."
            & Base_Name.To_Wide_Wide_String
            & Choice_Name.To_Wide_Wide_String
            & Add_Separator (XS_Term.Get_Name)
            & Optional_Value_Marker.To_Wide_Wide_String
            & "));"
            & LF & "  --  "
            & Type_D.Get_Base_Type.Get_Name);
      else
         Writer.P
           ("      Writer.Characters (Data."
            & Base_Name.To_Wide_Wide_String
            & Choice_Name.To_Wide_Wide_String
            & Add_Separator (XS_Term.Get_Name)
            & Optional_Value_Marker.To_Wide_Wide_String
            & ");"
            & LF & "  --  "
            & Type_D.Get_Base_Type.Get_Name);
      end if;

      Writer.N (Write_End_Element (XS_Term.Get_Name));

      if Min_Occurs
        and then not Max_Occurs
      then
         Writer.P ("      end if;");
      end if;

      if Max_Occurs then
         Writer.P ("      end loop;");
      end if;

      Writer.P;
   end Generate_Simple_Type;

   ---------------------------
   -- Print_Type_Definition --
   ---------------------------

   procedure Print_Type_Definition
    (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
     Indent       : Wide_Wide_String;
     Writer       : in out Writers.Writer;
     Writer_types : in out Writers.Writer;
     Mapping      : XSD_To_Ada.Mappings.Mapping;
     Name         : League.Strings.Universal_String;
     Anonym_Name  : League.Strings.Universal_String;
     Element_Name : League.Strings.Universal_String;
     Is_Min_Occur : Boolean := False)
   is
      use type XML.Schema.Type_Definitions.XS_Type_Definition;
      use League.Strings;

      procedure Print_Term
        (XS_Term      : XML.Schema.Terms.XS_Term;
         Indent       : Wide_Wide_String := "";
         Writer       : in out Writers.Writer;
         Writer_types : in out Writers.Writer;
         Map          : XSD_To_Ada.Mappings.Mapping;
         Name         : League.Strings.Universal_String;
         Base_Name    : League.Strings.Universal_String);

      XS_Particle    : XML.Schema.Particles.XS_Particle;
      XS_Term        : XML.Schema.Terms.XS_Term;
      XS_Base        : XML.Schema.Type_Definitions.XS_Type_Definition;

      CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;

      Choice     : Boolean := False;
      Min_Occurs : Boolean := False;
      Max_Occurs : Boolean := False;

      Choice_Name   : League.Strings.Universal_String;

      ----------------
      -- Print_Term --
      ----------------

      procedure Print_Term
        (XS_Term      : XML.Schema.Terms.XS_Term;
         Indent       : Wide_Wide_String := "";
         Writer       : in out Writers.Writer;
         Writer_types : in out Writers.Writer;
         Map          : XSD_To_Ada.Mappings.Mapping;
         Name         : League.Strings.Universal_String;
         Base_Name    : League.Strings.Universal_String)
      is
         use type XML.Schema.Model_Groups.Compositor_Kinds;

         XS_Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
         XS_List        : XML.Schema.Object_Lists.XS_Object_List;
         XS_Particle    : XML.Schema.Particles.XS_Particle;
         Decl           :
           XML.Schema.Element_Declarations.XS_Element_Declaration;
         Type_D         : XML.Schema.Type_Definitions.XS_Type_Definition;

         Optional_Marker : League.Strings.Universal_String;
      begin
         if Is_Min_Occur then
            Optional_Marker :=
              League.Strings.To_Universal_String ("Value.");
         end if;

         if XS_Term.Is_Model_Group then
            XS_Model_Group := XS_Term.To_Model_Group;
            XS_List := XS_Model_Group.Get_Particles;

            if XS_Model_Group.Get_Compositor =
              XML.Schema.Model_Groups.Compositor_Choice
            then
               Choice := True;

               Choice_Name :=
                 League.Strings.To_Universal_String
                   (Add_Separator (Name) & ".");

               if Base_Name.Is_Empty then
                  Writer.P
                    (Gen_Type_Line
                       ("case Data."
                        & Optional_Marker.To_Wide_Wide_String
                        & Add_Separator (Name) & "."
                        & "Kind is", 5));
               else
                  Writer.P
                    (Gen_Type_Line
                       ("case Data."
                        & Optional_Marker.To_Wide_Wide_String
                        & Add_Separator (Base_Name)
                        & Add_Separator (Name) & "."
                        & "Kind is", 5));
               end if;
            end if;

            for J in 1 .. XS_List.Get_Length loop
               Ada.Wide_Wide_Text_IO.Put
                (Ada.Wide_Wide_Text_IO.Standard_Error, Indent);

               XS_Particle := XS_List.Item (J).To_Particle;

               Min_Occurs := False;

               if XS_Particle.Get_Max_Occurs.Unbounded
                 or (not XS_Particle.Get_Max_Occurs.Unbounded
                       and then XS_Particle.Get_Max_Occurs.Value > 1)
               then
                  Max_Occurs := True;
               else
                  Max_Occurs := False;
               end if;

               if XS_Particle.Get_Min_Occurs = 0 then
                  Min_Occurs := True;
               end if;

               Print_Term
                 (XS_Particle.Get_Term,
                  Indent & "   ", Writer, Writer_types, Map, Name, Base_Name);
            end loop;

            if Choice then
               Choice := False;
               Writer.P ("     end case;" & LF);
               Choice_Name.Clear;
            end if;

         elsif XS_Term.Is_Element_Declaration then
            Decl := XS_Term.To_Element_Declaration;
            Type_D := Decl.Get_Type_Definition;

            if Choice then
               Writer.P
                 ("       when Payloads."
                  & Add_Separator (XS_Term.Get_Name)
                  & "_Case =>");
            end if;

            case Type_D.Get_Type_Category is
               when XML.Schema.Complex_Type =>
                  Generate_Complex_Type
                    (XS_Term => XS_Term,
                     Writer => Writer,
                     Choice_Name => Choice_Name,
                     Base_Name => Base_Name,
                     Min_Occurs => Min_Occurs,
                     Max_Occurs => Max_Occurs);

               when XML.Schema.Simple_Type =>
                  Generate_Simple_Type
                    (Type_D => Type_D,
                     XS_Term => XS_Term,
                     Writer => Writer,
                     Choice_Name => Choice_Name,
                     Base_Name => Base_Name,
                     Min_Occurs => Min_Occurs,
                     Max_Occurs => Max_Occurs);

               when XML.Schema.None =>
                  Ada.Wide_Wide_Text_IO.Put_Line
                    (Ada.Wide_Wide_Text_IO.Standard_Error, "NONE!!!");
            end case;
         end if;
      end Print_Term;

   begin
      XS_Base := Type_D.Get_Base_Type;

      if XS_Base.Get_Type_Category in
        XML.Schema.Complex_Type  -- .. XML.Schema.Simple_Type
        and XS_Base /= Type_D
      then
         Ada.Wide_Wide_Text_IO.Put_Line
           (Ada.Wide_Wide_Text_IO.Standard_Error, Indent & " is new");

         CTD := XS_Base.To_Complex_Type_Definition;

         if CTD.Get_Content_Type in Element_Only | Mixed then
            XS_Particle := CTD.Get_Particle;
            XS_Term := XS_Particle.Get_Term;
               Print_Term
                 (XS_Term,
                  Indent & "   ",
                  Writer,
                  Writer_types,
                  Mapping,
                  League.Strings.To_Universal_String
                    (Add_Separator (XS_Base.Get_Name)),
                  League.Strings.To_Universal_String
                    (Add_Separator (XS_Base.Get_Name) & "."));
         end if;
      end if;

      case Type_D.Get_Type_Category is
         when XML.Schema.Complex_Type =>
            CTD := Type_D.To_Complex_Type_Definition;

            if CTD.Get_Content_Type in Element_Only | Mixed then
               XS_Particle := CTD.Get_Particle;
               XS_Term := XS_Particle.Get_Term;

               if Name.To_UTF_8_String /= "" then
                  Print_Term
                    (XS_Term,
                     Indent & "   ",
                     Writer,
                     Writer_types,
                     Mapping,
                     League.Strings.To_Universal_String
                       (Add_Separator (Name)),
                     League.Strings.Empty_Universal_String);
               else
                  if not Anonym_Name.Is_Empty then
                     Print_Term
                       (XS_Term,
                        Indent & "   ",
                        Writer,
                        Writer_types,
                        Mapping,
                        League.Strings.To_Universal_String
                          (Add_Separator (Anonym_Name)),
                       League.Strings.Empty_Universal_String);
                  elsif not Element_Name.Is_Empty then
                     Print_Term
                       (XS_Term,
                        Indent & "   ",
                        Writer,
                        Writer_types,
                        Mapping,
                        League.Strings.To_Universal_String
                          (Add_Separator (Element_Name)),
                        League.Strings.Empty_Universal_String);
                  end if;
               end if;
            end if;

         when XML.Schema.Simple_Type =>
            Ada.Wide_Wide_Text_IO.Put
             (Ada.Wide_Wide_Text_IO.Standard_Error,
              Indent & "Simple_Type : " & Type_D.Get_Name.To_Wide_Wide_String);

         when XML.Schema.None =>
            Ada.Wide_Wide_Text_IO.Put_Line
             (Ada.Wide_Wide_Text_IO.Standard_Error, Indent & "NONE!!!");
      end case;

   end Print_Type_Definition;

   ----------------------
   -- Print_Type_Title --
   ----------------------

   procedure Print_Type_Title
     (Node_Vector          : XSD_To_Ada.Utils.Items;
      Indent               : Wide_Wide_String;
      Writer               : in out XSD_To_Ada.Writers.Writer;
      Spec_Writer          : in out XSD_To_Ada.Writers.Writer;
      Encoder_Names_Writer : in out XSD_To_Ada.Writers.Writer;
      Tag_Vector           : in out League.String_Vectors
                                       .Universal_String_Vector;
      Mapping              : XSD_To_Ada.Mappings.Mapping)
   is

      Payload_Writer      : XSD_To_Ada.Writers.Writer;
      Payload_Type_Writer : XSD_To_Ada.Writers.Writer;

      Type_D : XML.Schema.Type_Definitions.XS_Type_Definition;

      Discriminant_Type : League.Strings.Universal_String;
      Vector_Name       : League.Strings.Universal_String;
      Anonym_Name       : League.Strings.Universal_String;
      Item              : XSD_To_Ada.Utils.Item;
   begin
      for Index in 1 .. Natural (Node_Vector.Length) loop
         Item := Node_Vector.Element (Index);
         Type_D := Item.Type_Def;

         Discriminant_Type.Clear;

         if Item.Choice then
            Discriminant_Type := League.Strings.From_UTF_8_String ("_Case");
         end if;

         if Type_D.Get_Name.Is_Empty then
            Vector_Name.Clear;
            Vector_Name.Append (Item.Anonym_Name);
            Vector_Name.Append ("_Anonym");
            Vector_Name.Append (Discriminant_Type);
         else
            Vector_Name := Type_D.Get_Name;
         end if;

         if not Item.Max
           and then not Item.Min
           and then Item.Element_Name.Is_Empty
           and then Item.Type_Def
                      .Is_Complex_Type_Definition
         then
            if not Item.Anonym_Name.Is_Empty then
               Anonym_Name :=
                 XSD_To_Ada.Mappings.Ada_Type_Qualified_Name
                   (Mapping,
                    Add_Separator (Item.Anonym_Name)
                    & "_Anonym"
                    & Discriminant_Type);

               Generate_Procedure_Encode_Header (Payload_Writer, Anonym_Name);

               Payload_Writer.P
                 ("      Writer.Start_Element (IATS_URI, Name);");

               XSD_To_Ada.Encoder_2.Print_Type_Definition
                 (Type_D,
                  Indent & "   ",
                  Payload_Writer,
                  Payload_Type_Writer,
                  Mapping,
                  Type_D.Get_Name,
                  Item.Anonym_Name,
                  Item.Element_Name);

               Payload_Writer.P ("      Writer.End_Element (IATS_URI, Name);");

               Payload_Writer.P ("   end Encode;" & LF);
            elsif not Type_D.Get_Name.Ends_With ("Response") then
               if XSD_To_Ada.Utils.Has_Element_Session (Type_D) then

                  Generate_Overriding_Procedure_Encode_Header
                    (Payload_Writer,
                     Spec_Writer,
                     Type_D.Get_Name,
                     Tag_Vector);

                  Print_Type_Definition
                    (Type_D,
                     Indent & "   ",
                     Payload_Writer,
                     Payload_Type_Writer,
                     Mapping,
                     Type_D.Get_Name,
                     Item.Anonym_Name,
                     Item.Element_Name);

                  Payload_Writer.N
                    (Write_End_Element (Type_D.Get_Name));

                  Payload_Writer.P ("   end Encode;" & LF);
               elsif Type_D.Get_Base_Type.Get_Name.To_UTF_8_String =
                 "anyType"
               then
                  Generate_Overriding_Procedure_Encode_Header
                    (Payload_Writer,
                     Spec_Writer,
                     Type_D.Get_Name,
                     Tag_Vector,
                     True);

                  Payload_Writer.N (Write_End_Element (Type_D.Get_Name));

                  Payload_Writer.P ("   end Encode;" & LF);
               else
                  Generate_Procedure_Encode_Header
                    (Payload_Writer,
                     XSD_To_Ada.Mappings.Ada_Type_Qualified_Name
                       (Mapping, Type_D.Get_Name));

                  Payload_Writer.P
                    ("      Writer.Start_Element (IATS_URI, Name);");

                  Print_Type_Definition
                    (Type_D,
                     Indent & "   ",
                     Payload_Writer,
                     Payload_Type_Writer,
                     Mapping,
                     Type_D.Get_Name,
                     Item.Anonym_Name,
                     Item.Element_Name);

                  Payload_Writer.P
                    ("      Writer.End_Element (IATS_URI, Name);");

                  Payload_Writer.P ("   end Encode;" & LF);
               end if;
            end if;

         elsif not Item.Element_Name.Is_Empty then
            if Item.Type_Def.Get_Name.Is_Empty then
               if not Item.Element_Name.Ends_With ("Response")
                 and then XSD_To_Ada.Utils.Has_Element_Session (Type_D)
               then
                     Generate_Overriding_Procedure_Encode_Header
                       (Payload_Writer,
                        Spec_Writer,
                        Item.Element_Name,
                        Tag_Vector);

                     XSD_To_Ada.Encoder_2.Print_Type_Definition
                       (Type_D,
                        Indent & "   ",
                        Payload_Writer,
                        Payload_Type_Writer,
                        Mapping,
                        Type_D.Get_Name,
                        Item.Anonym_Name,
                        Item.Element_Name);

                     Payload_Writer.N (Write_End_Element (Item.Element_Name));

                     Payload_Writer.P ("   end Encode;" & LF);
               end if;
            elsif not Item.Element_Name.Ends_With ("Response") then
               if XSD_To_Ada.Utils.Has_Element_Session (Type_D) then

                  Generate_Overriding_Procedure_Encode_Header
                    (Payload_Writer,
                     Spec_Writer,
                     Item.Element_Name,
                     Tag_Vector);

                  Print_Type_Definition
                    (Type_D,
                     Indent & "   ",
                     Payload_Writer,
                     Payload_Type_Writer,
                     Mapping,
                     Type_D.Get_Name,
                     Item.Anonym_Name,
                     Item.Element_Name);

                  Payload_Writer.N (Write_End_Element (Item.Element_Name));

                  Payload_Writer.P ("   end Encode;" & LF);
               elsif Type_D.Get_Base_Type.Get_Name.To_UTF_8_String
                 = "anyType"
               then
                  Generate_Overriding_Procedure_Encode_Header
                    (Payload_Writer,
                     Spec_Writer,
                     Item.Element_Name,
                     Tag_Vector,
                     True);

                  Payload_Writer.N (Write_End_Element (Item.Element_Name));

                  Payload_Writer.P ("   end Encode;" & LF);
               else
                  Writer.P
                    ("   --  type " & Add_Separator (Item.Element_Name));
               end if;
            end if;
         end if;

         Writer.N (Payload_Type_Writer.Text);
         Writer.N (Payload_Writer.Text);

         Payload_Type_Writer.Text.Clear;
         Payload_Writer.Text.Clear;
      end loop;

      Encoder_Names_Writer.P (Element_Name.Text);

   end Print_Type_Title;

   -----------------------
   -- Write_End_Element --
   -----------------------

   function Write_End_Element
     (Name : League.Strings.Universal_String)
     return League.Strings.Universal_String is
   begin
      return
        League.Strings.To_Universal_String
          ("      Writer.End_Element (IATS_URI, "
           & Add_Separator (Name) & "_Name);" & LF);
   end Write_End_Element;

   -------------------------
   -- Write_Start_Element --
   -------------------------

   function Write_Start_Element
     (Name : League.Strings.Universal_String)
     return League.Strings.Universal_String is
   begin
      if Elements_Name.Index (Name) = 0 then
         Elements_Name.Append (Name);

         Element_Name.P
           (XSD_To_Ada.Encoder.Gen_Type_Line
              (Add_Separator (Name)
               & "_Name : constant League.Strings.Universal_String :=", 3)
            & LF
            & "     League.Strings.To_Universal_String ("""
            & Name & """);" & LF);
      end if;

      return
        League.Strings.To_Universal_String
          ("      Writer.Start_Element (IATS_URI, "
           & Add_Separator (Name) & "_Name);" & LF);
   end Write_Start_Element;

end XSD_To_Ada.Encoder_2;
