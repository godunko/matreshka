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
--  $Revision$ $Date$
------------------------------------------------------------------------------
with Ada.Characters.Wide_Wide_Latin_1;
with Ada.Strings.Wide_Wide_Fixed;
with Ada.Strings.Wide_Wide_Maps;
with Ada.Strings.Wide_Wide_Unbounded;
with Ada.Wide_Wide_Text_IO;

with XML.Schema.Complex_Type_Definitions;
with XML.Schema.Element_Declarations;
with XML.Schema.Model_Groups;
with XML.Schema.Named_Maps;
with XML.Schema.Object_Lists;
with XML.Schema.Objects;
with XML.Schema.Particles;
with XML.Schema.Simple_Type_Definitions;
with XML.Schema.Objects.Terms;
with Ada.Text_IO;
with XML.Schema.Objects.Particles;

with  XSD_To_Ada.Encoder_2;

package body XSD_To_Ada.Utils is

   use XML.Schema.Complex_Type_Definitions;
   use XSD_To_Ada.Writers;

   LF : constant Wide_Wide_Character := Ada.Characters.Wide_Wide_Latin_1.LF;

   --------------
   -- Add_Node --
   --------------

   procedure Add_Node
     (Node_Vector          : in out XSD_To_Ada.Utils.Items;
      Type_Difinition_Node : XSD_To_Ada.Utils.Item)
   is
      Difinition_Node         : XSD_To_Ada.Utils.Item;
      Max_Difinition_Node     : XSD_To_Ada.Utils.Item;
      Min_Difinition_Node     : XSD_To_Ada.Utils.Item;
      Choice_Difinition_Node  : XSD_To_Ada.Utils.Item;
      Element_Difinition_Node : XSD_To_Ada.Utils.Item;
   begin
      Difinition_Node := Type_Difinition_Node;
      Difinition_Node.Min := False;
      Difinition_Node.Max := False;
      Difinition_Node.Element_Name.Clear;

      if not Node_Vector.Contains (Difinition_Node) then

         if not Type_Difinition_Node.Type_Def.Get_Name.Is_Empty
           or not Type_Difinition_Node.Anonym_Name.Is_Empty
         then
            if not Node_Vector.Contains (Difinition_Node) then
               Node_Vector.Append (Difinition_Node);
            end if;
         end if;


--           if Type_Difinition_Node.Element_Name.To_UTF_8_String
--             /= Type_Difinition_Node.Type_Def.Get_Name.To_UTF_8_String
--  --           and then Type_Difinition_Node.Type_Def.Get_Name.Is_Empty
--             and then Type_Difinition_Node.Anonym_Name.Is_Empty
--           then
--  --            Difinition_Node.Element_Name.Append
--  --              (Type_Difinition_Node.Element_Name);
--
--              if not Node_Vector.Contains (Difinition_Node) then
--                 Node_Vector.Append (Difinition_Node);
--              end if;
--
--              Difinition_Node.Element_Name.Clear;
--           else
--              Node_Vector.Append (Difinition_Node);
--           end if;
      end if;

      if Type_Difinition_Node.Max then
         Difinition_Node.Max := True;

         if not Node_Vector.Contains (Difinition_Node) then
            Node_Vector.Append (Difinition_Node);
         end if;

         Difinition_Node.Max := False;
      end if;

      if Type_Difinition_Node.Min then
         Difinition_Node.Min := True;

         if not Node_Vector.Contains (Difinition_Node) then
            Node_Vector.Append (Difinition_Node);
         end if;

         Difinition_Node.Min := False;
      end if;

      if not Type_Difinition_Node.Element_Name.Is_Empty
        and then Type_Difinition_Node.Type_Def.Get_Name.To_UTF_8_String /=
          Type_Difinition_Node.Element_Name.To_UTF_8_String
      then
            Difinition_Node.Element_Name.Append
              (Type_Difinition_Node.Element_Name);

            if not Node_Vector.Contains (Difinition_Node) then
               Node_Vector.Append (Difinition_Node);
            end if;

            Difinition_Node.Element_Name.Clear;
--         end if;
      end if;
   end Add_Node;

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
    (Text : League.Strings.Universal_String) return Wide_Wide_String is
   begin
     return Add_Separator (Text.To_Wide_Wide_String);
   end Add_Separator;

   -------------------------
   -- Create_Element_Type --
   -------------------------

   procedure Create_Element_Type
     (Model       : XML.Schema.Models.XS_Model;
      Node_Vector : in out XSD_To_Ada.Utils.Items;
      Mapping     : XSD_To_Ada.Mappings.Mapping;
      Writer      : in out XSD_To_Ada.Writers.Writer)
   is
      Element_Declarations : constant XML.Schema.Named_Maps.XS_Named_Map
        := Model.Get_Components_By_Namespace
            (Object_Type => XML.Schema.Element_Declaration,
             Namespace   => Namespace);

      Type_D : XML.Schema.Type_Definitions.XS_Type_Definition;
   begin
      for J in 1 .. Element_Declarations.Length loop
--           if Element_Declarations.Item (J).Get_Name.To_UTF_8_String =
--             "Transaction"
--           then
            Type_D :=
              Element_Declarations.Item
                (J).To_Element_Declaration.Get_Type_Definition;

            Ada.Text_IO.Put_Line
              ("Name => "
               & Element_Declarations.Item (J).Get_Name.To_UTF_8_String);

            Create_Node_Vector
              (Type_D,
               "",
               Node_Vector,
               Mapping,
               1 , (False, 1),
               Element_Declarations.Item (J).Get_Name);
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
         & "with Ada.Strings.Unbounded;" & LF
         & "with ICTS.Currencies;"
         & LF & LF
         & "package Payloads is"
         & LF & LF
         & "   type Decimal_String is new Ada.Strings.Unbounded.Unbounded_String;"
         & LF
         & "   Null_Decimal : constant Decimal_String :=" & LF
         & "     Decimal_String (Ada.Strings.Unbounded.Null_Unbounded_String);"
         & LF & LF
         & "   type Rate_String is new Ada.Strings.Unbounded.Unbounded_String;" & LF
         & "   Null_Rate : constant Rate_String :=" & LF
         & "     Rate_String (Ada.Strings.Unbounded.Null_Unbounded_String);" & LF & LF
         & "   type TimeT is new Interfaces.Unsigned_64;" & LF & LF
         & "   type Diagnosis_Code is range 0 .. 2 ** 32 - 1;"
         & LF & LF
         & "   type Abstract_IATS_Responce is" & LF
         & "     abstract new Web_Services.SOAP.Payloads.Abstract_SOAP_Payload" & LF
         & "     with null record;"
         & LF & LF
         & "   type Abstract_IATS_Request is" & LF
         & "     abstract new Web_Services.SOAP.Payloads.Abstract_SOAP_Payload" & LF
         & "     with record" & LF
         & "       Session : League.Strings.Universal_String;"
         & LF
         & "     end record;" & LF);
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
                  "type "
                  & XSD_To_Ada.Utils.Add_Separator (XS_Object.Get_Name)
                  & " is new "
                  & XSD_To_Ada.Utils.Add_Separator (XS_Base.Get_Name)
                  & ";" & LF);
            else
               XSD_To_Ada.Writers.N
                 (Writer,
                  "type " &
                    XSD_To_Ada.Utils.Add_Separator (XS_Object.Get_Name)
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
                        & ");" & LF);
                  end if;
               end loop;
            end if;
         end;
      end loop;
   end Create_Simple_Type;

   ------------------------------------
   -- Create_Enumeration_Simple_Type --
   ------------------------------------

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
                    XSD_To_Ada.Utils.Add_Separator
                    (XS_Object.Get_Name.To_Wide_Wide_String) & " is"
                    & Wide_Wide_Character'Val (10) & "     (");

               for J in 1 .. List.Length loop
                  Ada.Wide_Wide_Text_IO.Put_Line
                   (Ada.Wide_Wide_Text_IO.Standard_Error,
                    List.Element (J).To_Wide_Wide_String);

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

      Payload_Writer      : XSD_To_Ada.Writers.Writer;
      Encoder_Writer      : XSD_To_Ada.Writers.Writer;
      Encoder_Full_Writer : XSD_To_Ada.Writers.Writer;
      Encoder_Spec_Writer : XSD_To_Ada.Writers.Writer;
      Encoder_Names_Writer : XSD_To_Ada.Writers.Writer;

      Current_Out_File : Ada.Wide_Wide_Text_IO.File_Type;

      Node_Vector : XSD_To_Ada.Utils.Items;

      Tag_Vector : League.String_Vectors.Universal_String_Vector;
   begin
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

--         if XS_Object.To_Type_Definition.Get_Name.To_UTF_8_String =
--           "PredefinedCondition"
--         then
            Create_Node_Vector
              (XS_Object.To_Type_Definition,
               "",
               Node_Vector,
               Mapping,
               1 , (False, 1));
--         end if;
      end loop;

      Create_Element_Type (Model, Node_Vector, Mapping, Payload_Writer);
      Print_Type_Title (Node_Vector, "", Payload_Writer, Mapping);

      Node_Vector.Clear;

      for J in 1 .. Complex_Types.Length loop
         XS_Object := Complex_Types.Item (J);

         if Has_Element_Session (XS_Object.To_Type_Definition)
           or XS_Object.To_Type_Definition.Get_Name.To_UTF_8_String =
             "OpenSession"
         then
            Create_Node_Vector
              (XS_Object.To_Type_Definition,
               "",
               Node_Vector,
               Mapping,
               1 , (False, 1));
         end if;
      end loop;

      for J in 1 .. Element_Declarations.Length loop
         Type_D :=
           Element_Declarations.Item
             (J).To_Element_Declaration.Get_Type_Definition;

         if Has_Element_Session (Type_D)
           or  Type_D.Get_Name.To_UTF_8_String = "OpenSession"
         then
            Create_Node_Vector
              (Type_D,
               "",
               Node_Vector,
               Mapping,
               1 , (False, 1),
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
         & "   function Image (Item : Boolean) return League.Strings.Universal_String;"
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
                     & League.Strings.To_Universal_String
                       (Add_Separator
                          (Tag_Vector.Element (Index))).To_Wide_Wide_String
                     & "'Tag,"));

         Writers.P
           (Encoder_Full_Writer,
            ("        " & League.Strings.To_Universal_String
               (Add_Separator
                  (Tag_Vector.Element (Index))).To_Wide_Wide_String
             & "_Encoder'Tag);"));
      end loop;

      Encoder_Full_Writer.N ("end Encoder;");
      Encoder_Spec_Writer.N ("end Encoder;");

      Writers.N (Payload_Writer, "end Payloads;");

      Ada.Wide_Wide_Text_IO.Create
        (Current_Out_File, Ada.Wide_Wide_Text_IO.Out_File, "./vector");

      for Index in 1 .. Natural (Node_Vector.Length) loop

         Ada.Wide_Wide_Text_IO.Put
           (Current_Out_File,
            Node_Vector.Element (Index).Type_Def.Get_Name.To_Wide_Wide_String);

         if not Node_Vector.Element (Index).Anonym_Name.Is_Empty then
         Ada.Wide_Wide_Text_IO.Put
           (Current_Out_File,
            " ANONYM_NAME ="
            & Node_Vector.Element (Index).Anonym_Name.To_Wide_Wide_String);
         end if;

         if not Node_Vector.Element (Index).Element_Name.Is_Empty then
         Ada.Wide_Wide_Text_IO.Put
              (Current_Out_File,
               " ELEMENT_NAME ="
               & Node_Vector.Element (Index).Element_Name.To_Wide_Wide_String);
         end if;

         Ada.Wide_Wide_Text_IO.Put
           (Current_Out_File,
            " Max ="
            & Boolean'Wide_Wide_Image (Node_Vector.Element (Index).Max));

         Ada.Wide_Wide_Text_IO.Put
           (Current_Out_File,
            " Min = "
            & Boolean'Wide_Wide_Image (Node_Vector.Element (Index).Min));

         Ada.Wide_Wide_Text_IO.Put_Line
           (Current_Out_File,
            " Choice = "
            & Boolean'Wide_Wide_Image (Node_Vector.Element (Index).Choice));
      end loop;

      Ada.Wide_Wide_Text_IO.Close (Current_Out_File);

      Ada.Wide_Wide_Text_IO.Create
        (Current_Out_File,
         Ada.Wide_Wide_Text_IO.Out_File,
         "../../../trading_server/src/client/soap/.wsdl/payloads.ads");
      Ada.Wide_Wide_Text_IO.Put_Line
        (Current_Out_File, Payload_Writer.Text.To_Wide_Wide_String);
      Ada.Wide_Wide_Text_IO.Close (Current_Out_File);

      Ada.Wide_Wide_Text_IO.Create
        (Current_Out_File,
         Ada.Wide_Wide_Text_IO.Out_File,
         "../../../trading_server/src/client/soap/.wsdl/encoder.adb");
      Ada.Wide_Wide_Text_IO.Put_Line
        (Current_Out_File, Encoder_Full_Writer.Text.To_Wide_Wide_String);
      Ada.Wide_Wide_Text_IO.Close (Current_Out_File);

      Ada.Wide_Wide_Text_IO.Create
        (Current_Out_File,
         Ada.Wide_Wide_Text_IO.Out_File,
         "../../../trading_server/src/client/soap/.wsdl/encoder.ads");
      Ada.Wide_Wide_Text_IO.Put_Line
        (Current_Out_File, Encoder_Spec_Writer.Text.To_Wide_Wide_String);
      Ada.Wide_Wide_Text_IO.Close (Current_Out_File);

--      Ada.Wide_Wide_Text_IO.Put_Line (Payload_Writer.Text.To_Wide_Wide_String);
   end Create_Complex_Type;

   ------------------------
   -- Create_Node_Vector --
   ------------------------

   procedure Create_Node_Vector
     (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
      Indent       : Wide_Wide_String;
      Node_Vector  : in out XSD_To_Ada.Utils.Items;
      Mapping      : XSD_To_Ada.Mappings.Mapping;
      Min_Occurs   : Natural;
      Max_Occurs   : XML.Schema.Objects.Particles.Unbounded_Natural;
      Element_Name : League.Strings.Universal_String :=
        League.Strings.Empty_Universal_String)
   is
      use XML.Schema.Objects.Terms.Model_Groups;

      Payload_Writer      : XSD_To_Ada.Writers.Writer;
      Payload_Type_Writer : XSD_To_Ada.Writers.Writer;

      Type_Difinition_Node : XSD_To_Ada.Utils.Item;
   begin
      Type_Difinition_Node.Type_Def := Type_D;
      Type_Difinition_Node.Element_Name := Element_Name;

      if Max_Occurs.Unbounded
        or (not Max_Occurs.Unbounded and then Max_Occurs.Value > 1)
      then
         Type_Difinition_Node.Max := True;
      end if;

      if Min_Occurs = 0 then
         Type_Difinition_Node.Min := True;
      end if;

      if Type_D.To_Complex_Type_Definition.Is_Particle
        and then Type_D.To_Complex_Type_Definition.Get_Particle.Get_Term
          .Is_Model_Group
          and then Type_D.To_Complex_Type_Definition.Get_Particle.Get_Term
            .To_Model_Group.Get_Compositor =
              XML.Schema.Model_Groups.Compositor_Choice
      then
         Type_Difinition_Node.Choice := True;
      end if;

      XSD_To_Ada.Utils.Node_Type_Definition
        (Type_D,
         Indent & "   ",
         Node_Vector,
         Type_Difinition_Node,
         Payload_Writer,
         Payload_Type_Writer,
         Type_D.Get_Name,
         Mapping,
         Types_Table);

      Add_Node (Node_Vector, Type_Difinition_Node);
   end Create_Node_Vector;

   ---------------------------
   -- Create_Vector_Package --
   ---------------------------

   procedure Create_Vector_Package
    (Type_D_Name  : League.Strings.Universal_String;
     Mapping      : XSD_To_Ada.Mappings.Mapping;
     Writer       : in out Writers.Writer;
     Writer_Types : in out Writers.Writer)
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
           (Writer_Types,
            "   package "
            & Add_Separator (Type_D_Name) & "_Vectors is" & LF
            & Gen_Type_Line
              ("     new Ada.Containers.Indefinite_Vectors "
               & "(Positive, "
               & Add_Separator (Type_D_Name) & ");", 7) & LF & LF
            & Gen_Type_Line
              ("   subtype " & Add_Separator (Type_D_Name)
               & "s is " & Add_Separator (Type_D_Name)
               & "_Vectors.Vector;", 5) & LF);

         Is_Vector_Type.Append (Type_D_Name);

         if not Mapping.Is_Type_In_Map (Type_D_Name) then
            Writers.N (Writer, "s");
         end if;
      end if;

      Writers.P (Writer, ";");
   end Create_Vector_Package;

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

   -------------------
   -- Gen_Type_Line --
   -------------------

   function Gen_Type_Line
     (Str : Wide_Wide_String := "";
      Tab : Natural := 0) return Wide_Wide_String
   is
      use Ada.Strings.Wide_Wide_Unbounded;
      use Ada.Strings.Wide_Wide_Maps;

      US      : League.Strings.Universal_String
        := League.Strings.To_Universal_String (Str);
      US_New : League.Strings.Universal_String;

      Tab_Count : Natural := Tab;
   begin
      if US.Length > 79 then
         for J in 1 .. US.Length loop
            if US.Element (J).To_Wide_Wide_Character = ' '
              and then
                (US.Element (J + 1).To_Wide_Wide_Character = '('
                 or US.Element (J + 1).To_Wide_Wide_Character = ':')
                 then
                 US_New.Append (Wide_Wide_Character'Val (10));

                 for Count in 1 .. Tab loop
                 US_New.Append (" ");
                 end loop;

                 US_New.Append (US.Element (J));

            elsif US.Element (J).To_Wide_Wide_Character = ' '
              and then US.Element (J + 1).To_Wide_Wide_Character = 'i'
              and then US.Element (J + 2).To_Wide_Wide_Character = 's'
              and then US.Element (J + 3).To_Wide_Wide_Character = ' '
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
     (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
      Indent       : Wide_Wide_String;
      XS_Term      : XML.Schema.Terms.XS_Term;
      Mapping      : XSD_To_Ada.Mappings.Mapping;
      Type_Name    : League.Strings.Universal_String;
      Table        : in out Types_Table_Type_Array;
      Min_Occurs   : in out Boolean;
      Max_Occurs   : in out Boolean;
      Writer       : in out Writers.Writer;
      Writer_types : in out Writers.Writer) is
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

      if Max_Occurs
        and then not XSD_To_Ada.Mappings.Is_Type_In_Map (Mapping, Type_D.Get_Name)
      then
         Max_Occurs := False;
         Writers.P (Writer, "_Vector;");
      else
         Writers.P (Writer, ";");
      end if;
   end Generate_Complex_Type;

   -------------------
   -- Generate_Type --
   -------------------

   procedure Generate_Type
     (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
      Indent       : Wide_Wide_String := "";
      XS_Term      : XML.Schema.Terms.XS_Term;
      Mapping      : XSD_To_Ada.Mappings.Mapping;
      Type_Name    : League.Strings.Universal_String;
      Table        : in out Types_Table_Type_Array;
      Max_Occurs   : in out Boolean;
      Min_Occurs   : in out Boolean;
      Choice       : in out Boolean;
      Writer       : in out Writers.Writer;
      Writer_types : in out Writers.Writer) is
   begin
      case Type_D.Get_Type_Category is
         when XML.Schema.Complex_Type =>
            Generate_Complex_Type
              (Type_D,
               Indent,
               XS_Term,
               Mapping,
               Type_Name,
               Table,
               Min_Occurs,
               Max_Occurs,
               Writer,
               Writer_types);

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

   --------------------------
   -- Generate_Simple_Type --
   --------------------------

   procedure Generate_Simple_Type
     (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
      XS_Term      : XML.Schema.Terms.XS_Term;
      Type_Name    : League.Strings.Universal_String;
      Min_Occurs   : in out Boolean;
      Max_Occurs   : in out Boolean;
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
              (Writer_Types,
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
               &  "     new Ada.Containers.Indefinite_Vectors" & LF
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

   ------------------------
   -- Print_Content_Type --
   ------------------------

   procedure Print_Content_Type
    (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
     Indent       : Wide_Wide_String := "";
     Writer       : in out Writers.Writer;
     Writer_types : in out Writers.Writer;
     Name         : League.Strings.Universal_String;
     Map          : XSD_To_Ada.Mappings.Mapping)
   is
      use type XML.Schema.Type_Definitions.XS_Type_Definition;

      XS_Particle    : XML.Schema.Particles.XS_Particle;
      XS_Term        : XML.Schema.Terms.XS_Term;

      CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;
      STD  : XML.Schema.Simple_Type_Definitions.XS_Simple_Type_Definition;

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
         use League.Strings;

         XS_Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
         XS_List        : XML.Schema.Object_Lists.XS_Object_List;
         XS_Particle    : XML.Schema.Particles.XS_Particle;
         Decl           :
           XML.Schema.Element_Declarations.XS_Element_Declaration;

         Type_D    : XML.Schema.Type_Definitions.XS_Type_Definition;
         Type_Name : League.Strings.Universal_String;

      begin
         Ada.Wide_Wide_Text_IO.Put
          (Ada.Wide_Wide_Text_IO.Standard_Error, Indent);
         Ada.Wide_Wide_Text_IO.Put_Line
          (Ada.Wide_Wide_Text_IO.Standard_Error,
           "Type "
             & XML.Schema.Component_Type'Wide_Wide_Image (XS_Term.Get_Type));
         Ada.Wide_Wide_Text_IO.Put
          (Ada.Wide_Wide_Text_IO.Standard_Error, Indent);
         Ada.Wide_Wide_Text_IO.Put_Line
          (Ada.Wide_Wide_Text_IO.Standard_Error,
           "XS_Term.Get_Name =" & XS_Term.Get_Name.To_Wide_Wide_String);

         if XS_Term.Is_Model_Group then
            XS_Model_Group := XS_Term.To_Model_Group;
            XS_List := XS_Model_Group.Get_Particles;
            Ada.Wide_Wide_Text_IO.Put_Line
             (Ada.Wide_Wide_Text_IO.Standard_Error,
              Indent
                & XML.Schema.Model_Groups.Compositor_Kinds'Wide_Wide_Image
                   (XS_Model_Group.Get_Compositor));

            for J in 1 .. XS_List.Get_Length loop
               Ada.Wide_Wide_Text_IO.Put
                (Ada.Wide_Wide_Text_IO.Standard_Error, Indent);
               XS_Particle := XS_List.Item (J).To_Particle;

               Print_Term
                (XS_Particle.Get_Term,
                 Indent & "   ",
                 Writer,
                 Writer_types,
                 Name,
                 Map);
            end loop;

         elsif XS_Term.Is_Element_Declaration then
            Decl := XS_Term.To_Element_Declaration;
            Type_D := Decl.Get_Type_Definition;

            Type_Name :=
              Map.Ada_Type_Qualified_Name (Type_D.Get_Name, False, False);

            case Type_D.Get_Type_Category is
               when XML.Schema.Complex_Type | XML.Schema.Simple_Type =>
                  Writers.P
                    (Writer,
                     "      "
                     & Add_Separator (XS_Term.Get_Name)
                     & " : "
                     & Type_Name & ";");

               when XML.Schema.None =>
                  Ada.Wide_Wide_Text_IO.Put_Line
                   (Ada.Wide_Wide_Text_IO.Standard_Error, Indent & "NONE!!!");
            end case;
         end if;
      end Print_Term;

   begin
      if Type_D.Get_Base_Type.Get_Name.To_UTF_8_String /= "" then
         Writers.P
           (Writer,
            Gen_Type_Line ("      "
            & Add_Separator (Type_D.Get_Base_Type.Get_Name)
            & " : Payloads."
            & Add_Separator (Type_D.Get_Base_Type.Get_Name)
            & ";", 8));
      end if;

      case Type_D.Get_Type_Category is
         when XML.Schema.Complex_Type =>
            CTD := Type_D.To_Complex_Type_Definition;

            if CTD.Get_Content_Type in Element_Only | Mixed then
               Ada.Wide_Wide_Text_IO.Put_Line
                 (Ada.Wide_Wide_Text_IO.Standard_Error,
                  Indent
                  & "Complex_Type :"
                  & Type_D.Get_Name.To_Wide_Wide_String);

               XS_Particle := CTD.Get_Particle;
               XS_Term := XS_Particle.Get_Term;

               Print_Term
                 (XS_Term, Indent & "   ", Writer, Writer_types, Name, Map);

               Ada.Wide_Wide_Text_IO.Put_Line
                 (Ada.Wide_Wide_Text_IO.Standard_Error,
                  Indent
                  & "End Complex_Type :"
                  & Type_D.Get_Name.To_Wide_Wide_String);
            end if;

         when XML.Schema.Simple_Type =>
            Ada.Wide_Wide_Text_IO.Put
              (Ada.Wide_Wide_Text_IO.Standard_Error,
               Indent
                 & "Simple_Type : "
                 & Type_D.Get_Name.To_Wide_Wide_String);
            STD := Type_D.To_Simple_Type_Definition;

         when XML.Schema.None =>
            Ada.Wide_Wide_Text_IO.Put_Line
             (Ada.Wide_Wide_Text_IO.Standard_Error, Indent & "NONE!!!");
      end case;
   end Print_Content_Type;

   ----------------------
   -- Print_Type_Title --
   ----------------------

   procedure Print_Type_Title
     (Node_Vector : XSD_To_Ada.Utils.Items;
      Indent      : Wide_Wide_String;
      Writer      : in out XSD_To_Ada.Writers.Writer;
      Mapping     : XSD_To_Ada.Mappings.Mapping)
   is
      use type League.Strings.Universal_String;
      use XML.Schema.Objects.Terms.Model_Groups;

      US_Response         : League.Strings.Universal_String;
      Payload_Writer      : XSD_To_Ada.Writers.Writer;
      Payload_Type_Writer : XSD_To_Ada.Writers.Writer;

      Type_D : XML.Schema.Type_Definitions.XS_Type_Definition;

      Discriminant_Type : League.Strings.Universal_String;
      Vector_Name       : League.Strings.Universal_String;
   begin

      for Index in 1 .. Natural (Node_Vector.Length) - 1 loop
         Type_D := Node_Vector.Element (Index).Type_Def;

         Ada.Wide_Wide_Text_IO.Put_Line
           (Ada.Wide_Wide_Text_IO.Standard_Error,
            Indent & Natural'Wide_Wide_Image (Index)
            & "; START Print_Type_Title Type_D="
            & Type_D.Get_Name.To_Wide_Wide_String
            & Node_Vector.Element (Index).Anonym_Name.To_Wide_Wide_String);

         Ada.Wide_Wide_Text_IO.Put_Line
           (Ada.Wide_Wide_Text_IO.Standard_Error,
            "Min " & Boolean'Wide_Wide_Image (Node_Vector.Element (Index).Min));

         Ada.Wide_Wide_Text_IO.Put_Line
           (Ada.Wide_Wide_Text_IO.Standard_Error,
            "Max " & Boolean'Wide_Wide_Image (Node_Vector.Element (Index).Max));

         Ada.Wide_Wide_Text_IO.Put_Line
           (Ada.Wide_Wide_Text_IO.Standard_Error,
            "Choice "
            & Boolean'Wide_Wide_Image (Node_Vector.Element (Index).Choice));

         Ada.Wide_Wide_Text_IO.Put_Line
           (Ada.Wide_Wide_Text_IO.Standard_Error,
            "Anonym_Name <"
            & Node_Vector.Element (Index).Anonym_Name.To_Wide_Wide_String & ">");

         Ada.Wide_Wide_Text_IO.Put_Line
           (Ada.Wide_Wide_Text_IO.Standard_Error,
            "Element_Name <"
            & Node_Vector.Element (Index).Element_Name.To_Wide_Wide_String & ">");
      end loop;


      for Index in 1 .. Natural (Node_Vector.Length) loop
         Type_D := Node_Vector.Element (Index).Type_Def;

         Discriminant_Type.Clear;

         if Node_Vector.Element (Index).Choice then
            Discriminant_Type := League.Strings.From_UTF_8_String ("_Case");
         end if;

         if Type_D.Get_Name.Is_Empty then
            Vector_Name.Clear;
            Vector_Name.Append (Node_Vector.Element (Index).Anonym_Name);
            Vector_Name.Append ("_Anonym");
            Vector_Name.Append (Discriminant_Type);
         else
            Vector_Name := Type_D.Get_Name;
         end if;

         Ada.Wide_Wide_Text_IO.Put_Line
           (Ada.Wide_Wide_Text_IO.Standard_Error,
            Indent & Natural'Wide_Wide_Image (Index)
            & "; START Print_Type_Title Type_D="
            & Type_D.Get_Name.To_Wide_Wide_String
            & Node_Vector.Element (Index).Anonym_Name.To_Wide_Wide_String);

         Ada.Wide_Wide_Text_IO.Put_Line
           (Ada.Wide_Wide_Text_IO.Standard_Error,
            "Min " & Boolean'Wide_Wide_Image (Node_Vector.Element (Index).Min));

         Ada.Wide_Wide_Text_IO.Put_Line
           (Ada.Wide_Wide_Text_IO.Standard_Error,
            "Max " & Boolean'Wide_Wide_Image (Node_Vector.Element (Index).Max));

         Ada.Wide_Wide_Text_IO.Put_Line
           (Ada.Wide_Wide_Text_IO.Standard_Error,
            "Choice "
            & Boolean'Wide_Wide_Image (Node_Vector.Element (Index).Choice));

         Ada.Wide_Wide_Text_IO.Put_Line
           (Ada.Wide_Wide_Text_IO.Standard_Error,
            "Anonym_Name <"
            & Node_Vector.Element (Index).Anonym_Name.To_Wide_Wide_String & ">");

         Ada.Wide_Wide_Text_IO.Put_Line
           (Ada.Wide_Wide_Text_IO.Standard_Error,
            "Element_Name <"
            & Node_Vector.Element (Index).Element_Name.To_Wide_Wide_String & ">");

         if Type_D.Get_Name.Length > 10 then
            US_Response := League.Strings.Slice
              (Type_D.Get_Name,
               Type_D.Get_Name.Length - 7,
               Type_D.Get_Name.Length);
         end if;

         if not Node_Vector.Element (Index).Max
           and then not Node_Vector.Element (Index).Min
           and then Node_Vector.Element (Index).Element_Name.Is_Empty
           and then Node_Vector.Element (Index).Type_Def.Is_Complex_Type_Definition
         then
            if not Node_Vector.Element (Index).Anonym_Name.Is_Empty then
               Writers.P
                 (Payload_Writer,
                  "   type "
                  & Add_Separator (Node_Vector.Element (Index).Anonym_Name)
                  & "_Anonym"
                  & Discriminant_Type
                  & " is record");

               XSD_To_Ada.Utils.Print_Type_Definition
                 (Type_D,
                  Indent & "   ",
                  Payload_Writer, Payload_Type_Writer,
                  Type_D.Get_Name,
                  Node_Vector.Element (Index).Anonym_Name,
                  Node_Vector.Element (Index).Element_Name,
                  Mapping,
                  Types_Table);

               Writers.P (Payload_Writer, "   end record;" & LF);
            else
               if Type_D.Get_Name.Length > 10
                 and US_Response.To_UTF_8_String = "Response"
               then

                  if Node_Vector.Element
                       (Index).Element_Name.To_UTF_8_String /= ""
                  then
                     Writers.N
                       (Payload_Writer,
                        "   type "
                        & Add_Separator
                          (Node_Vector.Element (Index).Element_Name)
                        & " is new Abstract_IATS_Responce with" & LF
                        & "     record" & LF
                        & "     "
                        & Add_Separator (Type_D.Get_Name)
                        & LF
                        & "      : ");

                     Writers.P
                       (Payload_Writer,
                          (XSD_To_Ada.Mappings.Ada_Type_Qualified_Name
                             (Mapping,
                              Type_D.Get_Name,
                              False,
                              False)));
                     Writers.P
                       (Payload_Writer,
                        "     end record;" & LF);

                     Gen_Access_Type
                       (Payload_Writer,
                        Add_Separator
                          (Node_Vector.Element (Index).Element_Name));
                  else
                     XSD_To_Ada.Utils.Gen_Proc_Header
                       (Payload_Writer,
                        XSD_To_Ada.Utils.Add_Separator
                          (Type_D.Get_Name.To_Wide_Wide_String));

                     Writers.P
                       (Payload_Writer,
                        "   type "
                        & XSD_To_Ada.Utils.Add_Separator
                          (Type_D.Get_Name.To_Wide_Wide_String)
                        & " is new Abstract_IATS_Responce with" & LF
                        & "     record");

                     XSD_To_Ada.Utils.Print_Type_Definition
                       (Type_D,
                        Indent & "   ",
                        Payload_Writer, Payload_Type_Writer,
                        Type_D.Get_Name,
                        Node_Vector.Element (Index).Anonym_Name,
                        Node_Vector.Element (Index).Element_Name,
                        Mapping,
                        Types_Table);

                     Writers.P (Payload_Writer, "     end record;" & LF);

                     XSD_To_Ada.Utils.Gen_Access_Type
                       (Payload_Writer,
                        Add_Separator (Type_D.Get_Name.To_Wide_Wide_String));
                  end if;

                  US_Response.Clear;
               else
                  if Has_Element_Session (Type_D)
                  then
                     XSD_To_Ada.Utils.Gen_Proc_Header
                       (Payload_Writer,
                        Add_Separator (Type_D.Get_Name));

                     Writers.P
                       (Payload_Writer,
                        "   type "
                        & Add_Separator (Type_D.Get_Name)
                        & " is" & LF
                        & "     new Web_Services.SOAP.Payloads.Abstract_SOAP_Payload"
                        & LF
                        & "   with record");

                     XSD_To_Ada.Utils.Print_Type_Definition
                       (Type_D,
                        Indent & "   ",
                        Payload_Writer,
                        Payload_Type_Writer,
                        Type_D.Get_Name,
                        Node_Vector.Element (Index).Anonym_Name,
                        Node_Vector.Element (Index).Element_Name,
                        Mapping,
                        Types_Table);

                     Writers.P (Payload_Writer, "   end record;" & LF);
                  else
                     if Type_D.Get_Base_Type.Get_Name.To_UTF_8_String =
                       "anyType"
                     then
                        Writers.P
                          (Payload_Writer,
                           "   type "
                           & Add_Separator (Type_D.Get_Name)
                           & " is" & LF
                           & "     new Web_Services.SOAP.Payloads.Abstract_SOAP_Payload" & LF
                           & "   with record" & LF
                           & "     null;" & LF
                           & "   end record;" & LF);

                        XSD_To_Ada.Utils.Gen_Access_Type
                          (Payload_Writer, Add_Separator (Type_D.Get_Name));
                     else
                        Writers.P
                          (Payload_Writer,
                           "   type "
                           & Add_Separator (Type_D.Get_Name) & " is record");

                        XSD_To_Ada.Utils.Print_Type_Definition
                          (Type_D.To_Type_Definition,
                           Indent & "   ",
                           Payload_Writer,
                           Payload_Type_Writer,
                           Type_D.Get_Name,
                           Node_Vector.Element (Index).Anonym_Name,
                           Node_Vector.Element (Index).Element_Name,
                           Mapping,
                           Types_Table);

                        Writers.P (Payload_Writer, "   end record;" & LF);
                     end if;
                  end if;
               end if;
            end if;
         elsif not Node_Vector.Element (Index).Element_Name.Is_Empty then
            if Node_Vector.Element (Index).Element_Name.Length > 10 then
               US_Response := League.Strings.Slice
                 (Node_Vector.Element (Index).Element_Name,
                  Node_Vector.Element (Index).Element_Name.Length - 7,
                  Node_Vector.Element (Index).Element_Name.Length);
            end if;

            if Node_Vector.Element (Index).Type_Def.Get_Name.Is_Empty then
               if Node_Vector.Element (Index).Element_Name.Length > 10
                 and US_Response.To_UTF_8_String = "Response"
               then
                  Writers.P
                    (Writer,
                     "   type "
                     & Add_Separator
                       (Node_Vector.Element (Index).Element_Name)
                     & " is new Abstract_IATS_Responce with" & LF
                     & "     record" & LF
                     & "     "
                     & Add_Separator (Type_D.Get_Name)
                     & LF
                     & "      : Payloads."
                     & Add_Separator (Type_D.Get_Name)
                     & ";");

                  Writers.P
                    (Writer,
                     "     end record;   --  Responce  Empty" & LF);

                  Gen_Access_Type
                    (Writer,
                     Add_Separator
                       (Node_Vector.Element (Index).Element_Name));
               else
                  if Has_Element_Session (Type_D) then
                     Writers.P
                       (Payload_Writer,
                        "   type "
                        & Add_Separator (Node_Vector.Element (Index).Element_Name)
                        & " is" & LF
                        & "     new Web_Services.SOAP.Payloads.Abstract_SOAP_Payload"
                        & LF
                        & "   with record");

                     XSD_To_Ada.Utils.Print_Type_Definition
                       (Type_D,
                        Indent & "   ",
                        Payload_Writer,
                        Payload_Type_Writer,
                        Type_D.Get_Name,
                        Node_Vector.Element (Index).Anonym_Name,
                        Node_Vector.Element (Index).Element_Name,
                        Mapping,
                        Types_Table);

                     Writers.P (Payload_Writer, "   end record;" & LF);
                  else
                     Writers.P
                       (Payload_Writer,
                        "   type "
                        & Add_Separator (Node_Vector.Element (Index).Element_Name)
                        & " is record");

                     XSD_To_Ada.Utils.Print_Type_Definition
                       (Type_D,
                        Indent & "   ",
                        Payload_Writer,
                        Payload_Type_Writer,
                        Type_D.Get_Name,
                        Node_Vector.Element (Index).Anonym_Name,
                        Node_Vector.Element (Index).Element_Name,
                        Mapping,
                        Types_Table);

                     Writers.P (Payload_Writer, "   end record;" & LF);
                  end if;
               end if;
            else
               if Node_Vector.Element (Index).Element_Name.Length > 10
                 and US_Response.To_UTF_8_String = "Response"
               then
                  Writers.P
                    (Writer,
                     "   type "
                     & Add_Separator
                       (Node_Vector.Element (Index).Element_Name)
                     & " is new Abstract_IATS_Responce with" & LF
                     & "     record" & LF
                     & "     "
                     & Add_Separator (Type_D.Get_Name)
                     & LF & "       : "
                     & (XSD_To_Ada.Mappings.Ada_Type_Qualified_Name
                       (Mapping,
                          Type_D.Get_Name,
                          False,
                          False))
                     & ";" & LF
                     & "     end record;   --  Responce" & LF);

                  Gen_Access_Type
                    (Writer,
                     Add_Separator
                       (Node_Vector.Element (Index).Element_Name));
               else
                  if XSD_To_Ada.Utils.Has_Element_Session
                    (Type_D.To_Type_Definition) then
                     Writers.P
                       (Writer,
                        "   type "
                        & Add_Separator (Node_Vector.Element (Index).Element_Name)
                        & " is" & LF
                        & "     new Payloads."
                        & Add_Separator (Node_Vector.Element (Index).Type_Def.Get_Name)
                        & LF
                        & "   with null record;" & LF);
                  else

                     if Type_D.Get_Base_Type.Get_Name.To_UTF_8_String
                       = "anyType"
                     then
                        Writers.P
                          (Writer,
                           "   type "
                           & Add_Separator (Node_Vector.Element (Index).Element_Name)
                           & " is" & LF
                           & "     new Web_Services.SOAP.Payloads.Abstract_SOAP_Payload" & LF
                           & "   with record" & LF
                           & "     null;" & LF
                           & "   end record;" & LF);

                        XSD_To_Ada.Utils.Gen_Access_Type
                          (Writer,
                           Add_Separator
                             (Node_Vector.Element (Index).Element_Name));
                     else

                        Writers.P
                          (Writer,
                           "   type "
                           & Add_Separator (Node_Vector.Element (Index).Element_Name)
                           & " is record" & LF
                           & "     "
                           & Add_Separator (Node_Vector.Element (Index).Type_Def.Get_Name)
                           & " : Payloads."
                           & Add_Separator (Node_Vector.Element (Index).Type_Def.Get_Name)
                           & ";" & LF
                           & "   end record;" & LF);
                     end if;
                  end if;
               end if;
            end if;
         elsif Node_Vector.Element (Index).Min then
            declare
               Type_Name : League.Strings.Universal_String;
            begin

               if Type_D.Get_Name.Is_Empty then
                  Type_Name :=
                    Node_Vector.Element (Index).Anonym_Name
                    & "_Anonym"
                    & Discriminant_Type;
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
                    (Mapping, Type_Name, False, False)
                  & ";"
                  & LF
                  & "   end record;"
                  & LF);
            end;

         elsif Node_Vector.Element (Index).Max then
            Writers.P
              (Payload_Writer,
               "   package "
               & Add_Separator (Vector_Name)
               & "_Vectors is" & LF
               & "     new Ada.Containers.Indefinite_Vectors" & LF
               & "      (Positive, "
               & Add_Separator (Vector_Name) & ");" & LF & LF
               & Gen_Type_Line
                 ("   subtype "
                  & Add_Separator (Vector_Name)
                  & "_Vector is "
                  & Add_Separator (Vector_Name) & "_Vectors.Vector;", 3)
               & LF);
         end if;

         Writer.N (Payload_Type_Writer.Text);
         Writer.N (Payload_Writer.Text);

         Payload_Type_Writer.Text.Clear;
         Payload_Writer.Text.Clear;
         US_Response.Clear;
      end loop;

      Ada.Wide_Wide_Text_IO.Put_Line
       (Ada.Wide_Wide_Text_IO.Standard_Error, Indent & "END Print_Type_Title");
   end Print_Type_Title;

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
     Element_Name  : League.Strings.Universal_String;
     Mapping      : XSD_To_Ada.Mappings.Mapping;
     Table        : in out Types_Table_Type_Array;
     Is_Max_Occur : Boolean := False;
     Is_Min_Occur : Boolean := False)
   is
      use type XML.Schema.Type_Definitions.XS_Type_Definition;

      XS_Particle    : XML.Schema.Particles.XS_Particle;
      XS_Term        : XML.Schema.Terms.XS_Term;
      XS_Base        : XML.Schema.Type_Definitions.XS_Type_Definition;

      CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;
      STD  : XML.Schema.Simple_Type_Definitions.XS_Simple_Type_Definition;

      Choice     : Boolean := False;
      Now_Add    : Boolean := False;
      Add_Choise : Boolean := False;
      Add_Anonym : Boolean := False;
      Max_Occurs : Boolean := False;
      Min_Occurs : Boolean := False;

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
       (XS_Term      : XML.Schema.Terms.XS_Term;
        Indent       : Wide_Wide_String := "";
        Writer       : in out Writers.Writer;
        Writer_types : in out Writers.Writer;
        Name         : League.Strings.Universal_String;
        Map          : XSD_To_Ada.Mappings.Mapping;
        Table        : in out Types_Table_Type_Array)
      is
         use type XML.Schema.Model_Groups.Compositor_Kinds;
         use type League.Strings.Universal_String;

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

         Ada.Wide_Wide_Text_IO.Put
          (Ada.Wide_Wide_Text_IO.Standard_Error, Indent);
         Ada.Wide_Wide_Text_IO.Put_Line
          (Ada.Wide_Wide_Text_IO.Standard_Error,
           "Type "
             & XML.Schema.Component_Type'Wide_Wide_Image (XS_Term.Get_Type));
         Ada.Wide_Wide_Text_IO.Put
          (Ada.Wide_Wide_Text_IO.Standard_Error, Indent);
         Ada.Wide_Wide_Text_IO.Put_Line
          (Ada.Wide_Wide_Text_IO.Standard_Error,
           "XS_Term.Get_Name ="
             & XS_Term.Get_Name.To_Wide_Wide_String
             & "; Anonym="
             & Boolean'Wide_Wide_Image
                (Anonyn_Vector (Now_Term_Level - 1).Term_State));

         if XS_Term.Is_Model_Group then
            XS_Model_Group := XS_Term.To_Model_Group;
            XS_List := XS_Model_Group.Get_Particles;
            Ada.Wide_Wide_Text_IO.Put
             (Ada.Wide_Wide_Text_IO.Standard_Error, Indent);
            Ada.Wide_Wide_Text_IO.Put_Line
             (Ada.Wide_Wide_Text_IO.Standard_Error,
              XML.Schema.Model_Groups.Compositor_Kinds'Wide_Wide_Image
               (XS_Model_Group.Get_Compositor));

            if XS_Model_Group.Get_Compositor =
              XML.Schema.Model_Groups.Compositor_Choice
            then
               Choice := True;

               if Is_Max_Occur then
                  Writers.N
                    (Writer,
                     Gen_Type_Line
                       ("      "
                        & Add_Separator (Name)
                        & " : "
                        & Optional_Type.To_Wide_Wide_String
                        & Add_Separator (Name)
                        & "_Case", 8));

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
                        & Add_Separator (Name)
                        & " : "
                        & Optional_Type.To_Wide_Wide_String
                        & Add_Separator (Name)
                        & "_Case;", 8));
               end if;

               if Is_Min_Occur then
                  Writers.P
                    (Vector_Package,
                     "   type Optional_" & Add_Separator (Name) & "_Case is record"
                     & LF
                     & "     Is_Set : Boolean := False;" & LF
                     & "     Value  : Payloads." & Add_Separator (Name) & "_Case;" & LF
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
                        & XSD_To_Ada.Utils.Add_Separator (Name)
                        & " : "
                        & Optional_Type.To_Wide_Wide_String
                        & XSD_To_Ada.Utils.Add_Separator (Name)
                        & "_Anonym"
                        & Vector_Symbol.To_Wide_Wide_String & ";", 8));

                  if Is_Max_Occur then
                     Anonym_Vector.Append
                       ("   package "
                        & XSD_To_Ada.Utils.Add_Separator (Name)
                        & "_Anonyms_Vectors is" & LF
                        & "     new Ada.Containers.Indefinite_Vectors" & LF
                        & "        (Positive, "
                        & XSD_To_Ada.Utils.Add_Separator (Name) & "_Anonym);"
                        & LF & LF
                        & Gen_Type_Line
                          ("   subtype " & XSD_To_Ada.Utils.Add_Separator (Name)
                           & "_Anonyms is " & XSD_To_Ada.Utils.Add_Separator (Name)
                           & "_Anonyms_Vectors.Vector;", 5)
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
                              & XSD_To_Ada.Utils.Add_Separator (Name)
                              & " : "
                              & XSD_To_Ada.Utils.Add_Separator (Name)
                              & "_Cases;", 8));

                        Max_Occurs := False;
                     else
                        null;
                     end if;
                  else
                     null;

                  end if;
               end if;

               if XS_Particle.Get_Min_Occurs = 0 then
                  Min_Occurs := True;
               end if;

               Print_Term
                 (XS_Particle.Get_Term,
                  Indent & "   ", Writer, Writer_types, Name, Map,
                  Table);

               if J /=  XS_List.Get_Length and Choice then
                  Name_Kind.Append
                    ("," & Wide_Wide_Character'Val (10) & "      ") ;
               end if;
            end loop;

            Choice := False;

         elsif XS_Term.Is_Element_Declaration then

            Decl := XS_Term.To_Element_Declaration;
            Type_D := Decl.Get_Type_Definition;

            Type_Name :=
              Map.Ada_Type_Qualified_Name
                (Type_D.Get_Name, Min_Occurs, Max_Occurs);


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
                       (League.Strings.To_Universal_String
                          (Add_Separator (XS_Term.Get_Name) & "_Case"));

                     Name_Case.Append
                       ("        when "
                        & Add_Separator (XS_Term.Get_Name)
                        & "_Case =>" & LF
                        & Gen_Type_Line ("           "
                          & Add_Separator (XS_Term.Get_Name)
                          & " : Payloads."
                          & Add_Separator (XS_Term.Get_Name)
                          & "_Anonym;", 15) & LF);
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
               Name_Kind.Append
                 (League.Strings.To_Universal_String
                    (Add_Separator (XS_Term.Get_Name) & "_Case"));

               if Min_Occurs then

                  if not Is_Type_In_Optional_Vector (Type_Name) then
                     Writers.P
                       (Writer_Types,
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
                     & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
                     & "_Case =>" & LF
                     & Gen_Type_Line ("           "
                       & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
                       & " : "
                       & "Optional_" & Type_Name.To_Wide_Wide_String & ";", 15) & LF);
               else
                  Name_Case.Append
                    ("        when "
                     & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
                     & "_Case =>" & LF
                     & Gen_Type_Line ("           "
                       & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
                       & " : "
                       & Type_Name.To_Wide_Wide_String & ";", 15) & LF);
               end if;

               Ada.Text_IO.Put_Line ("Min_Occurs Choice " &  Min_Occurs'Img);

            end if;

            if Type_D.Get_Name.To_UTF_8_String /= ""
              and then not Anonyn_Vector (Now_Term_Level - 2).Term_State
              and then not Choice
            then
               Generate_Type
                 (Type_D,
                  Indent,
                  XS_Term,
                  Mapping,
                  Type_Name,
                  Table,
                  Max_Occurs,
                  Min_Occurs,
                  Choice,
                  Writer,
                  Writer_types);
            end if;

            if Anonyn_Vector (Now_Term_Level - 2).Term_State
              and not Choice
            then
               Generate_Type
                 (Type_D,
                  Indent,
                 XS_Term,
                 Mapping,
                 Type_Name,
                 Table,
                 Max_Occurs,
                  Min_Occurs,
                  Choice,
                 Anonym_Kind,
                 Writer_types);
            end if;
         end if;
         Now_Term_Level := Now_Term_Level - 1;
      end Print_Term;

   begin
      Now_Print_Level := Now_Print_Level + 1;

      XS_Base := Type_D.Get_Base_Type;

      if XS_Base.Get_Type_Category in
        XML.Schema.Complex_Type .. XML.Schema.Simple_Type
        and XS_Base /= Type_D
      then
         Ada.Wide_Wide_Text_IO.Put_Line
           (Ada.Wide_Wide_Text_IO.Standard_Error, Indent & " is new");

         Ada.Wide_Wide_Text_IO.Put_Line
           (Ada.Wide_Wide_Text_IO.Standard_Error,
            Indent & ">>>>>>>>>> NAME : "
            & XS_Base.Get_Name.To_Wide_Wide_String);

         Writers.P (Writer,
                    Gen_Type_Line
                      ("     " & Add_Separator (XS_Base.Get_Name)
                       & " : Payloads."
                       & Add_Separator (XS_Base.Get_Name)
                       & ";", 5));

         Writers.P (Writer, "     --  " & Add_Separator (Element_Name));
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
                     Writer_Types,
                     League.Strings.To_Universal_String (Add_Separator (Name)),
                     Mapping,
                     Table);
               else
                  if not Anonym_Name.Is_Empty then
                     Print_Term
                       (XS_Term,
                        Indent & "   ",
                        Writer,
                        Writer_Types,
                        League.Strings.To_Universal_String
                          (Add_Separator (Anonym_Name)),
                        Mapping,
                        Table);
                  elsif not Element_Name.Is_Empty then
                     Print_Term
                       (XS_Term,
                        Indent & "   ",
                        Writer,
                        Writer_Types,
                        League.Strings.To_Universal_String
                          (Add_Separator (Element_Name)),
                        Mapping,
                        Table);
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
            STD := Type_D.To_Simple_Type_Definition;

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
         Writers.P (Writer_types, Name_Kind.To_Wide_Wide_String &  ");" & LF);

         Writers.P
           (Writer_types,
            Name_Case.To_Wide_Wide_String
            & "      end case;" & LF
            & "   end record;" & LF);

         Name_Kind.Clear;
         Name_Case.Clear;
         Now_Add := False;
         Add_Choise := False;
      end if;

      Writers.N (Writer_types, Vector_Package.Text);

      Choice := False;
      Now_Print_Level := Now_Print_Level - 1;
   end Print_Type_Definition;

   --------------------------
   -- Node_Type_Definition --
   --------------------------

   procedure Node_Type_Definition
    (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
     Indent       : Wide_Wide_String;
     Node_Vector : in out XSD_To_Ada.Utils.Items;
     Type_Difinition_Node : in out XSD_To_Ada.Utils.Item;
     Writer       : in out Writers.Writer;
     Writer_types : in out Writers.Writer;
     Name         : League.Strings.Universal_String;
     Mapping      : XSD_To_Ada.Mappings.Mapping;
     Table        : in out Types_Table_Type_Array;
     Is_Max_Occur : Boolean := False;
     Is_Min_Occur : Boolean := False)
   is
      use type XML.Schema.Type_Definitions.XS_Type_Definition;

      XS_Particle    : XML.Schema.Particles.XS_Particle;
      XS_Term        : XML.Schema.Terms.XS_Term;
      XS_Base        : XML.Schema.Type_Definitions.XS_Type_Definition;

      CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;
      STD  : XML.Schema.Simple_Type_Definitions.XS_Simple_Type_Definition;

      Choice     : Boolean := False;
      Now_Add    : Boolean := False;
      Add_Choise : Boolean := False;
      Add_Anonym : Boolean := False;

      Max_Occurs : Boolean := False;
      Max_Occurs_2 : XML.Schema.Objects.Particles.Unbounded_Natural;

      Min_Occurs : Boolean := False;
      Min_Occurs_2 : Natural;

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
       (XS_Term      : XML.Schema.Terms.XS_Term;
        Indent       : Wide_Wide_String := "";
        Writer       : in out Writers.Writer;
        Writer_types : in out Writers.Writer;
        Name         : League.Strings.Universal_String;
        Map          : XSD_To_Ada.Mappings.Mapping;
        Table        : in out Types_Table_Type_Array)
      is
         use type XML.Schema.Model_Groups.Compositor_Kinds;
         use XML.Schema.Objects.Terms.Model_Groups;
         use type League.Strings.Universal_String;
         use type XML.Schema.Type_Definitions.XS_Type_Definition;

         XS_Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
         XS_List        : XML.Schema.Object_Lists.XS_Object_List;
         XS_Particle    : XML.Schema.Particles.XS_Particle;
         Decl           :
           XML.Schema.Element_Declarations.XS_Element_Declaration;
         Type_D         : XML.Schema.Type_Definitions.XS_Type_Definition;
         Type_Name      : League.Strings.Universal_String;

      begin
         Now_Term_Level := Now_Term_Level + 1;

         Ada.Wide_Wide_Text_IO.Put
          (Ada.Wide_Wide_Text_IO.Standard_Error, Indent);
         Ada.Wide_Wide_Text_IO.Put_Line
          (Ada.Wide_Wide_Text_IO.Standard_Error,
           "Print_Term; Type "
             & XML.Schema.Component_Type'Wide_Wide_Image (XS_Term.Get_Type));
         Ada.Wide_Wide_Text_IO.Put
          (Ada.Wide_Wide_Text_IO.Standard_Error, Indent);
         Ada.Wide_Wide_Text_IO.Put_Line
          (Ada.Wide_Wide_Text_IO.Standard_Error,
           "XS_Term.Get_Name ="
             & XS_Term.Get_Name.To_Wide_Wide_String
             & "; Anonym="
             & Boolean'Wide_Wide_Image
                (Anonyn_Vector (Now_Term_Level - 1).Term_State));

         if XS_Term.Is_Model_Group then
            XS_Model_Group := XS_Term.To_Model_Group;
            XS_List := XS_Model_Group.Get_Particles;
            Ada.Wide_Wide_Text_IO.Put
             (Ada.Wide_Wide_Text_IO.Standard_Error, Indent);
            Ada.Wide_Wide_Text_IO.Put_Line
             (Ada.Wide_Wide_Text_IO.Standard_Error,
              XML.Schema.Model_Groups.Compositor_Kinds'Wide_Wide_Image
               (XS_Model_Group.Get_Compositor));

            for J in 1 .. XS_List.Get_Length loop
               XS_Particle := XS_List.Item (J).To_Particle;

               Max_Occurs_2 := XS_Particle.Get_Max_Occurs;
               Min_Occurs_2 := XS_Particle.Get_Min_Occurs;

               Print_Term
                 (XS_Particle.Get_Term,
                  Indent & "   ", Writer, Writer_types, Name, Map,
                  Table);
            end loop;

         elsif XS_Term.Is_Element_Declaration then

            Decl := XS_Term.To_Element_Declaration;
            Type_D := Decl.Get_Type_Definition;

            Type_Name :=
              Map.Ada_Type_Qualified_Name
               (Type_D.Get_Name, Min_Occurs, Max_Occurs);

            if Type_D.Get_Name.To_UTF_8_String = "" then

               Anonyn_Vector (Now_Term_Level).Term_State := True;

                  Node_Type_Definition
                    (Type_D, Indent & "   ",
                     Node_Vector, Type_Difinition_Node,
                     Writer, Writer_types,
                     Name & '_' & Decl.Get_Name,
                     Map,
                     Table,
                     Max_Occurs,
                     Min_Occurs);

               declare
                  Anonym_Type_Difinition_Node : XSD_To_Ada.Utils.Item;
               begin
                  Anonym_Type_Difinition_Node.Type_Def := Type_D;

                  Anonym_Type_Difinition_Node.Decl_Anonym_Name
                    := Decl.Get_Name;

                  if Min_Occurs_2 = 0 then
                     Anonym_Type_Difinition_Node.Min := True;
                  end if;

                  if not Name.Is_Empty then
                     Anonym_Type_Difinition_Node.Anonym_Name :=
                       (Name & "_" & Decl.Get_Name);
                  else
                     Anonym_Type_Difinition_Node.Anonym_Name :=
                       (Decl.Get_Name);
                  end if;

                  if Type_D.To_Complex_Type_Definition.Get_Particle.Get_Term
                    .To_Model_Group.Get_Compositor =
                      XML.Schema.Model_Groups.Compositor_Choice
                  then
                     Anonym_Type_Difinition_Node.Choice := True;
                  end if;

                  if Max_Occurs_2.Unbounded
                    or (not Max_Occurs_2.Unbounded
                        and then Max_Occurs_2.Value > 1)
                  then
                     Anonym_Type_Difinition_Node.Max := True;
                  end if;

                  Add_Node (Node_Vector, Anonym_Type_Difinition_Node);
               end;

               Max_Occurs := False;
               Add_Anonym := False;
            end if;

            if Has_Top_Level_Type (Type_D, Table) then
               Create_Node_Vector
                 (Type_D,
                  Indent & "   ",
                  Node_Vector,
                  Mapping,
                  Min_Occurs_2,
                  Max_Occurs_2);
            end if;
         end if;
         Now_Term_Level := Now_Term_Level - 1;
      end Print_Term;

   begin
      Now_Print_Level := Now_Print_Level + 1;

      XS_Base := Type_D.Get_Base_Type;

      if XS_Base.Get_Type_Category in
        XML.Schema.Complex_Type --  .. XML.Schema.Simple_Type
        and XS_Base /= Type_D
      then

         if XS_Base.Get_Name.To_UTF_8_String /= "anyType" then
            Ada.Wide_Wide_Text_IO.Put_Line
              (Ada.Wide_Wide_Text_IO.Standard_Error, Indent & " is new");

            Create_Node_Vector
              (XS_Base,
               Indent & "   ",
               Node_Vector,
               Mapping,
               1, (False, 1));
         end if;
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

               Print_Term
                (XS_Term,
                 Indent & "   ",
                 Writer,
                 Writer_Types,
                 Name,
                 Mapping,
                 Table);

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
            STD := Type_D.To_Simple_Type_Definition;

         when XML.Schema.None =>
            Ada.Wide_Wide_Text_IO.Put_Line
             (Ada.Wide_Wide_Text_IO.Standard_Error, Indent & "NONE!!!");
      end case;

      Choice := False;
      Now_Print_Level := Now_Print_Level - 1;
   end Node_Type_Definition;

   -------------------------
   -- Has_Element_Session --
   -------------------------

   function Has_Element_Session
     (Type_D : XML.Schema.Type_Definitions.XS_Type_Definition)
     return Boolean
   is
      use type XML.Schema.Type_Definitions.XS_Type_Definition;

      XS_Particle    : XML.Schema.Particles.XS_Particle;
      XS_Term        : XML.Schema.Terms.XS_Term;
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
        ("--  This file is generated by xsd_to_ada_generator, don't edit it.");
      Self.P (Lin);
      Self.P ("");
   end Put_Header;

end XSD_To_Ada.Utils;
