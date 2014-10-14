with WebAPI.DOM.Character_Datas;

package WebAPI.DOM.Texts is

   type Text is limited interface
     and WEbAPI.DOM.Character_Datas.Character_Data;

   type Text_Access is access all Text'Class
     with Storage_Size => 0;

end WebAPI.DOM.Texts;
