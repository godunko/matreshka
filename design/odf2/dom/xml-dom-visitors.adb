------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Open Document Toolkit                           --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2013-2014, Vadim Godunko <vgodunko@gmail.com>                --
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
with Matreshka.DOM_Nodes;

package body XML.DOM.Visitors is

   -----------
   -- Visit --
   -----------

   procedure Visit
    (Self    : in out Abstract_Iterator'Class;
     Visitor : in out Abstract_Visitor'Class;
     Node    : not null XML.DOM.Nodes.DOM_Node_Access;
     Control : in out Traverse_Control)
   is
      N : Matreshka.DOM_Nodes.Node'Class
        renames Matreshka.DOM_Nodes.Node'Class (Node.all);

   begin
      N.Enter_Node (Visitor, Control);

      if Control = Continue then
         N.Visit_Node (Self, Visitor, Control);
      end if;

      if Control in Continue | Abandon_Children | Abandon_Sibling then
         if Control = Abandon_Children then
            Control := Continue;
         end if;

         N.Leave_Node (Visitor, Control);
      end if;

      if Control = Abandon_Children then
         Control := Continue;
      end if;
   end Visit;

   --------------------
   -- Visit_Children --
   --------------------

   procedure Visit_Children
    (Self    : in out Abstract_Iterator'Class;
     Visitor : in out Abstract_Visitor'Class;
     Node    : not null access XML.DOM.Nodes.DOM_Node'Class;
     Control : in out Traverse_Control)
   is
      use type XML.DOM.Nodes.DOM_Node_Access;

      Child : XML.DOM.Nodes.DOM_Node_Access := Node.Get_First_Child;

   begin
      while Child /= null loop
         Self.Visit (Visitor, Child, Control);

         if Control = Abandon_Sibling then
            Control := Continue;

            exit;

         elsif Control = Terminate_Immediately then
            exit;
         end if;

         Child := Child.Get_Next_Sibling;
      end loop;
   end Visit_Children;

end XML.DOM.Visitors;
