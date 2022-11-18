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
-- Copyright © 2014, Vadim Godunko <vgodunko@gmail.com>                     --
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
with Matreshka.DOM_Documents;

with Matreshka.ODF_String_Constants;
with ODF.DOM.Iterators;
with ODF.DOM.Visitors;

package body Matreshka.ODF_Form.Visual_Effect_Attributes is

   ------------
   -- Create --
   ------------

   overriding function Create
    (Parameters : not null access Matreshka.DOM_Attributes.Attribute_L2_Parameters)
       return Form_Visual_Effect_Attribute_Node is
   begin
      return Self : Form_Visual_Effect_Attribute_Node do
         Matreshka.ODF_Form.Constructors.Initialize
          (Self'Unchecked_Access,
           Parameters.Document,
           Matreshka.ODF_String_Constants.Form_Prefix);
      end return;
   end Create;

   --------------------
   -- Get_Local_Name --
   --------------------

   overriding function Get_Local_Name
    (Self : not null access constant Form_Visual_Effect_Attribute_Node)
       return League.Strings.Universal_String
   is
      pragma Unreferenced (Self);

   begin
      return Matreshka.ODF_String_Constants.Visual_Effect_Attribute;
   end Get_Local_Name;

begin
   Matreshka.DOM_Documents.Register_Attribute
    (Matreshka.ODF_String_Constants.Form_URI,
     Matreshka.ODF_String_Constants.Visual_Effect_Attribute,
     Form_Visual_Effect_Attribute_Node'Tag);
end Matreshka.ODF_Form.Visual_Effect_Attributes;
