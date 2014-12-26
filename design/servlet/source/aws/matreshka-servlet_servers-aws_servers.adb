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
-- Copyright © 2014, Vadim Godunko <vgodunko@gmail.com>                     --
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
with Ada.Synchronous_Task_Control;
with Ada.Unchecked_Deallocation;

with GNAT.Ctrl_C;

with AWS.Config.Set;
with AWS.Response;
with AWS.Server.Log;
with AWS.Status;

with Matreshka.Servlet_Containers;
with Matreshka.Servlet_AWS_Requests;
with Matreshka.Servlet_AWS_Responses;
with Servlet.Requests;
with Servlet.Responses;

package body Matreshka.Servlet_Servers.AWS_Servers is

   Config           : AWS.Config.Object;
   Server           : AWS.Server.HTTP;
   Shutdown_Request : Ada.Synchronous_Task_Control.Suspension_Object;
   Container        : Matreshka.Servlet_Containers.Servlet_Container_Access;

   procedure Shutdown_Request_Handler;
   --  Interrupt handler to process shutdown request from the operating system.

   task Shutdown_Controller is
      entry Start;
   end Shutdown_Controller;

   function Request_Callback
    (Request : AWS.Status.Data) return AWS.Response.Data;
   --  Handles request.

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Self : not null access AWS_Server'Class) is
   begin
      AWS.Config.Set.Reuse_Address (Config, True);

      AWS.Server.Log.Start (Server);
      AWS.Server.Log.Start_Error (Server);
      AWS.Server.Start (Server, Request_Callback'Access, Config);
      Shutdown_Controller.Start;
   end Initialize;

   ----------------------
   -- Request_Callback --
   ----------------------

   function Request_Callback
    (Request : AWS.Status.Data) return AWS.Response.Data
   is
      procedure Free is
        new Ada.Unchecked_Deallocation
             (Servlet.Requests.Servlet_Request'Class,
              Servlet.Requests.Servlet_Request_Access);
      procedure Free is
        new Ada.Unchecked_Deallocation
             (Servlet.Responses.Servlet_Response'Class,
              Servlet.Responses.Servlet_Response_Access);

      Servlet_Request  : Servlet.Requests.Servlet_Request_Access
        := new Matreshka.Servlet_AWS_Requests.AWS_Servlet_Request;
      Servlet_Response : Servlet.Responses.Servlet_Response_Access
        := new Matreshka.Servlet_AWS_Responses.AWS_Servlet_Response;

   begin
      Container.Dispatch (Servlet_Request, Servlet_Response);

      return Result : constant AWS.Response.Data
        := Matreshka.Servlet_AWS_Responses.AWS_Servlet_Response'Class
            (Servlet_Response.all).Build
      do
         Free (Servlet_Request);
         Free (Servlet_Response);
      end return;
   end Request_Callback;

   -------------------
   -- Set_Container --
   -------------------

   overriding procedure Set_Container
    (Self      : not null access AWS_Server;
     Container : Matreshka.Servlet_Containers.Servlet_Container_Access) is
   begin
      AWS_Servers.Container := Container;
   end Set_Container;

   -------------------------
   -- Shutdown_Controller --
   -------------------------

   task body Shutdown_Controller is
   begin
      select
         accept Start;

         Ada.Synchronous_Task_Control.Set_False (Shutdown_Request);
         GNAT.Ctrl_C.Install_Handler (Shutdown_Request_Handler'Access);

      or
         terminate;
      end select;

      --  Wait till shutdown request was received.

      Ada.Synchronous_Task_Control.Suspend_Until_True (Shutdown_Request);

      --  Shutdown AWS server.

      AWS.Server.Shutdown (Server);
   end Shutdown_Controller;

   ------------------------------
   -- Shutdown_Request_Handler --
   ------------------------------

   procedure Shutdown_Request_Handler is
   begin
      Ada.Synchronous_Task_Control.Set_True (Shutdown_Request);
   end Shutdown_Request_Handler;

end Matreshka.Servlet_Servers.AWS_Servers;
