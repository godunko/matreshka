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
-- Copyright © 2014, Vadim Godunko <vgodunko@gmail.com>                --
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

with League.Characters;

with XML.Schema.Complex_Type_Definitions;
with XML.Schema.Element_Declarations;
with XML.Schema.Model_Groups;
with XML.Schema.Object_Lists;
with XML.Schema.Particles;

with XSD_To_Ada.Utils;

package body XSD_To_Ada.Payloads is

   use XML.Schema.Complex_Type_Definitions;
   use XSD_To_Ada.Writers;
   use all type League.Strings.Universal_String;

   LF : constant Wide_Wide_Character := Ada.Characters.Wide_Wide_Latin_1.LF;

   procedure Print_Type_Definition
     (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
      Writer       : in out Writers.Writer;
      Writer_types : in out Writers.Writer;
      Name         : League.Strings.Universal_String;
      Element_Name : League.Strings.Universal_String;
      Mapping      : XSD_To_Ada.Mappings.Mapping;
      Choice       : Boolean := False;
      Is_Min_Occur : Boolean := False;
      Is_Max_Occur : Boolean := False);

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

         if Current.Object.Is_Type_Definition then

            Print_Type_Definition
              (Type_D       => Current.Object.To_Type_Definition,
               Writer       => Payload_Writer,
               Writer_types => Payload_Type_Writer,
               Name         => Current.Short_Ada_Type_Name,
               Element_Name => Current.Element_Name,
               Mapping      => Mapping,
               Choice       => Current.Choice,
               Is_Min_Occur => Current.Min,
               Is_Max_Occur => Current.Max);

         elsif Current.Object.Is_Model_Group
           and then Current.Short_Ada_Type_Name.Element (1) /= '_'  --  FIX
         then
            Type_Name := XSD_To_Ada.Utils.Add_Separator
              (Current.Short_Ada_Type_Name);

            Model_Group := Current.Object.To_Model_Group;

            if Current.Choice then
               Payload_Writer.P
                 ("   type "
                  & Type_Name & LF
                  & "     (Kind : " & Type_Name & "_Kind" & LF
                  & "       := " & Type_Name
                  & "_Kind'First) is record" & LF
                  & "       case Kind is");
            else
               Payload_Writer.P ("   type " & Type_Name & " is record");
            end if;

            Print_Model
              (Model_Group  => Model_Group,
               Writer       => Payload_Writer,
               Writer_types => Payload_Type_Writer,
               Name         => Current.Short_Ada_Type_Name,
               Map          => Mapping,
               Choice       => Current.Choice);

            if Current.Choice then
               Payload_Writer.P ("      end case;" & LF);
            end if;

            Payload_Writer.P ("   end record;" & LF);
         else
            raise Constraint_Error;
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

            if Name.To_Wide_Wide_String = "Transaction" then  -- FIX!!!
               Type_Name.Append
                 (XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
                  & "_Anonym");
            else
               Type_Name.Append
                 (Name & "_"
                  & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
                  & "_Anonym");
            end if;

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
      Element_Name : League.Strings.Universal_String;
      Mapping      : XSD_To_Ada.Mappings.Mapping;
      Choice       : Boolean := False;
      Is_Min_Occur : Boolean := False;
      Is_Max_Occur : Boolean := False)
   is
      use type XML.Schema.Type_Definitions.XS_Type_Definition;

      XS_Particle    : XML.Schema.Particles.XS_Particle;
      XS_Term        : XML.Schema.Terms.XS_Term;
      XS_Base        : XML.Schema.Type_Definitions.XS_Type_Definition;
      Model_Group : XML.Schema.Model_Groups.XS_Model_Group;

      CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;

      Type_Name : League.Strings.Universal_String;

      Base_Type : League.Strings.Universal_String;

   begin
      XS_Base := Type_D.Get_Base_Type;

      if XS_Base.Get_Type_Category in
        XML.Schema.Complex_Type
        and XS_Base /= Type_D
      then

         if Element_Name.Is_Empty then
            Type_Name := Name;
         else
            Type_Name := Element_Name;
         end if;

         if XS_Base.Get_Name.To_Wide_Wide_String = "anyType" then
            Writer_types.P
              ("   type " & XSD_To_Ada.Utils.Add_Separator (Type_Name)
               & " is" & LF
               & "     new Web_Services.SOAP.Payloads.Abstract_SOAP_Payload"
               & LF
               & "       with null record;" & LF);
            return;
         else
            Base_Type := League.Strings.To_Universal_String
              (XSD_To_Ada.Utils.Split_Line
                 (XSD_To_Ada.Utils.Add_Separator (XS_Base.Get_Name)
                  & " : Payloads."
                  & XSD_To_Ada.Utils.Add_Separator (XS_Base.Get_Name)
                  & ";", 5) & LF);
         end if;
      end if;

      case Type_D.Get_Type_Category is
         when XML.Schema.Complex_Type =>

            if not Is_Min_Occur
              and then not Is_Max_Occur
              and then Element_Name.Is_Empty  --  FIX!!!! HAS ELEMENT
            then
               CTD := Type_D.To_Complex_Type_Definition;

               if CTD.Get_Content_Type in Element_Only | Mixed then
                  XS_Particle := CTD.Get_Particle;
                  XS_Term := XS_Particle.Get_Term;

                  if XS_Term.Is_Model_Group then
                     Model_Group := XS_Term.To_Model_Group;
                  end if;

                  Type_Name := Name;

                  if (XSD_To_Ada.Utils.Has_Element_Session (Type_D)
                    or Type_Name.Ends_With ("Response"))
                    and not Choice
                  then
                     Writer_types.P
                       ("   type "
                        & Type_Name
                        & " is" & LF
                        & "     new Web_Services.SOAP.Payloads."
                        & "Abstract_SOAP_Payload"
                        & LF
                        & "   with record");

                  elsif Choice then
                     Writer.P
                       ("   type " & Type_Name & LF
                        & "     (Kind : " & Type_Name
                        & "_Kind" & LF
                        & "       := " & Type_Name
                        & "_Kind'First) is record" & LF
                        & "       case Kind is");
                  else
                     Writer_types.P ("   type " & Type_Name & " is record");
                  end if;

                  if not Element_Name.Is_Empty
                    and then XSD_To_Ada.Utils.Add_Separator (Element_Name) /= Name
                  then
                      Writer_types.P
                       (XSD_To_Ada.Utils.Split_Line
                          (Name.To_Wide_Wide_String
                           & " : Payloads." & Name.To_Wide_Wide_String & ";", 5));
                  else
                     Writer.P (Base_Type);

                     Print_Model
                       (Model_Group  => Model_Group,
                        Writer       => Writer,
                        Writer_types => Writer_types,
                        Name         => Name,
                        Map          => Mapping,
                        Choice       => Choice);
                  end if;

                  if Choice then
                     Writer.P ("      end case;" & LF);
                  end if;

                  Writer.P ("   end record;" & LF);

                  if Type_Name.Ends_With ("Response") then
                     XSD_To_Ada.Utils.Gen_Access_Type
                       (Writer,
                        XSD_To_Ada.Utils.Add_Separator
                          (Type_Name));
                  end if;
               end if;

            elsif not Element_Name.Is_Empty then
               Type_Name := XSD_To_Ada.Utils.Add_Separator (Element_Name);

               CTD := Type_D.To_Complex_Type_Definition;

               if CTD.Get_Content_Type in Element_Only | Mixed then
                  XS_Term := CTD.Get_Particle.Get_Term;

                  if XS_Term.Is_Model_Group then
                     Model_Group := XS_Term.To_Model_Group;
                  end if;
               end if;

               if Name.Is_Empty then
                  if Choice then
                     Writer.P
                       ("   type " & Type_Name & LF
                        & "     (Kind : " & Type_Name
                        & "_Kind" & LF
                        & "       := " & Type_Name
                        & "_Kind'First) is record" & LF
                        & "       case Kind is");

                  elsif XSD_To_Ada.Utils.Has_Element_Session (Type_D) then
                     Writer.P
                       ("   type "
                        & Type_Name
                        & " is" & LF
                        & "     new Web_Services.SOAP.Payloads."
                        & "Abstract_SOAP_Payload"
                        & LF
                        & "   with record");
                  else
                     Writer_types.P ("   type " & Type_Name & " is record");
                  end if;
                     Writer.N (Base_Type);

                  Print_Model
                    (Model_Group  => Model_Group,
                     Writer       => Writer,
                     Writer_types => Writer_types,
                     Name         => Type_Name,
                     Map          => Mapping,
                     Choice       => Choice);

                  if Choice then
                     Writer.P ("     end case;" & LF);
                  end if;

                  Writer.P ("   end record;" & LF);

               elsif XSD_To_Ada.Utils.Has_Element_Session (Type_D) then
                  Writer_types.P
                    ("   type " & Type_Name & " is" & LF
                     & "     new Payloads." & Name & LF
                     & "       with null record;" & LF);

               elsif Type_Name.Ends_With ("Response") then
                  Writer_types.P
                    ("   type "
                     & Type_Name
                     & " is" & LF
                     & "     new Web_Services.SOAP.Payloads."
                     & "Abstract_SOAP_Payload"
                     & LF
                     & "   with record" & LF
                     & XSD_To_Ada.Utils.Split_Line
                       (XSD_To_Ada.Utils.Add_Separator (Type_D.Get_Name)
                        & " : Payloads."
                        & XSD_To_Ada.Utils.Add_Separator (Type_D.Get_Name)
                        & ";", 5) & LF
                     & "   end record;" & LF);

                  XSD_To_Ada.Utils.Gen_Access_Type
                    (Writer,
                     XSD_To_Ada.Utils.Add_Separator
                       (Type_Name));
               else
                  Writer_types.P
                    ("   type " & Type_Name & " is record" & LF
                     & "     " & XSD_To_Ada.Utils.Add_Separator (Type_D.Get_Name)
                     & " : Payloads."
                     & XSD_To_Ada.Utils.Add_Separator (Type_D.Get_Name) & ";"
                     & LF
                     & "   end record;" & LF);
               end if;

            elsif Is_Min_Occur then
               Writers.P
                    (Writer_types,
                     "   type Optional_" & Name
                     & " is record" & LF
                     & "     Is_Set : Boolean := False;" & LF
                     & "     Value  : " & Name & ";" & LF
                     & "   end record;" & LF);

            elsif Is_Max_Occur then
                  Writers.P
                    (Writer_types,
                     "   package " & Name & "_Vectors is" & LF
                     & "     new Ada.Containers.Vectors" & LF
                     & "      (Positive, "
                     & Name & ");"
                     & LF & LF
                     & XSD_To_Ada.Utils.Split_Line
                       ("subtype " & Name & "_Vector is "
                        & Name & "_Vectors.Vector;", 3)
                     & LF);
            end if;

         when XML.Schema.Simple_Type =>
            if Is_Min_Occur then
               Writers.P
                 (Writer_types,
                  "   type Optional_" & Name & " is record" & LF
                  & "     Is_Set : Boolean := False;" & LF
                  & "     Value  : "
                  & XSD_To_Ada.Mappings.Ada_Type_Qualified_Name
                    (Mapping,
                     Type_D.Get_Name)
                  & ";" & LF
                  & "   end record;" & LF);

            elsif Is_Max_Occur then
               Writers.P
                 (Writer_types,
                  "   package "
                  & XSD_To_Ada.Utils.Add_Separator (Type_D.Get_Name)
                  & "_Vector is" & LF
                  &  "     new Ada.Containers.Vectors" & LF
                  & "       (Positive, "
                  & XSD_To_Ada.Mappings.Ada_Type_Qualified_Name
                    (Mapping,
                     Type_D.Get_Name)
                  & "," & LF
                  & "       ""="" => ICTS.Types.""="");" & LF);
            end if;

         when XML.Schema.None =>
            raise Constraint_Error;
      end case;
   end Print_Type_Definition;

end XSD_To_Ada.Payloads;
