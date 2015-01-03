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
-- Copyright © 2014-2015, Vadim Godunko <vgodunko@gmail.com>                --
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
with Servlet.Configs;
with Servlet.Requests;
with Servlet.Responses;

package Servlet.Servlets is

   pragma Preelaborate;

   type Servlet is limited interface;

   not overriding procedure Destroy (Self : in out Servlet) is null;
   --  Called by the servlet container to indicate to a servlet that the
   --  servlet is being taken out of service. This method is only called once
   --  all threads within the servlet's service method have exited or after a
   --  timeout period has passed. After the servlet container calls this
   --  method, it will not call the service method again on this servlet.
   --
   --  This method gives the servlet an opportunity to clean up any resources
   --  that are being held (for example, memory, file handles, threads) and
   --  make sure that any persistent state is synchronized with the servlet's
   --  current state in memory.

   not overriding function Get_Servlet_Config
    (Self : Servlet)
       return access Standard.Servlet.Configs.Servlet_Config'Class is abstract;
   --  Returns a ServletConfig object, which contains initialization and
   --  startup parameters for this servlet. The ServletConfig object returned
   --  is the one passed to the init method.
   --
   --  Implementations of this interface are responsible for storing the
   --  ServletConfig object so that this method can return it. The
   --  GenericServlet class, which implements this interface, already does
   --  this.

   not overriding procedure Initialize
    (Self   : in out Servlet;
     Config : not null access Standard.Servlet.Configs.Servlet_Config'Class)
       is abstract;
   --  Called by the servlet container to indicate to a servlet that the
   --  servlet is being placed into service.
   --
   --  The servlet container calls the init method exactly once after
   --  instantiating the servlet. The init method must complete successfully
   --  before the servlet can receive any requests.
   --
   --  The servlet container cannot place the servlet into service if the init
   --  method
   --
   --   1. Throws a ServletException
   --   2. Does not return within a time period defined by the Web server

   not overriding procedure Service
    (Self     : in out Servlet;
     Request  : Standard.Servlet.Requests.Servlet_Request'Class;
     Response : in out Standard.Servlet.Responses.Servlet_Response'Class)
       is abstract;
   --  Called by the servlet container to allow the servlet to respond to a
   --  request.

end Servlet.Servlets;
