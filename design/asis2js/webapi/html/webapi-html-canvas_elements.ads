with WebAPI.HTML.Elements;

package WebAPI.HTML.Canvas_Elements is

   type HTML_Canvas_Element is limited interface
     and WebAPI.HTML.Elements.HTML_Element;

   type HTML_Canvas_Element_Access is access all HTML_Canvas_Element'Class
      with Storage_Size => 0;

end WebAPI.HTML.Canvas_Elements;
