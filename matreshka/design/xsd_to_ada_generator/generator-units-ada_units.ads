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

private with Ada.Containers.Ordered_Sets;

package Generator.Units.Ada_Units is

   type Ada_Unit is new Generator.Units.Abstract_Unit with private;

   Unit_Header_Section          : constant Positive := 1;
   Unit_Context_Clauses_Section : constant Positive := 2;
   Unit_Declaration_Section     : constant Positive := 3;

   procedure Initialize
    (Self    : in out Ada_Unit'Class;
     Name    : League.Strings.Universal_String;
     Is_Body : Boolean);
   --  Initializes unit, assign its name and kind (specification or body).

   procedure Add_With
    (Self : in out Ada_Unit'Class;
     Name : League.Strings.Universal_String);
   --  Add 'with' context clause to the unit.

   procedure Add_Private_With
    (Self : in out Ada_Unit'Class;
     Name : League.Strings.Universal_String);
   --  Add 'private with' context clause to the unit.

private

   package String_Sets is
     new Ada.Containers.Ordered_Sets
          (League.Strings.Universal_String,
           League.Strings."<",
           League.Strings."=");

   type Ada_Unit is new Generator.Units.Abstract_Unit with record
      Contexts : String_Sets.Set;
      Name     : League.Strings.Universal_String;
      Is_Body  : Boolean  := False;
   end record;

   overriding procedure Save (Self : in out Ada_Unit);

   overriding procedure Finalize (Self : in out Ada_Unit);

end Generator.Units.Ada_Units;
