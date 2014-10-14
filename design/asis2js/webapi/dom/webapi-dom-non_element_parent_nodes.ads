with League.Strings;

with WebAPI.DOM.Elements;

package WebAPI.DOM.Non_Element_Parent_Nodes is

   type Non_Element_Parent_Node is limited interface;

   not overriding function Get_Element_By_Id
    (Self       : not null access constant Non_Element_Parent_Node;
     Element_Id : League.Strings.Universal_String)
       return WebAPI.DOM.Elements.Element_Access is abstract
         with Import     => True,
              Convention => JavaScript_Function,
              Link_Name  => "getElementById";

end WebAPI.DOM.Non_Element_Parent_Nodes;
