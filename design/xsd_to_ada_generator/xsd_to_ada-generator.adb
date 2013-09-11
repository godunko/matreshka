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

with Ada.Directories;
with Ada.Containers.Vectors;

with XML.Schema.Complex_Type_Definitions;
with XML.Schema.Element_Declarations;
with XML.Schema.Object_Lists;
with XML.Schema.Objects;
with XML.Schema.Objects.Terms;
with XML.Schema.Objects.Terms.Model_Groups;
with XML.Schema.Objects.Type_Definitions;
with XML.Schema.Objects.Particles;
with XML.Schema.Model_Groups;
with XML.Schema.Named_Maps;
with XML.Schema.Simple_Type_Definitions;
with XML.Schema.Type_Definitions;

with League.Strings;
with League.String_Vectors;

with XSD_To_Ada.Utils;
with XSD_To_Ada.Mappings_XML;

package body XSD_To_Ada.Generator is

   Tab   : Natural := 0;

   Payloads       : XSD_To_Ada.Writers.Writer;

   ST_Writer      : XSD_To_Ada.Writers.Writer;
   CT_Writer      : XSD_To_Ada.Writers.Writer;

   Session_Bool   : Boolean := False;

   maxOccurs : Boolean := False;
   Is_Vector  : Boolean := False;

   ---------
   -- Dec --
   ---------

   procedure Dec is begin
      if Tab > 2 then
         Tab := Tab - 3;
      else
         Tab := 0;
      end if;
   end Dec;

   -----------------
   -- Delete_File --
   -----------------

   procedure Delete_File (Name : String) is
   begin
      if Ada.Directories.Exists (Name) then
         Ada.Directories.Delete_File (Name);
      end if;
   end Delete_File;

   --------------
   -- Generate --
   --------------

   procedure Generate (Model : XML.Schema.Models.XS_Model) is

   begin
      XSD_To_Ada.Utils.Put_Header (Payloads);
      XSD_To_Ada.Utils.Gen_Proc_Header (Payloads, "payloads");

      declare
         use type XML.Schema.Type_Category;
         use all type XML.Schema.Objects.Type_Definitions
           .Complex_Type_Definitions.Content_Types;

         procedure Print_Type_Definition
           (Type_D : XML.Schema.Type_Definitions.XS_Type_Definition;
            Vector_Type : in out Boolean;
            Name : Wide_Wide_String);

         ---------------------------
         -- Print_Type_Definition --
         ---------------------------

         procedure Print_Type_Definition
           (Type_D : XML.Schema.Type_Definitions.XS_Type_Definition;
            Vector_Type : in out Boolean;
            Name : Wide_Wide_String)
         is
            use type XML.Schema.Type_Definitions.XS_Type_Definition;

            XS_Particle    : XML.Schema.Objects.Particles.XS_Particle;
            XS_Term        : XML.Schema.Objects.Terms.XS_Term;
            CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;

            procedure Print_Term
              (XS_Term : XML.Schema.Objects.Terms.XS_Term;
               Has_Max_Occurs  : in out Boolean;
               Name : Wide_Wide_String);

            procedure Print_Term
              (XS_Term : XML.Schema.Objects.Terms.XS_Term;
               Has_Max_Occurs  : in out Boolean;
               Name : Wide_Wide_String)
            is
               use type XML.Schema.Objects.Terms.Model_Groups.Compositor_Kinds;

               XS_Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
               XS_List        : XML.Schema.Object_Lists.XS_Object_List;
               XS_Particle    : XML.Schema.Objects.Particles.XS_Particle;
               Decl : XML.Schema.Element_Declarations.XS_Element_Declaration;
            begin

               if XS_Term.Is_Model_Group then
                  XS_Model_Group := XS_Term.To_Model_Group;
                  XS_List := XS_Model_Group.Get_Particles;

                  Has_Max_Occurs := False;

                  for J in 1 .. XS_List.Get_Length loop
                     XS_Particle := XS_List.Item (J).To_Particle;

                     if XS_Particle.Get_Max_Occurs.Unbounded then
                        Has_Max_Occurs := True;
                     else
                        if XS_Particle.Get_Max_Occurs.Value > 1 then
                           Has_Max_Occurs := True;
                        end if;
                     end if;

                     Print_Term (XS_Particle.Get_Term, Has_Max_Occurs, Name);
                  end loop;
               elsif XS_Term.Is_Element_Declaration then
                  Decl   := XS_Term.To_Element_Declaration;

                  Print_Type_Definition
                    (Decl.Get_Type_Definition, Has_Max_Occurs, Name);
               end if;
            end Print_Term;

         begin
            if Type_D.Get_Name.To_Wide_Wide_String = Name and Vector_Type then
               Is_Vector := True;
            end if;

            case Type_D.Get_Type_Category is
            when XML.Schema.Complex_Type =>
               CTD := Type_D.To_Complex_Type_Definition;

               if CTD.Get_Content_Type in Element_Only | Mixed then
                  XS_Particle := CTD.Get_Particle;
                  XS_Term := XS_Particle.Get_Term;

                  Print_Term (XS_Term, maxOccurs, Name);
               end if;
            when XML.Schema.Simple_Type | XML.Schema.None =>
               null;
            end case;
         end Print_Type_Definition;

         Namespace : constant League.Strings.Universal_String
           := League.Strings.To_Universal_String
             ("http://www.actforex.com/iats");
         Name      : constant League.Strings.Universal_String
           := League.Strings.To_Universal_String ("OpenSessionResponse");
         Decl      : constant
           XML.Schema.Element_Declarations.XS_Element_Declaration
             := Model.Get_Element_Declaration (Name, Namespace);
         Type_D    : constant XML.Schema.Type_Definitions.XS_Type_Definition
           := Decl.Get_Type_Definition;

         CTD : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;

         Complex_Types : constant XML.Schema.Named_Maps.XS_Named_Map :=
           Model.Get_Components_By_Namespace
             (Object_Type => XML.Schema.Complex_Type,
              Namespace   => Namespace);

         XS_Object   : XML.Schema.Objects.XS_Object;
         XS_Object_2 : XML.Schema.Objects.XS_Object;

         Map : XSD_To_Ada.Mappings_XML.Mapping_XML;

         Table_Name  : League.String_Vectors.Universal_String_Vector;
         Table_State : League.String_Vectors.Universal_String_Vector;
      begin
         Map :=
           XSD_To_Ada.Utils.Read_Mapping
             (League.Strings.To_Universal_String ("./mapping.xml"));

         XSD_To_Ada.Utils.Create_Simple_Type (Model, ST_Writer);
         XSD_To_Ada.Utils.Create_Complex_Type (Model);

         Ada.Text_IO.Put_Line
           ("##################    TEST    ###################");

         for J in 1 .. Complex_Types.Length loop
            Table_Name.Append (Complex_Types.Item (J).Get_Name);
            Table_State.Append (League.Strings.To_Universal_String ("0"));
         end loop;

         for J in 1 .. Complex_Types.Length loop
            XS_Object := Complex_Types.Item (J);

            if XS_Object.Get_Name.To_UTF_8_String = "PredefinedCondition" then

               XSD_To_Ada.Utils.Gen_Proc_Header
                 (CT_Writer,
                  XSD_To_Ada.Utils.Add_Separator
                    (XS_Object.Get_Name.To_Wide_Wide_String));

               Writers.P
                 (CT_Writer,
                  "   type "
                  & XSD_To_Ada.Utils.Add_Separator
                    (XS_Object.Get_Name.To_Wide_Wide_String)
                  & " is new Web_Services.SOAP.Payloads.Abstract_SOAP_Payload"
                  & Wide_Wide_Character'Val (10)
                  & "   with record");

--                 XSD_To_Ada.Utils.Print_Type_Definition
--                   (XS_Object.To_Type_Definition,
--                    "",
--                    CT_Writer, CT_Writer,
--                    XS_Object.Get_Name, False, Map,
--                    Table_Name, Table_State);

               Writers.P (CT_Writer, "   end record;");
               Writers.P (CT_Writer);
            end if;
         end loop;
      end;

      Ada.Text_IO.Create
        (Current_Out_File, Ada.Text_IO.Out_File, "./XSD_Types_NEW.ads");
      Ada.Text_IO.Put_Line (Current_Out_File, CT_Writer.Text.To_UTF_8_String);
      Ada.Text_IO.Close (Current_Out_File);

      Ada.Text_IO.Create
        (Current_Out_File, Ada.Text_IO.Out_File, "./XSD_Types.ads");
      Ada.Text_IO.Put_Line (Current_Out_File, ST_Writer.Text.To_UTF_8_String);
      Ada.Text_IO.Close (Current_Out_File);
   end Generate;

   ---------
   -- Inc --
   ---------

   procedure Inc is begin
      Tab := Tab + 3;
   end Inc;

   -------
   -- P --
   -------

   procedure P
     (Self : in out XSD_To_Ada.Writers.Writer; Txt : Wide_Wide_String) is
   begin
      Self.P (Txt);
   end P;

end XSD_To_Ada.Generator;
