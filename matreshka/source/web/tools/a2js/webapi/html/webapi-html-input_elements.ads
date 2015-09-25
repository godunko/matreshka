------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
--                            Web API Definition                            --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2014-2015, Vadim Godunko <vgodunko@gmail.com>                --
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

with WebAPI.HTML.Elements;

package WebAPI.HTML.Input_Elements is

   pragma Preelaborate;

   type HTML_Input_Element is limited interface
     and WebAPI.HTML.Elements.HTML_Element;

   type HTML_Input_Element_Access is access all HTML_Input_Element'Class
      with Storage_Size => 0;

--   XXX Not implemented
--
--   interface HTMLInputElement : HTMLElement {
--     readonly attribute HTMLFormElement? form;
--     readonly attribute FileList? files;

   not overriding function Get_Accept
    (Self : not null access constant HTML_Input_Element)
       return League.Strings.Universal_String is abstract
         with Import     => True,
              Convention => JavaScript_Property_Getter,
              Link_Name  => "accept";

   not overriding procedure Set_Accept
    (Self : not null access constant HTML_Input_Element;
     To   : League.Strings.Universal_String) is abstract
       with Import     => True,
            Convention => JavaScript_Property_Setter,
            Link_Name  => "accept";

   not overriding function Get_Alt
    (Self : not null access constant HTML_Input_Element)
       return League.Strings.Universal_String is abstract
         with Import     => True,
              Convention => JavaScript_Property_Getter,
              Link_Name  => "alt";

   not overriding procedure Set_Alt
    (Self : not null access constant HTML_Input_Element;
     To   : League.Strings.Universal_String) is abstract
       with Import     => True,
            Convention => JavaScript_Property_Setter,
            Link_Name  => "alt";

   not overriding function Get_Autocomplete
    (Self : not null access constant HTML_Input_Element)
       return League.Strings.Universal_String is abstract
         with Import     => True,
              Convention => JavaScript_Property_Getter,
              Link_Name  => "autocomplete";

   not overriding procedure Set_Autocomplete
    (Self : not null access constant HTML_Input_Element;
     To   : League.Strings.Universal_String) is abstract
       with Import     => True,
            Convention => JavaScript_Property_Setter,
            Link_Name  => "autocomplete";

   not overriding function Get_Autofocus
    (Self : not null access constant HTML_Input_Element)
       return Boolean is abstract
         with Import     => True,
              Convention => JavaScript_Property_Getter,
              Link_Name  => "autofocus";

   not overriding procedure Set_Autofocus
    (Self : not null access constant HTML_Input_Element;
     To   : Boolean) is abstract
       with Import     => True,
            Convention => JavaScript_Property_Setter,
            Link_Name  => "autofocus";

   not overriding function Get_Default_Checked
    (Self : not null access constant HTML_Input_Element)
       return Boolean is abstract
         with Import     => True,
              Convention => JavaScript_Property_Getter,
              Link_Name  => "defaultChecked";

   not overriding procedure Set_Default_Checked
    (Self : not null access constant HTML_Input_Element;
     To   : Boolean) is abstract
       with Import     => True,
            Convention => JavaScript_Property_Setter,
            Link_Name  => "defaultChecked";

   not overriding function Get_Checked
    (Self : not null access constant HTML_Input_Element)
       return Boolean is abstract
         with Import     => True,
              Convention => JavaScript_Property_Getter,
              Link_Name  => "checked";

   not overriding procedure Set_Checked
    (Self : not null access constant HTML_Input_Element;
     To   : Boolean) is abstract
       with Import     => True,
            Convention => JavaScript_Property_Setter,
            Link_Name  => "checked";

   not overriding function Get_Dir_Name
    (Self : not null access constant HTML_Input_Element)
       return League.Strings.Universal_String is abstract
         with Import     => True,
              Convention => JavaScript_Property_Getter,
              Link_Name  => "dirName";

   not overriding procedure Set_Dir_Name
    (Self : not null access constant HTML_Input_Element;
     To   : League.Strings.Universal_String) is abstract
       with Import     => True,
            Convention => JavaScript_Property_Setter,
            Link_Name  => "dirName";

   not overriding function Get_Disabled
    (Self : not null access constant HTML_Input_Element)
       return Boolean is abstract
         with Import     => True,
              Convention => JavaScript_Property_Getter,
              Link_Name  => "disabled";

   not overriding procedure Set_Disabled
    (Self : not null access constant HTML_Input_Element;
     To   : Boolean) is abstract
       with Import     => True,
            Convention => JavaScript_Property_Setter,
            Link_Name  => "disabled";

   not overriding function Get_Form_Action
    (Self : not null access constant HTML_Input_Element)
       return League.Strings.Universal_String is abstract
         with Import     => True,
              Convention => JavaScript_Property_Getter,
              Link_Name  => "formAction";

   not overriding procedure Set_Form_Action
    (Self : not null access constant HTML_Input_Element;
     To   : League.Strings.Universal_String) is abstract
       with Import     => True,
            Convention => JavaScript_Property_Setter,
            Link_Name  => "formAction";

   not overriding function Get_Form_Enctype
    (Self : not null access constant HTML_Input_Element)
       return League.Strings.Universal_String is abstract
         with Import     => True,
              Convention => JavaScript_Property_Getter,
              Link_Name  => "formEnctype";

   not overriding procedure Set_Form_Enctype
    (Self : not null access constant HTML_Input_Element;
     To   : League.Strings.Universal_String) is abstract
       with Import     => True,
            Convention => JavaScript_Property_Setter,
            Link_Name  => "formEnctype";

   not overriding function Get_Form_Method
    (Self : not null access constant HTML_Input_Element)
       return League.Strings.Universal_String is abstract
         with Import     => True,
              Convention => JavaScript_Property_Getter,
              Link_Name  => "formMethod";

   not overriding procedure Set_Form_Method
    (Self : not null access constant HTML_Input_Element;
     To   : League.Strings.Universal_String) is abstract
       with Import     => True,
            Convention => JavaScript_Property_Setter,
            Link_Name  => "formMethod";

   not overriding function Get_Form_No_Validate
    (Self : not null access constant HTML_Input_Element)
       return Boolean is abstract
         with Import     => True,
              Convention => JavaScript_Property_Getter,
              Link_Name  => "formNoValidate";

   not overriding procedure Set_Form_No_Validate
    (Self : not null access constant HTML_Input_Element;
     To   : Boolean) is abstract
       with Import     => True,
            Convention => JavaScript_Property_Setter,
            Link_Name  => "formNoValidate";

   not overriding function Get_Form_Target
    (Self : not null access constant HTML_Input_Element)
       return League.Strings.Universal_String is abstract
         with Import     => True,
              Convention => JavaScript_Property_Getter,
              Link_Name  => "formTarget";

   not overriding procedure Set_Form_Target
    (Self : not null access constant HTML_Input_Element;
     To   : League.Strings.Universal_String) is abstract
       with Import     => True,
            Convention => JavaScript_Property_Setter,
            Link_Name  => "formTarget";

   --             attribute unsigned long height;
   --             attribute boolean indeterminate;
   --    readonly attribute HTMLElement? list;
   --             attribute DOMString max;
   --             attribute long maxLength;
   --             attribute DOMString min;
   --             attribute long minLength;
   --             attribute boolean multiple;
   --             attribute DOMString name;
   --             attribute DOMString pattern;
   --             attribute DOMString placeholder;

   not overriding function Get_Read_Only
    (Self : not null access constant HTML_Input_Element)
       return Boolean is abstract
         with Import     => True,
              Convention => JavaScript_Property_Getter,
              Link_Name  => "readOnly";

   not overriding procedure Set_Read_Only
    (Self : not null access constant HTML_Input_Element;
     To   : Boolean) is abstract
       with Import     => True,
            Convention => JavaScript_Property_Setter,
            Link_Name  => "readOnly";

   not overriding function Get_Required
    (Self : not null access constant HTML_Input_Element)
       return Boolean is abstract
         with Import     => True,
              Convention => JavaScript_Property_Getter,
              Link_Name  => "required";

   not overriding procedure Set_Required
    (Self : not null access constant HTML_Input_Element;
     To   : Boolean) is abstract
       with Import     => True,
            Convention => JavaScript_Property_Setter,
            Link_Name  => "required";

   --             attribute unsigned long size;
   --             attribute DOMString src;
   --             attribute DOMString step;
   --             attribute DOMString type;
   --             attribute DOMString defaultValue;
   --             attribute Date? valueAsDate;
   --             attribute unrestricted double valueAsNumber;
   --             attribute unsigned long width;
   --
   --    void stepUp(optional long n = 1);
   --    void stepDown(optional long n = 1);
   --
   --    readonly attribute boolean willValidate;
   --    readonly attribute ValidityState validity;
   --    readonly attribute DOMString validationMessage;
   --    boolean checkValidity();
   --    void setCustomValidity(DOMString error);
   --
   --    readonly attribute NodeList labels;
   --
   --    void select();
   --             attribute unsigned long selectionStart;
   --             attribute unsigned long selectionEnd;
   --             attribute DOMString selectionDirection;
   --    void setRangeText(DOMString replacement);
   --    void setRangeText(DOMString replacement, unsigned long start, unsigned long end, optional SelectionMode selectionMode = "preserve");
   --    void setSelectionRange(unsigned long start, unsigned long end, optional DOMString direction);
   --  };

   not overriding function Get_Value
    (Self : not null access constant HTML_Input_Element)
       return League.Strings.Universal_String is abstract
         with Import     => True,
              Convention => JavaScript_Property_Getter,
              Link_Name  => "value";

   not overriding procedure Set_Value
    (Self : not null access constant HTML_Input_Element;
     To   : League.Strings.Universal_String) is abstract
       with Import     => True,
            Convention => JavaScript_Property_Setter,
            Link_Name  => "value";

end WebAPI.HTML.Input_Elements;
