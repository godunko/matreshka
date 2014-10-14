with League.Strings;

with WebAPI.DOM.Non_Element_Parent_Nodes;
with WebAPI.DOM.Texts;

package WebAPI.DOM.Documents is

   type Document is limited interface
     and WebAPI.DOM.Non_Element_Parent_Nodes.Non_Element_Parent_Node;

   type Document_Access is access all Document'Class
     with Storage_Size => 0;

   not overriding function Create_Text_Node
    (Self : not null access Document;
     Data : League.Strings.Universal_String)
       return not null WebAPI.DOM.Texts.Text_Access is abstract
         with Import     => True,
              Convention => JavaScript_Function,
              Link_Name  => "createTextNode";

end WebAPI.DOM.Documents;
