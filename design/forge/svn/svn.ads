with Interfaces.C.Strings;

with APR.Pools;

package SVN is

   pragma Preelaborate;

   type svn_error_t;
   type svn_error_t_access is access svn_error_t
     with Convention   => C,
          Storage_Size => 0;

   type svn_error_t is limited record
      apr_err : APR.apr_status_t;
      message : Interfaces.C.Strings.chars_ptr;
      child   : svn_error_t_access;
      pool    : APR.Pools.apr_pool_t_access;
      file    : Interfaces.C.Strings.chars_ptr;
      line    : Interfaces.C.long;
   end record with Convention => C;

end SVN;
