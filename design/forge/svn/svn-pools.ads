--  This package provides support for APR pools
--
--  It should be linked with svn_subr library.

with APR.Pools;

package SVN.Pools is

   pragma Preelaborate;

   type apr_allocator_t is limited private;

   type apr_allocator_t_access is access apr_allocator_t
     with Convention   => C,
          Storage_Size => 0;

   function apr_initialize return APR.apr_status_t
     with Import     => True,
          Convention => C,
          Link_Name  => "apr_initialize";

   procedure apr_terminate
     with Import     => True,
          Convention => C,
          Link_Name  => "apr_terminate";

   function svn_pool_create
    (parent_pool : APR.Pools.apr_pool_t_access := null;
     allocator   : apr_allocator_t_access      := null)
       return APR.Pools.apr_pool_t_access
         with Import     => True,
              Convention => C,
              Link_Name  => "svn_pool_create_ex";
   --  This function covers both svn_pool_create macro and svn_pool_create_ex
   --  subprogram by defaulting parameters to be null.

   procedure svn_pool_clear (pool : APR.Pools.apr_pool_t_access)
     with Import     => True,
          Convention => C,
          Link_Name  => "apr_pool_clear";

   procedure svn_pool_destroy (pool : APR.Pools.apr_pool_t_access)
     with Import     => True,
          Convention => C,
          Link_Name  => "apr_pool_destroy";

private

   type apr_allocator_t is limited null record;

end SVN.Pools;
