with Interfaces.C.Strings;

with APR.Pools;
with SVN.Error;
with SVN.Pools;
with SVN.Repos;

package body Forge.Admin.Repository is

   -----------------------
   -- Create_Repository --
   -----------------------

   procedure Create_Repository
    (Path   : League.Strings.Universal_String;
     Status : in out Forge.Admin.Repository.Status)
   is
      use type APR.Pools.apr_pool_t_access;
      use type SVN.svn_error_t_access;

      Pool   : APR.Pools.apr_pool_t_access;
      Error  : SVN.svn_error_t_access;
      Repos  : SVN.Repos.svn_repos_t_access;
      C_Path : Interfaces.C.Strings.chars_ptr
        := Interfaces.C.Strings.New_String (Path.To_UTF_8_String);

   begin
      Pool := SVN.Pools.svn_pool_create;

      if Pool = null then
         Status.Success := False;
         Status.Error_String :=
           League.Strings.To_Universal_String ("insufficient memory");
      end if;

      Error :=
        SVN.Repos.svn_repos_create
         (repos => Repos, path => C_Path, pool => Pool);

      if Error /= null then
         Status.Success := False;
         Status.Error_String :=
           League.Strings.From_UTF_8_String
            (Interfaces.C.Strings.Value (Error.message));
         SVN.Error.svn_error_clear (Error);
      end if;

      SVN.Pools.svn_pool_destroy (Pool);
      Interfaces.C.Strings.Free (C_Path);
   end Create_Repository;

end Forge.Admin.Repository;
