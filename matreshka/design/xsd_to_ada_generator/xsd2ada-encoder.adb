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
with Ada.Wide_Wide_Text_IO;

with XML.Schema.Complex_Type_Definitions;
with XML.Schema.Element_Declarations;
with XML.Schema.Object_Lists;
with XML.Schema.Particles;

with XSD_To_Ada.Utils; use XSD_To_Ada.Utils;
with XSD_To_Ada.Mappings.XML;

package body XSD2Ada.Encoder is

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
     (XS_Term      : XML.Schema.Terms.XS_Term;
      Writer       : in out XSD_To_Ada.Writers.Writer;
      Element_Name : League.Strings.Universal_String;
      Base_Name    : League.Strings.Universal_String;
      Min_Occurs   : Boolean;
      Max_Occurs   : Boolean)
   is
      pragma Unreferenced (Base_Name);
      use League.Strings;

      Spaces_Count : constant Natural := 6;
      New_Spaces : Natural := 0;

      Optional : Boolean := False;
      Vector   : Boolean := False;

      Vector_Element_Marker : League.Strings.Universal_String;
      Optional_Value_Marker : League.Strings.Universal_String;
      Top_Name              : League.Strings.Universal_String;
   begin

      if not Element_Name.Is_Empty then
         Top_Name := XSD_To_Ada.Utils.Add_Separator (Element_Name) & ".";
      end if;

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
           (Add_Indent (Spaces_Count + New_Spaces) & "if Data." & Payload_Type
            & Top_Name
            & Add_Separator (XS_Term.Get_Name)
            & ".Is_Set then");

         New_Spaces := New_Spaces + 3;
      end if;

      if Vector then
         Writer.P
           (Split_Line
              ("for Index in 1 .. Natural (Data." & Payload_Type
               & Top_Name
               & Add_Separator (XS_Term.Get_Name)
               & ".Length) loop", Spaces_Count + New_Spaces));

         New_Spaces := New_Spaces + 3;
      end if;

      Writer.P
        (Split_Line
           ("Encoder_Types.Encode (Data." & Payload_Type
            & Top_Name
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
     (Writer          : in out XSD_To_Ada.Writers.Writer;
      Spec_Writer     : in out XSD_To_Ada.Writers.Writer;
      Procedures_Name : League.Strings.Universal_String;
      Tag_Vector      : in out League.String_Vectors.Universal_String_Vector;
      Namespace       : League.Strings.Universal_String;
      Is_AnyType      : Boolean := False)
   is
      Name : constant League.Strings.Universal_String := Procedures_Name;
   begin

      Tag_Vector.Append (Procedures_Name);

      Spec_Writer.P
        ("   type " & Name & "_Encoder is"
         & LF
         & "   limited new Web_Services.SOAP.Payloads.Encoders."
         & "SOAP_Payload_Encoder"
         & LF & "   with null record;"
         & LF & LF
         & "   overriding function Create"
         & LF
         & "     (Dummy : not null access Boolean) return"
         & LF
         & "      " & Name & "_Encoder;"
         & LF & LF
         & "   overriding procedure Encode" & LF
         & "     (Self    : "
         & Name
         & "_Encoder;" & LF
         & "      Message : Web_Services.SOAP.Payloads."
         & "Abstract_SOAP_Payload'Class;" & LF
         & "      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);"
         & LF);

      XSD_To_Ada.Utils.Gen_Proc_Header (Writer, Name.To_Wide_Wide_String);

      Writer.P
        ("   overriding function Create" & LF
         & "     (Dummy : not null access Boolean)" & LF
         & "      return " & Name & "_Encoder"
         & LF
         & "   is" & LF
         & "     pragma Unreferenced (Dummy);" & LF
         & "   begin" & LF
         & "     return X : "
         & Name & "_Encoder;"
         & LF
         & "   end Create;" & LF);

      if Is_AnyType then
         Writer.P
           ("   overriding procedure Encode" & LF
            & "     (Self    : "
            & Name
            & "_Encoder;" & LF
            & "      Message : Web_Services.SOAP.Payloads."
            & "Abstract_SOAP_Payload'Class;" & LF
            & "      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)"
            & LF
            & "   is" & LF
            & "     pragma Unreferenced (Self, Message);"
            & LF & LF
            & "     use IATS_Types;"
            & LF & LF);

         if Namespace.Ends_With ("crutches") then
            Writer.P
              ("   begin" & LF
               & "      Writer.Start_Prefix_Mapping (IATS_Crutches_Prefix,"
               & LF &
                 "         To_Universal_String (""" & Namespace & """));");

            Writer.P
              ("      Writer.Start_Prefix_Mapping (IATS_Prefix,"
               & LF & "         To_Universal_String " &
                 "(""http://www.actforex.com/iats""));");
         else
            Writer.P
              ("   begin" & LF
               & "      Writer.Start_Prefix_Mapping (IATS_Prefix," & LF &
                 "         To_Universal_String (""" & Namespace & """));");
         end if;

      else
         Writer.P
           ("   overriding procedure Encode" & LF
            & "     (Self    : "
            & Name
            & "_Encoder;" & LF
            & "      Message : Web_Services.SOAP.Payloads."
            & "Abstract_SOAP_Payload'Class;" & LF
            & "      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)"
            & LF
            & "   is" & LF
            & "     pragma Unreferenced (Self);" & LF & LF
            & "     use IATS_Types;" & LF
            & "     Data : Payloads."
            & Name  & LF
            & "       renames Payloads."
            & Name & " (Message);"
            & LF);

         if Namespace.Ends_With ("crutches") then
            Writer.P
              ("   begin" & LF
               & "      Writer.Start_Prefix_Mapping (IATS_Crutches_Prefix,"
               & LF &
                 "         To_Universal_String (""" & Namespace & """));");

            Writer.P
              ("      Writer.Start_Prefix_Mapping (IATS_Prefix,"
               & LF & "         To_Universal_String " &
                 "(""http://www.actforex.com/iats""));");
         else
            Writer.P
              ("   begin" & LF
               & "      Writer.Start_Prefix_Mapping (IATS_Prefix," & LF &
                 "         To_Universal_String (""" & Namespace & """));");
         end if;
      end if;

      Writer.P (Write_Start_Element (Procedures_Name, Namespace));
   end Generate_Overriding_Procedure_Encode_Header;

   -----------------------------
   -- Generate_Package_Header --
   -----------------------------

   procedure Generate_Package_Header
     (Payload_Writer : in out XSD_To_Ada.Writers.Writer) is
   begin
      Payload_Writer.P
        ("with Encoder_Types;" & LF
         & "with Payloads;" & LF
         & "with IATS_Types;" & LF
         & "with League.Strings; use League.Strings;" & LF
         & "with Web_Services.SOAP.Payloads.Encoders.Registry;"
         & LF & LF
         & "package body Encoder is"
         & LF & LF
         & "   IATS_Prefix : constant League.Strings.Universal_String :=" & LF
         & "     League.Strings.To_Universal_String (""iats"");" & LF
         & "   IATS_Crutches_Prefix : constant Universal_String :=" & LF
         & "     League.Strings.To_Universal_String (""iatsc"");" & LF);
   end Generate_Package_Header;

   --------------------------------------
   -- Generate_Procedure_Encode_Header --
   --------------------------------------

   procedure Generate_Procedure_Encode_Header
     (Writer          : in out XSD_To_Ada.Writers.Writer;
      Spec_Writer     : in out XSD_To_Ada.Writers.Writer;
      Procedures_Name : League.Strings.Universal_String) is
   begin
      Spec_Writer.P
        ("   procedure Encode" & LF
         & "     (Data   : IATS_Types."
         & Procedures_Name & ";"
         & LF
         & "      Writer : in out XML.SAX.Writers.SAX_Writer'Class;"
         & LF
         & "      Name   : League.Strings.Universal_String);"
         & LF);

      Writer.P
        ("   procedure Encode" & LF
         & "     (Data   : IATS_Types." & Procedures_Name & ";" & LF
         & "      Writer : in out XML.SAX.Writers.SAX_Writer'Class;" & LF
         & "      Name   : League.Strings.Universal_String)" & LF
         & "   is" & LF
         & "      use IATS_Types;" & LF
         &"   begin");
   end Generate_Procedure_Encode_Header;

   --------------------------
   -- Generate_Simple_Type --
   --------------------------

   procedure Generate_Simple_Type
     (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
      XS_Term      : XML.Schema.Terms.XS_Term;
      Writer       : in out XSD_To_Ada.Writers.Writer;
      Element_Name : League.Strings.Universal_String;
      Base_Name    : League.Strings.Universal_String;
      Min_Occurs   : Boolean;
      Max_Occurs   : Boolean)
   is
      use League.Strings;

      Optional_Value_Marker : League.Strings.Universal_String;
      Top_Name              : League.Strings.Universal_String;
      Base_Type_Name        : League.Strings.Universal_String;
   begin

      if not Base_Name.Is_Empty then
         Base_Type_Name := Base_Name & ".";
      end if;

      if not Element_Name.Is_Empty then
         Top_Name := XSD_To_Ada.Utils.Add_Separator (Element_Name) & ".";
      end if;

      if Min_Occurs
        and then not Max_Occurs
      then
         Optional_Value_Marker :=
           League.Strings.To_Universal_String (".Value");

         Writer.P
           (Split_Line
              ("if Data." & Payload_Type
               & Top_Name
               & Add_Separator (XS_Term.Get_Name)
               & ".Is_Set then", 6));
      end if;

      if Max_Occurs then
         Writer.P
           (Split_Line
              ("for Index in 1 .. Natural (Data." & Payload_Type
            & Top_Name
            & Add_Separator (XS_Term.Get_Name)
            & ".Length) loop", 6));
      end if;

      Writer.N (Write_Start_Element (XS_Term.Get_Name,
                League.Strings.To_Universal_String
                  ("http://www.actforex.com/iats")));

      if Type_D.Get_Base_Type.Get_Name.To_UTF_8_String = "string" then
         if not Type_D.To_Simple_Type_Definition.Get_Lexical_Enumeration
           .Is_Empty
         then
            Writer.P
              (Split_Line
                 ("Writer.Characters (League.Strings.From_UTF_8_String (Data."
                  & Payload_Type
                  & Top_Name
                  & Add_Separator (XS_Term.Get_Name)
                  & Optional_Value_Marker.To_Wide_Wide_String
                  & "'Img));", 6)
               & LF & "  --  "
               & Add_Separator
                 (Type_D.Get_Base_Type.Get_Name));
         else
            Writer.P
              (Split_Line
                 ("Writer.Characters (Data." & Payload_Type
                  & Top_Name
                  & Add_Separator (XS_Term.Get_Name)
                  & Optional_Value_Marker.To_Wide_Wide_String
                  & ");", 6)
               & LF & "  --  "
               & Add_Separator
                 (Type_D.Get_Base_Type.Get_Name));
         end if;

      elsif Type_D.Get_Base_Type.Get_Name.To_UTF_8_String = "decimal" then

         Writer.P
           ("      Writer.Characters" & LF
            & XSD_To_Ada.Utils.Split_Line
         ("(League.Strings.From_UTF_8_String (To_String (Data." & Payload_Type
               & Element_Name
               & Base_Type_Name
               & Add_Separator (XS_Term.Get_Name)
               & Optional_Value_Marker
               & ")));", 8)
            & LF & "  --  "
            & Type_D.Get_Base_Type.Get_Name);

      elsif Type_D.Get_Base_Type.Get_Name.To_UTF_8_String = "positiveInteger"
        or Type_D.Get_Base_Type.Get_Name.To_UTF_8_String = "unsignedShort"
      then
         Writer.P
           ("      Writer.Characters" & LF
            & XSD_To_Ada.Utils.Split_Line
              ("(League.Strings.From_UTF_8_String (Data." & Payload_Type
               & Top_Name
               & Add_Separator (XS_Term.Get_Name)
               & Optional_Value_Marker.To_Wide_Wide_String
               & "'Img)", 8)
            & ");"
            & LF &  "  --  "
            & Add_Separator
              (Type_D.Get_Base_Type.Get_Name));

      elsif Type_D.Get_Base_Type.Get_Name.To_UTF_8_String = "boolean" then

         Writer.P
           (Split_Line
              ("Writer.Characters (Encoder_Types.Image (Data."
               & Payload_Type
               & Top_Name
               & Add_Separator (XS_Term.Get_Name)
               & Optional_Value_Marker.To_Wide_Wide_String & "));"
               & LF & "  --  "
               & Type_D.Get_Base_Type.Get_Name, 6));
      else
         Writer.P
           ("      Writer.Characters (Data." & Payload_Type
            & Top_Name
            & Add_Separator (XS_Term.Get_Name)
            & Optional_Value_Marker.To_Wide_Wide_String
            & ");"
            & LF & "  --  "
            & Type_D.Get_Base_Type.Get_Name);
      end if;

      Writer.N (Write_End_Element
                (XS_Term.Get_Name,
                   League.Strings.To_Universal_String
                     ("http://www.actforex.com/iats")));

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

   -----------------
   -- Print_Model --
   -----------------

   procedure Print_Model
     (Model_Group  : XML.Schema.Model_Groups.XS_Model_Group;
      Writer       : in out XSD_To_Ada.Writers.Writer;
      Writer_types : in out XSD_To_Ada.Writers.Writer;
      Name         : League.Strings.Universal_String;
      Element_Name : League.Strings.Universal_String;
      Base_Name    : League.Strings.Universal_String
      := League.Strings.Empty_Universal_String;
      Choice       : Boolean := False)
   is
      use type XML.Schema.Model_Groups.Compositor_Kinds;

      XS_List        : XML.Schema.Object_Lists.XS_Object_List;
      XS_Particle    : XML.Schema.Particles.XS_Particle;

      Max_Occurs : Boolean := False;
      Min_Occurs : Boolean := False;

      procedure Print_Element
        (XS_Term      : XML.Schema.Terms.XS_Term;
         Writer       : in out XSD_To_Ada.Writers.Writer;
         Writer_types : in out XSD_To_Ada.Writers.Writer;
         Name         : League.Strings.Universal_String);

      procedure Print_Element
        (XS_Term      : XML.Schema.Terms.XS_Term;
         Writer       : in out XSD_To_Ada.Writers.Writer;
         Writer_types : in out XSD_To_Ada.Writers.Writer;
         Name         : League.Strings.Universal_String)
      is
         pragma Unreferenced (Writer_types, Name);
         Decl : constant XML.Schema.Element_Declarations.XS_Element_Declaration
           := XS_Term.To_Element_Declaration;
         Type_D  : constant XML.Schema.Type_Definitions.XS_Type_Definition :=
           Decl.Get_Type_Definition;
      begin
         if XS_Term.Is_Element_Declaration then
            if Choice then
               Writer.P
                 ("       when IATS_Types."
                  & Add_Separator (XS_Term.Get_Name)
                  & "_Case =>");
            end if;

            case Type_D.Get_Type_Category is
               when XML.Schema.Complex_Type =>
                  Generate_Complex_Type
                    (XS_Term      => XS_Term,
                     Writer       => Writer,
                     Element_Name => Element_Name,
                     Base_Name    => Base_Name,
                     Min_Occurs   => Min_Occurs,
                     Max_Occurs   => Max_Occurs);

               when XML.Schema.Simple_Type =>
                  Generate_Simple_Type
                    (Type_D       => Type_D,
                     XS_Term      => XS_Term,
                     Writer       => Writer,
                     Element_Name => Element_Name,
                     Base_Name    => Base_Name,
                     Min_Occurs   => Min_Occurs,
                     Max_Occurs   => Max_Occurs);

               when XML.Schema.None =>
                  Ada.Wide_Wide_Text_IO.Put_Line
                    (Ada.Wide_Wide_Text_IO.Standard_Error, "NONE!!!");
            end case;
         end if;
      end Print_Element;

   begin
      XS_List := Model_Group.Get_Particles;

      if Choice
        and then not Name.Is_Empty
      then
         Writer.P ("      case Data.Kind is" & LF);
      end if;

      for J in 1 .. XS_List.Get_Length loop

         Max_Occurs := False;
         Min_Occurs := False;

         XS_Particle := XS_List.Item (J).To_Particle;

         if XS_Particle.Get_Max_Occurs.Unbounded then
            Max_Occurs := True;
         else
            if XS_Particle.Get_Max_Occurs.Value > 1 then
               Max_Occurs := True;
            end if;
         end if;

         if XS_Particle.Get_Min_Occurs = 0 then
            Min_Occurs := True;
         end if;

         if XS_Particle.Get_Term.Is_Element_Declaration then
            Print_Element
              (XS_Particle.Get_Term,
               Writer,
               Writer_types,
               Name);

         elsif XS_Particle.Get_Term.Is_Model_Group then
            declare
               Model_Groups_Choice :  constant Boolean :=
                 XS_Particle.Get_Term.To_Model_Group.Get_Compositor =
                   XML.Schema.Model_Groups.Compositor_Choice;

               Full_Name      : League.Strings.Universal_String := Name;
               Full_Base_Name : League.Strings.Universal_String
                 := Base_Name;

            begin
               if not Base_Name.Is_Empty then
                  Full_Base_Name.Append ("_Anonym");

                  if Model_Groups_Choice then
                     Writer.P
                       (Split_Line
                          ("case Data." & Payload_Type
                           & Name & "." & Full_Base_Name &".Kind is", 6));
                  end if;
               else
                  Full_Name.Append ("_Anonym");

                  if Model_Groups_Choice then
                     Writer.P
                       (Split_Line ("case Data." & Payload_Type
                        & Full_Name & ".Kind is", 6));
                  end if;
               end if;

               Print_Model
                 (Model_Group  => XS_Particle.Get_Term.To_Model_Group,
                  Writer       => Writer,
                  Writer_types => Writer_types,
                  Name         => League.Strings.Empty_Universal_String,
                  Element_Name => Full_Name & ".",
                  Base_Name    => Full_Base_Name,
                  Choice       => Model_Groups_Choice);

               if Model_Groups_Choice then
                  Writer.P ("      end case;");
               end if;
            end;
         end if;
      end loop;

      if Choice
        and then not Name.Is_Empty
      then
         Writer.P ("      end case;");
      end if;
   end Print_Model;

   ---------------------------
   -- Print_Type_Definition --
   ---------------------------

   procedure Print_Type_Definition
     (Type_D        : XML.Schema.Type_Definitions.XS_Type_Definition;
      Encoder_Types : in out XSD_To_Ada.Writers.Writer;
      Encoder_Spec_Types : in out XSD_To_Ada.Writers.Writer;
      Writer        : in out XSD_To_Ada.Writers.Writer;
      Writer_types  : in out XSD_To_Ada.Writers.Writer;
      Spec_Writer   : in out XSD_To_Ada.Writers.Writer;
      Name          : League.Strings.Universal_String;
      Element_Name  : League.Strings.Universal_String;
      Tag_Vector    : in out League.String_Vectors.Universal_String_Vector;
      Namespace     : League.Strings.Universal_String;
      Choice        : Boolean := False;
      Is_Min_Occur  : Boolean := False;
      Is_Max_Occur  : Boolean := False)
   is
      use type XML.Schema.Type_Definitions.XS_Type_Definition;

      XS_Particle : XML.Schema.Particles.XS_Particle;
      XS_Term     : XML.Schema.Terms.XS_Term;
      XS_Base     : constant XML.Schema.Type_Definitions.XS_Type_Definition
        := Type_D.Get_Base_Type;
      Model_Group : XML.Schema.Model_Groups.XS_Model_Group;

      CTD : constant
        XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition
          := Type_D.To_Complex_Type_Definition;

      Top_Name : League.Strings.Universal_String;
   begin
      if not Element_Name.Is_Empty then
         Top_Name := XSD_To_Ada.Utils.Add_Separator (Type_D.Get_Name);
      end if;

      if XS_Base.Get_Type_Category in
        XML.Schema.Complex_Type
        and XS_Base /= Type_D
      then
         if XS_Base.Get_Name.To_Wide_Wide_String = "anyType" then
            Generate_Overriding_Procedure_Encode_Header
                    (Writer,
                     Spec_Writer,
                     Add_Separator (Name),
                     Tag_Vector,
                     Namespace,
                     True);

            Writer.N (Write_End_Element (Add_Separator (Name), Namespace));
            Writer.P ("   end Encode;" & LF);
            return;
         end if;
      end if;

      case Type_D.Get_Type_Category is
         when XML.Schema.Complex_Type =>

            if CTD.Get_Content_Type in Element_Only | Mixed then
               XS_Particle := CTD.Get_Particle;
               XS_Term := XS_Particle.Get_Term;

               if XS_Term.Is_Model_Group then
                  Model_Group := XS_Term.To_Model_Group;
               end if;
            else
               raise Constraint_Error;
            end if;

            if not Is_Min_Occur
              and then not Is_Max_Occur
            then
               if Type_D.Get_Base_Type.Get_Name.To_UTF_8_String
                 = "anyType"
               then
                  Generate_Overriding_Procedure_Encode_Header
                    (Writer,
                     Spec_Writer,
                     Add_Separator (Name),
                     Tag_Vector,
                     Namespace,
                     True);

                  Writer.N
                    (Write_End_Element (Add_Separator (Name), Namespace));

               elsif XSD_To_Ada.Mappings.XML.Payload_Types.Index (Name)
                 /= 0
               then

                  Payload_Type := League.Strings.To_Universal_String ("Item.");

                  Generate_Overriding_Procedure_Encode_Header
                    (Writer,
                     Spec_Writer,
                     Add_Separator (Name),
                     Tag_Vector,
                     Namespace);

                  if XS_Base.Get_Type_Category in XML.Schema.Complex_Type
                    and XS_Base /= Type_D
                  then
                     Print_Model
                       (Model_Group  =>
                          XS_Base.To_Complex_Type_Definition
                        .Get_Particle.Get_Term.To_Model_Group,
                        Writer       => Writer,
                        Writer_types => Writer_types,
                        Name         => Add_Separator (XS_Base.Get_Name),
                        Element_Name => XS_Base.Get_Name,
                        Base_Name    => Add_Separator (XS_Base.Get_Name),
                        Choice       => Choice);
                  end if;

                  Print_Model
                    (Model_Group  => Model_Group,
                     Writer       => Writer,
                     Writer_types => Writer_types,
                     Name         => Add_Separator (Name),
                     Element_Name => Top_Name,
                     Choice       => Choice);

                  Writer.N
                    (Write_End_Element (Add_Separator (Name), Namespace));

                  Writer.P ("   end Encode;" & LF);
               else
                  Payload_Type.Clear;

                   Generate_Procedure_Encode_Header
                    (Encoder_Types,
                     Encoder_Spec_Types,
                     Add_Separator (Name));

                  Encoder_Types.P
                    ("      Writer.Start_Element" & LF &
                       "        (To_Universal_String (""" & Namespace & """),"
                     & LF & "         Name);");

                  Print_Model
                    (Model_Group  => Model_Group,
                     Writer       => Encoder_Types,
                     Writer_types => Encoder_Spec_Types,
                     Name         => Add_Separator (Name),
                     Element_Name => Top_Name,
                     Choice       => Choice);

                  Encoder_Types.P
                    ("      Writer.End_Element" & LF &
                       "        (To_Universal_String (""" & Namespace & """),"
                     & LF & "         Name);");

                  Encoder_Types.P ("   end Encode;" & LF);
               end if;
            end if;
         when XML.Schema.Simple_Type =>
            null;

         when XML.Schema.None =>
            raise Constraint_Error;
      end case;
   end Print_Type_Definition;

   ----------------------
   -- Print_Type_Title --
   ----------------------

   procedure Print_Type_Title
     (Node_Vector          : XSD2Ada.Analyzer.Items;
      Encoder_Types        : in out XSD_To_Ada.Writers.Writer;
      Encoder_Spec_Types   : in out XSD_To_Ada.Writers.Writer;
      Encoder              : in out XSD_To_Ada.Writers.Writer;
      Encoder_Spec         : in out XSD_To_Ada.Writers.Writer)
   is
      Types        : XSD_To_Ada.Writers.Writer;

      Tag_Vector : League.String_Vectors.Universal_String_Vector;

      Encoder_Writer      : XSD_To_Ada.Writers.Writer;
      Encoder_Type_Writer : XSD_To_Ada.Writers.Writer;

      Encoder_Procedures  : XSD_To_Ada.Writers.Writer;
   begin

      Put_Header (Encoder_Spec_Types);
      Encoder_Spec_Types.P ("with IATS_Types;");
      Encoder_Spec_Types.P ("with XML.SAX.Writers;");
      Encoder_Spec_Types.P ("with League.Strings; use League.Strings;" & LF);
      Encoder_Spec_Types.P ("package Encoder_Types is" & LF);
      Encoder_Spec_Types.P ("   function Image (Item : Boolean) "
                            & "return League.Strings.Universal_String;" & LF);

      Put_Header (Encoder_Types);
      Encoder_Types.P ("package body Encoder_Types is" & LF);
      Encoder_Types.P ("   function Image (Item : Boolean) "
                            & "return League.Strings.Universal_String is");
      Encoder_Types.P ("     begin");
      Encoder_Types.P ("       if Item then");
      Encoder_Types.P
        ("         return League.Strings.To_Universal_String (""true"");");
      Encoder_Types.P ("           else");
      Encoder_Types.P
        ("         return League.Strings.To_Universal_String (""false"");");
      Encoder_Types.P ("       end if;");
      Encoder_Types.P ("   end Image;" & LF);

      Encoder_Spec.P
        ("with XML.SAX.Writers;" & LF
         & "with Web_Services.SOAP.Payloads.Encoders;" & LF & LF
         & "package Encoder is"  & LF);

      for Current of Node_Vector loop
         if Current.Object.Is_Type_Definition then

            Print_Type_Definition
              (Type_D        => Current.Object.To_Type_Definition,
               Encoder_Types => Types,
               Encoder_Spec_Types => Encoder_Spec_Types,
               Writer        => Encoder_Procedures,
               Writer_types  => Encoder_Type_Writer,
               Spec_Writer   => Encoder_Spec,
               Name          => Current.Short_Ada_Type_Name,
               Element_Name  => Current.Element_Name,
               Tag_Vector    => Tag_Vector,
               Namespace     => Current.Get_Namespace,
               Choice        => Current.Choice,
               Is_Min_Occur  => Current.Min,
               Is_Max_Occur  => Current.Max);

         elsif Current.Object.Is_Model_Group then
            null;
         end if;

         Encoder.N (Encoder_Type_Writer.Text);
         Encoder.N (Encoder_Writer.Text);

         Encoder_Type_Writer.Text.Clear;
         Encoder_Writer.Text.Clear;
      end loop;

      Encoder.N (Element_Name.Text);
      Encoder.N (Encoder_Procedures.Text);

      Encoder.P ("   begin");

      for Index in 1 .. Tag_Vector.Length loop
         Encoder.P
           ("   Web_Services.SOAP.Payloads.Encoders.Registry.Register");

         Encoder.P ("     (Payloads."
                    & Add_Separator (Tag_Vector.Element (Index)) & "'Tag,");

         Encoder.P
            ("        "
             & Add_Separator (Tag_Vector.Element (Index))
             & "_Encoder'Tag);");
      end loop;

      Encoder.N ("end Encoder;");

      Encoder_Types.N (Type_Element_Name.Text);
      Encoder_Types.N (Types.Text);

      Encoder_Spec.N ("end Encoder;");

      Encoder_Types.N ("end Encoder_Types;");
      Encoder_Spec_Types.P ("end Encoder_Types;");

      Ada.Wide_Wide_Text_IO.Put_Line (Encoder_Spec.Text.To_Wide_Wide_String);
      Ada.Wide_Wide_Text_IO.Put_Line (Encoder.Text.To_Wide_Wide_String);

      Ada.Wide_Wide_Text_IO.Put_Line
        (Encoder_Spec_Types.Text.To_Wide_Wide_String);
      Ada.Wide_Wide_Text_IO.Put_Line (Encoder_Types.Text.To_Wide_Wide_String);
   end Print_Type_Title;

   -----------------------
   -- Write_End_Element --
   -----------------------

   function Write_End_Element
     (Name      : League.Strings.Universal_String;
      Namespace : League.Strings.Universal_String)
      return League.Strings.Universal_String is
   begin
      return "      Writer.End_Element" & LF &
        "        (To_Universal_String (""" & Namespace & """),"
        & LF & "         " & Add_Separator (Name) & "_Name);" & LF;
   end Write_End_Element;

   -------------------------
   -- Write_Start_Element --
   -------------------------

   function Write_Start_Element
     (Name : League.Strings.Universal_String;
      Namespace : League.Strings.Universal_String)
      return League.Strings.Universal_String
   is
      N : constant League.String_Vectors.Universal_String_Vector :=
        League.Strings.Split (Name, '_');
      Name_Without_Separators : League.Strings.Universal_String;
   begin

      for Index in 1 .. N.Length loop
         Name_Without_Separators.Append (N.Element (Index));
      end loop;

      if Payload_Type.Is_Empty then
         if Type_Elements_Name.Index (Name) = 0 then
            Type_Elements_Name.Append (Name);

            Type_Element_Name.P
              (XSD_To_Ada.Utils.Split_Line
                 (Add_Separator (Name)
                  & "_Name : constant League.Strings.Universal_String :=", 3) &
                 LF & "     To_Universal_String (""" &
                 Name_Without_Separators & """);" & LF);
         end if;
      else

         if Elements_Name.Index (Name) = 0 then
            Elements_Name.Append (Name);

            Element_Name.P
              (XSD_To_Ada.Utils.Split_Line
                 (Add_Separator (Name)
                  & "_Name : constant League.Strings.Universal_String :=", 3)
               & LF
               & "     To_Universal_String ("""
               & Name_Without_Separators & """);" & LF);
         end if;
      end if;

      return "      Writer.Start_Element" & LF &
        "        (To_Universal_String (""" & Namespace & """),"
       & LF & "         " & Add_Separator (Name) & "_Name);" & LF;
   end Write_Start_Element;

end XSD2Ada.Encoder;
