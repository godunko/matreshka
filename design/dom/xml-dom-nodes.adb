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

package body XML.DOM.Nodes is

   use type Matreshka.XML.Dom_Nodes.Node_Access;

   ------------
   -- Adjust --
   ------------

   overriding procedure Adjust (Self : in out DOM_Node) is
   begin
      if Self.Node /= null then
         Matreshka.XML.Dom_Nodes.Reference (Self.Node);
      end if;
   end Adjust;

   ------------------
   -- Append_Child --
   ------------------

   function Append_Child
    (Self      : in out DOM_Node'Class;
     New_Child : DOM_Node'Class) return DOM_Node is
   begin
      if Self.Node /= null then
         Self.Node.Append_Child (New_Child.Node);

         return DOM_Node (New_Child);

      else
         raise Constraint_Error;
      end if;
   end Append_Child;

   ------------------
   -- Append_Child --
   ------------------

   procedure Append_Child
    (Self      : in out DOM_Node'Class;
     New_Child : DOM_Node'Class) is
   begin
      if Self.Node /= null then
         Self.Node.Append_Child (New_Child.Node);

      else
         raise Constraint_Error;
      end if;
   end Append_Child;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out DOM_Node) is
   begin
      if Self.Node /= null then
         Matreshka.XML.Dom_Nodes.Dereference (Self.Node);
      end if;
   end Finalize;

   -------------
   -- Is_Null --
   -------------

   function Is_Null (Self : DOM_Node'Class) return Boolean is
   begin
      return Self.Node = null;
   end Is_Null;

end XML.DOM.Nodes;
