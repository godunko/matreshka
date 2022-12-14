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
with Matreshka.Internals.Calendars.Gregorian;

package body Matreshka.Internals.Calendars.Formatting.ISO_8601 is

   procedure Append
    (Result  : in out League.Strings.Universal_String;
     Value   : Natural;
     Padding : Positive);

   ------------
   -- Append --
   ------------

   procedure Append
    (Result  : in out League.Strings.Universal_String;
     Value   : Natural;
     Padding : Positive)
   is
      Image : constant Wide_Wide_String := Integer'Wide_Wide_Image (Value);

   begin
      for J in 1 .. Padding - Image'Length + 1 loop
         Result.Append ('0');
      end loop;

      Result.Append (Image (Image'First + 1 .. Image'Last));
   end Append;

   ----------------------------
   -- Append_Abbreviated_Era --
   ----------------------------

   overriding procedure Append_Abbreviated_Era
    (Self    : ISO_8601_Printer;
     Output  : in out League.Strings.Universal_String;
     Date    : Julian_Day_Number;
     Padding : Era_Padding) is
   begin
      --  XXX Not yet implemented.

      null;
   end Append_Abbreviated_Era;

   ------------------------------
   -- Append_Abbreviated_Month --
   ------------------------------

   overriding procedure Append_Abbreviated_Month
    (Self           : ISO_8601_Printer;
     Output         : in out League.Strings.Universal_String;
     Date           : Julian_Day_Number;
     Is_Stand_Alone : Boolean)
   is
      pragma Unreferenced (Self, Is_Stand_Alone);

      Index : constant Gregorian.Month_Number
        := Calendars.Gregorian.Month (Date);
      Names : constant array (Gregorian.Month_Number) of
        Wide_Wide_String (1 .. 3)
          := ("Jan", "Feb", "Mar", "Apr", "May", "Jun",
              "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
   begin
      --  XXX Is_Stand_Alone Not yet implemented.

      Output.Append (Names (Index));
   end Append_Abbreviated_Month;

   --------------------------------
   -- Append_Abbreviated_Quarter --
   --------------------------------

   overriding procedure Append_Abbreviated_Quarter
    (Self           : ISO_8601_Printer;
     Output         : in out League.Strings.Universal_String;
     Date           : Julian_Day_Number;
     Is_Stand_Alone : Boolean) is
   begin
      --  XXX Not yet implemented.

      null;
   end Append_Abbreviated_Quarter;

   -------------------------------
   -- Append_Chinese_Leap_Month --
   -------------------------------

   overriding procedure Append_Chinese_Leap_Month
    (Self   : ISO_8601_Printer;
     Output : in out League.Strings.Universal_String;
     Date   : Julian_Day_Number) is
   begin
      --  XXX Not yet implemented.

      null;
   end Append_Chinese_Leap_Month;

   -------------------------
   -- Append_Day_Of_Month --
   -------------------------

   overriding procedure Append_Day_Of_Month
    (Self    : ISO_8601_Printer;
     Output  : in out League.Strings.Universal_String;
     Date    : Julian_Day_Number;
     Padding : Positive) is
   begin
      Append
       (Output,
        Matreshka.Internals.Calendars.Gregorian.Day (Date),
        Padding);
   end Append_Day_Of_Month;

   ---------------------------------
   -- Append_Day_Of_Week_In_Month --
   ---------------------------------

   overriding procedure Append_Day_Of_Week_In_Month
    (Self   : ISO_8601_Printer;
     Output : in out League.Strings.Universal_String;
     Date   : Julian_Day_Number) is
   begin
      --  XXX Not yet implemented.

      null;
   end Append_Day_Of_Week_In_Month;

   ------------------------
   -- Append_Day_Of_Year --
   ------------------------

   overriding procedure Append_Day_Of_Year
    (Self    : ISO_8601_Printer;
     Output  : in out League.Strings.Universal_String;
     Date    : Julian_Day_Number;
     Padding : Positive) is
   begin
      --  XXX Not yet implemented.

      null;
   end Append_Day_Of_Year;

   --------------------------
   -- Append_Extended_Year --
   --------------------------

   overriding procedure Append_Extended_Year
    (Self    : ISO_8601_Printer;
     Output  : in out League.Strings.Universal_String;
     Date    : Julian_Day_Number;
     Padding : Positive) is
   begin
      --  XXX Not yet implemented.

      null;
   end Append_Extended_Year;

   -----------------------------
   -- Append_Full_Day_Of_Week --
   -----------------------------

   overriding procedure Append_Full_Day_Of_Week
    (Self           : ISO_8601_Printer;
     Output         : in out League.Strings.Universal_String;
     Date           : Julian_Day_Number;
     Is_Stand_Alone : Boolean) is
   begin
      --  XXX Not yet implemented.

      null;
   end Append_Full_Day_Of_Week;

   -----------------------
   -- Append_Full_Month --
   -----------------------

   overriding procedure Append_Full_Month
    (Self           : ISO_8601_Printer;
     Output         : in out League.Strings.Universal_String;
     Date           : Julian_Day_Number;
     Is_Stand_Alone : Boolean) is
   begin
      --  XXX Not yet implemented.

      null;
   end Append_Full_Month;

   -------------------------
   -- Append_Full_Quarter --
   -------------------------

   overriding procedure Append_Full_Quarter
    (Self           : ISO_8601_Printer;
     Output         : in out League.Strings.Universal_String;
     Date           : Julian_Day_Number;
     Is_Stand_Alone : Boolean) is
   begin
      --  XXX Not yet implemented.

      null;
   end Append_Full_Quarter;

   -----------------------
   -- Append_Julian_Day --
   -----------------------

   overriding procedure Append_Julian_Day
    (Self    : ISO_8601_Printer;
     Output  : in out League.Strings.Universal_String;
     Date    : Julian_Day_Number;
     Padding : Positive) is
   begin
      --  XXX Not yet implemented.

      null;
   end Append_Julian_Day;

   ---------------------
   -- Append_Long_Era --
   ---------------------

   overriding procedure Append_Long_Era
    (Self    : ISO_8601_Printer;
     Output  : in out League.Strings.Universal_String;
     Date    : Julian_Day_Number) is
   begin
      --  XXX Not yet implemented.

      null;
   end Append_Long_Era;

   -------------------------------
   -- Append_Narrow_Day_Of_Week --
   -------------------------------

   overriding procedure Append_Narrow_Day_Of_Week
    (Self           : ISO_8601_Printer;
     Output         : in out League.Strings.Universal_String;
     Date           : Julian_Day_Number;
     Is_Stand_Alone : Boolean) is
   begin
      --  XXX Not yet implemented.

      null;
   end Append_Narrow_Day_Of_Week;

   -----------------------
   -- Append_Narrow_Era --
   -----------------------

   overriding procedure Append_Narrow_Era
    (Self    : ISO_8601_Printer;
     Output  : in out League.Strings.Universal_String;
     Date    : Julian_Day_Number) is
   begin
      --  XXX Not yet implemented.

      null;
   end Append_Narrow_Era;

   -------------------------
   -- Append_Narrow_Month --
   -------------------------

   overriding procedure Append_Narrow_Month
    (Self           : ISO_8601_Printer;
     Output         : in out League.Strings.Universal_String;
     Date           : Julian_Day_Number;
     Is_Stand_Alone : Boolean) is
   begin
      --  XXX Not yet implemented.

      null;
   end Append_Narrow_Month;

   ----------------------------------
   -- Append_Numerical_Day_Of_Week --
   ----------------------------------

   overriding procedure Append_Numerical_Day_Of_Week
    (Self           : ISO_8601_Printer;
     Output         : in out League.Strings.Universal_String;
     Date           : Julian_Day_Number;
     Padding        : Positive;
     Is_Stand_Alone : Boolean) is
   begin
      --  XXX Not yet implemented.

      null;
   end Append_Numerical_Day_Of_Week;

   ----------------------------
   -- Append_Numerical_Month --
   ----------------------------

   overriding procedure Append_Numerical_Month
    (Self           : ISO_8601_Printer;
     Output         : in out League.Strings.Universal_String;
     Date           : Julian_Day_Number;
     Padding        : Positive;
     Is_Stand_Alone : Boolean) is
   begin
      Append
       (Output,
        Matreshka.Internals.Calendars.Gregorian.Month (Date),
        Padding);
   end Append_Numerical_Month;

   ------------------------------
   -- Append_Numerical_Quarter --
   ------------------------------

   overriding procedure Append_Numerical_Quarter
    (Self           : ISO_8601_Printer;
     Output         : in out League.Strings.Universal_String;
     Date           : Julian_Day_Number;
     Padding        : Positive;
     Is_Stand_Alone : Boolean) is
   begin
      --  XXX Not yet implemented.

      null;
   end Append_Numerical_Quarter;

   ------------------------------
   -- Append_Short_Day_Of_Week --
   ------------------------------

   overriding procedure Append_Short_Day_Of_Week
    (Self           : ISO_8601_Printer;
     Output         : in out League.Strings.Universal_String;
     Date           : Julian_Day_Number;
     Padding        : Positive;
     Is_Stand_Alone : Boolean)
   is
      pragma Unreferenced (Self, Padding, Is_Stand_Alone);

      Index : constant Gregorian.Day_Of_Week_Number
        := Calendars.Gregorian.Day_Of_Week (Date);
      Names : constant array (Gregorian.Day_Of_Week_Number) of
        Wide_Wide_String (1 .. 3)
          := ("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun");
   begin
      --  XXX Is_Stand_Alone Not yet implemented.

      Output.Append (Names (Index));
   end Append_Short_Day_Of_Week;

   --------------------------
   -- Append_Week_Of_Month --
   --------------------------

   overriding procedure Append_Week_Of_Month
    (Self   : ISO_8601_Printer;
     Output : in out League.Strings.Universal_String;
     Date   : Julian_Day_Number) is
   begin
      --  XXX Not yet implemented.

      null;
   end Append_Week_Of_Month;

   -------------------------
   -- Append_Week_Of_Year --
   -------------------------

   overriding procedure Append_Week_Of_Year
    (Self    : ISO_8601_Printer;
     Output  : in out League.Strings.Universal_String;
     Date    : Julian_Day_Number;
     Padding : Positive) is
   begin
      --  XXX Not yet implemented.

      null;
   end Append_Week_Of_Year;

   -----------------
   -- Append_Year --
   -----------------

   overriding procedure Append_Year
    (Self    : ISO_8601_Printer;
     Output  : in out League.Strings.Universal_String;
     Date    : Julian_Day_Number;
     Padding : Positive) is
   begin
      Append
       (Output,
        Matreshka.Internals.Calendars.Gregorian.Year (Date),
        Padding);
   end Append_Year;

   ----------------------
   -- Append_Year_Week --
   ----------------------

   overriding procedure Append_Year_Week
    (Self    : ISO_8601_Printer;
     Output  : in out League.Strings.Universal_String;
     Date    : Julian_Day_Number;
     Padding : Positive) is
   begin
      --  XXX Not yet implemented.

      null;
   end Append_Year_Week;

end Matreshka.Internals.Calendars.Formatting.ISO_8601;
