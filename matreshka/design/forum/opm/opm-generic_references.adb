------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2015, Vadim Godunko <vgodunko@gmail.com>                     --
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

package body OPM.Generic_References is

   ------------
   -- Adjust --
   ------------

   overriding procedure Adjust (Self : in out Reference) is
   begin
      Self.Self := Self'Unchecked_Access;
   end Adjust;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out Variable_Reference_Type) is
   begin
      Self.Reference.Store.Release (Self.Object);
   end Finalize;

   ----------------
   -- Identifier --
   ----------------

   function Identifier (Self : Reference'Class) return Element_Identifier is
   begin
      return Self.Identifier;
   end Identifier;

   ----------------
   -- Initialize --
   ----------------

   overriding procedure Initialize (Self : in out Reference) is
   begin
      Self.Self := Self'Unchecked_Access;
   end Initialize;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
    (Self       : in out Reference;
     Store      : not null access Element_Store'Class;
     Identifier : Element_Identifier) is
   begin
      Self.Store      := Store;
      Self.Identifier := Identifier;
   end Initialize;

   ------------
   -- Object --
   ------------

   function Object (Self : Reference'Class) return Variable_Reference_Type is
   begin
      return
       (Ada.Finalization.Limited_Controlled with
          Object    => Self.Store.Get (Self.Identifier),
          Reference => Self.Self);
   end Object;

end OPM.Generic_References;
