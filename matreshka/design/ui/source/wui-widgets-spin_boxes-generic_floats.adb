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
with WebAPI.HTML.Globals;

package body WUI.Widgets.Spin_Boxes.Generic_Floats is

   procedure Internal_Set_Value
    (Self   : in out Float_Spin_Box'Class;
     To     : Data_Type;
     Update : Boolean);
   --  Sets value, emit signal when value was modified, and update value of
   --  input element when Update is True.

   ------------------
   -- Change_Event --
   ------------------

   overriding procedure Change_Event (Self : in out Float_Spin_Box) is
      Input : constant WebAPI.HTML.Input_Elements.HTML_Input_Element_Access
        := WebAPI.HTML.Input_Elements.HTML_Input_Element_Access
            (Self.Element);

   begin
      if not Input.Get_Validity.Get_Valid then
         if Input.Get_Validity.Get_Bad_Input then
            Self.Internal_Set_Value
             (Data_Type'Wide_Wide_Value
               (League.Strings.To_Wide_Wide_String (Input.Get_Min)), True);

         elsif Input.Get_Validity.Get_Range_Overflow then
            Self.Internal_Set_Value
             (Data_Type'Wide_Wide_Value
               (League.Strings.To_Wide_Wide_String (Input.Get_Max)), True);

         elsif Input.Get_Validity.Get_Range_Underflow then
            Self.Internal_Set_Value
             (Data_Type'Wide_Wide_Value
               (League.Strings.To_Wide_Wide_String (Input.Get_Min)), True);

         elsif Input.Get_Validity.Get_Value_Missing then
            Self.Internal_Set_Value
             (Data_Type'Wide_Wide_Value
               (League.Strings.To_Wide_Wide_String (Input.Get_Min)), True);
         end if;
      end if;

      Self.Editing_Finished.Emit;
   end Change_Event;

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      type Float_Spin_Box_Internal_Access is access all Float_Spin_Box'Class;

      ------------
      -- Create --
      ------------

      function Create
       (Element :
          not null WebAPI.HTML.Input_Elements.HTML_Input_Element_Access)
            return not null Float_Spin_Box_Access
      is
         Result : constant not null Float_Spin_Box_Internal_Access
           := new Float_Spin_Box;

      begin
         Initialize (Result.all, Element);

         return Float_Spin_Box_Access (Result);
      end Create;

      ------------
      -- Create --
      ------------

      function Create
       (Id : League.Strings.Universal_String)
          return not null Float_Spin_Box_Access is
      begin
         return
           Create
            (WebAPI.HTML.Input_Elements.HTML_Input_Element_Access
              (WebAPI.HTML.Globals.Window.Get_Document.Get_Element_By_Id
                (Id)));
      end Create;

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize
       (Self    : in out Float_Spin_Box'Class;
        Element :
          not null WebAPI.HTML.Input_Elements.HTML_Input_Element_Access) is
      begin
         WUI.Widgets.Spin_Boxes.Constructors.Initialize (Self, Element);

         --  Extract properties value from HTML element.

         Self.Last_Value :=
           Data_Type'Wide_Wide_Value
            (League.Strings.To_Wide_Wide_String (Element.Get_Value));
      end Initialize;

   end Constructors;

   -----------------
   -- Input_Event --
   -----------------

   overriding procedure Input_Event (Self  : in out Float_Spin_Box) is
      Input : constant WebAPI.HTML.Input_Elements.HTML_Input_Element_Access
        := WebAPI.HTML.Input_Elements.HTML_Input_Element_Access
            (Self.Element);

   begin
      if Input.Get_Validity.Get_Valid then
         Self.Last_Value := 
           Data_Type'Wide_Wide_Value
            (League.Strings.To_Wide_Wide_String
              (WebAPI.HTML.Input_Elements.HTML_Input_Element_Access
                (Self.Element).Get_Value));
         Self.Value_Changed.Emit (Self.Last_Value);
      end if;
   end Input_Event;

   ------------------------
   -- Internal_Set_Value --
   ------------------------

   procedure Internal_Set_Value
    (Self   : in out Float_Spin_Box'Class;
     To     : Data_Type;
     Update : Boolean)
   is
      Input : constant WebAPI.HTML.Input_Elements.HTML_Input_Element_Access
        := WebAPI.HTML.Input_Elements.HTML_Input_Element_Access
            (Self.Element);

   begin
      if Self.Last_Value /= To then
         Self.Last_Value := To;
         Input.Set_Value
          (League.Strings.To_Universal_String
            (Data_Type'Wide_Wide_Image (To)));
         Self.Value_Changed.Emit (To);
         --  'input' event is not send when value is changed programmatically.

      elsif Update then
         Input.Set_Value
          (League.Strings.To_Universal_String
            (Data_Type'Wide_Wide_Image (To)));
      end if;
   end Internal_Set_Value;

   ---------------
   -- Set_Value --
   ---------------

   not overriding procedure Set_Value
    (Self : in out Float_Spin_Box;
     To   : Data_Type) is
   begin
      Self.Internal_Set_Value (To, False);
   end Set_Value;

   ---------------
   -- Step_Down --
   ---------------

   overriding procedure Step_Down (Self : in out Float_Spin_Box) is
   begin
      raise Program_Error;
   end Step_Down;

   -------------
   -- Step_Up --
   -------------

   overriding procedure Step_Up (Self : in out Float_Spin_Box) is
   begin
      raise Program_Error;
   end Step_Up;

   -----------
   -- Value --
   -----------

   not overriding function Value (Self : Float_Spin_Box) return Data_Type is
   begin
      return Self.Last_Value;
   end Value;

   --------------------------
   -- Value_Changed_Signal --
   --------------------------

   not overriding function Value_Changed_Signal
    (Self : in out Float_Spin_Box)
       return not null access Float_Slots.Signal'Class is
   begin
      return Self.Value_Changed'Unchecked_Access;
   end Value_Changed_Signal;

end WUI.Widgets.Spin_Boxes.Generic_Floats;
