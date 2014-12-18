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
private with Ada.Containers.Hashed_Maps;
private with Ada.Containers.Vectors;

private with League.Strings.Hash;

private with Servlet.Context_Listeners;
with Servlet.Contexts;
private with Servlet.Event_Listeners;
with Servlet.Requests;
with Servlet.Responses;
private with Servlet.Servlets;
private with Servlet.Servlet_Registrations;
with Matreshka.Servlet_Servers;
private with Matreshka.Servlet_Registrations;

package Matreshka.Servlet_Containers is

   type Servlet_Container is
     limited new Servlet.Contexts.Servlet_Context with private;

   procedure Initialize
    (Self   : not null access Servlet_Container'Class;
     Server : not null Matreshka.Servlet_Servers.Server_Access);
   --  Initializes servlet container. Specified server object must be
   --  initialized.

   procedure Finalize (Self : not null access Servlet_Container'Class);
   --  Finalizes servlet container.

   procedure Dispatch
    (Self     : not null access Servlet_Container'Class;
     Request  : not null Servlet.Requests.Servlet_Request_Access;
     Response : not null Servlet.Responses.Servlet_Response_Access);
   --  Dispatch request to filters/servlet.

private

   type Container_States is (Uninitialized, Initialization, Initialized);

   package Servlet_Context_Listener_Vectors is
     new Ada.Containers.Vectors
          (Positive,
           Servlet.Context_Listeners.Servlet_Context_Listener_Access,
           Servlet.Context_Listeners."=");

   package Servlet_Registration_Maps is
     new Ada.Containers.Hashed_Maps
          (League.Strings.Universal_String,
           Matreshka.Servlet_Registrations.Servlet_Registration_Access,
           League.Strings.Hash,
           League.Strings."=",
           Matreshka.Servlet_Registrations."=");

   type Servlet_Container is
     limited new Servlet.Contexts.Servlet_Context with record
      State             : Container_States := Uninitialized;
      Context_Listeners : Servlet_Context_Listener_Vectors.Vector;
      Servlets          : Servlet_Registration_Maps.Map;
   end record;

   overriding procedure Add_Listener
    (Self     : not null access Servlet_Container;
     Listener : not null Servlet.Event_Listeners.Event_Listener_Access);

   overriding function Add_Servlet
    (Self     : not null access Servlet_Container;
     Name     : League.Strings.Universal_String;
     Instance : not null access Servlet.Servlets.Servlet'Class)
       return access Servlet.Servlet_Registrations.Servlet_Registration'Class;

end Matreshka.Servlet_Containers;
