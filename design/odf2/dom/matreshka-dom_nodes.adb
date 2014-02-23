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
with Matreshka.DOM_Documents;

package body Matreshka.DOM_Nodes is

   ------------------
   -- Append_Child --
   ------------------

   overriding function Append_Child
    (Self : not null access Node;
     Node : not null XML.DOM.Nodes.DOM_Node_Access)
       return not null XML.DOM.Nodes.DOM_Node_Access
   is
      N : constant Node_Access := Node_Access (Node);

   begin
      --  Remove node from its curent position in the tree.

      if N.Parent /= null then
         if N.Parent.First = N then
            N.Parent.First := N.Next;
         end if;

         if N.Parent.Last = N then
            N.Parent.Last := N.Previous;
         end if;

         if N.Previous /= null then
            N.Previous.Next := N.Next;
         end if;

         if N.Next /= null then
            N.Next.Previous := N.Previous;
         end if;

      --  Remove node from the list of detached nodes.

      else
         if N.Document.First_Detached = N then
            N.Document.First_Detached := N.Next;
         end if;

         if N.Document.Last_Detached = N then
            N.Document.Last_Detached := N.Previous;
         end if;

         if N.Previous /= null then
            N.Previous.Next := N.Next;
         end if;

         if N.Next /= null then
            N.Next.Previous := N.Previous;
         end if;
      end if;

      --  Append node to the requested position.

      N.Parent := Node_Access (Self);

      if Self.First = null then
         Self.First := N;
         Self.Last := N;
         N.Previous := null;
         N.Next := null;

      else
         N.Previous := Self.Last;
         N.Next := null;
         Self.Last.Next := N;
         Self.Last := N;
      end if;

      return Node;
   end Append_Child;

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
       (Self     : not null access Node'Class;
        Document : not null Document_Access)
      is
         S : constant Node_Access := Node_Access (Self);

      begin
         --  Append element to the list of detached nodes of the document.

         Self.Document := Document;

         if Document.First_Detached = null then
            Document.First_Detached := S;
            Document.Last_Detached := S;
            Self.Previous := null;
            Self.Next := null;

         else
            S.Previous := Document.Last_Detached;
            S.Next := null;
            Document.Last_Detached.Next := S;
            Document.Last_Detached := S;
         end if;
      end Initialize;

   end Constructors;

   --------------------
   -- Get_Node_Value --
   --------------------

   overriding function Get_Node_Value
    (Self : not null access constant Node)
       return League.Strings.Universal_String
   is
      pragma Unreferenced (Self);

   begin
      return League.Strings.Empty_Universal_String;
   end Get_Node_Value;

   ---------------------
   -- Get_Parent_Node --
   ---------------------

   overriding function Get_Parent_Node
    (Self : not null access constant Node)
       return XML.DOM.Nodes.DOM_Node_Access is
   begin
      return XML.DOM.Nodes.DOM_Node_Access (Self.Parent);
   end Get_Parent_Node;

   --------------------
   -- Set_Node_Value --
   --------------------

   overriding procedure Set_Node_Value
    (Self      : not null access Node;
     New_Value : League.Strings.Universal_String)
   is
      pragma Unreferenced (Self);
      pragma Unreferenced (New_Value);

   begin
      null;
   end Set_Node_Value;

end Matreshka.DOM_Nodes;
