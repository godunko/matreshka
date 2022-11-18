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
-- Copyright © 2009-2011, Vadim Godunko <vgodunko@gmail.com>                --
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
with Ada.Unchecked_Deallocation;

with Matreshka.Internals.Locales.Defaults;

package body Matreshka.Internals.Locales is

   Application_Locale : Locale_Data_Access := null;
   Thread_Locale      : Locale_Data_Access := null;
   pragma Thread_Local_Storage (Thread_Locale);

   -----------------
   -- Dereference --
   -----------------

   procedure Dereference (Self : in out Locale_Data_Access) is

      procedure Free is
        new Ada.Unchecked_Deallocation (Locale_Data, Locale_Data_Access);

   begin
      if Matreshka.Atomics.Counters.Decrement (Self.Counter) then
         pragma Assert (Self /= Defaults.Default_Locale'Access);

         Free (Self);
      end if;
   end Dereference;

   --------------
   -- Get_Core --
   --------------

   function Get_Core
    (Self : not null access Locale_Data'Class;
     Code : Unicode.Code_Point)
       return Unicode.Ucd.Core_Values
   is

      function Element is
        new Matreshka.Internals.Unicode.Ucd.Generic_Element
             (Matreshka.Internals.Unicode.Ucd.Core_Values,
              Matreshka.Internals.Unicode.Ucd.Core_Second_Stage,
              Matreshka.Internals.Unicode.Ucd.Core_Second_Stage_Access,
              Matreshka.Internals.Unicode.Ucd.Core_First_Stage);

   begin
      return Element (Self.Core.all, Code);
   end Get_Core;

   ----------------
   -- Get_Locale --
   ----------------

   function Get_Locale return not null Locale_Data_Access is
   begin
      if Thread_Locale /= null then
         Reference (Thread_Locale);

         return Thread_Locale;

      elsif Application_Locale /= null then
         Reference (Application_Locale);

         return Application_Locale;

      else
         Reference
          (Matreshka.Internals.Locales.Defaults.Default_Locale'Access);

         return Matreshka.Internals.Locales.Defaults.Default_Locale'Access;
      end if;
   end Get_Locale;

   ---------------
   -- Reference --
   ---------------

   procedure Reference (Self : Locale_Data_Access) is
   begin
      Matreshka.Atomics.Counters.Increment (Self.Counter);
   end Reference;

   -----------------------
   -- Set_Thread_Locale --
   -----------------------

   procedure Set_Thread_Locale (Self : Locale_Data_Access) is
   begin
      if Thread_Locale /= null then
         Dereference (Thread_Locale);
      end if;

      Thread_Locale := Self;

      if Thread_Locale /= null then
         Reference (Thread_Locale);
      end if;
   end Set_Thread_Locale;

end Matreshka.Internals.Locales;
