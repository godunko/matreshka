------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                              Web Framework                               --
--                                                                          --
--                              Tools Component                             --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2013, Vadim Godunko <vgodunko@gmail.com>                     --
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
private with Ada.Finalization;
private with Ada.Wide_Wide_Text_IO;

private with League.String_Vectors;
with League.Strings;

package Generator.Units is

   type Abstract_Unit is abstract tagged limited private;

   not overriding procedure Save (Self : in out Abstract_Unit) is abstract;

   procedure Set_Section
    (Self    : in out Abstract_Unit'Class;
     Section : Positive);

   procedure New_Line (Self : in out Abstract_Unit'Class);

   procedure Put_Line
    (Self : in out Abstract_Unit'Class;
     Item : League.Strings.Universal_String);

   procedure Put
    (Self : in out Abstract_Unit'Class;
     Item : League.Strings.Universal_String);

private

   type Section is record
      Lines    : League.String_Vectors.Universal_String_Vector;
      Complete : Boolean := True;
      --  True means that last line was completed and new element must be added
      --  to Lines next time.
   end record;

   type Section_Array is array (Positive range 1 .. 10) of Section;

   type Abstract_Unit is
     abstract limited new Ada.Finalization.Limited_Controlled with record
      Is_Saved : Boolean  := True;
      Current  : Positive := 1;
      Sections : Section_Array;
   end record;

   overriding procedure Finalize (Self : in out Abstract_Unit);

   procedure Internal_Save
    (Self : in out Abstract_Unit'Class;
     File : Ada.Wide_Wide_Text_IO.File_Type);
   --  Internal procedure to save unit's text into the text file.

end Generator.Units;
