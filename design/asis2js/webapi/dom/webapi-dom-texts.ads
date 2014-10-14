
package WebAPI.DOM.Texts is

   type Text is limited interface;

   type Text_Access is access all Text'Class
     with Storage_Size => 0;

end WebAPI.DOM.Texts;
