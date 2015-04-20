------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Ada Modeling Framework                          --
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
with System.Storage_Elements;
private with System;

with League.Strings;

private with AMF3.Object_References;
with AMF3.Slots;
private with AMF3.Slots.Collections;
with AMF3.Metadata;

package AMF3.Objects is

--   pragma Preelaborate;

   function To_Slot (Address : System.Address) return AMF3.Slots.Slot_Access;

   ---------------------
   -- Abstract_Object --
   ---------------------

   Object_Descriptor : aliased constant AMF3.Metadata.Descriptor;

   type Abstract_Object
         (Metadata : access constant AMF3.Metadata.Descriptor
            := Object_Descriptor'Access) is abstract tagged limited private;

   not overriding procedure On_Property_Changed
    (Self : in out Abstract_Object) is null;

private

   Object_Descriptor : aliased constant AMF3.Metadata.Descriptor
     := (Name             => League.Strings.Empty_Universal_String,
         Superclass_Count => 0,
         Superclasses     => (others => <>),
         Slot_Count       => 0,
         Slots            => (others => <>));

   type Abstract_Object
         (Metadata : access constant AMF3.Metadata.Descriptor
            := Object_Descriptor'Access) is abstract tagged limited
   record
      Default : aliased
        AMF3.Slots.Collections.Collection_Slot (Abstract_Object'Access);
   end record;

end AMF3.Objects;
