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
--  $Revision: 4452 $ $Date: 2014-02-06 11:19:08 +0200 (Чт., 06 февр. 2014) $
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

with XSD_To_Ada.Utils;

package body XSD_To_Ada.Payloads is

   use XML.Schema.Complex_Type_Definitions;
   use XSD_To_Ada.Writers;
   use all type League.Strings.Universal_String;

   LF : constant Wide_Wide_Character := Ada.Characters.Wide_Wide_Latin_1.LF;

   --------------------
   -- Print_Payloads --
   --------------------

   procedure Print_Payloads
    (Node_Vector : XSD2Ada.Analyzer.Items;
     Writer      : in out XSD_To_Ada.Writers.Writer;
     Mapping     : XSD_To_Ada.Mappings.Mapping)
   is
      use type League.Characters.Universal_Character;
      use type XML.Schema.Type_Definitions.XS_Type_Definition;

      Payload_Writer      : XSD_To_Ada.Writers.Writer;
      Payload_Type_Writer : XSD_To_Ada.Writers.Writer;

      Type_D  : XML.Schema.Type_Definitions.XS_Type_Definition;
      XS_Base : XML.Schema.Type_Definitions.XS_Type_Definition;

      Type_Name : League.Strings.Universal_String;

      XS_Term      : XML.Schema.Terms.XS_Term;

      CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;

      Empty_Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
      Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
   begin
      for Current of Node_Vector loop

         Model_Group := Empty_Model_Group;

         if Current.Object.Is_Type_Definition
           and then Current.Element_Name.Is_Empty
         then

            if not Current.Type_Def.Is_Simple_Type_Definition
              and then Current.Short_Ada_Type_Name.Element (1) /= '_'
            then
               Type_D := Current.Type_Def;
               XS_Base := Type_D.Get_Base_Type;

               CTD := Type_D.To_Complex_Type_Definition;

               if CTD.Get_Content_Type in Element_Only | Mixed then
                  XS_Term := CTD.Get_Particle.Get_Term;

                  if XS_Term.Is_Model_Group then
                     Model_Group := XS_Term.To_Model_Group;
                  end if;
               end if;

               if not Current.Min
                 and then not Current.Max
                 and then not Current.Choice
               then

                  if Type_D.Get_Base_Type.Get_Name.To_Wide_Wide_String
                    = "anyType"
                  then
                     Payload_Writer.P
                       ("   type "
                        & XSD_To_Ada.Utils.Add_Separator (Type_D.Get_Name)
                        & " is" & LF
                        & "     new Web_Services.SOAP.Payloads."
                        & "Abstract_SOAP_Payload" & LF
                        & "   with record" & LF
                        & "     null;");

                  elsif XSD_To_Ada.Utils.Has_Element_Session
                    (Current.Object.To_Type_Definition)
                    or Current.Object.Get_Name.Ends_With ("Response")
                  then
                     Payload_Writer.P
                       ("   type "
                        & Current.Short_Ada_Type_Name
                        & " is" & LF
                        & "     new Web_Services.SOAP.Payloads."
                        & "Abstract_SOAP_Payload"
                        & LF
                        & "   with record");
                  else
                     Payload_Writer.P
                       ("   type "
                        & Current.Short_Ada_Type_Name
                        & " is record");
                  end if;

                  Print_Model
                    (Model_Group  => Model_Group,
                     Writer       => Payload_Writer,
                     Writer_types => Payload_Type_Writer,
                     Name         => Current.Short_Ada_Type_Name,
                     Map          => Mapping);

                  Payload_Writer.P
                    ("   end record;  --  "
                     & League.Strings.From_UTF_8_String (Current.Choice'Img)
                     & LF);

                  if Current.Object.Get_Name.Ends_With ("Response") then
                     XSD_To_Ada.Utils.Gen_Access_Type
                       (Payload_Writer,
                        XSD_To_Ada.Utils.Add_Separator
                          (Current.Object.Get_Name));
                  end if;

                  if Type_D.Get_Base_Type.Get_Name.To_Wide_Wide_String
                    = "anyType"
                  then
                     XSD_To_Ada.Utils.Gen_Access_Type
                       (Payload_Writer,
                        XSD_To_Ada.Utils.Add_Separator (Type_D.Get_Name));
                  end if;

               elsif Current.Choice
                 and then not Current.Min
                 and then not Current.Max
               then
                  Payload_Writer.P
                    ("   type "
                     & Current.Short_Ada_Type_Name & LF
                     & "     (Kind : " & Current.Short_Ada_Type_Name
                     & "_Kind" & LF
                     & "       := " & Current.Short_Ada_Type_Name
                     & "_Kind'First) is record" & LF
                     & "       case Kind is");

                  Print_Model
                    (Model_Group  => Model_Group,
                     Writer       => Payload_Writer,
                     Writer_types => Payload_Type_Writer,
                     Name         => Current.Short_Ada_Type_Name,
                     Map          => Mapping,
                     Choice       => Current.Choice);

                  Payload_Writer.P
                    ("      end case;" & LF
                     & "   end record;" & LF);

               elsif Current.Min then
                  Writers.P
                    (Payload_Type_Writer,
                     "   type Optional_" & Current.Short_Ada_Type_Name
                     & " is record" & LF
                     & "     Is_Set : Boolean := False;" & LF
                     & "     Value  : "
                     & Current.Short_Ada_Type_Name
                     & ";" & LF
                     & "   end record;" & LF);

               elsif Current.Max then
                  Writers.P
                    (Payload_Type_Writer,
                     "   package "
                     & Current.Short_Ada_Type_Name
                     & "_Vectors is" & LF
                     & "     new Ada.Containers.Vectors" & LF
                     & "      (Positive, "
                     & Current.Short_Ada_Type_Name & ");"
                     & LF & LF
                     & XSD_To_Ada.Utils.Split_Line
                       ("subtype " & Current.Short_Ada_Type_Name & "_Vector is "
                        & Current.Short_Ada_Type_Name & "_Vectors.Vector;",
                        3)
                     & LF);
               end if;

            elsif Current.Type_Def.Is_Simple_Type_Definition then
               if Current.Min then
                  Writers.P
                    (Payload_Type_Writer,
                     "   type Optional_"
                     & XSD_To_Ada.Utils.Add_Separator (Current.Simple_Type_Name)
                     & " is record" & LF
                     & "     Is_Set : Boolean := False;" & LF
                     & "     Value  : "
                     & XSD_To_Ada.Mappings.Ada_Type_Qualified_Name
                       (Mapping,
                        Current.Object.To_Type_Definition.Get_Name)
                     & ";" & LF
                     & "   end record;" & LF);

               elsif Current.Max then
                  Writers.P
                    (Payload_Type_Writer,
                     "   package "
                     & XSD_To_Ada.Utils.Add_Separator
                       (Current.Object.To_Type_Definition.Get_Name)
                     & "_Vector is" & LF
                     &  "     new Ada.Containers.Vectors" & LF
                     & "       (Positive, "
                     & XSD_To_Ada.Mappings.Ada_Type_Qualified_Name
                       (Mapping,
                        Current.Object.To_Type_Definition.Get_Name) & "," & LF
                     & "       ""="" => ICTS.Types.""="");" & LF);
               end if;
            end if;
         elsif not Current.Element_Name.Is_Empty then
            if Current.Object.Get_Name.Is_Empty then

               Type_D := Current.Type_Def;

               CTD := Type_D.To_Complex_Type_Definition;

               if CTD.Get_Content_Type in Element_Only | Mixed then
                  XS_Term := CTD.Get_Particle.Get_Term;

                  if XS_Term.Is_Model_Group then
                     Model_Group := XS_Term.To_Model_Group;
                  end if;
               end if;

               if XSD_To_Ada.Utils.Has_Element_Session
                 (Current.Object.To_Type_Definition)
               then
                  Payload_Writer.P
                    ("   type "
                     & XSD_To_Ada.Utils.Add_Separator
                       (Current.Element_Name)
                     & " is" & LF
                     & "     new Web_Services.SOAP.Payloads."
                     & "Abstract_SOAP_Payload"
                     & LF
                     & "   with record");
               else
                  Payload_Writer.P
                    ("   type "
                     & XSD_To_Ada.Utils.Add_Separator (Current.Element_Name)
                     & " is record");
               end if;

               XS_Base := Type_D.Get_Base_Type;

               if XS_Base.Get_Type_Category in
                 XML.Schema.Complex_Type .. XML.Schema.Simple_Type
                 and XS_Base /= Type_D
               then
                  Writers.P
                    (Payload_Writer,
                     XSD_To_Ada.Utils.Split_Line
                       (XSD_To_Ada.Utils.Add_Separator (XS_Base.Get_Name)
                        & " : Payloads."
                        & XSD_To_Ada.Utils.Add_Separator (XS_Base.Get_Name)
                        & ";", 6));
               end if;

                  Print_Model
                    (Model_Group  => Model_Group,
                     Writer       => Payload_Writer,
                     Writer_types => Payload_Type_Writer,
                     Name         => XSD_To_Ada.Utils.Add_Separator
                       (Current.Element_Name),
                     Map          => Mapping);

                  Payload_Writer.P ("   end record;" & LF);
            else
               if XSD_To_Ada.Utils.Has_Element_Session
                 (Current.Object.To_Type_Definition)
               then
                  Payload_Writer.P
                    ("   type "
                     & XSD_To_Ada.Utils.Add_Separator (Current.Element_Name) & LF
                     & "     is new "
                     & XSD_To_Ada.Utils.Add_Separator (Current.Object.Get_Name) & LF
                     & "       with null record;  --  XXXX" & LF);
               elsif Current.Element_Name.Ends_With ("Response") then

                  Payload_Writer.P
                       ("   type "
                        & XSD_To_Ada.Utils.Add_Separator (Current.Element_Name)
                        & " is" & LF
                        & "     new Web_Services.SOAP.Payloads."
                        & "Abstract_SOAP_Payload"
                        & LF
                        & "   with record" & LF
                        & XSD_To_Ada.Utils.Add_Separator (Current.Object.Get_Name)
                        & " : Payloads."
                        & XSD_To_Ada.Utils.Add_Separator (Current.Object.Get_Name)
                        & ";" & LF & "   end record;  --  ZZZZ"  & LF);

                  XSD_To_Ada.Utils.Gen_Access_Type
                    (Payload_Writer,
                     XSD_To_Ada.Utils.Add_Separator (Current.Element_Name));
               else
                  Payload_Writer.P
                    ("   type "
                     & XSD_To_Ada.Utils.Add_Separator (Current.Element_Name)
                     & "     is record" & LF
                     & XSD_To_Ada.Utils.Add_Separator (Current.Object.Get_Name)
                     & " : Payloads."
                     & XSD_To_Ada.Utils.Add_Separator (Current.Object.Get_Name)
                     & ";" & LF
                     & " end record;  --  SSSS" & LF);
               end if;
            end if;

         elsif Current.Object.Is_Model_Group
           and then Current.Short_Ada_Type_Name.Element (1) /= '_'
         then
            Type_Name := XSD_To_Ada.Utils.Add_Separator
              (Current.Short_Ada_Type_Name);

            Model_Group := Current.Object.To_Model_Group;

            Payload_Writer.P
              ("   type "
               & Type_Name & LF
               & "     (Kind : " & Type_Name & "_Kind" & LF
               & "       := " & Type_Name
               & "_Kind'First) is record" & LF
               & "       case Kind is");

            Print_Model
              (Model_Group  => Model_Group,
               Writer       => Payload_Writer,
               Writer_types => Payload_Type_Writer,
               Name         => Current.Short_Ada_Type_Name,
               Map          => Mapping,
               Choice       => Current.Choice);

            Payload_Writer.P
              ("      end case;" & LF
               & "   end record;" & LF);
         else
            null;
         end if;

         Writer.N (Payload_Type_Writer.Text);
         Writer.N (Payload_Writer.Text);

         Payload_Type_Writer.Text.Clear;
         Payload_Writer.Text.Clear;

      end loop;
   end Print_Payloads;

   -----------------
   -- Print_Model --
   -----------------

   procedure Print_Model
     (Model_Group  : XML.Schema.Model_Groups.XS_Model_Group;
      Writer       : in out Writers.Writer;
      Writer_types : in out Writers.Writer;
      Name         : League.Strings.Universal_String;
      Map          : XSD_To_Ada.Mappings.Mapping;
      Choice       : Boolean := False)
   is
      use type XML.Schema.Model_Groups.Compositor_Kinds;

      XS_List        : XML.Schema.Object_Lists.XS_Object_List;
      XS_Particle    : XML.Schema.Particles.XS_Particle;

      Case_Type : League.Strings.Universal_String;
      Max_Occurs : Boolean := False;
      Min_Occurs : Boolean := False;

      procedure Print_Element
        (XS_Term      : XML.Schema.Terms.XS_Term;
         Writer       : in out Writers.Writer;
         Writer_types : in out Writers.Writer;
         Name         : League.Strings.Universal_String;
         Map          : XSD_To_Ada.Mappings.Mapping)
      is
         XS_List        : XML.Schema.Object_Lists.XS_Object_List;
         XS_Particle    : XML.Schema.Particles.XS_Particle;

         Decl           :
         XML.Schema.Element_Declarations.XS_Element_Declaration;
         Type_Dif       : XML.Schema.Type_Definitions.XS_Type_Definition;
         Type_Name      : League.Strings.Universal_String;

      begin

         Decl := XS_Term.To_Element_Declaration;
         Type_Dif := Decl.Get_Type_Definition;

         if Type_Dif.Get_Name.Is_Empty then
            Type_Name.Append (Name & "_" & XS_Term.Get_Name & "_Anonym");

            if Min_Occurs
              and then not Max_Occurs
            then
               Type_Name := "Payloads.Optional_"
                 & XSD_To_Ada.Utils.Add_Separator (Type_Name);

            elsif Max_Occurs then
               Type_Name := "Payloads."
                 & XSD_To_Ada.Utils.Add_Separator (Type_Name)
                 & "_Vector";
            end if;

         else
            Type_Name := Map.Ada_Type_Qualified_Name
              (Type_Dif.Get_Name,
               Min_Occurs,
               Max_Occurs);
         end if;

         if Choice then
            Case_Type.Append
              (XSD_To_Ada.Utils.Add_Separator (Decl.Get_Name) & "_Case");

            Writers.P (Writer,
                       "      when "
                       & XSD_To_Ada.Utils.Add_Separator (Decl.Get_Name)
                       & "_Case =>" & LF
                       & XSD_To_Ada.Utils.Split_Line
                         (XSD_To_Ada.Utils.Add_Separator
                            (Decl.Get_Name).To_Wide_Wide_String
                          & " : " & Type_Name.To_Wide_Wide_String & ";", 8));
         else
            if Type_Dif.Is_Simple_Type_Definition
              and then Min_Occurs
            then
               Type_Name := "Payloads.Optional_"
                 & XSD_To_Ada.Utils.Add_Separator (Decl.Get_Name);

            elsif Type_Dif.Is_Simple_Type_Definition
              and then Max_Occurs
            then
               Type_Name := "Payloads."
                 & XSD_To_Ada.Utils.Add_Separator (Type_Dif.Get_Name)
                 & "_Vector.Vector";
            end if;

            Writers.P (Writer,
                       XSD_To_Ada.Utils.Split_Line
                         (XSD_To_Ada.Utils.Add_Separator (Decl.Get_Name)
                          & " : " & Type_Name.To_Wide_Wide_String & ";", 6));
--                         & ";  --  Min :"
--                         & League.Strings.From_UTF_8_String (Min_Occurs'Img)
--                        & "; Max :"
--                         & League.Strings.From_UTF_8_String (Max_Occurs'Img));
         end if;
      end Print_Element;

   begin
      XS_List := Model_Group.Get_Particles;

      if Choice then
         Case_Type.Append
           ("   type "
            & Name
            & "_Kind is" & LF & "     (");
      end if;

      for J in 1 .. XS_List.Get_Length loop

         XS_Particle := XS_List.Item (J).To_Particle;

         if XS_Particle.Get_Max_Occurs.Unbounded then
            Max_Occurs := True;
         else
            if XS_Particle.Get_Max_Occurs.Value > 1 then
               Max_Occurs := True;
            else
               Max_Occurs := False;
            end if;
         end if;

         if XS_Particle.Get_Min_Occurs = 0 then
            Min_Occurs := True;
         else
            Min_Occurs := False;
         end if;

         if XS_Particle.Get_Term.Is_Element_Declaration then
            Print_Element
              (XS_Particle.Get_Term,
               Writer,
               Writer_types,
               Name,
               Map);
         else
            Writers.P
              (Writer,
               "      " & Name & LF
               &"        : " & Name & "_Case_Anonym;");
         end if;

         if J /= XS_List.Get_Length and Choice then
            Case_Type.Append ("," & LF & "      ");
         end if;
      end loop;

      if Choice then
         Case_Type.Append (");" & LF);
         Writer_types.P (Case_Type);
      end if;
   end Print_Model;

   ---------------------------
   -- Print_Type_Definition --
   ---------------------------

   procedure Print_Type_Definition
     (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
      Writer       : in out Writers.Writer;
      Writer_types : in out Writers.Writer;
      Name         : League.Strings.Universal_String;
      Anonym_Name  : League.Strings.Universal_String;
      Element_Name : League.Strings.Universal_String;
      Mapping      : XSD_To_Ada.Mappings.Mapping;
      Choice       : Boolean := False;
      Is_Max_Occur : Boolean := False;
      Is_Min_Occur : Boolean := False)
   is
      use type XML.Schema.Type_Definitions.XS_Type_Definition;

      procedure Print_Term
        (XS_Term      : XML.Schema.Terms.XS_Term;
         Writer       : in out Writers.Writer;
         Writer_types : in out Writers.Writer;
         Name         : League.Strings.Universal_String;
         Map          : XSD_To_Ada.Mappings.Mapping);

      XS_Particle    : XML.Schema.Particles.XS_Particle;
      XS_Term        : XML.Schema.Terms.XS_Term;
      XS_Base        : XML.Schema.Type_Definitions.XS_Type_Definition;

      CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;

      Case_Type : League.Strings.Universal_String;
      Max_Occurs : Boolean := False;
      Min_Occurs : Boolean := False;

      ----------------
      -- Print_Term --
      ----------------

      procedure Print_Term
        (XS_Term      : XML.Schema.Terms.XS_Term;
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
         Type_Dif       : XML.Schema.Type_Definitions.XS_Type_Definition;
         Type_Name      : League.Strings.Universal_String;
      begin

         if XS_Term.Is_Model_Group then
            XS_Model_Group := XS_Term.To_Model_Group;
            XS_List := XS_Model_Group.Get_Particles;

            if Choice then
               Case_Type.Append
                 ("   type "
                  & XSD_To_Ada.Utils.Add_Separator (Type_D.Get_Name)
                  & "_Kind is (");
            end if;

            for J in 1 .. XS_List.Get_Length loop
               XS_Particle := XS_List.Item (J).To_Particle;

               if XS_Particle.Get_Max_Occurs.Unbounded then
                  Max_Occurs := True;
               else
                  if XS_Particle.Get_Max_Occurs.Value > 1 then
                     Max_Occurs := True;
                  else
                     Max_Occurs := False;
                  end if;
               end if;

               if XS_Particle.Get_Min_Occurs = 0 then
                  Min_Occurs := True;
               else
                  Min_Occurs := False;
               end if;

               if not XS_Particle.Get_Term.Is_Model_Group then
                  Print_Term
                    (XS_Particle.Get_Term,
                     Writer,
                     Writer_types,
                     Name,
                     Map);
               end if;

               if J /= XS_List.Get_Length and Choice then
                  Case_Type.Append (", ");
               end if;
            end loop;

            if Choice then
               Case_Type.Append (");" & LF);
               Writer_types.P (Case_Type);
            end if;

         elsif XS_Term.Is_Element_Declaration then

            Decl := XS_Term.To_Element_Declaration;
            Type_Dif := Decl.Get_Type_Definition;

            Type_Name := Map.Ada_Type_Qualified_Name
              (Type_Dif.Get_Name,
               Min_Occurs);

            if Choice then
               Case_Type.Append (Decl.Get_Name & "_Case");

               Writers.P (Writer,
                          "      when " & Decl.Get_Name & "_Case =>" & LF
                          & "        "
                          & Decl.Get_Name & " : " & Type_Name & ";");
            else
               Writers.P (Writer,
                          "      "
                          & Decl.Get_Name & " : " & Type_Name & "; --  "
                          & League.Strings.From_UTF_8_String
                            (Type_Dif.Get_Type_Category'Img) & "; Max :"
                          & League.Strings.From_UTF_8_String (Max_Occurs'Img));
            end if;
         end if;
      end Print_Term;

   begin
      XS_Base := Type_D.Get_Base_Type;

      if XS_Base.Get_Type_Category in
        XML.Schema.Complex_Type .. XML.Schema.Simple_Type
        and XS_Base /= Type_D
      then
         null;
         --           Writers.P
         --            (Writer,
         --             Split_Line
         --              ("     "
         --                 & Add_Separator (XS_Base.Get_Name)
         --                 & " : Payloads."
         --                 & Add_Separator (XS_Base.Get_Name)
         --                 & ";", 5));
      end if;

      case Type_D.Get_Type_Category is
         when XML.Schema.Complex_Type =>
            CTD := Type_D.To_Complex_Type_Definition;

            if CTD.Get_Content_Type in Element_Only | Mixed then
               XS_Particle := CTD.Get_Particle;
               XS_Term := XS_Particle.Get_Term;

               Print_Term
                 (XS_Term,
                  Writer,
                  Writer_types,
                  XSD_To_Ada.Utils.Add_Separator (Name),
                  Mapping);
            end if;

         when XML.Schema.Simple_Type =>
            null;

         when XML.Schema.None =>
            null;
--            raise Constraint_Error;
      end case;

   end Print_Type_Definition;

end XSD_To_Ada.Payloads;
