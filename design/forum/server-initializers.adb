------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2015, Vadim Godunko <vgodunko@gmail.com>                     --
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
with League.Strings;
with SQL.Options;

with Servlet.Servlets;
with Servlet.Servlet_Registrations;
with Spikedog.Servlet_Contexts;

with AWFC.Accounts.Account_Servlets;
with AWFC.Static_Resource_Servlets;
with Forum.Forums.Servers;
with Server.Servlets.Forum_Servlets;

with Matreshka.Internals.SQL_Drivers.PostgreSQL.Factory;

package body Server.Initializers is

   type Servlet_Access is access all Servlet.Servlets.Servlet'Class;

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   ----------------
   -- On_Startup --
   ----------------

   overriding procedure On_Startup
     (Self    : in out Server_Initializer;
      Context : in out Servlet.Contexts.Servlet_Context'Class)
   is
      Options       : SQL.Options.SQL_Options;
      Forum_Servlet : constant
        Server.Servlets.Forum_Servlets.Forum_Servlet_Access
          := new Server.Servlets.Forum_Servlets.Forum_Servlet;
      Registry      : access
        Standard.Servlet.Servlet_Registrations.Servlet_Registration'Class;
      Aux           : Servlet_Access;

   begin
      --  Initialize persistance manager.

      Options.Set
        (League.Strings.To_Universal_String ("dbname"),
         League.Strings.To_Universal_String ("forum"));
      Forum.Forums.Servers.Initialize
       (Forum_Servlet.Server,
        League.Strings.To_Universal_String ("POSTGRESQL"),
        Options);

      --  Replace default session manager.

      Spikedog.Servlet_Contexts.Spikedog_Servlet_Context'Class
       (Context).Set_Session_Manager
         (Forum_Servlet.Server.Get_HTTP_Session_Manager);

      --  Create and register servlets.

      Registry := Context.Add_Servlet
        (+"StaticResources",
         Servlet_Access'
           (new AWFC.Static_Resource_Servlets.Static_Resource_Servlet));

      Registry.Add_Mapping (+"/css/*");
      Registry.Add_Mapping (+"/images/*");

      Aux :=
        new AWFC.Accounts.Account_Servlets.Account_Servlet
             (Forum_Servlet.Server.Password_Manager);
      Registry := Context.Add_Servlet (+"AccountManager", Aux);
      Registry.Add_Mapping (+"/account/*");

      Registry := Context.Add_Servlet (+"ForumManager", Forum_Servlet);
      Registry.Add_Mapping (+"/forum/*");

   end On_Startup;

end Server.Initializers;
