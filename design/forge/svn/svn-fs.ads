--  This package should be linked with svn_fs library.

with APR.Pools;

package SVN.FS is

   type svn_fs_t is limited private;

   type svn_fs_t_access is access svn_fs_t
     with Convention   => C,
          Storage_Size => 0;

   function svn_fs_create
    (fs_p      : out svn_fs_t_access;
     path      : Interfaces.C.Strings.chars_ptr;
     fs_config : APR.apr_hash_t_access;
     pool      : APR.Pools.apr_pool_t_access) return svn_error_t_access
       with Import     => True,
            Convention => C,
            Link_Name  => "svn_fs_create";

private

   type svn_fs_t is limited null record;

end SVN.FS;
