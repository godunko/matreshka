with League.Strings;

--with WebAPI.DOM.Elements;
--with WebAPI.DOM.Texts;
--with WebAPI.HTML.Documents;
with WebAPI.HTML.Canvas_Elements;
with WebAPI.HTML.Globals; use WebAPI.HTML.Globals;

--procedure Hello_World is
--
--   D : constant WebAPI.HTML.Documents.Document_Access
--     := Window.Get_Document;
--   P : constant WebAPI.DOM.Elements.Element_Access
--     := D.Get_Element_By_Id (+"text");
--   T : constant WebAPI.DOM.Texts.Text_Access
--     := D.Create_Text_Node (+"Hello, world!");
--
--begin
--   P.Append_Child (T);
--end Hello_World;

package body Hello_WebGL is

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   ---------------------
   -- Run_Application --
   ---------------------

   procedure Run_Application is
      Canvas : constant WebAPI.HTML.Canvas_Elements.HTML_Canvas_Element_Access
        := WebAPI.HTML.Canvas_Elements.HTML_Canvas_Element_Access
            (Window.Get_Document.Get_Element_By_Id (+"canvas"));

   begin
      null;
   end Run_Application;

end Hello_WebGL;
