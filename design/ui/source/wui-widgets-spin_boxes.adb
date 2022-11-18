------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2016-2017, Vadim Godunko <vgodunko@gmail.com>                --
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
with WebAPI.DOM.Event_Targets;

package body WUI.Widgets.Spin_Boxes is

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
       (Self    : in out Abstract_Spin_Box'Class;
        Element :
          not null WebAPI.HTML.Input_Elements.HTML_Input_Element_Access) is
      begin
         WUI.Widgets.Constructors.Initialize
          (Self, WebAPI.HTML.Elements.HTML_Element_Access (Element));
      end Initialize;

   end Constructors;

   -----------------------------
   -- Editing_Finished_Signal --
   -----------------------------

   not overriding function Editing_Finished_Signal
    (Self : in out Abstract_Spin_Box)
       return not null access Core.Slots_0.Signal'Class
   is
   begin
      return Self.Editing_Finished'Unchecked_Access;
   end Editing_Finished_Signal;

   ------------------
   -- Set_Disabled --
   ------------------

   not overriding procedure Set_Disabled
    (Self     : in out Abstract_Spin_Box;
     Disabled : Boolean) is
   begin
      WebAPI.HTML.Input_Elements.HTML_Input_Element_Access
       (Self.Element).Set_Disabled (Disabled);
   end Set_Disabled;

   -----------------
   -- Set_Enabled --
   -----------------

   not overriding procedure Set_Enabled
    (Self    : in out Abstract_Spin_Box;
     Enabled : Boolean) is
   begin
      Self.Set_Disabled (not Enabled);
   end Set_Enabled;

end WUI.Widgets.Spin_Boxes;
