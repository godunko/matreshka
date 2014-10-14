with WebAPI.DOM.Nodes;

package WebAPI.DOM.Texts is

   type Text is limited interface
     and WEbAPI.DOM.Nodes.Node;  -- XXX Must be derived from CharacterData!

   type Text_Access is access all Text'Class
     with Storage_Size => 0;

end WebAPI.DOM.Texts;
