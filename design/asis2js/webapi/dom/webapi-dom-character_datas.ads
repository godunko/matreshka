with WebAPI.DOM.Nodes;

package WebAPI.DOM.Character_Datas is

   type Character_Data is limited interface
     and WebAPI.DOM.Nodes.Node;

   type Character_Data_Access is access all Character_Data'Class
     with Storage_Size => 0;

end WebAPI.DOM.Character_Datas;
