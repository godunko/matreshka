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
--  This package provides implementation of the Case Algorithms from the
--  Unicode specification.
with Matreshka.Internals.Locales;

with Matreshka.Internals.Ucd;

private package Matreshka.Strings.Casing is

   pragma Preelaborate;

   procedure To_Uppercase
    (Locale      : not null Matreshka.Internals.Locales.Locale_Data_Access;
     Source      : Matreshka.Internals.Utf16.Utf16_String;
     Source_Last : Natural;
     Kind        : Matreshka.Internals.Ucd.Case_Mapping_Kinds;
     Property    : Matreshka.Internals.Ucd.Boolean_Properties;
     Destination : out Utf16_String_Access;
     Last        : out Natural;
     Length      : out Natural;
     Index_Mode  : out Index_Modes);

--   procedure To_Lowercase
--    (Source      : Matreshka.Internals.Utf16.Utf16_String;
--     Source_Last : Natural;
--     Destination : out Utf16_String_Access;
--     Last        : out Natural;
--     Length      : out Natural;
--     Index_Mode  : out Index_Modes);
--
--   procedure To_Titlecase
--    (Source      : Matreshka.Internals.Utf16.Utf16_String;
--     Source_Last : Natural;
--     Destination : out Utf16_String_Access;
--     Last        : out Natural;
--     Length      : out Natural;
--     Index_Mode  : out Index_Modes);

end Matreshka.Strings.Casing;
