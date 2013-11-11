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

package body Generator.Units.Ada_Units is

   ----------------------
   -- Add_Private_With --
   ----------------------

   procedure Add_Private_With
    (Self : in out Ada_Unit'Class;
     Name : League.Strings.Universal_String) is
   begin
      Self.Contexts.Include (Name);
   end Add_Private_With;

   --------------
   -- Add_With --
   --------------

   procedure Add_With
    (Self : in out Ada_Unit'Class;
     Name : League.Strings.Universal_String) is
   begin
      Self.Contexts.Include (Name);
   end Add_With;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
    (Self    : in out Ada_Unit'Class;
     Name    : League.Strings.Universal_String;
     Is_Body : Boolean) is
   begin
      Self.Name     := Name;
      Self.Is_Body  := Is_Body;
      Self.Is_Saved := False;

      for J in Self.Sections'Range loop
         Self.Sections (J).Clear;
      end loop;
   end Initialize;

   ----------
   -- Save --
   ----------

   overriding procedure Save (Self : in out Ada_Unit) is
   begin
      --  Output context clauses.

      for Unit of Self.Contexts loop
         Ada.Wide_Wide_Text_IO.Put_Line
          (Ada.Wide_Wide_Text_IO.Standard_Output,
           "with " & Unit.To_Wide_Wide_String & ';');
      end loop;

      Self.Internal_Save (Ada.Wide_Wide_Text_IO.Standard_Output);
      Self.Is_Saved := True;
   end Save;

end Generator.Units.Ada_Units;
