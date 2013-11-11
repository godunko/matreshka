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

package body Generator.Units is

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out Abstract_Unit) is
   begin
      --  If unit is not saved it means misuse or fatal error. Current content
      --  or the unit is output to standard error for convenience.

      if not Self.Is_Saved then
         Ada.Wide_Wide_Text_IO.Put_Line
          (Ada.Wide_Wide_Text_IO.Standard_Error,
           "generated code was not been saved, dupming...");
         Ada.Wide_Wide_Text_IO.Put_Line
          (Ada.Wide_Wide_Text_IO.Standard_Error,
           "-----------------------------------------------------------------"
             & "-------------");
         Self.Internal_Save (Ada.Wide_Wide_Text_IO.Standard_Error);
         Ada.Wide_Wide_Text_IO.Put_Line
          (Ada.Wide_Wide_Text_IO.Standard_Error,
           "-----------------------------------------------------------------"
             & "-------------");
      end if;
   end Finalize;

   -------------------
   -- Internal_Save --
   -------------------

   procedure Internal_Save
    (Self : in out Abstract_Unit'Class;
     File : Ada.Wide_Wide_Text_IO.File_Type) is
   begin
      --  Output code.

      for J in Self.Sections'Range loop
         if not Self.Sections (J).Is_Empty then
            for K in 1 .. Self.Sections (J).Length loop
               Ada.Wide_Wide_Text_IO.Put_Line
                (File, Self.Sections (J).Element (K).To_Wide_Wide_String);
            end loop;
         end if;
      end loop;
   end Internal_Save;

   --------------
   -- New_Line --
   --------------

   procedure New_Line (Self : in out Abstract_Unit'Class) is
   begin
      Self.Is_Saved := False;

      if Self.Sections (Self.Current).Is_Empty then
         Self.Sections (Self.Current).Append
          (League.Strings.Empty_Universal_String);
      end if;

      Self.Sections (Self.Current).Append
       (League.Strings.Empty_Universal_String);
   end New_Line;

   --------------
   -- Put_Line --
   --------------

   procedure Put_Line
    (Self : in out Abstract_Unit'Class;
     Item : League.Strings.Universal_String)
   is
      use type League.Strings.Universal_String;

   begin
      Self.Is_Saved := False;

      if Self.Sections (Self.Current).Is_Empty then
         Self.Sections (Self.Current).Append (Item);

      else
         Self.Sections (Self.Current).Replace
          (Self.Sections (Self.Current).Length,
           Self.Sections (Self.Current).Element
            (Self.Sections (Self.Current).Length)
             & Item);
      end if;

      Self.Sections (Self.Current).Append
       (League.Strings.Empty_Universal_String);
   end Put_Line;

   -----------------
   -- Set_Section --
   -----------------

   procedure Set_Section
    (Self    : in out Abstract_Unit'Class;
     Section : Positive) is
   begin
      Self.Current := Section;
   end Set_Section;

end Generator.Units;
