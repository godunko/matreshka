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
with Matreshka.XML.Counters;
with Matreshka.XML.DOM_Nodes.Attributes;
with Matreshka.XML.DOM_Nodes.Documents;
with Matreshka.XML.DOM_Nodes.Elements;

package body Matreshka.XML.DOM_Lists is

   use type Matreshka.XML.DOM_Nodes.Node_Access;

   ---------------------------
   -- Append_Attribute_Node --
   ---------------------------

   procedure Append_Attribute_Node
    (Element   : not null Matreshka.XML.DOM_Nodes.Element_Access;
     Attribute : not null Matreshka.XML.DOM_Nodes.Attribute_Access)
   is
      Attribute_Node : constant Matreshka.XML.DOM_Nodes.Node_Access
        := Matreshka.XML.DOM_Nodes.Node_Access (Attribute);
      Element_Node   : constant Matreshka.XML.DOM_Nodes.Node_Access
        := Matreshka.XML.DOM_Nodes.Node_Access (Element);
      Owner_Node     : Matreshka.XML.DOM_Nodes.Node_Access
        := Matreshka.XML.DOM_Nodes.Node_Access (Element);

   begin
      Detach_From_Parent (Attribute_Node);

      --  Set owner of attribute node.

      Attribute.Is_Root := False;
      Attribute.Owner := Element_Node;

      --  Append to the list of attribute nodes.

      if Element.First_Attribute = null then
         --  First attribute of the list.

         Element.First_Attribute := Attribute_Node;
         Element.Last_Attribute := Attribute_Node;

      else
         Element.Last_Attribute.Next := Attribute_Node;
         Attribute.Previous := Element.Last_Attribute;
         Element.Last_Attribute := Attribute_Node;
      end if;

      --  Increment counters of parent nodes by value of counter of attribute
      --  node.

      while Owner_Node /= null loop
         Matreshka.XML.Counters.Increment
          (Owner_Node.Counter, Attribute.Counter);

         exit when Owner_Node.Is_Root;

         Owner_Node := Owner_Node.Owner;
      end loop;

      --  Increment attribute node counter by one to reflect parent-child
      --  relationship.

      Matreshka.XML.Counters.Increment (Attribute.Counter);
   end Append_Attribute_Node;

   --------------------------
   -- Append_Detached_Node --
   --------------------------

   procedure Append_Detached_Node
    (Document : not null Matreshka.XML.DOM_Nodes.Document_Access;
     Node     : not null Matreshka.XML.DOM_Nodes.Node_Access) is
   begin
      --  Set node's owner.

      Node.Owner := Matreshka.XML.DOM_Nodes.Node_Access (Document);

      --  Insert node into documents's list of detached nodes.

      if Document.First_Detached = null then
         --  First node in the list.

         Document.First_Detached := Node;
         Document.Last_Detached := Node;

      else
         Document.Last_Detached.Next := Node;
         Node.Previous := Document.Last_Detached;
         Document.Last_Detached := Node;
      end if;
   end Append_Detached_Node;

   ------------------------
   -- Detach_From_Parent --
   ------------------------

   procedure Detach_From_Parent
    (Node : not null Matreshka.XML.DOM_Nodes.Node_Access)
   is
      Owner : Matreshka.XML.DOM_Nodes.Node_Access := Node.Owner;

   begin
      Node.Remove_From_Parent;

      if Node.Is_Root then
         --  When root node has owner node it means what it is detached node of
         --  the document. Document node's counter need to be decremented by 1.

         if Owner /= null then
            if Matreshka.XML.Counters.Decrement (Owner.Counter) then
               --  Must never happen.

               raise Program_Error;
            end if;
         end if;

      else
         --  Decrement counter to remove parent-child dependency.

         if Matreshka.XML.Counters.Decrement (Node.Counter) then
            --  Must never happen.

            raise Program_Error;
         end if;

         --  Decrement counters of all parent nodes by value of counter of
         --  removed node.

         while Owner /= null loop
            if Matreshka.XML.Counters.Is_Zero (Owner.Counter) then
               raise Program_Error;
            end if;

            if Matreshka.XML.Counters.Decrement
                (Owner.Counter, Node.Counter)
            then
               --  Must never happen.

               raise Program_Error;
            end if;

            exit when Owner.Is_Root;

            Owner := Owner.Owner;
         end loop;
      end if;
   end Detach_From_Parent;

end Matreshka.XML.DOM_Lists;
