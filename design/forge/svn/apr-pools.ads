
package APR.Pools is

   pragma Preelaborate;

   type apr_pool_t is limited private;

   type apr_pool_t_access is access apr_pool_t
     with Convention   => C,
          Storage_Size => 0;

private

   type apr_pool_t is limited null record;

end APR.Pools;
