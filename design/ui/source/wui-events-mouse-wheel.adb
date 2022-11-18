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

package body WUI.Events.Mouse.Wheel is

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
       (Self  : in out Mouse_Wheel_Event'Class;
        Event : not null access WebAPI.UI_Events.Wheel.Wheel_Event'Class) is
      begin
         WUI.Events.Mouse.Constructors.Initialize (Self, Event);
      end Initialize;

   end Constructors;

   -------------
   -- Delta_X --
   -------------

   function Delta_X (Self : Mouse_Wheel_Event'Class) return Long_Float is
   begin
      return
        Long_Float
          (WebAPI.UI_Events.Wheel.Wheel_Event'Class
            (Self.Event.all).Get_Delta_X);
   end Delta_X;

   -------------
   -- Delta_Y --
   -------------

   function Delta_Y (Self : Mouse_Wheel_Event'Class) return Long_Float is
   begin
      return
        Long_Float
          (WebAPI.UI_Events.Wheel.Wheel_Event'Class
            (Self.Event.all).Get_Delta_Y);
   end Delta_Y;

   -------------
   -- Delta_Z --
   -------------

   function Delta_Z (Self : Mouse_Wheel_Event'Class) return Long_Float is
   begin
      return
        Long_Float
          (WebAPI.UI_Events.Wheel.Wheel_Event'Class
            (Self.Event.all).Get_Delta_Z);
   end Delta_Z;

end WUI.Events.Mouse.Wheel;
