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
-- Copyright © 2017, Vadim Godunko <vgodunko@gmail.com>                     --
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
with WebAPI.HTML.Globals;

package body WUI.Widgets.Combo_Boxes is

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      type Combo_Box_Internal_Access is access all Combo_Box'Class;

      ------------
      -- Create --
      ------------

      function Create
       (Element :
          not null WebAPI.HTML.Select_Elements.HTML_Select_Element_Access)
            return not null Combo_Box_Access
      is
         Result : constant not null Combo_Box_Internal_Access
           := new Combo_Box;

      begin
         Initialize (Result.all, Element);

         return Combo_Box_Access (Result);
      end Create;

      ------------
      -- Create --
      ------------

      function Create
       (Id : League.Strings.Universal_String)
          return not null Combo_Box_Access is
      begin
         return
           Create
            (WebAPI.HTML.Select_Elements.HTML_Select_Element_Access
              (WebAPI.HTML.Globals.Window.Get_Document.Get_Element_By_Id
                (Id)));
      end Create;

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
       (Self    : in out Combo_Box'Class;
        Element :
          not null WebAPI.HTML.Select_Elements.HTML_Select_Element_Access) is
      begin
         WUI.Widgets.Constructors.Initialize
          (Self,
           WebAPI.HTML.Elements.HTML_Element_Access (Element));
      end Initialize;

   end Constructors;

   -------------------
   -- Current_Index --
   -------------------

   function Current_Index
    (Self : in out Combo_Box'Class)
       return League.Strings.Universal_String
   is
      Input : constant WebAPI.HTML.Select_Elements.HTML_Select_Element_Access
        := WebAPI.HTML.Select_Elements.HTML_Select_Element_Access
            (Self.Element);

   begin
      return Input.Get_Value;
   end Current_Index;

   ----------------------------------
   -- Current_Index_Changed_Signal --
   ----------------------------------

   not overriding function Current_Index_Changed_Signal
    (Self : in out Combo_Box)
       return not null access WUI.String_Slots.Signal'Class is
   begin
      return Self.Current_Index_Changed'Unchecked_Access;
   end Current_Index_Changed_Signal;

   -----------------
   -- Input_Event --
   -----------------

   overriding procedure Input_Event (Self : in out Combo_Box) is
      Input : constant WebAPI.HTML.Select_Elements.HTML_Select_Element_Access
        := WebAPI.HTML.Select_Elements.HTML_Select_Element_Access
            (Self.Element);

   begin
      Self.Current_Index_Changed.Emit (Input.Get_Value);
   end Input_Event;

   -----------------------
   -- Set_Current_Index --
   -----------------------

   not overriding procedure Set_Current_Index
    (Self : in out Combo_Box;
     To   : League.Strings.Universal_String)
   is
      use type League.Strings.Universal_String;

      Input : constant WebAPI.HTML.Select_Elements.HTML_Select_Element_Access
        := WebAPI.HTML.Select_Elements.HTML_Select_Element_Access
            (Self.Element);

   begin
      if Input.Get_Value /= To then
         Input.Set_Value (To);
         Self.Current_Index_Changed.Emit (Input.Get_Value);
         --  'input' event is not send when value is updated programmatically.
      end if;
   end Set_Current_Index;

   ------------------
   -- Set_Disabled --
   ------------------

   not overriding procedure Set_Disabled
    (Self     : in out Combo_Box;
     Disabled : Boolean) is
   begin
      WebAPI.HTML.Select_Elements.HTML_Select_Element_Access
       (Self.Element).Set_Disabled (Disabled);
   end Set_Disabled;

   -----------------
   -- Set_Enabled --
   -----------------

   not overriding procedure Set_Enabled
    (Self    : in out Combo_Box;
     Enabled : Boolean) is
   begin
      Self.Set_Disabled (not Enabled);
   end Set_Enabled;

end WUI.Widgets.Combo_Boxes;
