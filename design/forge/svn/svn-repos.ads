--  This package should be linked with svn_repos library.

with APR.Pools;

package SVN.Repos is

   pragma Preelaborate;

   type svn_repos_t is limited private;

   type svn_repos_t_access is access svn_repos_t
     with Convention   => C,
          Storage_Size => 0;

   function svn_repos_create
    (repos     : out svn_repos_t_access;
     path      : Interfaces.C.Strings.chars_ptr;
     unused_1  : Interfaces.C.Strings.chars_ptr
       := Interfaces.C.Strings.Null_Ptr;
     unused_2  : Interfaces.C.Strings.chars_ptr
       := Interfaces.C.Strings.Null_Ptr;
     config    : APR.apr_hash_t_access := null;
     fs_config : APR.apr_hash_t_access := null;
     pool      : APR.Pools.apr_pool_t_access)
       return svn_error_t_access
         with Import     => True,
              Convention => C,
              Link_Name  => "svn_repos_create";

private

   type svn_repos_t is limited null record;

end SVN.Repos;
