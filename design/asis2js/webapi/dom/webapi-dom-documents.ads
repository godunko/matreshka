with WebAPI.DOM.Non_Element_Parent_Nodes;

package WebAPI.DOM.Documents is

   type Document is limited interface
     and WebAPI.DOM.Non_Element_Parent_Nodes.Non_Element_Parent_Node;

   type Document_Access is access all Document'Class
     with Storage_Size => 0;

end WebAPI.DOM.Documents;
