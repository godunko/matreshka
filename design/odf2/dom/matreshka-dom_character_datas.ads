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
with League.Strings;

with Matreshka.DOM_Nodes;
with XML.DOM.Character_Datas;

package Matreshka.DOM_Character_Datas is

   pragma Preelaborate;

   type Character_Data_Node is abstract new Matreshka.DOM_Nodes.Node
     and XML.DOM.Character_Datas.DOM_Character_Data with
   record
      Data : League.Strings.Universal_String;
   end record;

   overriding function Get_Data
    (Self : not null access constant Character_Data_Node)
       return League.Strings.Universal_String;

   overriding function Get_Node_Value
    (Self : not null access constant Character_Data_Node)
       return League.Strings.Universal_String renames Get_Data;

   overriding procedure Set_Data
    (Self      : not null access Character_Data_Node;
     New_Value : League.Strings.Universal_String);

   overriding procedure Set_Node_Value
    (Self      : not null access Character_Data_Node;
     New_Value : League.Strings.Universal_String) renames Set_Data;

   package Constructors is

      procedure Initialize
       (Self     : not null access Character_Data_Node'Class;
        Document : not null Matreshka.DOM_Nodes.Document_Access;
        Data     : League.Strings.Universal_String);

   end Constructors;

end Matreshka.DOM_Character_Datas;
