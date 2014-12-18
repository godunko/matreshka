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
--  Defines a set of methods that a servlet uses to communicate with its
--  servlet container, for example, to get the MIME type of a file, dispatch
--  requests, or write to a log file.
------------------------------------------------------------------------------
with League.Strings;

with Servlet.Event_Listeners;
with Servlet.Servlet_Registrations;
with Servlet.Servlets;

package Servlet.Contexts is

   pragma Preelaborate;

   type Servlet_Context is limited interface;

   type Servlet_Context_Access is access all Servlet_Context'Class;

   not overriding function Add_Servlet
    (Self     : not null access Servlet_Context;
     Name     : League.Strings.Universal_String;
     Instance : not null access Servlet.Servlets.Servlet'Class)
       return not null access
         Servlet.Servlet_Registrations.Servlet_Registration'Class
           is abstract;
   --  Registers the given servlet instance with this ServletContext under the
   --  given servletName.
   --
   --  The registered servlet may be further configured via the returned
   --  ServletRegistration object.
   --
   --  If this ServletContext already contains a preliminary
   --  ServletRegistration for a servlet with the given servletName, it will be
   --  completed (by assigning the class name of the given servlet instance to
   --  it) and returned.

   procedure Add_Servlet
    (Self     : not null access Servlet_Context'Class;
     Name     : League.Strings.Universal_String;
     Instance : not null access Servlet.Servlets.Servlet'Class);

   not overriding procedure Add_Listener
    (Self     : not null access Servlet_Context;
     Listener : not null Servlet.Event_Listeners.Event_Listener_Access)
       is abstract;
   --  Adds a listener of the given class type to this ServletContext.
   --
   --  The given listenerClass must implement one or more of the following
   --  interfaces:
   --
   --    ServletContextAttributeListener
   --    ServletRequestListener
   --    ServletRequestAttributeListener
   --    HttpSessionAttributeListener
   --    HttpSessionIdListener
   --    HttpSessionListener 
   --
   --  If this ServletContext was passed to
   --  Servlet_Container_Initializer.On_Startup, then the given listener may
   --  also be an instance of ServletContextListener, in addition to the
   --  interfaces listed above.
   --
   --  If the given listenerClass implements a listener interface whose
   --  invocation order corresponds to the declaration order (i.e., if it
   --  implements ServletRequestListener, ServletContextListener, or
   --  HttpSessionListener), then the new listener will be added to the end of
   --  the ordered list of listeners of that interface.

end Servlet.Contexts;
