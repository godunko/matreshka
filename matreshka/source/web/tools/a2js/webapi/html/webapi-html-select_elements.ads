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
-- Copyright © 2016, Vadim Godunko <vgodunko@gmail.com>                     --
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
with WebAPI.HTML.Elements;

package WebAPI.HTML.Select_Elements is

   pragma Preelaborate;

   type HTML_Select_Element is limited interface
     and WebAPI.HTML.Elements.HTML_Element;

   type HTML_Select_Element_Access is access all HTML_Select_Element'Class
      with Storage_Size => 0;

   not overriding function Get_Autofocus
    (Self : not null access constant HTML_Select_Element)
       return WebAPI.DOM_Boolean is abstract
         with Import     => True,
              Convention => JavaScript_Property_Getter,
              Link_Name  => "autofocus";

   not overriding procedure Set_Autofocus
    (Self : not null access constant HTML_Select_Element;
     To   : WebAPI.DOM_Boolean) is abstract
       with Import     => True,
            Convention => JavaScript_Property_Setter,
            Link_Name  => "autofocus";

   not overriding function Get_Disabled
    (Self : not null access constant HTML_Select_Element)
       return WebAPI.DOM_Boolean is abstract
         with Import     => True,
              Convention => JavaScript_Property_Getter,
              Link_Name  => "disabled";

   not overriding procedure Set_Disabled
    (Self : not null access constant HTML_Select_Element;
     To   : WebAPI.DOM_Boolean) is abstract
       with Import     => True,
            Convention => JavaScript_Property_Setter,
            Link_Name  => "disabled";

   --    readonly attribute HTMLFormElement? form;

   not overriding function Get_Multiple
    (Self : not null access constant HTML_Select_Element)
       return WebAPI.DOM_Boolean is abstract
         with Import     => True,
              Convention => JavaScript_Property_Getter,
              Link_Name  => "multiple";

   not overriding procedure Set_Multiple
    (Self : not null access constant HTML_Select_Element;
     To   : WebAPI.DOM_Boolean) is abstract
       with Import     => True,
            Convention => JavaScript_Property_Setter,
            Link_Name  => "multiple";

   not overriding function Get_Name
    (Self : not null access constant HTML_Select_Element)
       return WebAPI.DOM_String is abstract
         with Import     => True,
              Convention => JavaScript_Property_Getter,
              Link_Name  => "name";

   not overriding procedure Set_Name
    (Self : not null access constant HTML_Select_Element;
     To   : WebAPI.DOM_String) is abstract
       with Import     => True,
            Convention => JavaScript_Property_Setter,
            Link_Name  => "name";

   not overriding function Get_Required
    (Self : not null access constant HTML_Select_Element)
       return WebAPI.DOM_Boolean is abstract
         with Import     => True,
              Convention => JavaScript_Property_Getter,
              Link_Name  => "required";

   not overriding procedure Set_Required
    (Self : not null access constant HTML_Select_Element;
     To   : WebAPI.DOM_Boolean) is abstract
       with Import     => True,
            Convention => JavaScript_Property_Setter,
            Link_Name  => "required";

   --             attribute unsigned long size;

   not overriding function Get_Type
    (Self : not null access constant HTML_Select_Element)
       return WebAPI.DOM_String is abstract
         with Import     => True,
              Convention => JavaScript_Property_Getter,
              Link_Name  => "type";

   --    readonly attribute HTMLOptionsCollection options;
   --             attribute unsigned long length;
   --    getter Element? item(unsigned long index);
   --    HTMLOptionElement? namedItem(DOMString name);
   --    void add((HTMLOptionElement or HTMLOptGroupElement) element, optional (HTMLElement or long)? before = null);
   --    void remove(); // ChildNode overload
   --    void remove(long index);
   --    setter creator void (unsigned long index, HTMLOptionElement? option);
   --  
   --    readonly attribute HTMLCollection selectedOptions;

   not overriding function Get_Selected_Index
    (Self : not null access constant HTML_Select_Element)
       return WebAPI.DOM_Long is abstract
         with Import     => True,
              Convention => JavaScript_Property_Getter,
              Link_Name  => "selectedIndex";

   not overriding procedure Set_Selected_Index
    (Self : not null access constant HTML_Select_Element;
     To   : WebAPI.DOM_Long) is abstract
       with Import     => True,
            Convention => JavaScript_Property_Setter,
            Link_Name  => "selectedIndex";

   not overriding function Get_Value
    (Self : not null access constant HTML_Select_Element)
       return WebAPI.DOM_String is abstract
         with Import     => True,
              Convention => JavaScript_Property_Getter,
              Link_Name  => "value";

   not overriding procedure Set_Value
    (Self : not null access constant HTML_Select_Element;
     To   : WebAPI.DOM_String) is abstract
       with Import     => True,
            Convention => JavaScript_Property_Setter,
            Link_Name  => "value";

   not overriding function Get_Will_Validate
    (Self : not null access constant HTML_Select_Element)
       return WebAPI.DOM_Boolean is abstract
         with Import     => True,
              Convention => JavaScript_Property_Getter,
              Link_Name  => "willValidate";

   not overriding procedure Set_Will_Validate
    (Self : not null access constant HTML_Select_Element;
     To   : WebAPI.DOM_Boolean) is abstract
       with Import     => True,
            Convention => JavaScript_Property_Setter,
            Link_Name  => "willValidate";

   --    readonly attribute ValidityState validity;

   not overriding function Get_Validation_Message
    (Self : not null access constant HTML_Select_Element)
       return WebAPI.DOM_String is abstract
         with Import     => True,
              Convention => JavaScript_Property_Getter,
              Link_Name  => "validationMessage";

   not overriding function Check_Validity
    (Self : not null access constant HTML_Select_Element)
       return Boolean is abstract
         with Import     => True,
              Convention => JavaScript_Method,
              Link_Name  => "checkValidity";

   not overriding procedure Set_Custom_Validity
    (Self  : not null access constant HTML_Select_Element;
     Error : WebAPI.DOM_String) is abstract
         with Import     => True,
              Convention => JavaScript_Method,
              Link_Name  => "setCustomValidity";

   --    readonly attribute NodeList labels;

end WebAPI.HTML.Select_Elements;
