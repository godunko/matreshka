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
with Ada.Containers.Hashed_Maps;

with League.Strings.Hash;

with Matreshka.XML_Schema.AST.Types;

package Matreshka.XML_Schema.AST.Schemas is

   pragma Preelaborate;

   package Type_Definition_Maps is
     new Ada.Containers.Hashed_Maps
          (League.Strings.Universal_String,
           Matreshka.XML_Schema.AST.Types.Type_Definition_Access,
           League.Strings.Hash,
           League.Strings."=",
           Matreshka.XML_Schema.AST.Types."=");

   type Schema_Node is new Abstract_Node with record
      --  Properties:
      --
      --  {annotations}
      --  A sequence of Annotation components.

      Type_Definitions : Type_Definition_Maps.Map;
      --  {type definitions}
      --  A set of Type Definition components.

      --  {attribute declarations}
      --  A set of Attribute Declaration components.
      --
      --  {element declarations}
      --  A set of Element Declaration components.
      --
      --  {attribute group definitions}
      --  A set of Attribute Group Definition components.
      --
      --  {model group definitions}
      --  A set of Model Group Definition components.
      --
      --  {notation declarations}
      --  A set of Notation Declaration components.
      --
      --  {identity-constraint definitions}
      --  A set of Identity-Constraint Definition components.

      --  Internal data.

      Final_Default            : Matreshka.XML_Schema.AST.Derivation_Set;

      Target_Namespace         : League.Strings.Universal_String;
      Target_Namespace_Defined : Boolean;
   end record;

   type Schema_Access is access all Schema_Node'Class;

end Matreshka.XML_Schema.AST.Schemas;
