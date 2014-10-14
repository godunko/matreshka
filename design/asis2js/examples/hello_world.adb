with League.Strings;

with WebAPI.DOM.Elements;
with WebAPI.DOM.Texts;
--with WebAPI.HTML.Canvas_Elements;
with WebAPI.HTML.Documents;
with WebAPI.HTML.Globals; use WebAPI.HTML.Globals;

procedure Hello_World is
   D : constant WebAPI.HTML.Documents.Document_Access
     := Window.Get_Document;
--   C : constant WebAPI.HTML.Canvas_Elements.HTML_Canvas_Element_Access
--     := WebAPI.HTML.Canvas_Elements.HTML_Canvas_Element_Access
--         (D.Get_Element_By_Id (League.Strings.To_Universal_String ("canvas")));
   P : constant WebAPI.DOM.Elements.Element_Access
     := D.Get_Element_By_Id (League.Strings.To_Universal_String ("text"));
   T : constant WebAPI.DOM.Texts.Text_Access
     := D.Create_Text_Node (League.Strings.To_Universal_String ("label"));

begin
   P.Append_Child (T);
end Hello_World;
