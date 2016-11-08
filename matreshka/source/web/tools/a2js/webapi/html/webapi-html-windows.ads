------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
--                            Web API Definition                            --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2014-2016, Vadim Godunko <vgodunko@gmail.com>                --
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
with WebAPI.DOM.Event_Targets;

with WebAPI.HTML.Documents;

package WebAPI.HTML.Windows is

   pragma Preelaborate;

   type Window is limited interface
     and WebAPI.DOM.Event_Targets.Event_Target;

   type Window_Access is access all Window'Class
     with Storage_Size => 0;

   not overriding function Get_Document
    (Self : not null access Window)
      return WebAPI.HTML.Documents.Document_Access is abstract
        with Import     => True,
             Convention => JavaScript_Property_Getter,
             Link_Name  => "document";

   --  APIs for creating and navigating browsing contexts by name

   not overriding function Open
    (Self     : not null access WebAPI.HTML.Windows.Window;
     URL      : WebAPI.DOM_String;
     Name     : WebAPI.DOM_String;
     Features : WebAPI.DOM_String)
      return WebAPI.HTML.Windows.Window_Access is abstract
        with Import     => True,
              Convention => JavaScript_Method,
              Link_Name  => "open";
   --  Opens a window to show url (defaults to about:blank), and returns it.
   --  The target argument gives the name of the new window. If a window
   --  exists with that name already, it is reused. The features argument
   --  can be used to influence the rendering of the new window.

   not overriding function Get_Name
    (Self : not null access Window)
      return WebAPI.DOM_String is abstract
        with Import     => True,
             Convention => JavaScript_Property_Getter,
             Link_Name  => "name";
   --  Returns the name of the window. Can be set, to change the name.

   not overriding procedure Set_Name
    (Self  : not null access Window;
     Value : WebAPI.DOM_String) is abstract
        with Import     => True,
             Convention => JavaScript_Property_Setter,
             Link_Name  => "name";

   not overriding procedure Close
    (Self : not null access WebAPI.HTML.Windows.Window) is abstract
         with Import     => True,
              Convention => JavaScript_Method,
              Link_Name  => "close";
   --  Closes the window.

   not overriding function Get_Closed
    (Self : not null access Window)
      return WebAPI.DOM_Boolean is abstract
        with Import     => True,
             Convention => JavaScript_Property_Getter,
             Link_Name  => "closed";
   --  Returns true if the window has been closed, false otherwise.

   not overriding procedure Stop
    (Self : not null access WebAPI.HTML.Windows.Window) is abstract
         with Import     => True,
              Convention => JavaScript_Method,
              Link_Name  => "stop";
   --  Cancels the document load.

end WebAPI.HTML.Windows;
