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
with League.Strings;
private with Matreshka.Atomics.Counters;

package XML.DOM.Nodes is

   type DOM_Node is abstract tagged limited private;

   type DOM_Node_Access is access all DOM_Node'Class;

   function Get_First_Child
    (Self : not null access constant DOM_Node'Class) return DOM_Node_Access;

   function Get_Next_Sibling
    (Self : not null access constant DOM_Node'Class) return DOM_Node_Access;

   procedure Append_Child
    (Self : not null access DOM_Node'Class; Node : not null DOM_Node_Access);

   ---------------
   -- Internals --
   ---------------

   procedure Dereference (Node : in out DOM_Node_Access);
   --  Decrements reference counter; deallocate node when counter reachs zero.
   --  Sets Node to null on return.

private

   type DOM_Node is abstract tagged limited record
      Counter          : Matreshka.Atomics.Counters.Counter;
      Parent_Node      : DOM_Node_Access;
      First_Child      : DOM_Node_Access;
      Last_Child       : DOM_Node_Access;
      Next_Sibling     : DOM_Node_Access;
      Previous_Sibling : DOM_Node_Access;
   end record;

   procedure Reference (Node : not null DOM_Node_Access);
   --  Increments reference counter.

end XML.DOM.Nodes;
