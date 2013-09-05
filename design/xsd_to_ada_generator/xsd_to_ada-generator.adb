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

with XSD_To_Ada.Utils;
with XML.Schema.Objects;
with XML.Schema.Objects.Type_Definitions;
with XML.Schema.Type_Definitions;
with XML.Schema.Element_Declarations;
with XML.Schema.Complex_Type_Definitions;
with XML.Schema.Simple_Type_Definitions;
with XML.Schema.Named_Maps;

with League.Strings;

package body XSD_To_Ada.Generator is

   Tab   : Natural := 0;

   Payloads       : XSD_To_Ada.Writers.Writer;

   Payload_Writer          : XSD_To_Ada.Writers.Writer;
   Payload_Type_Writer     : XSD_To_Ada.Writers.Writer;

   Session_Type_Writer     : XSD_To_Ada.Writers.Writer;
   Session_Writer          : XSD_To_Ada.Writers.Writer;

   NON_Session_Writer      : XSD_To_Ada.Writers.Writer;
   NON_Session_Type_Writer : XSD_To_Ada.Writers.Writer;

   ST_Writer      : XSD_To_Ada.Writers.Writer;

   CT_Writer      : XSD_To_Ada.Writers.Writer;

   Session_Bool   : Boolean := False;
   Is_Record      : Boolean := False;

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

         Count : Natural := 0;

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

         STD : XML.Schema.Simple_Type_Definitions.XS_Simple_Type_Definition;

         Simple_Types : constant XML.Schema.Named_Maps.XS_Named_Map :=
           Model.Get_Components_By_Namespace
             (Object_Type => XML.Schema.Simple_Type,
              Namespace   => Namespace);

         XS_Object   : XML.Schema.Objects.XS_Object;
         XS_Base     : XML.Schema.Type_Definitions.XS_Type_Definition;
         Type_D_ST   : XML.Schema.Type_Definitions.XS_Type_Definition;

         US_Response : League.Strings.Universal_String;
      begin
         --  Create all Simple_Types
         if Type_D.Get_Type_Category = XML.Schema.Simple_Type then
            STD := Type_D.To_Simple_Type_Definition;

            if STD.Is_Null then
               raise Program_Error;
            end if;
         end if;

         for J in 1 .. Simple_Types.Length loop
            XS_Object := Simple_Types.Item (J);
            Type_D_ST := XS_Object.To_Type_Definition;
            XS_Base   := Type_D_ST.Get_Base_Type;

            XSD_To_Ada.Writers.P
              (ST_Writer,
               "type " &
                 XSD_To_Ada.Utils.Add_Separator
                 (XS_Object.Get_Name.To_Wide_Wide_String)
               & " is new "
               & XSD_To_Ada.Utils.Add_Separator
                 (XS_Base.Get_Name.To_Wide_Wide_String)
               & ";" & Wide_Wide_Character'Val (10));

            if XS_Object.Is_Multivalue_Facet then
               XSD_To_Ada.Writers.P (ST_Writer, "Is_Multivalue_Facet");
            end if;
         end loop;

         --  Create all Complex_Types
         if Type_D.Get_Type_Category = XML.Schema.Complex_Type then
            CTD := Type_D.To_Complex_Type_Definition;

            if CTD.Is_Null then
               raise Program_Error;
            end if;
         end if;

         for J in 1 .. Complex_Types.Length loop
            Count := 0;
            Is_Record := False;
            XS_Object := Complex_Types.Item (J);

            if XS_Object.Get_Name.Length > 10 then
               US_Response := League.Strings.Slice
                 (XS_Object.Get_Name,
                  XS_Object.Get_Name.Length - 7,
                  XS_Object.Get_Name.Length);
            end if;

            if XS_Object.Get_Name.Length > 10
              and
                US_Response.To_UTF_8_String = "Response"
            then
               XSD_To_Ada.Utils.Gen_Proc_Header
                 (Payload_Writer,
                  XSD_To_Ada.Utils.Add_Separator
                  (XS_Object.Get_Name.To_Wide_Wide_String));

               Writers.P
                 (Payload_Writer,
                  "   type "
                  & XSD_To_Ada.Utils.Add_Separator
                    (XS_Object.Get_Name.To_Wide_Wide_String)
                  & " is new Web_Services.SOAP.Payloads.Abstract_SOAP_Payload"
                  & Wide_Wide_Character'Val (10)
                  & "   with record");

               XSD_To_Ada.Utils.Print_Type_Definition
                 (XS_Object.To_Type_Definition,
                  "",
                  Payload_Writer, Payload_Type_Writer,
                  XS_Object.Get_Name);

               XSD_To_Ada.Utils.Gen_Access_Type
                 (Payload_Writer,
                  XSD_To_Ada.Utils.Add_Separator
                 (XS_Object.Get_Name.To_Wide_Wide_String));
               US_Response.Clear;
            else
               XSD_To_Ada.Utils.Print_Type_Session
                 (XS_Object.To_Type_Definition, "", Session_Bool);

               if Session_Bool then
                  XSD_To_Ada.Utils.Gen_Proc_Header
                    (Session_Writer,
                     XSD_To_Ada.Utils.Add_Separator
                       (XS_Object.Get_Name.To_Wide_Wide_String));

               Writers.P
                 (Session_Writer,
                  "   type "
                  & XSD_To_Ada.Utils.Add_Separator
                    (XS_Object.Get_Name.To_Wide_Wide_String)
                  & " is new Web_Services.SOAP.Payloads.Abstract_SOAP_Payload"
                  & Wide_Wide_Character'Val (10)
                  & "   with record");

                  XSD_To_Ada.Utils.Print_Type_Definition
                    (XS_Object.To_Type_Definition,
                     "",
                     Session_Writer, Session_Type_Writer,
                     XS_Object.Get_Name);
               else
                  Is_Record := True;

                  Writers.N
                    (NON_Session_Writer,
                     "type "
                     & XSD_To_Ada.Utils.Add_Separator
                       (XS_Object.Get_Name.To_Wide_Wide_String) & " ");

                  XSD_To_Ada.Utils.Print_Type_Definition
                    (XS_Object.To_Type_Definition,
                     "",
                     NON_Session_Writer, NON_Session_Type_Writer,
                     XS_Object.Get_Name,
                     Is_Record);

                  Is_Record := False;
               end if;
            end if;

            Session_Bool := False;
            US_Response.Clear;
         end loop;

         Ada.Text_IO.Put_Line
           ("##################    ActivateCondition    ###################");

         for J in 1 .. Complex_Types.Length loop
            XS_Object := Complex_Types.Item (J);

--              if XS_Object.Get_Name.To_UTF_8_String = "OpenOrderInformation"
--                or XS_Object.Get_Name.To_UTF_8_String = "ActivateCondition"
--                  or XS_Object.Get_Name.To_UTF_8_String = "ConditionalOpenOrderInformation"
--              then
               Writers.P
                 (CT_Writer,
                  "type "
                  & XSD_To_Ada.Utils.Add_Separator
                    (XS_Object.Get_Name.To_Wide_Wide_String) & " is record");

               XSD_To_Ada.Utils.Print_Type_Definition
                 (XS_Object.To_Type_Definition,
                  "",
                  CT_Writer, CT_Writer,
                  XS_Object.Get_Name);

               Writers.P (CT_Writer, "end record;");
               Writers.P (CT_Writer);
--            end if;
         end loop;
      end;

      Ada.Text_IO.Create
        (Current_Out_File, Ada.Text_IO.Out_File, "./Payload.ads");
      Ada.Text_IO.Put_Line
        (Current_Out_File, Payload_Type_Writer.Text.To_UTF_8_String);
      Ada.Text_IO.Put_Line
        (Current_Out_File, Payload_Writer.Text.To_UTF_8_String);
      Ada.Text_IO.Put_Line
        (Current_Out_File, Session_Type_Writer.Text.To_UTF_8_String);
      Ada.Text_IO.Put_Line
        (Current_Out_File, Session_Writer.Text.To_UTF_8_String);
      Ada.Text_IO.Close (Current_Out_File);

      Ada.Text_IO.Create
        (Current_Out_File, Ada.Text_IO.Out_File, "./XSD_Forex.ads");
      Ada.Text_IO.Put_Line
        (Current_Out_File, NON_Session_Type_Writer.Text.To_UTF_8_String);
      Ada.Text_IO.Put_Line
        (Current_Out_File, NON_Session_Writer.Text.To_UTF_8_String);
      Ada.Text_IO.Close (Current_Out_File);

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
