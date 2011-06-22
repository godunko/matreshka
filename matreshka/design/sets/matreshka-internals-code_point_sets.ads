------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--         Localization, Internationalization, Globalization for Ada        --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2011, Vadim Godunko <vgodunko@gmail.com>                     --
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
--  Internal representation of code point sets.
------------------------------------------------------------------------------
with Matreshka.Internals.Atomics.Counters;
with Matreshka.Internals.Unicode.Ucd;
with League.Characters;

package Matreshka.Internals.Code_Point_Sets is

   pragma Preelaborate;

   subtype First_Stage_Index is
     Matreshka.Internals.Unicode.Ucd.First_Stage_Index;

   subtype Second_Stage_Index is
     Matreshka.Internals.Unicode.Ucd.Second_Stage_Index;

   type Boolean_Second_Stage is array (Second_Stage_Index) of Boolean;
   pragma Pack (Boolean_Second_Stage);

   type Second_Stage_Array_Index is new First_Stage_Index;

   type Boolean_Second_Stage_Array is array (Second_Stage_Array_Index range <>)
     of Boolean_Second_Stage;

   type First_Stage_Map is array (First_Stage_Index)
     of Second_Stage_Array_Index;

   type Shared_Code_Point_Set (Last : Second_Stage_Array_Index) is limited
   record
      Counter   : aliased Matreshka.Internals.Atomics.Counters.Counter;
      --  Atomic reference counter.

      First_Stage   : First_Stage_Map;
      Second_Stages : Boolean_Second_Stage_Array (0 .. Last);
   end record;

   function To_Set
     (Sequence : Wide_Wide_String)
     return Shared_Code_Point_Set;
   --  Return set containing all characters from Sequence

   function "=" (Left, Right : Shared_Code_Point_Set) return Boolean;

   function "not"
     (Right : Shared_Code_Point_Set)
     return Shared_Code_Point_Set;
   --  Return complementing set of character

   function "and"
     (Left, Right : Shared_Code_Point_Set)
     return Shared_Code_Point_Set;
   --  Return intersection of Left and Right

   function "or"
     (Left, Right : Shared_Code_Point_Set)
     return Shared_Code_Point_Set;
   --  Return union of Left and Right

   function "xor"
     (Left, Right : Shared_Code_Point_Set)
     return Shared_Code_Point_Set;

   function "-"
     (Left, Right : Shared_Code_Point_Set)
     return Shared_Code_Point_Set;
   --  Return difference

   function Has
     (Set     : Shared_Code_Point_Set;
      Element : League.Characters.Universal_Character)
     return Boolean;

   function Is_Subset
     (Elements : Shared_Code_Point_Set;
      Set      : Shared_Code_Point_Set)
     return Boolean;

   function Is_Empty (Set : Shared_Code_Point_Set) return Boolean;

   type Shared_Code_Point_Set_Access is access all Shared_Code_Point_Set;

   Shared_Empty : aliased Shared_Code_Point_Set :=
     (Last => 0,
      Counter => <>,
      First_Stage => (others => 0),
      Second_Stages => (others => (others => False)));

   --  Globally defined empty shared code point set to be used as default value
   --  Reference and Dereference subprograms known about this object and
   --  never change its reference counter for speed optimization (atomic
   --  increment/decrement operations have significant perfomance penalty)
   --  and allows to be used in Preelaborateable_Initialization types.

   procedure Reference (Self : Shared_Code_Point_Set_Access);
   pragma Inline (Reference);
   --  Increment reference counter. Change of reference counter of Shared_Empty
   --  object is prevented to provide speedup and to allow to use it to
   --  initialize components of Preelaborateable_Initialization types.

   procedure Dereference (Self : in out Shared_Code_Point_Set_Access);
   --  Decrement reference counter and free resources if it reach zero value.
   --  Self is setted to null. Decrement of reference counter and deallocation
   --  of Shared_Empty object is prevented to provide minor speedup and to
   --  allow use it to initialize components of Preelaborateable_Initialization
   --  types.

end Matreshka.Internals.Code_Point_Sets;
