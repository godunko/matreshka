with WebAPI.DOM.Elements;

package WebAPI.HTML.Elements is

   type HTML_Element is limited interface
     and WebAPI.DOM.Elements.Element;

   type HTML_Element_Access is access all HTML_Element'Class
     with Storage_Size => 0;

end WebAPI.HTML.Elements;
