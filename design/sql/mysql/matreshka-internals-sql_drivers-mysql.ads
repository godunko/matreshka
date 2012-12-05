------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                           SQL Database Access                            --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2012, Vadim Godunko <vgodunko@gmail.com>                     --
-- All rights reserved.                                                     --
--                                                                          --
-- Redistribution and use in source and binary forms, with or without       --
-- modification, are permitted provided that the following conditions       --
-- are met:                                                                 --
--                                                                          --
--  * Redistributions of source code must retain the above copyright        --
--    notice, this list of conditions and the following disclaimer.         --
--                                                                          --
--  * Redistributions in binary form must reproduce the above copyright     --
--    notice, this list of conditions and the following disclaimer in the   --
--    documentation and/or other materials provided with the distribution.  --
--                                                                          --
--  * Neither the name of the Vadim Godunko, IE nor the names of its        --
--    contributors may be used to endorse or promote products derived from  --
--    this software without specific prior written permission.              --
--                                                                          --
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS      --
-- "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT        --
-- LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    --
-- A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT     --
-- HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,   --
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED --
-- TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR   --
-- PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF   --
-- LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING     --
-- NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS       --
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.             --
--                                                                          --
------------------------------------------------------------------------------
--  $Revision$ $Date$
------------------------------------------------------------------------------
--  This package provides low level binding to MySQL client library or embedded
--  server functions.
------------------------------------------------------------------------------
pragma Ada_2012;

with Interfaces.C.Strings;

package Matreshka.Internals.SQL_Drivers.MySQL is

   pragma Preelaborate;

   -----------
   -- Types --
   -----------

   type MYSQL is limited private;

   type MYSQL_Access is access all MYSQL
     with Convention => C;

   type MYSQL_STMT is limited private;

   type MYSQL_STMT_Access is access all MYSQL_STMT
     with Convention => C;

   type my_bool is new Interfaces.C.signed_char;

   type mysql_option is
    (MYSQL_OPT_CONNECT_TIMEOUT,
     MYSQL_OPT_COMPRESS,
     MYSQL_OPT_NAMED_PIPE,
     MYSQL_INIT_COMMAND,
     MYSQL_READ_DEFAULT_FILE,
     MYSQL_READ_DEFAULT_GROUP,
     MYSQL_SET_CHARSET_DIR,
     MYSQL_SET_CHARSET_NAME,
     MYSQL_OPT_LOCAL_INFILE,
     MYSQL_OPT_PROTOCOL,
     MYSQL_SHARED_MEMORY_BASE_NAME,
     MYSQL_OPT_READ_TIMEOUT,
     MYSQL_OPT_WRITE_TIMEOUT,
     MYSQL_OPT_USE_RESULT,
     MYSQL_OPT_USE_REMOTE_CONNECTION,
     MYSQL_OPT_USE_EMBEDDED_CONNECTION,
     MYSQL_OPT_GUESS_CONNECTION,
     MYSQL_SET_CLIENT_IP,
     MYSQL_SECURE_AUTH,
     MYSQL_REPORT_DATA_TRUNCATION,
     MYSQL_OPT_RECONNECT,
     MYSQL_OPT_SSL_VERIFY_SERVER_CERT,
     MYSQL_PLUGIN_DIR,
     MYSQL_DEFAULT_AUTH)
       with Convention => C;

   -----------------
   -- Subprograms --
   -----------------

   procedure mysql_close (handle : not null access MYSQL)
     with Convention => C,
          Import     => True,
          Link_Name  => "mysql_close";

   function mysql_error
    (handle : not null access MYSQL) return Interfaces.C.Strings.chars_ptr
       with Convention => C,
            Import     => True,
            Link_Name  => "mysql_error";

   function mysql_init (handle : access MYSQL) return MYSQL_Access
     with Convention => C,
          Import     => True,
          Link_Name  => "mysql_init";

   function mysql_library_init
    (argc   : Interfaces.C.int;
     argv   : access Interfaces.C.Strings.chars_ptr;
     groups : access Interfaces.C.Strings.chars_ptr) return Interfaces.C.int
       with Convention => C,
            Import     => True,
            Link_Name  => "mysql_server_init";
   --  MySQL defines mysql_library_init as alias of mysql_server_init.

   function mysql_options
    (handle : not null access MYSQL;
     option : mysql_option;
     arg    : Interfaces.C.char_array) return Interfaces.C.int
       with Convention => C,
            Import     => True,
            Link_Name  => "mysql_options";

   function mysql_real_connect
    (handle : not null access MYSQL;
     host   : Interfaces.C.Strings.chars_ptr;
     user   : Interfaces.C.Strings.chars_ptr;
     passwd : Interfaces.C.Strings.chars_ptr;
     db     : Interfaces.C.Strings.chars_ptr;
     port   : Interfaces.C.unsigned;
     unix_socket : Interfaces.C.Strings.chars_ptr;
     client_flag : Interfaces.C.unsigned_long) return MYSQL_Access
       with Convention => C,
            Import     => True,
            Link_Name  => "mysql_real_connect";

   function mysql_stmt_close
    (handle : not null access MYSQL_STMT) return my_bool
       with Convention => C,
            Import     => True,
            Link_Name  => "mysql_stmt_close";

   function mysql_stmt_error
    (handle : not null access MYSQL_STMT) return Interfaces.C.Strings.chars_ptr
       with Convention => C,
            Import     => True,
            Link_Name  => "mysql_stmt_error";

   function mysql_stmt_execute
    (handle   : not null access MYSQL_STMT) return Interfaces.C.int
       with Convention => C,
            Import     => True,
            Link_Name  => "mysql_stmt_execute";

   function mysql_stmt_init
    (handle : not null access MYSQL) return MYSQL_STMT_Access
       with Convention => C,
            Import     => True,
            Link_Name  => "mysql_stmt_init";

   function mysql_stmt_prepare
    (handle   : not null access MYSQL_STMT;
     stmt_str : Interfaces.C.Strings.chars_ptr;
     length   : Interfaces.C.unsigned_long) return Interfaces.C.int
       with Convention => C,
            Import     => True,
            Link_Name  => "mysql_stmt_prepare";

private

   type MYSQL is limited null record;

   type MYSQL_STMT is limited null record;

end Matreshka.Internals.SQL_Drivers.MySQL;
