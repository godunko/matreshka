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
--  $Revision$ $Date$
------------------------------------------------------------------------------
with Ada.Characters.Wide_Wide_Latin_1;
with Ada.Strings.Wide_Wide_Fixed;
with Ada.Strings.Wide_Wide_Maps;
with Ada.Strings.Wide_Wide_Unbounded;
with Ada.Text_IO;
with Ada.Wide_Wide_Text_IO;

with League.Strings;
with League.String_Vectors;

with XML.SAX.Input_Sources.Streams.Files;
with XML.SAX.Simple_Readers;

with XML.Schema.Element_Declarations;
with XML.Schema.Complex_Type_Definitions;
with XML.Schema.Models;
with XML.Schema.Model_Groups;
with XML.Schema.Named_Maps;
with XML.Schema.Objects.Particles;
with XML.Schema.Objects.Terms.Model_Groups;
with XML.Schema.Object_Lists;
with XML.Schema.Simple_Type_Definitions;
with XML.Schema.Type_Definitions.Complex_Type_Definitions;

with XSD_To_Ada.Mappings;
with XSD_To_Ada.Mappings_XML;
with XSD_To_Ada.Writers;

package body XSD_To_Ada.Encoder is

   use XML.Schema.Type_Definitions.Complex_Type_Definitions;
   use XSD_To_Ada.Writers;

   LF : constant Wide_Wide_Character := Ada.Characters.Wide_Wide_Latin_1.LF;

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

   function Add_Separator
     (Text : League.Strings.Universal_String) return Wide_Wide_String is
   begin
     return Add_Separator (Text.To_Wide_Wide_String);
   end Add_Separator;

   procedure Create_Element_Type
     (Model  : XML.Schema.Models.XS_Model;
      Writer : in out XSD_To_Ada.Writers.Writer)
   is
      Element_Declarations : constant XML.Schema.Named_Maps.XS_Named_Map :=
        Model.Get_Components_By_Namespace
          (Object_Type => XML.Schema.Element_Declaration,
           Namespace   => Namespace);

      Type_D    : XML.Schema.Type_Definitions.XS_Type_Definition;
      XS_Object : XML.Schema.Objects.XS_Object;

      Print_Element : Boolean := True;

   begin
      for J in 1 .. Element_Declarations.Length loop

         XS_Object := Element_Declarations.Item (J);

         Print_Element := True;

         for X in 1 .. Types_Table'Last loop
            if Element_Declarations.Item (J).Get_Name.To_UTF_8_String
              = Types_Table (X).Type_Name.To_UTF_8_String
            then
               Print_Element := False;
            end if;
         end loop;

         if Print_Element
           and Element_Declarations.Item (J).Get_Name.To_UTF_8_String
           /= "Transaction"
             and Element_Declarations.Item (J).Get_Name.To_UTF_8_String
           /= "InstrumentUpdated"
         then
            declare
               XS_Term : XML.Schema.Objects.Terms.XS_Term;
               Decl    : XML.Schema.Element_Declarations.XS_Element_Declaration;
               Name    : League.Strings.Universal_String;
            begin
               Decl := Element_Declarations.Item (J).To_Element_Declaration;
               Type_D := Decl.Get_Type_Definition;

               Name := Find_Type (Type_D.Get_Name, Map);

               if Element_Declarations.Item (J).Get_Name.Length > 10
               then
                  if League.Strings.Slice
                    (Element_Declarations.Item (J).Get_Name,
                     Element_Declarations.Item (J).Get_Name.Length - 7,
                     Element_Declarations.Item (J).Get_Name.Length).To_UTF_8_String = "Response"
                  then
                     null;
                  else
                     if XSD_To_Ada.Encoder.Has_Element_Session
                       (Type_D.To_Type_Definition)
                       and then Type_D.Get_Base_Type.Get_Name.To_UTF_8_String = ""
                     then

                        Tag_Vector.Append (Decl.Get_Name);

                        Writers.P
                          (Spec_Writer,
                           "   type " & Add_Separator (Decl.Get_Name) & "_Encoder is"
                           & LF
                           & "   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder"
                           & LF & "   with null record;"
                           & LF & LF
                           & "   overriding function Create"
                           & LF
                           & "     (Dummy : not null access Boolean) return "
                           & LF
                           & "      " & Add_Separator (Decl.Get_Name) & "_Encoder;"
                           & LF & LF
                           & "   overriding procedure Encode" & LF
                           & "     (Self    : "
                           & Add_Separator (Decl.Get_Name)
                           & "_Encoder;" & LF
                           & "      Message : Web_Services.SOAP.Payloads."
                           & "Abstract_SOAP_Payload'Class;" & LF
                           & "      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);"
                           & LF);

                        Writers.P
                          (Writer,
                           "   overriding function Create" & LF
                           & "     (Dummy : not null access Boolean)" & LF
                           & "      return " & Add_Separator (Decl.Get_Name) & "_Encoder"
                           & LF
                           & "   is" & LF
                           & "     pragma Unreferenced (Dummy);" & LF
                           & "   begin" & LF
                           & "     return X : "
                           & Add_Separator (Decl.Get_Name) & "_Encoder;"
                           & LF
                           & "   end Create;" & LF);

                        Writers.P
                          (Writer,
                           "   overriding procedure Encode" & LF
                           & "     (Self    : "
                           & Add_Separator (Decl.Get_Name)
                           & "_Encoder;" & LF
                           & "      Message : Web_Services.SOAP.Payloads."
                           & "Abstract_SOAP_Payload'Class;" & LF
                           & "      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)"
                           & LF
                           & "   is" & LF
                           & "     pragma Unreferenced (Self);" & LF & LF
                           & "     use Ada.Strings.Unbounded;"
                           & LF
                           & "     use Payloads;" & LF & LF
                           & "     Data : Payloads."
                           & Add_Separator (Decl.Get_Name)  & LF
                           & "       renames Payloads."
                           & Add_Separator (Decl.Get_Name) & " (Message);"
                           & LF & LF
                           & "   begin" & LF
                           & "      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);"
                           & LF & LF
                           & Write_Start_Element
                             (Decl.Get_Name).To_Wide_Wide_String);

                        XSD_To_Ada.Encoder.Print_Type_Definition
                          (Type_D => Type_D,
                           Indent => "",
                           Writer => Writer,
                           Name => Type_D.Get_Name,
                           Full_Anonym_Name => League.Strings.Empty_Universal_String,
                           Base_Name => League.Strings.Empty_Universal_String,
                           Table => Types_Table);

                        Writers.P
                          (Writer,
                           "      Writer.End_Element (IATS_URI, "
                           & Add_Separator (Decl.Get_Name) & "_Name);"
                           & LF
                           & "   end Encode;"
                           & LF);

                     else
                        null;
                        if Element_Declarations.Item (J).Get_Name.To_UTF_8_String
                          /= "OpenSession2"
--                              and then (Element_Declarations.Item (J).Get_Name.To_UTF_8_String
--                                        = "CreateStopOpenOrder"
--                                        or Element_Declarations.Item (J).Get_Name.To_UTF_8_String
--                            = "CreateStopCloseOrder")
                        then

                           XSD_To_Ada.Encoder.Gen_Proc_Header
                             (Writer,
                              XSD_To_Ada.Encoder.Add_Separator (Decl.Get_Name));

                           Tag_Vector.Append (Decl.Get_Name);

                           Writers.P
                             (Spec_Writer,
                              "   type " & Add_Separator (Decl.Get_Name) & "_Encoder is"
                              & LF
                              & "   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder"
                              & LF & "   with null record;"
                              & LF & LF
                              & "   overriding function Create"
                              & LF
                              & "     (Dummy : not null access Boolean) return "
                              & LF
                              & "      " & Add_Separator (Decl.Get_Name) & "_Encoder;"
                              & LF & LF
                              & "   overriding procedure Encode" & LF
                              & "     (Self    : "
                              & Add_Separator (Decl.Get_Name)
                              & "_Encoder;" & LF
                              & "      Message : Web_Services.SOAP.Payloads."
                              & "Abstract_SOAP_Payload'Class;" & LF
                              & "      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);"
                              & LF);

                           Writers.P
                             (Writer,
                              "   overriding function Create" & LF
                              & "     (Dummy : not null access Boolean)" & LF
                              & "      return " & Add_Separator (Decl.Get_Name) & "_Encoder"
                              & LF
                              & "   is" & LF
                              & "     pragma Unreferenced (Dummy);" & LF
                              & "   begin" & LF
                              & "     return X : "
                              & Add_Separator (Decl.Get_Name) & "_Encoder;"
                              & LF
                              & "   end Create;" & LF);

                           Writers.P
                             (Writer,
                              "   overriding procedure Encode" & LF
                              & "     (Self    : "
                              & Add_Separator (Decl.Get_Name)
                              & "_Encoder;" & LF
                              & "      Message : Web_Services.SOAP.Payloads."
                              & "Abstract_SOAP_Payload'Class;" & LF
                              & "      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)"
                              & LF
                              & "   is" & LF
                              & "     pragma Unreferenced (Self);" & LF & LF
                              & "     use Ada.Strings.Unbounded;"
                              & LF
                              & "     use Payloads;" & LF & LF
                              & "     Data : Payloads."
                              & Add_Separator (Decl.Get_Name)  & LF
                              & "       renames Payloads."
                              & Add_Separator (Decl.Get_Name) & " (Message);"
                              & LF & LF
                              & "   begin" & LF
                              & "      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);"
                              & LF & LF
                              & Write_Start_Element
                                (Decl.Get_Name).To_Wide_Wide_String);


                           XSD_To_Ada.Encoder.Print_Type_Definition
                             (Type_D => Type_D,
                              Indent => "",
                              Writer => Writer,
                              Name => Decl.Get_Name,
                              Full_Anonym_Name => League.Strings.Empty_Universal_String,
                              Base_Name => League.Strings.Empty_Universal_String,
                              Table => Types_Table);

                           Writers.P
                             (Writer,
                              "      Writer.End_Element (IATS_URI, "
                              & Add_Separator (Decl.Get_Name) & "_Name);"
                              & LF
                              & "   end Encode;"
                              & LF);
                        end if;
                     end if;
                  end if;
               end if;
            end;
         end if;
      end loop;
   end Create_Element_Type;

   -------------------------
   -- Create_Package_Name --
   -------------------------

   procedure Create_Package_Name
     (Payload_Writer : in out XSD_To_Ada.Writers.Writer) is
   begin
      Writers.P
        (Payload_Writer,
         "with Ada.Containers.Indefinite_Vectors;" & LF
         & "with League.Strings;" & LF
         & "with Interfaces;" & LF
         & "with ICTS.Types;" & LF
         & "with ICTS.Forex;" & LF
         & "with ICTSClient.Types;" & LF
         & "with Web_Services.SOAP.Payloads;" & LF
         & "with Ada.Strings.Unbounded;" & LF & LF
         & "package Payloads is" & LF & LF
         & "   type Decimal_String is new Ada.Strings.Unbounded.Unbounded_String;"
         & LF
         & "   Null_Decimal : constant Decimal_String :=" & LF
         & "     Decimal_String (Ada.Strings.Unbounded.Null_Unbounded_String);"
         & LF & LF
         & "   type Rate_String is new Ada.Strings.Unbounded.Unbounded_String;" & LF
         & "   Null_Rate : constant Rate_String :=" & LF
         & "     Rate_String (Ada.Strings.Unbounded.Null_Unbounded_String);" & LF & LF
         & "   type TimeT is new Interfaces.Unsigned_64;" & LF & LF
         & "   type Diagnosis_Code is range 0 .. 2 ** 32 - 1;" & LF & LF
         & "   type Abstract_IATS_Responce is" & LF
         & "     abstract new Web_Services.SOAP.Payloads.Abstract_SOAP_Payload" & LF
         & "     with null record;" & LF);
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
               XSD_To_Ada.Writers.P
                 (Writer,
                  "type " &
                    XSD_To_Ada.Encoder.Add_Separator (XS_Object.Get_Name)
                  & " is new "
                  & XSD_To_Ada.Encoder.Add_Separator (XS_Base.Get_Name)
                  & ";" & Wide_Wide_Character'Val (10));
            else
               XSD_To_Ada.Writers.N
                 (Writer,
                  "type " &
                    XSD_To_Ada.Encoder.Add_Separator (XS_Object.Get_Name)
                  & " is (");

               for J in 1 .. List.Length loop
                  if J /= List.Length then
                     XSD_To_Ada.Writers.N
                       (Writer,
                        League.Strings.To_Lowercase
                          (List.Element (J)).To_Wide_Wide_String & ", ");
                  else
                     XSD_To_Ada.Writers.P
                       (Writer,
                        League.Strings.To_Lowercase
                          (List.Element (J)).To_Wide_Wide_String
                        & ");"
                        & Wide_Wide_Character'Val (10));
                  end if;
               end loop;
            end if;
         end;
      end loop;
   end Create_Simple_Type;

   procedure Create_Enumeration_Simple_Type
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
            if not List.Is_Empty then
               XSD_To_Ada.Writers.N
                 (Writer,
                  "   type " &
                    XSD_To_Ada.Encoder.Add_Separator
                    (XS_Object.Get_Name.To_Wide_Wide_String) & " is "
                    & Wide_Wide_Character'Val (10) & "     (");

               for J in 1 .. List.Length loop
                  Ada.Text_IO.Put_Line (List.Element (J).To_UTF_8_String);

                  if J /= List.Length then
                     XSD_To_Ada.Writers.N
                       (Writer,
                        League.Strings.To_Lowercase
                          (List.Element (J)).To_Wide_Wide_String & ", ");
                  else
                     XSD_To_Ada.Writers.P
                       (Writer,
                        League.Strings.To_Lowercase
                          (List.Element (J)).To_Wide_Wide_String
                        & ");"
                        & Wide_Wide_Character'Val (10));
                  end if;
               end loop;
            end if;
         end;
      end loop;
   end Create_Enumeration_Simple_Type;

   -------------------------
   -- Create_Complex_Type --
   -------------------------

   procedure Create_Complex_Type
     (Model        : XML.Schema.Models.XS_Model;
      Mapping_Path : League.Strings.Universal_String)
   is
      XS_Object : XML.Schema.Objects.XS_Object;
      Type_D    : XML.Schema.Type_Definitions.XS_Type_Definition;

      Complex_Types : constant XML.Schema.Named_Maps.XS_Named_Map :=
        Model.Get_Components_By_Namespace
          (Object_Type => XML.Schema.Complex_Type,
           Namespace   => Namespace);

      Payload_Writer : XSD_To_Ada.Writers.Writer;

      Current_Out_File : Ada.Text_IO.File_Type;

   begin
      Map := XSD_To_Ada.Encoder.Read_Mapping (Mapping_Path);

      for J in 1 .. Complex_Types.Length loop
         Types_Table (J).Type_Name := Complex_Types.Item (J).Get_Name;
         Types_Table (J).Type_State := True;
      end loop;

      Put_Header (Payload_Writer);

      Create_Package_Name (Payload_Writer);
      Create_Enumeration_Simple_Type (Model, Payload_Writer);

      for J in 1 .. Complex_Types.Length loop
         XS_Object := Complex_Types.Item (J);

         for J in 1 .. Anonyn_Vector'Last loop
            Anonyn_Vector (J).Print_State := False;
            Anonyn_Vector (J).Term_State := False;
         end loop;

         if Complex_Types.Item (J).Get_Name.To_UTF_8_String /= "OpenSession"
--         if Complex_Types.Item (J).Get_Name.To_UTF_8_String = "ModifyConditionalOrderBase"
--           if Complex_Types.Item (J).Get_Name.To_UTF_8_String = "SetPositionItemApplicationData"
--           if Complex_Types.Item (J).Get_Name.To_UTF_8_String = "CreateOpenOrder"
--           if Complex_Types.Item (J).Get_Name.To_UTF_8_String = "BindOrders"
         then
            Print_Type_Title
              (XS_Object.To_Type_Definition,
               "",
               Payload_Writer,
               Spec_Writer);
         end if;
      end loop;

--      Create_Element_Type (Model, Payload_Writer);

      Ada.Text_IO.Create
        (Current_Out_File, Ada.Text_IO.Out_File, "./Encoder.adb");
      Ada.Text_IO.Put_Line (Current_Out_File, "with Ada.Strings.Unbounded;");
      Ada.Text_IO.Put_Line (Current_Out_File, "with Ada.Strings.Wide_Wide_Fixed;");
      Ada.Text_IO.Put_Line (Current_Out_File, "with League.Strings;");
      Ada.Text_IO.Put_Line (Current_Out_File, "with Payloads;");
      Ada.Text_IO.Put_Line (Current_Out_File, "with ICTS.Forex;");
      Ada.Text_IO.Put_Line (Current_Out_File, "with ICTS.Types;");
      Ada.Text_IO.Put_Line (Current_Out_File, "with CLI.Ws_Utils;");

      Ada.Text_IO.Put_Line (Current_Out_File, "package body Encoder is");

      Ada.Text_IO.Put_Line
        (Current_Out_File, "   IATS_URI : constant League.Strings.Universal_String :=");
        Ada.Text_IO.Put_Line
        (Current_Out_File, "     League.Strings.To_Universal_String (""http://www.actforex.com/iats"");");
      Ada.Text_IO.Put_Line
        (Current_Out_File, "   IATS_Prefix : constant League.Strings.Universal_String :=");
        Ada.Text_IO.Put_Line
        (Current_Out_File, "     League.Strings.To_Universal_String (""iats"");");

      Ada.Text_IO.Put
        (Current_Out_File, Element_Name.Text.To_UTF_8_String);
      Ada.Text_IO.Put_Line
        (Current_Out_File, Encoder_Top_Writer.Text.To_UTF_8_String);
      Ada.Text_IO.Put_Line
        (Current_Out_File, Payload_Writer.Text.To_UTF_8_String);

      Ada.Text_IO.Put_Line (Current_Out_File, "   begin");

      for Index in 1 .. Tag_Vector.Length loop
         Ada.Text_IO.Put_Line
           (Current_Out_File,
            "   Web_Services.SOAP.Payloads.Encoders.Registry.Register");

         Ada.Text_IO.Put_Line
           (Current_Out_File,
            "     (Payloads."
            & League.Strings.To_Universal_String
              (Add_Separator (Tag_Vector.Element (Index))).To_UTF_8_String
            & "'Tag, "
            & League.Strings.To_Universal_String
              (Add_Separator (Tag_Vector.Element (Index))).To_UTF_8_String
              & "_Encoder'Tag);");
      end loop;

      Ada.Text_IO.Put_Line (Current_Out_File, "end Encoder;");

      Ada.Text_IO.Close (Current_Out_File);

      Ada.Text_IO.Create
        (Current_Out_File, Ada.Text_IO.Out_File, "./Encoder.ads");

      Ada.Text_IO.Put_Line (Current_Out_File, "package Encoder is");
      Ada.Text_IO.Put_Line
        (Current_Out_File, Spec_Writer.Text.To_UTF_8_String);
      Ada.Text_IO.Put_Line (Current_Out_File, "end Encoder;");

      Ada.Text_IO.Close (Current_Out_File);
   end Create_Complex_Type;

   ---------------------------
   -- Create_Vector_Package --
   ---------------------------

   procedure Create_Vector_Package
     (Type_D_Name  : League.Strings.Universal_String;
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
            exit;
         else
            Added_Vector_Type := True;
         end if;
      end loop;

      if Added_Vector_Type then
          Writers.P
           (Writer_Types,
            "   package "
            & Add_Separator (Type_D_Name) & "_Vectors is "
            & Wide_Wide_Character'Val (10)
            & Gen_Type_Line
              ("     new Ada.Containers.Indefinite_Vectors "
               & "(Positive, "
               & Add_Separator (Type_D_Name) & ");", 7)
            & Wide_Wide_Character'Val (10)
            & Wide_Wide_Character'Val (10)
            & Gen_Type_Line
              ("   subtype " & Add_Separator (Type_D_Name)
               & "s is " & Add_Separator (Type_D_Name)
               & "_Vectors.Vector;", 5)
            & Wide_Wide_Character'Val (10));

         Is_Vector_Type.Append (Type_D_Name);

         if not Is_Type_In_Map (Type_D_Name, Map) then
            Writers.N (Writer, "s");
         end if;

      end if;

      Writers.P (Writer, ";");
   end Create_Vector_Package;

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
        ("Payloads." & XSD_To_Ada.Encoder.Add_Separator (Type_D_Name));
   end Find_Type;

   --------------------
   -- Is_Type_In_Map --
   --------------------

   function Is_Type_In_Map
     (Type_D_Name : League.Strings.Universal_String;
      Map         : XSD_To_Ada.Mappings_XML.Mapping_XML)
      return Boolean
   is
   begin
      for j in 1 .. Map.Map_Vector.Length loop
         if Type_D_Name.To_UTF_8_String =
           Map.Map_Vector.Element (J).To_UTF_8_String
         then
            return True;
         end if;
      end loop;

      return False;
   end Is_Type_In_Map;

   function Is_Type_In_Optional_Vector
     (Type_Name : League.Strings.Universal_String)
      return Boolean
   is
   begin
      for Index in 1 .. Optional_Vector.Length loop
         if Optional_Vector.Element (Index).To_Wide_Wide_String =
           Type_Name.To_Wide_Wide_String
         then
            return True;
         end if;
      end loop;

      Optional_Vector.Append (Type_Name);

      return False;
   end Is_Type_In_Optional_Vector;

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

   -------------------
   -- Gen_Type_Line --
   -------------------

--     function Gen_Type_Line
--       (Str : Wide_Wide_String := "";
--        Tab : Natural := 0)
--        return Wide_Wide_String
--     is
--        use Ada.Strings.Wide_Wide_Unbounded;
--        use Ada.Strings.Wide_Wide_Maps;
--
--        US      : League.Strings.Universal_String
--          := League.Strings.To_Universal_String (Str);
--        US_New : League.Strings.Universal_String;
--
--        Char_Count  : Natural := US.Length + Tab;
--        Used_Char_Count : Natural := 0;
--        Tab_Count : Natural := Tab;
--
--        Index : Natural := 0;
--     begin
--
--        for J in 1 .. Tab_Count loop
--           US_New.Append (" ");
--           Used_Char_Count := Used_Char_Count + 1;
--           Char_Count := Char_Count - 1;
--        end loop;
--
--        for J in 1 .. US.Length loop
--           if Char_Count + Used_Char_Count > 78 then
--              if (US.Element (J).To_Wide_Wide_Character = ':'
--                  and then J /= 1)
--                or (US.Element (J).To_Wide_Wide_Character = '('
--                    and then J /= 1)
--                or (J + 4 < US.Length
--                    and then US.Element (J).To_Wide_Wide_Character = ' '
--                    and then US.Element (J + 1).To_Wide_Wide_Character = 'i'
--                    and then US.Element (J + 2).To_Wide_Wide_Character = 's'
--                    and then US.Element (J + 3).To_Wide_Wide_Character = ' ')
--                or (US.Element (J).To_Wide_Wide_Character = ' '
--                    and then US.Element (J + 1).To_Wide_Wide_Character = '/'
--                    and then US.Element (J + 2).To_Wide_Wide_Character = '='
--                    and then US.Element (J + 3).To_Wide_Wide_Character = ' ')
--                or (J /= 1
--                    and then J + 1 < US.Length
--                    and then US.Element (J).To_Wide_Wide_Character = '.'
--                    and then US.Element (J + 1).To_Wide_Wide_Character /= '.')
--              then
--
--                 Tab_Count := Tab_Count + 2;
--                 Char_Count := US.Length - J;
--                 Used_Char_Count := Tab_Count;
--
--                 US_New.Append (LF & "--  LF");
--
--                 for Count in 1 .. Tab_Count loop
--                    US_New.Append (" ");
--                 end loop;
--
--                 US_New.Append (US.Element (J));
--              else
--                 US_New.Append (US.Element (J));
--              end if;
--           else
--              US_New.Append (US.Element (J));
--           end if;
--        end loop;
--
--        return US_New.To_Wide_Wide_String;
--     end Gen_Type_Line;

   function Gen_Type_Line
     (Str : Wide_Wide_String := "";
      Tab : Natural := 0)
      return Wide_Wide_String
   is
      use Ada.Strings.Wide_Wide_Unbounded;
      use Ada.Strings.Wide_Wide_Maps;

      US      : League.Strings.Universal_String
        := League.Strings.To_Universal_String (Str);
      US_New : League.Strings.Universal_String;

      Char_Count  : Natural := US.Length + Tab;
      Used_Char_Count : Natural := 0;
      Tab_Count : Natural := Tab;

      Index : Natural := 0;

      procedure Trim
        (US        : in out League.Strings.Universal_String;
         US_New    : in out League.Strings.Universal_String;
         Tab_Count : in out Natural)
      is
         Temp_US : League.Strings.Universal_String
           := US.Slice (1, 79 - Tab_Count);
      begin

         for J in reverse 1 .. Temp_US.Length loop

            Ada.Text_IO.Put_Line (J'Img);

            if (Temp_US.Element (J).To_Wide_Wide_Character = ':'
                and then J /= 1)
              or (Temp_US.Element (J).To_Wide_Wide_Character = '('
                  and then J /= 1)
              or (J + 3 < Temp_US.Length
                  and then Temp_US.Element (J).To_Wide_Wide_Character = ' '
                  and then Temp_US.Element (J + 1).To_Wide_Wide_Character = 'i'
                  and then Temp_US.Element (J + 2).To_Wide_Wide_Character = 's'
                  and then Temp_US.Element (J + 3).To_Wide_Wide_Character = ' ')
              or (J + 2 < Temp_US.Length
                  and then Temp_US.Element (J).To_Wide_Wide_Character = ' '
                  and then Temp_US.Element (J + 1).To_Wide_Wide_Character = '/'
                  and then Temp_US.Element (J + 2).To_Wide_Wide_Character = '=')
              or (J /= 1
                  and then J + 1 < Temp_US.Length
                  and then Temp_US.Element (J).To_Wide_Wide_Character = '.'
                  and then Temp_US.Element (J + 1).To_Wide_Wide_Character /= '.')
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

      if US.Length + Tab_Count < 80 then
         US_New.Append (US);
         return US_New.To_Wide_Wide_String;
      end if;

      loop
         if US.Length + Tab > 80 then
            Trim (US, US_New, Tab_Count);
         else
            US_New.Append (US);
            return US_New.To_Wide_Wide_String;
         end if;
      end loop;
   end Gen_Type_Line;

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

   ---------------------------
   -- Generate_Complex_Type --
   ---------------------------

   procedure Generate_Complex_Type
     (Type_D         : XML.Schema.Type_Definitions.XS_Type_Definition;
      Indent         : String;
      XS_Term        : XML.Schema.Objects.Terms.XS_Term;
      Type_Name      : League.Strings.Universal_String;
      Name           : League.Strings.Universal_String;
      Full_Anonym_Name : League.Strings.Universal_String;
      Table          : in out Types_Table_Type_Array;
      Max_Occurs     : in out Boolean;
      Top_Max_Occurs : Boolean;
      Choice         : Boolean := False;
      Writer         : in out Writers.Writer;
      Level          : Natural := 0)
   is
      use League.Strings;
   begin

      Ada.Text_IO.Put_Line ("###" & Level'Img);

      if Has_Top_Level_Type (Type_D, Table) then

         XSD_To_Ada.Encoder.Print_Type_Title
           (XS_Term,
            "   " & Indent,
            Writer,
            Spec_Writer,
            Level);
      end if;

      if Max_Occurs then
         Writers.P
           (Writer,
            Gen_Type_Line ("for Index in 1 .. Natural (Data."
              & Full_Anonym_Name.To_Wide_Wide_String
              & Add_Separator (XS_Term.Get_Name)
              & ".Length) loop", 5));

         Writers.P
           (Writer,
            Gen_Type_Line
              ("Encode (Data."
               & Full_Anonym_Name.To_Wide_Wide_String
               & Add_Separator (XS_Term.Get_Name)
               & ".Element (Index),", 6)
            & LF
            & "              Writer,"
            & LF
            & "              League.Strings.To_Universal_String ("""
            & XS_Term.Get_Name & """));");

         Writers.P (Writer, "     end loop;" & LF);

         Max_Occurs := False;
      elsif Top_Max_Occurs then
         Writers.P
           (Writer,
            Gen_Type_Line
              ("Encode (Data."
               & Full_Anonym_Name.To_Wide_Wide_String
               & "Element (Index)."
               & Add_Separator (XS_Term.Get_Name) & ",", 6)
            & LF
            & "              Writer,"
            & LF
            & "              League.Strings.To_Universal_String ("""
            & XS_Term.Get_Name & """));");
      else
      Writers.P
           (Writer,
            Gen_Type_Line
              ("Encode (Data."
               & Full_Anonym_Name.To_Wide_Wide_String
               & Add_Separator (XS_Term.Get_Name) & ",", 6)
            & LF
            & "              Writer,"
            & LF
            & "              League.Strings.To_Universal_String ("""
            & XS_Term.Get_Name & """));");
      end if;

   end Generate_Complex_Type;

   -------------------
   -- Generate_Type --
   -------------------

   procedure Generate_Type
     (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
      Indent       : String;
      XS_Term      : XML.Schema.Objects.Terms.XS_Term;
      Type_Name    : League.Strings.Universal_String;
      Name         : League.Strings.Universal_String;
      Full_Anonym_Name : League.Strings.Universal_String;
      Base_Choice_Name    : League.Strings.Universal_String;
      Base_Name    : League.Strings.Universal_String;
      Table        : in out Types_Table_Type_Array;
      Max_Occurs   : in out Boolean;
      Top_Max_Occurs : Boolean;
      Min_Occurs   : in out Boolean;
      Choice       : Boolean;
      Writer       : in out Writers.Writer;
      Level : Natural := 0) is
   begin
      case Type_D.Get_Type_Category is
         when XML.Schema.Complex_Type =>

            Ada.Text_IO.Put_Line
              ("#############   Generate_Complex_Type:"
               & Type_D.Get_Name.To_UTF_8_String & "; "
               & "Choice " & Choice'Img
               & "; Top_Max_Occurs : " & Top_Max_Occurs'Img);

            Generate_Complex_Type
              (Type_D => Type_D,
               Indent => Indent,
               XS_Term => XS_Term,
               Type_Name => Type_Name,
               Name => Name,
               Full_Anonym_Name => Full_Anonym_Name,
               Table => Table,
               Max_Occurs => Max_Occurs,
               Top_Max_Occurs => Top_Max_Occurs,
               Choice => Choice,
               Writer => Writer,
               Level => Level);

         when XML.Schema.Simple_Type =>
            Generate_Simple_Type
              (Type_D => Type_D,
               XS_Term => XS_Term,
               Type_Name => Type_Name,
               Name => Name,
               Full_Anonym_Name => Full_Anonym_Name,
               Base_Choice_Name => Base_Choice_Name,
               Base_Name => Base_Name,
               Max_Occurs => Max_Occurs,
               Top_Max_Occurs => Top_Max_Occurs,
               Min_Occurs => Min_Occurs,
               Choice => Choice,
               Writer => Writer);

         when XML.Schema.None =>
            Ada.Text_IO.Put_Line ("NONE!!!");
      end case;
   end Generate_Type;

   --------------------------
   -- Generate_Simple_Type --
   --------------------------

   procedure Generate_Simple_Type
     (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
      XS_Term      : XML.Schema.Objects.Terms.XS_Term;
      Type_Name    : League.Strings.Universal_String;
      Name         : League.Strings.Universal_String;
      Full_Anonym_Name : League.Strings.Universal_String;
      Base_Choice_Name : League.Strings.Universal_String;
      Base_Name    : League.Strings.Universal_String;
      Max_Occurs   : in out Boolean;
      Top_Max_Occurs : Boolean;
      Min_Occurs   : in out Boolean;
      Choice       : Boolean;
      Writer       : in out Writers.Writer)
   is
      use League.Strings;

   begin
      if Type_D.Get_Base_Type.Get_Name.To_UTF_8_String = "string" then

         if Min_Occurs then
            if Top_Max_Occurs then
               Writers.P
                 (Writer,
                  Gen_Type_Line
                    ("if not Data."
                     & Full_Anonym_Name.To_Wide_Wide_String
                     & Base_Choice_Name.To_Wide_Wide_String
                     & "Element (Index)."
                     & Add_Separator (XS_Term.Get_Name) & "."
                     & Add_Separator (XS_Term.Get_Name)
                     & ".Is_Empty then", 5));
            else
               Writers.P
                 (Writer,
                  Gen_Type_Line
                    ("if not Data."
                     & Full_Anonym_Name.To_Wide_Wide_String
                     & Base_Choice_Name.To_Wide_Wide_String
                     & Add_Separator (XS_Term.Get_Name) & "."
                     & Add_Separator (XS_Term.Get_Name)
                     & ".Is_Empty then", 5));
            end if;
         end if;

         Writers.N (Writer, Write_Start_Element (XS_Term.Get_Name));

         if not Type_D.To_Simple_Type_Definition.Get_Lexical_Enumeration
           .Is_Empty
         then
            Writers.P
              (Writer,
               Gen_Type_Line
                 ("Writer.Characters (League.Strings.From_UTF_8_String (Data."
                  & Full_Anonym_Name.To_Wide_Wide_String
                  & Base_Choice_Name.To_Wide_Wide_String
                  & Add_Separator (XS_Term.Get_Name)
                  & "'Img));", 6)
               & LF & "  --  "
               & Add_Separator (Type_D.Get_Base_Type.Get_Name));
         else
            if Top_Max_Occurs then
               if Min_Occurs then
                  Writers.P
                    (Writer,
                     Gen_Type_Line
                       ("Writer.Characters (Data."
                        & Full_Anonym_Name.To_Wide_Wide_String
                        & Base_Choice_Name.To_Wide_Wide_String
                        & "Element (Index)."
                        & Add_Separator (XS_Term.Get_Name) & "."
                        & Add_Separator (XS_Term.Get_Name)
                        & ");", 6)
                     & LF & "  -- "
                     & Add_Separator (Type_D.Get_Base_Type.Get_Name));
               else
                  Writers.P
                    (Writer,
                     Gen_Type_Line
                       ("Writer.Characters (Data."
                        & Full_Anonym_Name.To_Wide_Wide_String
                        & Base_Choice_Name.To_Wide_Wide_String
                        & "Element (Index)."
                        & Add_Separator (XS_Term.Get_Name)
                        & ");", 6)
                     & LF & "  --  "
                     & Add_Separator (Type_D.Get_Base_Type.Get_Name));
               end if;
            else
               if Min_Occurs then
                  Writers.P
                    (Writer,
                     Gen_Type_Line
                       ("Writer.Characters (Data."
                        & Full_Anonym_Name.To_Wide_Wide_String
                        & Base_Choice_Name.To_Wide_Wide_String
                        & Add_Separator (XS_Term.Get_Name) & "."
                        & Add_Separator (XS_Term.Get_Name)
                        & ");", 6)
                     & LF & "  --  "
                     & Add_Separator (Type_D.Get_Base_Type.Get_Name));
               else
                  Writers.P
                    (Writer,
                     Gen_Type_Line
                       ("Writer.Characters (Data."
                        & Full_Anonym_Name.To_Wide_Wide_String
                        & Base_Choice_Name.To_Wide_Wide_String
                        & Add_Separator (XS_Term.Get_Name)
                        & ");", 6)
                     & LF & "  --  "
                     & Add_Separator (Type_D.Get_Base_Type.Get_Name));
               end if;
            end if;
         end if;

         Writers.P
           (Writer,
            "      Writer.End_Element (IATS_URI, "
            & Add_Separator (XS_Term.Get_Name)
            & "_Name);"
            & LF);

         if Min_Occurs then
            Writers.P (Writer, "     end if;");
         end if;

      elsif Type_D.Get_Base_Type.Get_Name.To_UTF_8_String = "decimal" then

         if Min_Occurs then
            if Top_Max_Occurs then
               Writers.P
                 (Writer,
                  (Gen_Type_Line
                     ("if Data."
                      & Full_Anonym_Name.To_Wide_Wide_String
                      & Base_Choice_Name.To_Wide_Wide_String
                      & "Element (Index)."
                      & Add_Separator (XS_Term.Get_Name)
                      & " /= Payloads.Null_Decimal", 5)
                   & LF
                   & "      and then CLI.Ws_Utils.Is_Digits"
                   & LF
                   & "        (Data."
                   & Full_Anonym_Name.To_Wide_Wide_String
                   & "Element (Index)."
                   & Base_Choice_Name.To_Wide_Wide_String
                   & Add_Separator (XS_Term.Get_Name) & ")"
                   & LF
                   & "    then"));
            else
               Writers.P
                 (Writer,
                  (Gen_Type_Line
                     ("if Data."
                      & Full_Anonym_Name.To_Wide_Wide_String
                      & Base_Choice_Name.To_Wide_Wide_String
                      & Add_Separator (XS_Term.Get_Name)
                      & " /= Payloads.Null_Decimal", 5)
                   & LF
                   & "      and then CLI.Ws_Utils.Is_Digits"
                   & LF
                   & "        (Data."
                   & Base_Choice_Name.To_Wide_Wide_String
                   & Add_Separator (XS_Term.Get_Name) & ")"
                   & LF
                   & "    then"));
            end if;
         end if;

         Writers.N (Writer, Write_Start_Element (XS_Term.Get_Name));

         if Choice then
            if Top_Max_Occurs then
               Writers.P
                 (Writer,
                  "      Writer.Characters" & LF
                  & "        (League.Strings.From_UTF_8_String" & LF
                  & Gen_Type_Line
                    ("(To_String (Data."
                     & Name.To_Wide_Wide_String & "."
                     & Base_Name.To_Wide_Wide_String
                     & "Element (Index)."
                     & Add_Separator (XS_Term.Get_Name)
                     & ")));", 13)
                  & LF & "  --  "
                  & Type_D.Get_Base_Type.Get_Name);
            else
               Writers.P
                 (Writer,
                  "      Writer.Characters" & LF
                  & "        (League.Strings.From_UTF_8_String" & LF
                  & Gen_Type_Line
                    ("(To_String (Data."
                     & Name.To_Wide_Wide_String & "."
                     & Base_Name.To_Wide_Wide_String
                     & Add_Separator (XS_Term.Get_Name)
                     & ")));", 13)
                  & LF & "  --  "
                  & Type_D.Get_Base_Type.Get_Name);
            end if;
         else
            if Top_Max_Occurs then
               Writers.P
                 (Writer,
                  "      Writer.Characters" & LF
                  & "        (League.Strings.From_UTF_8_String" & LF
                  & Gen_Type_Line
                    ("(To_String (Data."
                     & Full_Anonym_Name.To_Wide_Wide_String
                     & Base_Choice_Name.To_Wide_Wide_String
                     & "Element (Index)."
                     & Add_Separator (XS_Term.Get_Name)
                     & ")));", 13)
                  & LF & "  --  "
                  & Type_D.Get_Base_Type.Get_Name);
            else
               Writers.P
                 (Writer,
                  "      Writer.Characters" & LF
                  & "        (League.Strings.From_UTF_8_String" & LF
                  & Gen_Type_Line
                    ("(To_String (Data."
                     & Full_Anonym_Name.To_Wide_Wide_String
                     & Base_Choice_Name.To_Wide_Wide_String
                     & Add_Separator (XS_Term.Get_Name)
                     & ")));", 13)
                  & LF & "  --  "
                  & Type_D.Get_Base_Type.Get_Name);
            end if;
         end if;

         Writers.P
           (Writer,
            "      Writer.End_Element (IATS_URI, "
            & Add_Separator (XS_Term.Get_Name)
            & "_Name);"
            & LF);

         if Min_Occurs then
            Writers.P (Writer, "     end if;");
         end if;

      elsif Type_D.Get_Base_Type.Get_Name.To_UTF_8_String = "positiveInteger" then

         Writers.N (Writer, Write_Start_Element (XS_Term.Get_Name));

         if Top_Max_Occurs then
            Writers.P
              (Writer,
               "      Writer.Characters" & LF
               & "        (League.Strings.To_Universal_String" & LF
               & "           (Ada.Strings.Wide_Wide_Fixed.Trim" & LF
               & "              (" & Find_Type (Type_D.Get_Name, Map)
               & "'Wide_Wide_Image" & LF
               & Gen_Type_Line
                 ("(Data."
                  & Full_Anonym_Name.To_Wide_Wide_String
                  & Base_Choice_Name.To_Wide_Wide_String
                  & "Element (Index)."
                  & Add_Separator (XS_Term.Get_Name) & "),", 15)
               & LF
               & "            Ada.Strings.Both)));"
               & LF &  "  --  "
               & Add_Separator (Type_D.Get_Base_Type.Get_Name));
         else
            Writers.P
              (Writer,
               "      Writer.Characters" & LF
               & "        (League.Strings.To_Universal_String" & LF
               & "           (Ada.Strings.Wide_Wide_Fixed.Trim" & LF
               & "              (" & Find_Type (Type_D.Get_Name, Map)
               & "'Wide_Wide_Image" & LF
               & "               (Data."
               & Full_Anonym_Name & Base_Choice_Name
               & Add_Separator (XS_Term.Get_Name) & ")," & LF
               & "            Ada.Strings.Both)));"
               & LF & "  --  "
               & Add_Separator (Type_D.Get_Base_Type.Get_Name));
         end if;

         Writers.P
           (Writer,
            "      Writer.End_Element (IATS_URI, "
            & Add_Separator (XS_Term.Get_Name)
            & "_Name);"
            & LF);

      elsif Type_D.Get_Base_Type.Get_Name.To_UTF_8_String = "boolean" then

         Writers.N (Writer, Write_Start_Element (XS_Term.Get_Name));

         if Top_Max_Occurs then
            Writers.P
              (Writer,
               "      Writer.Characters (CLI.Ws_Utils.Image"
               & LF
               & "        (Data."
               & Full_Anonym_Name & Base_Choice_Name & "Element (Index)."
               & Add_Separator (XS_Term.Get_Name)
               & "));"
               & LF & "  --  "
               & Type_D.Get_Base_Type.Get_Name);
         else
            Writers.P
              (Writer,
               "      Writer.Characters (CLI.Ws_Utils.Image"
               & LF
               & "        (Data."
               & Full_Anonym_Name & Base_Choice_Name
               & Add_Separator (XS_Term.Get_Name)
               & "));"
               & LF & "  --  "
               & Type_D.Get_Base_Type.Get_Name);
         end if;

         Writers.P
           (Writer,
            "      Writer.End_Element (IATS_URI, "
            & Add_Separator (XS_Term.Get_Name)
            & "_Name);"
            & LF);

      else
         Writers.N (Writer, Write_Start_Element (XS_Term.Get_Name));

         if Top_Max_Occurs then
            Writers.P
              (Writer,
               "      Writer.Characters (IATS_URI, Data."
               & Full_Anonym_Name & Base_Choice_Name & "Element (Index)."
               & Add_Separator (XS_Term.Get_Name)
               & "));"
               & LF & "  --  "
               & Type_D.Get_Base_Type.Get_Name);
         else
            Writers.P
              (Writer,
               "      Writer.Characters (IATS_URI, Data."
               & Full_Anonym_Name & Base_Choice_Name
               & Add_Separator (XS_Term.Get_Name)
               & "));"
               & LF & "  --  "
               & Type_D.Get_Base_Type.Get_Name);
         end if;

         Writers.P
           (Writer,
            "      Writer.End_Element (IATS_URI, "
            & Add_Separator (XS_Term.Get_Name)
            & "_Name);"
            & LF);
      end if;
   end Generate_Simple_Type;

   ------------------------
   -- Has_Top_Level_Type --
   ------------------------

   function Has_Top_Level_Type
     (Type_D : XML.Schema.Type_Definitions.XS_Type_Definition;
      Table  : Types_Table_Type_Array)
      return Boolean is
   begin
      for j in 1 .. Table'Last loop
         if Type_D.Get_Name.To_Wide_Wide_String =
           Table (J).Type_Name.To_Wide_Wide_String
           and Table (J).Type_State
         then
            return True;
         end if;
      end loop;

      return False;

   end Has_Top_Level_Type;

   --------------
   -- New_Line --
   --------------

   procedure New_Line (Self : in out XSD_To_Ada.Writers.Writer) is
   begin
      Self.P ("");
   end New_Line;

   ------------------------
   -- Print_Content_Type --
   ------------------------

   procedure Print_Content_Type
     (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
      Indent       : String := "";
      Writer       : in out Writers.Writer;
      Writer_types : in out Writers.Writer;
      Name         : League.Strings.Universal_String;
      Map          : XSD_To_Ada.Mappings_XML.Mapping_XML)
   is
      use type XML.Schema.Type_Definitions.XS_Type_Definition;

      XS_Particle    : XML.Schema.Objects.Particles.XS_Particle;
      XS_Term        : XML.Schema.Objects.Terms.XS_Term;

      CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;
      STD  : XML.Schema.Simple_Type_Definitions.XS_Simple_Type_Definition;

      ----------------
      -- Print_Term --
      ----------------

      procedure Print_Term
        (XS_Term      : XML.Schema.Objects.Terms.XS_Term;
         Indent       : String := "";
         Writer       : in out Writers.Writer;
         Writer_types : in out Writers.Writer;
         Name         : League.Strings.Universal_String;
         Map          : XSD_To_Ada.Mappings_XML.Mapping_XML)
      is
         use type XML.Schema.Objects.Terms.Model_Groups.Compositor_Kinds;

         XS_Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
         XS_List        : XML.Schema.Object_Lists.XS_Object_List;
         XS_Particle    : XML.Schema.Objects.Particles.XS_Particle;
         Decl           : XML.Schema.Element_Declarations.XS_Element_Declaration;

         Type_D    : XML.Schema.Type_Definitions.XS_Type_Definition;
         Type_Name : League.Strings.Universal_String;
      begin
         Ada.Text_IO.Put (Indent);
         Ada.Text_IO.Put_Line ("Type " & XS_Term.Get_Type'Img);
         Ada.Text_IO.Put (Indent);
         Ada.Text_IO.Put_Line
           ("XS_Term.Get_Name =" & XS_Term.Get_Name.To_UTF_8_String);

         if XS_Term.Is_Model_Group then
            XS_Model_Group := XS_Term.To_Model_Group;
            XS_List := XS_Model_Group.Get_Particles;
            Ada.Text_IO.Put_Line (Indent & XS_Model_Group.Get_Compositor'Img);

            for J in 1 .. XS_List.Get_Length loop
               Ada.Text_IO.Put (Indent);
               XS_Particle := XS_List.Item (J).To_Particle;

               Print_Term
                 (XS_Particle.Get_Term,
                  Indent & "   ", Writer, Writer_types, Name, Map);
            end loop;

         elsif XS_Term.Is_Element_Declaration then
            Decl := XS_Term.To_Element_Declaration;
            Type_D := Decl.Get_Type_Definition;

            Type_Name := Find_Type (Type_D.Get_Name, Map);

            case Type_D.Get_Type_Category is
               when XML.Schema.Complex_Type | XML.Schema.Simple_Type =>
                  Writers.P
                    (Writer,
                     "      "
                     & XSD_To_Ada.Encoder.Add_Separator
                       (XS_Term.Get_Name)
                     & " : "
                     & Type_Name.To_Wide_Wide_String & ";  -- gbgfbh");

               when XML.Schema.None =>
                  Ada.Text_IO.Put_Line (Indent & "NONE!!!");
            end case;
         end if;
      end Print_Term;

   begin

      if Type_D.Get_Base_Type.Get_Name.To_UTF_8_String /= "" then
         Writers.P
           (Writer,
            Gen_Type_Line ("      "
            & Add_Separator (Type_D.Get_Base_Type.Get_Name.To_Wide_Wide_String)
            & " : Payloads."
            & Add_Separator (Type_D.Get_Base_Type.Get_Name.To_Wide_Wide_String)
            & ";", 8));
      end if;

      case Type_D.Get_Type_Category is
         when XML.Schema.Complex_Type =>
            CTD := Type_D.To_Complex_Type_Definition;

            if CTD.Get_Content_Type in Element_Only | Mixed then
               Ada.Text_IO.Put_Line
                 (Indent & "Complex_Type :" & Type_D.Get_Name.To_UTF_8_String);

                  XS_Particle := CTD.Get_Particle;
                  XS_Term := XS_Particle.Get_Term;

                  Print_Term
                    (XS_Term, Indent & "   ", Writer, Writer_types, Name, Map);

               Ada.Text_IO.Put_Line
                 (Indent & "End Complex_Type :" & Type_D.Get_Name.To_UTF_8_String);
            end if;

         when XML.Schema.Simple_Type =>
            Ada.Text_IO.Put
              (Indent & "Simple_Type : " & Type_D.Get_Name.To_UTF_8_String);
            STD := Type_D.To_Simple_Type_Definition;

         when XML.Schema.None =>
            Ada.Text_IO.Put_Line (Indent & "NONE!!!");
      end case;
   end Print_Content_Type;

   ----------------------
   -- Print_Type_Title --
   ----------------------

   procedure Print_Type_Title
     (Type_D      : XML.Schema.Type_Definitions.XS_Type_Definition;
      Indent      : String;
      Writer      : in out XSD_To_Ada.Writers.Writer;
      Spec_Writer : in out XSD_To_Ada.Writers.Writer;
      Level       : Positive := 1)
   is
      use League.Strings;

      Is_Record   : Boolean := False;

      US_Response : League.Strings.Universal_String;

      Payload_Writer      : XSD_To_Ada.Writers.Writer;
      Payload_Type_Writer : XSD_To_Ada.Writers.Writer;
   begin

      Ada.Text_IO.Put_Line
        ("START Print_Type_Title Type_D="  & Type_D.Get_Name.To_UTF_8_String);

    for J in 1 .. Types_Table'Last loop
         if Type_D.Get_Name.To_UTF_8_String = Types_Table (J).Type_Name.To_UTF_8_String
           and then Types_Table (J).Type_State
         then
          Types_Table (J).Type_State := False;

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
               null;
            else
               if XSD_To_Ada.Encoder.Has_Element_Session
                 (Type_D.To_Type_Definition)
               then
                  XSD_To_Ada.Encoder.Gen_Proc_Header
                    (Writer, XSD_To_Ada.Encoder.Add_Separator (Type_D.Get_Name));

                  Tag_Vector.Append (Type_D.Get_Name);

            Writers.P
              (Spec_Writer,
               "   type " & Add_Separator (Type_D.Get_Name) & "_Encoder is"
               & LF
               & "   limited new Web_Services.SOAP.Payloads.Encoders.SOAP_Payload_Encoder"
               & LF & "   with null record;"
               & LF & LF
               & "   overriding function Create"
               & LF
               & "     (Dummy : not null access Boolean) return "
               & LF
               & "      " & Add_Separator (Type_D.Get_Name) & "_Encoder;"
               & LF & LF
               & "   overriding procedure Encode" & LF
               & "     (Self    : "
               & Add_Separator (Type_D.Get_Name)
               & "_Encoder;" & LF
               & "      Message : Web_Services.SOAP.Payloads."
               & "Abstract_SOAP_Payload'Class;" & LF
               & "      Writer  : in out XML.SAX.Writers.SAX_Writer'Class);"
               & LF);

            Writers.P
              (Top_Level_Writer (Level),
               "   overriding function Create" & LF
               & "     (Dummy : not null access Boolean)" & LF
               & "      return " & Add_Separator (Type_D.Get_Name) & "_Encoder"
               & LF
               & "   is" & LF
               & "     pragma Unreferenced (Dummy);" & LF
               & "   begin" & LF
               & "     return X : "
               & Add_Separator (Type_D.Get_Name) & "_Encoder;"
               & LF
               & "   end Create;" & LF);

                  Writers.P
                    (Top_Level_Writer (Level),
                     "   overriding procedure Encode" & LF
                     & "     (Self    : "
                     & Add_Separator (Type_D.Get_Name)
                     & "_Encoder;" & LF
                     & "      Message : Web_Services.SOAP.Payloads."
                     & "Abstract_SOAP_Payload'Class;" & LF
                     & "      Writer  : in out XML.SAX.Writers.SAX_Writer'Class)"
                     & LF
                     & "   is" & LF
                     & "     pragma Unreferenced (Self);" & LF & LF
                     & "     use Payloads;" & LF
                     & "     use Ada.Strings.Unbounded;" & LF & LF
                     & "     Data : Payloads."
                     & Add_Separator (Type_D.Get_Name)  & LF
                     & "       renames Payloads."
                     & Add_Separator (Type_D.Get_Name) & " (Message);"
                     & LF & LF
                     & "   begin" & LF
                     & "      Writer.Start_Prefix_Mapping (IATS_Prefix, IATS_URI);");

            Writers.P
              (Top_Level_Writer (Level),
               XSD_To_Ada.Encoder.Write_Start_Element (Type_D.Get_Name));

                  XSD_To_Ada.Encoder.Print_Type_Definition
                    (Type_D => Type_D,
                     Indent => "",
                     Writer => Top_Level_Writer (Level),
                     Name => Type_D.Get_Name,
                     Full_Anonym_Name => League.Strings.Empty_Universal_String,
                     Base_Name => League.Strings.Empty_Universal_String,
                     Table => Types_Table);

                  Writers.P
                    (Top_Level_Writer (Level),
                     "      Writer.End_Element (IATS_URI, "
                     & Add_Separator (Type_D.Get_Name) & "_Name);"
                     & LF
                     & "   end Encode;"
                     & LF);
               else
                  null;
                  Ada.Text_IO.Put_Line ("else 1408");
              end if;
            end if;

            Writer.N (Top_Level_Writer (Level).Text);
            Writer.N (Payload_Writer.Text);

            Top_Level_Writer (Level).Text.Clear;
       end if;
         US_Response.Clear;
    end loop;

      Ada.Text_IO.Put_Line ("END Print_Type_Title");
   end Print_Type_Title;

   ----------------------
   -- Print_Type_Title --
   ----------------------

   procedure Print_Type_Title
     (XS_Term     : XML.Schema.Objects.Terms.XS_Term;
      Indent      : String;
      Writer      : in out XSD_To_Ada.Writers.Writer;
      Spec_Writer : in out XSD_To_Ada.Writers.Writer;
      Level       : Natural := 0)
   is
      use League.Strings;

      Payload_Writer      : XSD_To_Ada.Writers.Writer;
      Payload_Type_Writer : XSD_To_Ada.Writers.Writer;

      Decl   : XML.Schema.Element_Declarations.XS_Element_Declaration;
      Type_D : XML.Schema.Type_Definitions.XS_Type_Definition;

      US_Response  : League.Strings.Universal_String;
      Mapping_Name : League.Strings.Universal_String;

   begin


      Decl := XS_Term.To_Element_Declaration;
      Type_D := Decl.Get_Type_Definition;

      Mapping_Name := Find_Type (Type_D.Get_Name, Map);

      Ada.Text_IO.Put_Line
        ("START Print_Type_Title XS_Term Type_D=" & Type_D.Get_Name.To_UTF_8_String);

      for J in 1 .. Types_Table'Last loop
         if Type_D.Get_Name.To_UTF_8_String = Types_Table (J).Type_Name.To_UTF_8_String
           and then Types_Table (J).Type_State
         then
            Types_Table (J).Type_State := False;

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
               null;
            else
               if XSD_To_Ada.Encoder.Has_Element_Session
                 (Type_D.To_Type_Definition)
               then
                  null;
               else
                  Writers.P
                    (Top_Level_Writer (Level),
                     "   procedure Encode" & LF
                     & "     (Data : "
                     & Mapping_Name & ";" & LF
                     & "      Writer : in out XML.SAX.Writers.SAX_Writer'Class;"
                     & LF
                     & "      Name : League.Strings.Universal_String);"
                     & LF);

                  Writers.P
                    (Top_Level_Writer (Level),
                     "   procedure Encode" & LF
                     & "     (Data : "
                     & Mapping_Name & ";" & LF
                     & "      Writer : in out XML.SAX.Writers.SAX_Writer'Class;"
                     & LF
                     & "      Name : League.Strings.Universal_String)" & LF
                     & "   is" & LF
                     & "      use Payloads;" & LF
                     & "      use Ada.Strings.Unbounded;" & LF
                     &"   begin");

                  Writers.P
                    (Top_Level_Writer (Level),
                     "      Writer.Start_Element (IATS_URI, Name);" & LF);

                  XSD_To_Ada.Encoder.Print_Type_Definition
                    (Type_D => Type_D.To_Type_Definition,
                     Indent => Indent,
                     Writer => Top_Level_Writer (Level),
                     Name => Type_D.Get_Name,
                     Full_Anonym_Name => League.Strings.Empty_Universal_String,
                     Base_Name => League.Strings.Empty_Universal_String,
                     Table => Types_Table);

                  Writers.P
                    (Top_Level_Writer (Level),
                    "      Writer.End_Element (IATS_URI, Name);"
                     & LF);

                  Writers.P (Top_Level_Writer (Level), "   end Encode;");
              end if;
            end if;

            Encoder_Top_Writer.N (Top_Level_Writer (Level).Text);

            Top_Level_Writer (Level).Text.Clear;
         end if;
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
      Name         : League.Strings.Universal_String;
      Full_Anonym_Name : League.Strings.Universal_String;
      Base_Name    : League.Strings.Universal_String;
      Table        : in out Types_Table_Type_Array;
      Is_Max_Occur : Boolean := False;
      Is_Min_Occur : Boolean := False;
      Top_Max_Occur : Boolean := False)
   is
      use type XML.Schema.Type_Definitions.XS_Type_Definition;
      use League.Strings;

      XS_Particle    : XML.Schema.Objects.Particles.XS_Particle;
      XS_Term        : XML.Schema.Objects.Terms.XS_Term;
      XS_Base        : XML.Schema.Type_Definitions.XS_Type_Definition;

      CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;
      STD  : XML.Schema.Simple_Type_Definitions.XS_Simple_Type_Definition;

      Choice     : Boolean := False;
      Now_Add    : Boolean := False;
      Add_Choise : Boolean := False;
      Add_Anonym : Boolean := False;
      Max_Occurs : Boolean := False;
      Min_Occurs : Boolean := False;

      Base_Choice_Name : League.Strings.Universal_String;

      Name_Kind   : League.Strings.Universal_String;
      Name_Case   : League.Strings.Universal_String;
      Anonym_Vector : League.Strings.Universal_String;
      Vectop_US   : League.Strings.Universal_String;

      Anonym_Kind : Writers.Writer;

      Vector_Package : Writers.Writer;

      ----------------
      -- Print_Term --
      ----------------

      procedure Print_Term
        (XS_Term      : XML.Schema.Objects.Terms.XS_Term;
         Indent       : String := "";
         Writer       : in out Writers.Writer;
         Name         : League.Strings.Universal_String;
         Map          : XSD_To_Ada.Mappings_XML.Mapping_XML;
         Table        : in out Types_Table_Type_Array)
      is
         use type XML.Schema.Objects.Terms.Model_Groups.Compositor_Kinds;
         use type League.Strings.Universal_String;

         XS_Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
         XS_List        : XML.Schema.Object_Lists.XS_Object_List;
         XS_Particle    : XML.Schema.Objects.Particles.XS_Particle;
         Decl           : XML.Schema.Element_Declarations.XS_Element_Declaration;
         Type_D         : XML.Schema.Type_Definitions.XS_Type_Definition;
         Type_Name      : League.Strings.Universal_String;
      begin

         Now_Term_Level := Now_Term_Level + 1;

         Ada.Text_IO.Put (Indent);
         Ada.Text_IO.Put ("Type " & XS_Term.Get_Type'Img);
         Ada.Text_IO.Put_Line (" / XS_Term.Get_Name =" & XS_Term.Get_Name.To_UTF_8_String);

         if XS_Term.Is_Model_Group then
            XS_Model_Group := XS_Term.To_Model_Group;
            XS_List := XS_Model_Group.Get_Particles;
            Ada.Text_IO.Put (Indent);
            Ada.Text_IO.Put_Line (XS_Model_Group.Get_Compositor'Img);

            if XS_Model_Group.Get_Compositor =
              XML.Schema.Objects.Terms.Model_Groups.Compositor_Choice
            then
               Choice := True;

               Base_Choice_Name :=
                 League.Strings.To_Universal_String
                   (Add_Separator (Name) & ".");

               if Top_Max_Occur then
                  Writer.P
                    (Gen_Type_Line
                       ("case Data."
                        & Add_Separator (Name) & "."
                        & Base_Name.To_Wide_Wide_String
                        & "Element (Index).Kind is", 5));
               else
                  Writer.P
                    (Gen_Type_Line
                       ("case Data."
                        & Add_Separator (Name) & "."
                        & Base_Name.To_Wide_Wide_String
                        & "Kind is", 5));
               end if;

               Ada.Text_IO.Put_Line ("!!!!!!!!!!!   Choice := True;");
            end if;

            for J in 1 .. XS_List.Get_Length loop
               Ada.Text_IO.Put (Indent);

               XS_Particle := XS_List.Item (J).To_Particle;

               if XS_Particle.Get_Max_Occurs.Unbounded
               then
                  Max_Occurs := True;
                  Ada.Text_IO.Put ("Max_Occ <>;");
               else
                  if XS_Particle.Get_Max_Occurs.Value > 1 then
                     Max_Occurs := True;
                     Ada.Text_IO.Put ("Max_Occ > 1;");
                  end if;
               end if;

               if XS_Particle.Get_Min_Occurs = 0 then
                    Ada.Text_IO.Put
                      (XS_Particle.Get_Term.Get_Name.To_UTF_8_String
                       & "  = Min_Occ = 0;");
                  Min_Occurs := True;
               else
                  Min_Occurs := False;
               end if;

               Print_Term
                 (XS_Particle.Get_Term,
                  Indent & "   ", Writer, --  Writer_types,
                  Name, Map, Table);

               if J /=  XS_List.Get_Length and Choice then
                  Name_Kind.Append (", " & LF & "      ") ;
               end if;
            end loop;

            if Choice then
               Choice := False;
               Writer.P ( "     end case;" & LF);
               Base_Choice_Name.Clear;
            end if;

         elsif XS_Term.Is_Element_Declaration then
            Decl := XS_Term.To_Element_Declaration;
            Type_D := Decl.Get_Type_Definition;

            Type_Name := Find_Type (Type_D.Get_Name, Map);

            if Type_D.Get_Name.To_UTF_8_String = "" then

               if Max_Occurs then
                  Writer.P
                    (Gen_Type_Line
                       ("for Index in 1 .. Natural (Data."
                        & Add_Separator (Name & "_" & XS_Term.Get_Name)
                        & ".Length) loop", 5));

--                      ("     for Index in 1 .. Natural"
--                       & LF
--                       & "       (Data."
--                       & Add_Separator (Name & "_" & XS_Term.Get_Name)
--                       & ".Length) loop");
               end if;


               Writers.N (Writer, Write_Start_Element (XS_Term.Get_Name));

                  XSD_To_Ada.Encoder.Print_Type_Definition
                    (Type_D => Type_D,
                     Indent => "   " & Indent,
                     Writer => Writer,
                     Name => League.Strings.To_Universal_String
                       (Add_Separator ((Name) & "_" & XS_Term.Get_Name)),
                     Full_Anonym_Name => League.Strings.To_Universal_String
                       (Add_Separator ((Name) & "_" & XS_Term.Get_Name) & "."),
                     Base_Name => Base_Name,
                     Table => Types_Table,
                     Is_Max_Occur => False,
                     Is_Min_Occur => Min_Occurs,
                     Top_Max_Occur => Max_Occurs);

               Anonyn_Vector (Now_Term_Level).Term_State := True;

               Writers.P
                 (Writer,
                  "      Writer.End_Element (IATS_URI, "
                  & Add_Separator (XS_Term.Get_Name)
                  & "_Name);"
                  & LF);

               if Max_Occurs then
                  Writer.P ("     end loop;" & LF);
               end if;

               Add_Anonym := False;
            end if;

            if Choice then
               null;
            end if;

            if Type_D.Get_Name.To_UTF_8_String /= ""
            then
               if Choice then
                  Writer.P
                    ("       when Payloads."
                     & Add_Separator (XS_Term.Get_Name)
                     & "_Case =>");
               end if;

               Generate_Type
                 (Type_D => Type_D,
                  Indent => Indent,
                  XS_Term => XS_Term,
                  Type_Name => Type_Name,
                  Name => League.Strings.To_Universal_String
                    (Add_Separator (Name)),
                  Full_Anonym_Name => Full_Anonym_Name,
                  Base_Choice_Name => Base_Choice_Name,
                  Base_Name => Base_Name,
                  Table => Table,
                  Max_Occurs => Max_Occurs,
                  Top_Max_Occurs => Top_Max_Occur,
                  Min_Occurs => Min_Occurs,
                  Choice => Choice,
                  Writer => Writer,
                  Level => Now_Term_Level);
            end if;
         end if;
         Now_Term_Level := Now_Term_Level - 1;
      end Print_Term;

   begin
      Min_Occurs := Is_Min_Occur;

      Now_Print_Level := Now_Print_Level + 1;

      XS_Base := Type_D.Get_Base_Type;

      if XS_Base.Get_Type_Category in
        XML.Schema.Complex_Type .. XML.Schema.Simple_Type
        and XS_Base /= Type_D  --  This is to filter predefined types
      then
         Ada.Text_IO.Put_Line (Indent & " is new");
         Print_Type_Definition
           (Type_D => XS_Base,
            Indent => Indent & "   ",
            Writer => Writer, --  Writer_types,
            Name => League.Strings.To_Universal_String
              (Add_Separator (XS_Base.Get_Name)),
            Full_Anonym_Name => League.Strings.To_Universal_String
              (Add_Separator (XS_Base.Get_Name) & "."),
            Base_Name => League.Strings.To_Universal_String
              (Add_Separator (XS_Base.Get_Name) & "."),
            Table => Table);
      end if;

      case Type_D.Get_Type_Category is
         when XML.Schema.Complex_Type =>
            CTD := Type_D.To_Complex_Type_Definition;

            if CTD.Get_Content_Type in Element_Only | Mixed then
               Ada.Text_IO.Put_Line
                 (Indent & "Complex_Type :" & Type_D.Get_Name.To_UTF_8_String);

               XS_Particle := CTD.Get_Particle;
               XS_Term := XS_Particle.Get_Term;

               Print_Term (XS_Term, Indent & "   ", Writer, Name, Map, Table);

               Ada.Text_IO.Put_Line
                 (Indent & "End Complex_Type :" & Type_D.Get_Name.To_UTF_8_String);
            end if;

         when XML.Schema.Simple_Type =>
            Ada.Text_IO.Put
              (Indent & "Simple_Type : " & Type_D.Get_Name.To_UTF_8_String);
            STD := Type_D.To_Simple_Type_Definition;

         when XML.Schema.None =>
            Ada.Text_IO.Put_Line (Indent & "NONE!!!");
      end case;

      Choice := False;
      Now_Print_Level := Now_Print_Level - 1;
   end Print_Type_Definition;

   -------------------------
   -- Has_Element_Session --
   -------------------------

   function Has_Element_Session
     (Type_D : XML.Schema.Type_Definitions.XS_Type_Definition)
     return Boolean
   is
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
                     return True;
                  end if;

                  return Has_Element_Session (Decl.Get_Type_Definition);
               end loop;
            end if;

         when XML.Schema.Simple_Type =>
            STD := Type_D.To_Simple_Type_Definition;

         when XML.Schema.None =>
            null;
      end case;

      return False;
   end Has_Element_Session;

   ----------------
   -- Put_Header --
   ----------------

   procedure Put_Header (Self : in out XSD_To_Ada.Writers.Writer) is
      Lin : constant Wide_Wide_String (1 .. 77) := (others => '-');
   begin
      Self.P (Lin);
      Self.P
        ("--  This file is generated by xsd_to_Ada, don't edit it.");
      Self.P (Lin);
      Self.P ("");
   end Put_Header;

   ------------------
   -- Read_Mapping --
   ------------------

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

   -------------------------
   -- Write_Start_Element --
   -------------------------

   function Write_Start_Element
     (Name : League.Strings.Universal_String)
      return League.Strings.Universal_String
   is
      use League.Strings;

      Add : Boolean := False;
   begin

      for Index in 1 .. Element_Vector.Length loop
         if Element_Vector.Element (Index).To_UTF_8_String
           = Name.To_UTF_8_String
         then
            Add := True;
            exit;
         end if;
      end loop;

      if not Add then
         Element_Vector.Append (Name);
         Element_Name.P
           (Gen_Type_Line
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
   end;

end XSD_To_Ada.Encoder;
