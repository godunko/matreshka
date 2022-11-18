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
private with Ada.Finalization;

generic
   type Element_Identifier is private;
   type Element (<>) is abstract tagged limited private;
   type Element_Access is access all Element'Class;
   type Element_Store (<>) is abstract tagged limited private;

   with function Get
    (Self       : in out Element_Store;
     Identifier : Element_Identifier) return Element_Access is abstract;
   with procedure Release
    (Self   : in out Element_Store;
     Object : not null Element_Access) is abstract;

package OPM.Generic_References is

   pragma Preelaborate;

   type Reference is tagged private;

   procedure Initialize
    (Self       : in out Reference;
     Store      : not null access Element_Store'Class;
     Identifier : Element_Identifier);

   type Variable_Reference_Type
         (Object : not null access Element'Class) is limited private
     with Implicit_Dereference => Object;

   function Object (Self : Reference'Class) return Variable_Reference_Type;

   function Identifier (Self : Reference'Class) return Element_Identifier;

private

   type Reference_Access is access all Reference'Class with Storage_Size => 0;

   type Reference is new Ada.Finalization.Controlled with record
      Store      : access Element_Store'Class;
      Identifier : Element_Identifier;
      Self       : Reference_Access;
   end record;

   overriding procedure Adjust (Self : in out Reference);

   overriding procedure Initialize (Self : in out Reference);

   type Variable_Reference_Type
         (Object : not null access Element'Class) is
     new Ada.Finalization.Limited_Controlled with record
      Reference : Reference_Access;
   end record;

   overriding procedure Finalize (Self : in out Variable_Reference_Type);

end OPM.Generic_References;
