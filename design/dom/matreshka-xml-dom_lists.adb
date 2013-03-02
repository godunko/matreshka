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
      Owner_Document : Matreshka.XML.DOM_Nodes.Node_Access := Attribute.Owner;

   begin
      Attribute.Remove_From_Parent;

      --  Set owner of attribute node.

      Attribute.Is_Root := False;
      Attribute.Owner := Matreshka.XML.DOM_Nodes.Node_Access (Element);

      --  Append to the list of attribute nodes.

      if Element.First_Attribute = null then
         --  First attribute of the list.

         Element.First_Attribute :=
           Matreshka.XML.DOM_Nodes.Node_Access (Attribute);
         Element.Last_Attribute :=
           Matreshka.XML.DOM_Nodes.Node_Access (Attribute);

      else
         Element.Last_Attribute.Next :=
           Matreshka.XML.DOM_Nodes.Node_Access (Attribute);
         Attribute.Previous := Element.Last_Attribute;
         Element.Last_Attribute :=
           Matreshka.XML.DOM_Nodes.Node_Access (Attribute);
      end if;

      --  Update reference counters.

      Matreshka.XML.Counters.Increment (Attribute.Counter);
--      Matreshka.XML.DOM_Nodes.Reference
--       (Matreshka.XML.DOM_Nodes.Node_Access (Attribute));
      Matreshka.XML.DOM_Nodes.Reference
       (Matreshka.XML.DOM_Nodes.Node_Access (Element));
      Matreshka.XML.DOM_Nodes.Dereference (Owner_Document);
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

end Matreshka.XML.DOM_Lists;
