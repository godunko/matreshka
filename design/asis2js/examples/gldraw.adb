with League.Strings;

with WebAPI.DOM.Node_Lists;
with WebAPI.HTML.Canvas_Elements;
with WebAPI.HTML.Documents;
with WebAPI.HTML.Globals; use WebAPI.HTML.Globals;
with WebAPI.WebGL.Rendering_Contexts;

procedure GLDraw is

   use type WebAPI.WebGL.Rendering_Contexts.WebGL_Rendering_Context_Access;

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   D : constant WebAPI.HTML.Documents.Document_Access
     := Window.Get_Document;
   C : constant WebAPI.HTML.Canvas_Elements.HTML_Canvas_Element_Access
     := WebAPI.HTML.Canvas_Elements.HTML_Canvas_Element_Access
         (D.Get_Element_By_Id (League.Strings.To_Universal_String ("canvas")));
   G : constant WebAPI.WebGL.Rendering_Contexts.WebGL_Rendering_Context_Access
     := WebAPI.WebGL.Rendering_Contexts.WebGL_Rendering_Context_Access
         (C.Get_Context (+"webgl"));
   L : constant WebAPI.DOM.Node_Lists.Node_List
     := C.Query_Selector_All (+"test");

begin
   if G = null then
      return;
   end if;
end GLDraw;
