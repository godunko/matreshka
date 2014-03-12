------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Open Document Toolkit                           --
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
with Ada.Streams;
with Ada.Text_IO;

with AWS.Attachments;
with AWS.Messages;
with AWS.Response.Set;
with AWS.Server;

with League.JSON.Documents;
with League.Stream_Element_Vectors;
with League.Strings;

with ODF.DOM.Packages;
with ODF.Packages;

with ODF.Web.Applier;

package body ODF.Web.AWS_Callbacks is

   Json_Mime_Type : constant String := "application/json";
   Text_Mime_Type : constant String := "text/text";

   ---------------------
   -- Change_Callback --
   ---------------------

   function Change_Callback
    (Request : AWS.Status.Data) return AWS.Response.Data is
   begin
      ODF.Web.Applier.Apply
       (League.JSON.Documents.From_JSON
         (League.Stream_Element_Vectors.To_Stream_Element_Vector
           (AWS.Status.Binary_Data (Request))).To_Object);

      return AWS.Response.Build (Text_Mime_Type, "OK");
   end Change_Callback;

   ------------------
   -- Get_Callback --
   ------------------

   function Get_Callback
    (Request : AWS.Status.Data) return AWS.Response.Data is
   begin
      return
        AWS.Response.Build
         (JSON_Mime_Type, To_JSON (Document.Styles, Document.Content));
   end Get_Callback;

   ---------------------
   -- Upload_Callback --
   ---------------------

   function Upload_Callback
    (Request : AWS.Status.Data) return AWS.Response.Data
   is
      Attachments : AWS.Attachments.List := AWS.Status.Attachments (Request);
      The_Package : ODF.DOM.Packages.ODF_Package_Access;

   begin
      Ada.Text_IO.Put_Line ("Content type   : " & AWS.Status.Content_Type (Request));
      Ada.Text_IO.Put_Line ("Content length :" & Integer'Image (AWS.Status.Content_Length (Request)));
      Ada.Text_IO.Put_Line ("Is Uploaded    : " & Boolean'Image (AWS.Status.Is_Body_Uploaded (Request)));
      Ada.Text_IO.Put_Line ("Size of data   :" & Ada.Streams.Stream_Element_Offset'Image (AWS.Status.Binary_Size (Request)));
      Ada.Text_IO.Put_Line ("Attachments    :" & Integer'Image (AWS.Status.Attachments (Request).Count));

      for J in 1 .. Attachments.Count loop
         Ada.Text_IO.Put_Line ("  " & AWS.Attachments.Local_Filename (Attachments.Get (J)));
      end loop;

      if Attachments.Count = 1 then
         The_Package :=
           ODF.Packages.Load (League.Strings.From_UTF_8_String (AWS.Attachments.Local_Filename (Attachments.Get (1))));

         Ada.Text_IO.Put_Line (ODF.Web.To_JSON (The_Package.Get_Styles, The_Package.Get_Content));
         --  Debug output.

         ODF.Web.Document.Styles := The_Package.Get_Styles;
         ODF.Web.Document.Content := The_Package.Get_Content;
      end if;

      return Response : AWS.Response.Data := AWS.Response.URL ("index.html") do
         AWS.Response.Set.Status_Code (Response, AWS.Messages.S303);
      end return;
   end Upload_Callback;

end ODF.Web.AWS_Callbacks;
