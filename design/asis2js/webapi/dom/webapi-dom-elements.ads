with WebAPI.DOM.Nodes;

package WebAPI.DOM.Elements is

   type Element is limited interface
     and WebAPI.DOM.Nodes.Node;

   type Element_Access is access all Element'Class
     with Storage_Size => 0;

end WebAPI.DOM.Elements;
