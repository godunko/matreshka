
package WebAPI.DOM.Nodes is

   type Node is limited interface;

   type Node_Access is access all Node'Class
     with Storage_Size => 0;

   not overriding function Append_Child
    (Self       : not null access Node;
     Child_Node : not null access Node'Class) return Node_Access is abstract
       with Import     => True,
            Convention => JavaScript_Function,
            Link_Name  => "appendChild";

   procedure Append_Child
    (Self       : not null access Node'Class;
     Child_Node : not null access Node'Class)
       with Import     => True,
            Convention => JavaScript_Function,
            Link_Name  => "appendChild";

end WebAPI.DOM.Nodes;
