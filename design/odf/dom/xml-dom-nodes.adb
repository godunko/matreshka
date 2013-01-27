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
with Ada.Unchecked_Deallocation;

package body XML.DOM.Nodes is

   ------------------
   -- Append_Child --
   ------------------

   not overriding procedure Append_Child
    (Self : not null access DOM_Node'Class;
     Node : not null DOM_Node_Access) is
   begin
      Reference (Node);

      if Self.Last_Child = null then
         Self.First_Child      := Node;
         Self.Last_Child       := Node;
         Node.Parent_Node      := DOM_Node_Access (Self);
         Node.Next_Sibling     := null;
         Node.Previous_Sibling := null;

      else
         Node.Parent_Node             := DOM_Node_Access (Self);
         Node.Next_Sibling            := null;
         Node.Previous_Sibling        := Self.Last_Child;
         Self.Last_Child.Next_Sibling := Node;
         Self.Last_Child              := Node;
      end if;
   end Append_Child;

   -----------------
   -- Dereference --
   -----------------

   procedure Dereference (Node : in out DOM_Node_Access) is

      procedure Free is
        new Ada.Unchecked_Deallocation (DOM_Node'Class, DOM_Node_Access);

   begin
      if Matreshka.Atomics.Counters.Decrement (Node.Counter) then
         Free (Node);

      else
         Node := null;
      end if;
   end Dereference;

   ---------------
   -- Reference --
   ---------------

   procedure Reference (Node : not null DOM_Node_Access) is
   begin
      Matreshka.Atomics.Counters.Increment (Node.Counter);
   end Reference;

end XML.DOM.Nodes;
