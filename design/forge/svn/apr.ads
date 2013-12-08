with Interfaces.C;

package APR is

   pragma Pure;

   ------------------
   -- apr_status_t --
   ------------------

   type apr_status_t is new Interfaces.C.int;

   ----------------
   -- apr_hash_t --
   ----------------

   type apr_hash_t is limited private;

   type apr_hash_t_access is access apr_hash_t
     with Convention   => C,
          Storage_Size => 0;

private

   type apr_hash_t is limited null record;

end APR;
