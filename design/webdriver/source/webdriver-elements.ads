------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
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

with League.Strings;
with League.String_Vectors;

package WebDriver.Elements is

   type Element is limited interface;

   type Element_Access is access all Element'Class
     with Storage_Size => 0;

   not overriding function Is_Selected
     (Self : access Element) return Boolean is abstract;
   --  Determines if the referenced element is selected or not.

   not overriding function Is_Enabled
     (Self : access Element) return Boolean is abstract;
   --  Determines if the referenced element is enabled or not.

   not overriding function Get_Attribute
     (Self : access Element;
      Name : League.Strings.Universal_String)
        return League.Strings.Universal_String is abstract;
   --  Returns the attribute of a web element.

   not overriding function Get_Property
     (Self : access Element;
      Name : League.Strings.Universal_String)
        return League.Strings.Universal_String is abstract;
   --  Returns the result of getting a property of an element.

   not overriding function Get_CSS_Value
     (Self : access Element;
      Name : League.Strings.Universal_String)
        return League.Strings.Universal_String is abstract;
   --  Retrieves the computed value of the given CSS property of the given
   --  web element.

   not overriding function Get_Text
     (Self : access Element)
        return League.Strings.Universal_String is abstract;
   --  Returns an element’s text "as rendered".

   not overriding function Get_Tag_Name
     (Self : access Element)
        return League.Strings.Universal_String is abstract;
   --  Returns the qualified element name of the given web element.

   not overriding procedure Click (Self : access Element) is abstract;
   --  Scrolls into view the element if it is not already pointer-interactable,
   --  and clicks its in-view center point.

   not overriding procedure Clear (Self : access Element) is abstract;
   --  Scrolls into view an editable or resettable element and then attempts
   --  to clear its selected files or text content.

   not overriding procedure Send_Keys
     (Self : access Element;
      Text : League.String_Vectors.Universal_String_Vector) is abstract;
   --  Scrolls into view the form control element and then sends the provided
   --  keys to the element.

   procedure Send_Keys
     (Self : access Element'Class;
      Text : League.Strings.Universal_String);

end WebDriver.Elements;
