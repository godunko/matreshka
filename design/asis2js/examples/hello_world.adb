with WebAPI.HTML.Documents;
with WebAPI.HTML.Globals; use WebAPI.HTML.Globals;

procedure Hello_World is
   D : constant WebAPI.HTML.Documents.Document_Access
     := Window.Get_Document;
begin
   null;
end Hello_World;
