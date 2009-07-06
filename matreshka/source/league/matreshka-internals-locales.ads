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
-- Copyright © 2009 Vadim Godunko <vgodunko@gmail.com>                      --
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
--  This package provides type for representations of the locale's data and
--  internal operations on locales data.
------------------------------------------------------------------------------
with Matreshka.Internals.Atomics.Counters;
with Matreshka.Internals.Ucd;

package Matreshka.Internals.Locales is

   pragma Preelaborate;

   type Locale_Data is limited record
      Counter : aliased Matreshka.Internals.Atomics.Counters.Counter;
      Breaks  : not null Matreshka.Internals.Ucd.Break_First_Stage_Access;
   end record;

   type Locale_Data_Access is access all Locale_Data;

   procedure Reference (Self : Locale_Data_Access);
   pragma Inline (Reference);

   procedure Dereference (Self : in out Locale_Data_Access);

   function Get_Locale return not null Locale_Data_Access;
   --  Returns current locale. Reference counter of locale is automatically
   --  incremented, so caller is responsible to call Dereference for free
   --  locale then it is no longer needed.

end Matreshka.Internals.Locales;
