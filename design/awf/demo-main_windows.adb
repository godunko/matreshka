------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
--                            Examples Component                            --
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
--  $Revision$ $Date$
------------------------------------------------------------------------------
with League.Signals;
with League.Strings;

with AWF.Layouts;

package body Demo.Main_Windows is

   ------------
   -- Create --
   ------------

   function Create return not null Main_Window_Access is
      L : AWF.Layouts.AWF_Layout_Access;

      package Slot is new League.Signals.Generic_Slot (Main_Window, On_Click);

   begin
      return Self : not null Main_Window_Access := new Main_Window do
         AWF.Internals.AWF_Widgets.Constructors.Initialize (Self);

         L := AWF.Layouts.Create;
         Self.Set_Layout (L);
         Self.Button := AWF.Push_Buttons.Create (Self);
         Self.Button.Set_Text
          (League.Strings.To_Universal_String ("Click me!"));
         Slot.Connect (Self.Button.Clicked, Self);
      end return;
   end Create;

   --------------
   -- On_Click --
   --------------

   not overriding procedure On_Click (Self : not null access Main_Window) is
   begin
      Self.Counter := Self.Counter + 1;
      Self.Button.Set_Text
       (League.Strings.To_Universal_String
         ("Was clicked"
            & Integer'Wide_Wide_Image (Self.Counter)
            & " times. Click again!"));
   end On_Click;

end Demo.Main_Windows;
