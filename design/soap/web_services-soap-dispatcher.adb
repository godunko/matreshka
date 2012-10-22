------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2012, Vadim Godunko <vgodunko@gmail.com>                     --
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
with League.Strings;
with League.Text_Codecs;
with XML.SAX.Input_Sources.Streams.Element_Arrays;
with XML.SAX.Simple_Readers;

with Web_Services.SOAP.Handler_Registry;
with Web_Services.SOAP.Message_Decoders;
with Web_Services.SOAP.Message_Encoders;
with Web_Services.SOAP.Messages;

package body Web_Services.SOAP.Dispatcher is

   function To_Stream_Element_Vector
    (Item : String) return League.Stream_Element_Vectors.Stream_Element_Vector;

   --------------
   -- Dispatch --
   --------------

   procedure Dispatch
    (Input_Data   : Ada.Streams.Stream_Element_Array;
     Status       : out Status_Type;
     Content_Type : out League.Stream_Element_Vectors.Stream_Element_Vector;
     Output_Data  : out League.Stream_Element_Vectors.Stream_Element_Vector)
   is
      use type Web_Services.SOAP.Messages.SOAP_Message_Access;

      Source  : aliased
        XML.SAX.Input_Sources.Streams.Element_Arrays.
          Stream_Element_Array_Input_Source;
      Handler : aliased
        Web_Services.SOAP.Message_Decoders.SOAP_Message_Decoder;
      Reader  : aliased XML.SAX.Simple_Readers.SAX_Simple_Reader;
      Input   : Web_Services.SOAP.Messages.SOAP_Message_Access;
      Output  : Web_Services.SOAP.Messages.SOAP_Message_Access;

   begin
      --  Parse request data.

      Source.Set_Stream_Element_Array (Input_Data);
      Reader.Set_Content_Handler (Handler'Unchecked_Access);
      Reader.Set_Error_Handler (Handler'Unchecked_Access);
      Reader.Set_Lexical_Handler (Handler'Unchecked_Access);
      Reader.Parse (Source'Access);

      if Handler.Success then
         --  Request was decoded successfully, lookup for handler and call it.

         Input := Handler.Message;

         Web_Services.SOAP.Handler_Registry.Resolve
          (Input.Payload'Tag) (Input, Output);
         Status := S_200;

      else
         Output := Handler.Message;

         if Output = null then
            --  SOAP message handler detects error, but unable to generate
            --  SOAP fault.

            declare
               Codec : constant League.Text_Codecs.Text_Codec
                 := League.Text_Codecs.Codec
                     (League.Strings.To_Universal_String ("utf-8"));

            begin
               Output_Data  := Codec.Encode (Handler.Error_String);
               Content_Type := To_Stream_Element_Vector ("text/plain");
               Status       := S_400;

               return;
            end;

         else
            Status := S_400;
         end if;
      end if;

      if Output /= null then
         declare
            Encoder : Web_Services.SOAP.Message_Encoders.SOAP_Message_Encoder;

         begin
            Content_Type := To_Stream_Element_Vector ("application/soap+xml");
            Output_Data := Encoder.Encode (Output.all);
            Web_Services.SOAP.Messages.Free (Output);

            return;
         end;
      end if;
   end Dispatch;

   ------------------------------
   -- To_Stream_Element_Vector --
   ------------------------------

   function To_Stream_Element_Vector
    (Item : String) return League.Stream_Element_Vectors.Stream_Element_Vector
   is
      use type Ada.Streams.Stream_Element_Offset;

      Aux : Ada.Streams.Stream_Element_Array (0 .. Item'Length - 1);
      for Aux'Address use Item'Address;
      pragma Import (Ada, Aux);

   begin
      return League.Stream_Element_Vectors.To_Stream_Element_Vector (Aux);
   end To_Stream_Element_Vector;

end Web_Services.SOAP.Dispatcher;
