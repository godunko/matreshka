with League.Strings;

with WebAPI.DOM.Elements;
with WebAPI.DOM.Texts;
with WebAPI.HTML.Documents;
with WebAPI.HTML.Globals; use WebAPI.HTML.Globals;

with My_Handlers;
with WebAPI.DOM.Event_Targets;

procedure HTML_Button is

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   D : constant WebAPI.HTML.Documents.Document_Access
     := Window.Get_Document;
   P : constant WebAPI.DOM.Elements.Element_Access
     := D.Get_Element_By_Id (+"text");
   T : constant WebAPI.DOM.Texts.Text_Access
     := D.Create_Text_Node (+"Hello, world!");
   H : constant My_Handlers.Handler_Access := new My_Handlers.Handler;

begin
   H.P := P;
   H.T := T;
   WebAPI.DOM.Event_Targets.Add_Event_Listener (P, +"click", H, False);
end HTML_Button;

