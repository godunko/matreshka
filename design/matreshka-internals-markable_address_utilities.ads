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
--  Markable address is a standard System.Address lower bit of it is used for
--  "mark".
with System;

package Matreshka.Internals.Markable_Address_Utilities is

   pragma Pure;

   function Is_Marked (Value : System.Address) return Boolean;
   pragma Inline (Is_Marked);

   procedure Mark (Value : in out System.Address);
   pragma Inline (Mark);

   procedure Unmark (Value : in out System.Address);
   pragma Inline (Unmark);

   function To_Marked (Value : System.Address) return System.Address;
   pragma Inline (To_Marked);

   function To_Unmarked (Value : System.Address) return System.Address;
   pragma Inline (To_Unmarked);

end Matreshka.Internals.Markable_Address_Utilities;
