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
-- Copyright © 2010 Vadim Godunko <vgodunko@gmail.com>                      --
--                                                                          --
-- Matreshka is free software;  you can  redistribute it  and/or modify  it --
-- under terms of the  GNU General Public License as published  by the Free --
-- Software  Foundation;  either version 2,  or (at your option)  any later --
-- version.  Matreshka  is distributed in the hope that it will be  useful, --
-- but   WITHOUT  ANY  WARRANTY;  without  even  the  implied  warranty  of --
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General --
-- Public License for more details.  You should have received a copy of the --
-- GNU General Public License distributed with Matreshka; see file COPYING. --
-- If not, write  to  the  Free Software Foundation,  51  Franklin  Street, --
-- Fifth Floor, Boston, MA 02110-1301, USA.                                 --
--                                                                          --
-- As a special exception,  if other files  instantiate  generics from this --
-- unit, or you link  this unit with other files  to produce an executable, --
-- this  unit  does not  by itself cause  the resulting  executable  to  be --
-- covered  by the  GNU  General  Public  License.  This exception does not --
-- however invalidate  any other reasons why  the executable file  might be --
-- covered by the  GNU Public License.                                      --
--                                                                          --
------------------------------------------------------------------------------
--  $Revision$ $Date$
------------------------------------------------------------------------------
with Matreshka.Internals.Atomics.Counters;
with Matreshka.Internals.Strings;
with Matreshka.Internals.Utf16;

package Matreshka.Internals.Regexps is

   pragma Preelaborate;

   type Shared_String_Array is
     array (Natural range <>)
       of aliased Matreshka.Internals.Strings.Shared_String_Access;
   pragma Atomic_Components (Shared_String_Array);

   type Slice is record
      First_Position : Matreshka.Internals.Utf16.Utf16_String_Index;
      First_Index    : Positive;
      Next_Position  : Matreshka.Internals.Utf16.Utf16_String_Index;
      Next_Index     : Positive;
   end record;
   --  Slice represent slice in the source Shared_String. Next points to the
   --  first character after slice.

   type Slice_Array is array (Natural range <>) of Slice;

   type Shared_Match (Groups : Natural) is limited record
      Counter   : aliased Matreshka.Internals.Atomics.Counters.Counter;
      --  Atomic reference counter.

      Is_Matched : Boolean := False;
      --  Flag is object contains match information or not.

      Source     : Matreshka.Internals.Strings.Shared_String_Access;
      --  Reference to source string.

      Number     : Natural;
      --  Number of actual subexpression captures.

      Slices     : Slice_Array (0 .. Groups);
      --  Slices of captured data.

      Captures   : Shared_String_Array (0 .. Groups);
      pragma Volatile (Captures);
      --  Actual captured data.
   end record;
   --  Shared match is a results of the match of the string to pattern. When
   --  shared object is constructed, only slices information is filled. Actual
   --  captures is constructed lazy on request.

   type Shared_Match_Access is access all Shared_Match;

   Empty_Shared_Match : aliased Shared_Match :=
    (Groups     => 0,
     Counter    => <>,
     Is_Matched => False,
     Source     => null,
     Number     => 0,
     Slices     => (others => (0, 1, 0, 1)),
     Captures   => (others => null));

   procedure Reference (Item : not null Shared_Match_Access);

   procedure Dereference (Item : in out Shared_Match_Access);

   function Capture
    (Item   : not null Shared_Match_Access;
     Number : Natural)
       return not null Matreshka.Internals.Strings.Shared_String_Access;

end Matreshka.Internals.Regexps;
