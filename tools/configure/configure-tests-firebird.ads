------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--         Localization, Internationalization, Globalization for Ada        --
--                                                                          --
--                              Tools Component                             --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2012, Vadim Godunko <vgodunko@gmail.com>                     --
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
--  $Revision: 2359 $ $Date: 2011-12-27 10:20:56 +0200 (Вт, 27 дек 2011) $
------------------------------------------------------------------------------
--  This test detects parameters to link with PostgreSQL client library.
--
--  It sets following substitutions variables:
--   - HAS_FIREBIRD
--   - FIREBIRD_LIBRARY_OPTIONS
------------------------------------------------------------------------------
with Configure.Abstract_Tests;
private with Configure.Component_Switches;

package Configure.Tests.Firebird is

   type Firebird_Test is
     new Configure.Abstract_Tests.Abstract_Test with private;

   overriding function Name (Self : Firebird_Test) return String;
   --  Returns name of the test to be used in reports.

   overriding function Help
    (Self : Firebird_Test) return Unbounded_String_Vector;
   --  Returns help information for test.

   overriding procedure Execute
    (Self      : in out Firebird_Test;
     Arguments : in out Unbounded_String_Vector);
   --  Executes test's actions. All used arguments must be removed from
   --  Arguments.

private

   type Firebird_Test is
     new Configure.Abstract_Tests.Abstract_Test with record
      Switches : Configure.Component_Switches.Component_Switches
        := Configure.Component_Switches.Create
            (Name           => "firebird",
             Description    => "Firebird support",
             Libdir_Enabled => True);
   end record;

end Configure.Tests.Firebird;
