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
-- Copyright © 2011-2014, Vadim Godunko <vgodunko@gmail.com>                --
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
with Ada.Characters.Latin_1;
with Ada.Strings.Fixed;
with Ada.Text_IO;

with Configure.Internals;

package body Configure.Abstract_Tests is

   use Ada.Text_IO;
   use Configure.Internals;

   ------------------
   -- Report_Check --
   ------------------

   procedure Report_Check (Self : in out Abstract_Test'Class; Message : String) is
      Name : constant String  := Self.Name;
      Last : constant Natural := Integer'Min (Name'Length, 10);
      Msg  : String           := "[          ] " & Message & "...";

   begin
      Msg (2 .. Last + 1) := Name (1 .. Last);
      Self.Test_Log_Prefix :=
        To_Unbounded_String (Msg (Msg'First .. Msg'Last - 3));
      Put (Standard_Error, Msg);
      Flush (Standard_Error);
      Put_Line (Log_Output, Msg);
      Flush (Log_Output);
   end Report_Check;

   ----------------
   -- Report_Log --
   ----------------

   procedure Report_Log (Self : Abstract_Test'Class; Message : String) is
   begin
      Put_Line (Log_Output, Message);
      Flush (Log_Output);
   end Report_Log;

   -------------------
   -- Report_Status --
   -------------------

   procedure Report_Status (Self : Abstract_Test'Class; Message : String) is
      use Ada.Characters.Latin_1;
      use Ada.Strings.Fixed;

      Msg : constant String := ": " & Message;

   begin
      Put_Line (Standard_Error, (3 * BS) & Msg);
      Flush (Standard_Error);
      Put_Line (Log_Output, To_String (Self.Test_Log_Prefix) & Msg);
      Flush (Log_Output);
   end Report_Status;

end Configure.Abstract_Tests;
