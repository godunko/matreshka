with Ada.Text_IO;
with Interfaces.C.Strings;

with APR.Pools;
with SVN.Error;
with SVN.Pools;
with SVN.Repos;

procedure Main is

   use type APR.apr_status_t;
   use type APR.Pools.apr_pool_t_access;

   ------------------
   -- Handle_Error --
   ------------------

   procedure Handle_Error (Item : SVN.svn_error_t_access) is
      use type SVN.svn_error_t_access;

   begin
      if Item /= null then
         Ada.Text_IO.Put_Line
          (Ada.Text_IO.Standard_Error,
           "Error: " & Interfaces.C.Strings.Value (Item.message));
         SVN.Error.svn_error_clear (Item);

         raise Program_Error;
      end if;
   end Handle_Error;

   Path  : Interfaces.C.Strings.chars_ptr
     := Interfaces.C.Strings.New_String ("data");
   Pool  : APR.Pools.apr_pool_t_access;
   Repos : SVN.Repos.svn_repos_t_access;

begin
   if SVN.Pools.apr_initialize /= 0 then
      return;
   end if;

   Pool := SVN.Pools.svn_pool_create;

   if Pool = null then
      raise Program_Error;
   end if;

   Handle_Error
    (SVN.Repos.svn_repos_create
      (Repos,
       Path,
       Interfaces.C.Strings.Null_Ptr,
       Interfaces.C.Strings.Null_Ptr,
       null,
       null,
       Pool));

   SVN.Pools.svn_pool_destroy (Pool);
   SVN.Pools.apr_terminate;

   Interfaces.C.Strings.Free (Path);
end Main;
