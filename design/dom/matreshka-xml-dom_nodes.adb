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
-- Copyright © 2011-2013, Vadim Godunko <vgodunko@gmail.com>                --
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

with Matreshka.XML.DOM_Lists;
with Matreshka.XML.DOM_Nodes.Documents;

package body Matreshka.XML.DOM_Nodes is

   ------------------
   -- Append_Child --
   ------------------

   not overriding procedure Append_Child
    (Self  : not null access Abstract_Node;
     Child : not null Node_Access) is
   begin
      Matreshka.XML.DOM_Lists.Append_Child_Node (Self, Child);
   end Append_Child;

   -----------------
   -- Dereference --
   -----------------

   procedure Dereference (Self : in out Node_Access) is

      procedure Free is
        new Ada.Unchecked_Deallocation (Abstract_Node'Class, Node_Access);

      Is_Root : constant Boolean := Self.Is_Root;
      Owner   : Node_Access := Self.Owner;

   begin
      if Matreshka.XML.Counters.Decrement (Self.Counter) then
         Self.Finalize;
         Free (Self);

         if Is_Root and Owner /= null then
            Dereference (Owner);
         end if;

      else
         if not Is_Root
           and then Owner /= null
           and then not Matreshka.XML.Counters.Is_Zero (Owner.Counter)
         then
            --  Counter of owner node equal to zero means what owner is in
            --  destruction, otherwise dereference owner node.

            Dereference (Owner);
         end if;

         Self := null;
      end if;
   end Dereference;

   --------------
   -- Finalize --
   --------------

   not overriding procedure Finalize (Self : not null access Abstract_Node) is
      Current : Node_Access := Self.First;

   begin
      --  Remove children nodes.

      while Current /= null loop
         Dereference (Current);
         Current := Self.First;
      end loop;

      --  Remove node from parent's list of nodes.

      Abstract_Node'Class (Self.all).Remove_From_Parent;
   end Finalize;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
    (Self     : not null access Abstract_Node'Class;
     Document : Matreshka.XML.DOM_Nodes.Document_Access) is
   begin
      Matreshka.XML.DOM_Nodes.Reference
       (Matreshka.XML.DOM_Nodes.Node_Access (Document));
      Matreshka.XML.DOM_Lists.Append_Detached_Node (Document, Self);
   end Initialize;

   ---------------
   -- Reference --
   ---------------

   procedure Reference (Self : not null Node_Access) is
   begin
      if not Self.Is_Root then
         Reference (Self.Owner);
      end if;

      Matreshka.XML.Counters.Increment (Self.Counter);
   end Reference;

   ------------------------
   -- Remove_From_Parent --
   ------------------------

   not overriding procedure Remove_From_Parent
    (Self : not null access Abstract_Node)
   is
      Owner_Document : Matreshka.XML.DOM_Nodes.Document_Access;

   begin
      if Self.Owner /= null then
         if Self.Is_Root then
            --  Root elements are attached to the list of detached nodes of
            --  document.

            Owner_Document :=
              Matreshka.XML.DOM_Nodes.Document_Access (Self.Owner);

            if Owner_Document.First_Detached = Self then
               Owner_Document.First_Detached := Self.Next;
            end if;

            if Owner_Document.Last_Detached = Self then
               Owner_Document.Last_Detached := Self.Previous;
            end if;

         else
            if Self.Owner.First = Self then
               Self.Owner.First := Self.Next;
            end if;

            if Self.Owner.Last = Self then
               Self.Owner.Last := Self.Previous;
            end if;
         end if;

         if Self.Previous /= null then
            Self.Previous.Next := Self.Next;
         end if;

         if Self.Next /= null then
            Self.Next.Previous := Self.Previous;
         end if;

         Self.Owner    := null;
         Self.Next     := null;
         Self.Previous := null;
      end if;
   end Remove_From_Parent;

end Matreshka.XML.DOM_Nodes;
