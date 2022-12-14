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
--  $Revision$ $Date$
------------------------------------------------------------------------------

package body XML.DOM.Nodes.Internals is

   ------------
   -- Create --
   ------------

   function Create
    (Node : Matreshka.DOM_Nodes.Node_Access)
       return XML.DOM.Nodes.DOM_Node
   is
      use type Matreshka.DOM_Nodes.Node_Access;

   begin
      if Node /= null then
         Matreshka.DOM_Nodes.Reference
          (Matreshka.DOM_Nodes.Node_Access (Node));
      end if;

      return
       (Ada.Finalization.Controlled
          with Node => Matreshka.DOM_Nodes.Node_Access (Node));
   end Create;

   --------------
   -- Internal --
   --------------

   function Internal
    (Node : XML.DOM.Nodes.DOM_Node'Class)
       return Matreshka.DOM_Nodes.Node_Access is
   begin
      return Node.Node;
   end Internal;

--   ----------
--   -- Wrap --
--   ----------
--
--   function Wrap
--    (Node : Matreshka.XML.DOM_Nodes.Document_Access)
--       return XML.DOM.Nodes.Documents.DOM_Document is
--   begin
--      return
--       (Ada.Finalization.Controlled
--          with Node => Matreshka.XML.DOM_Nodes.Node_Access (Node));
--   end Wrap;

end XML.DOM.Nodes.Internals;
