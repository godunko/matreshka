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
with Matreshka.XML.DOM_Nodes.Elements;

package body Matreshka.XML.DOM_Nodes.Attributes is

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
    (Self           : not null access Attribute_Node'Class;
     Document       : not null Matreshka.XML.DOM_Nodes.Document_Access;
     Namespace_URI  : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String) is
   begin
      Matreshka.XML.DOM_Nodes.Initialize (Self, Document);
   end Initialize;

   ------------------------
   -- Remove_From_Parent --
   ------------------------

   overriding procedure Remove_From_Parent
    (Self : not null access Abstract_Attribute)
   is
      Owner_Element : Matreshka.XML.DOM_Nodes.Element_Access;

   begin
      --  Detach attribute from the list of attributes of owner element.

      if not Self.Is_Root then
         --  Owner of attribute node is element node when attribute node is not
         --  root.

         Owner_Element := Matreshka.XML.DOM_Nodes.Element_Access (Self.Owner);

         if Owner_Element.First_Attribute
              = Matreshka.XML.DOM_Nodes.Node_Access (Self)
         then
            Owner_Element.First_Attribute := Self.Next;
         end if;

         if Owner_Element.Last_Attribute
              = Matreshka.XML.DOM_Nodes.Node_Access (Self)
         then
            Owner_Element.Last_Attribute := Self.Previous;
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

      else
         Matreshka.XML.DOM_Nodes.Remove_From_Parent
          (Matreshka.XML.DOM_Nodes.Abstract_Node (Self.all)'Access);
      end if;
   end Remove_From_Parent;

end Matreshka.XML.DOM_Nodes.Attributes;
