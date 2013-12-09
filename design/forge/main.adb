with Ada.Wide_Wide_Text_IO;

with League.Strings;

with APR;
with SVN.Pools;

with Forge.Admin.Repository;

procedure Main is

   use type APR.apr_status_t;

   Status : Forge.Admin.Repository.Status;

begin
   if SVN.Pools.apr_initialize /= 0 then
      return;
   end if;

   Forge.Admin.Repository.Create_Repository
    (League.Strings.To_Universal_String ("data"), Status);

   if not Status.Success then
      Ada.Wide_Wide_Text_IO.Put_Line
       ("forge: " & Status.Error_String.To_Wide_Wide_String);

      return;
   end if;

   SVN.Pools.apr_terminate;
end Main;
