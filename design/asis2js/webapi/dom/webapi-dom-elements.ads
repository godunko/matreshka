
package WebAPI.DOM.Elements is

   type Element is limited interface;

   type Element_Access is access all Element'Class
     with Storage_Size => 0;

end WebAPI.DOM.Elements;
