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
-- Copyright © 2011-2015, Vadim Godunko <vgodunko@gmail.com>                --
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
--  This package provides binding to subset of Windows API.
------------------------------------------------------------------------------
with Interfaces.C.Strings;
with Interfaces.C.Pointers;
with System;

with Matreshka.Internals.Strings.C;
with Matreshka.Internals.Utf16;

package Matreshka.Internals.Windows is

   pragma Preelaborate;

   subtype DWORD is interfaces.C.unsigned_long;
   subtype LONG is Interfaces.C.long;

   subtype LPCSTR is Interfaces.C.Strings.chars_ptr;

   subtype LPWSTR is Matreshka.Internals.Strings.C.Utf16_Code_Unit_Access;

   subtype LPWCH is LPWSTR;

   type LPCWSTR is access constant Matreshka.Internals.Utf16.Utf16_Code_Unit;
   pragma Convention (C, LPCWSTR);

   function wcslen (str : LPWSTR) return Interfaces.C.size_t;
   pragma Import (C, wcslen);

   type HMODULE is new System.Address;

   -----------------------------------------------------------
   --  Used in command line/environment conversion package  --
   -----------------------------------------------------------

   package WCHAR_Pointers is
     new Interfaces.C.Pointers
          (Matreshka.Internals.Utf16.Utf16_String_Index,
           Matreshka.Internals.Utf16.Utf16_Code_Unit,
           Matreshka.Internals.Utf16.Unaligned_Utf16_String,
           0);

end Matreshka.Internals.Windows;
