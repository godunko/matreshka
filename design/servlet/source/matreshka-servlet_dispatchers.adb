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

package body Matreshka.Servlet_Dispatchers is

   --------------
   -- Dispatch --
   --------------

   overriding function Dispatch
    (Self  : not null access constant Segment_Dispatcher;
     Path  : League.String_Vectors.Universal_String_Vector;
     Index : Positive)
       return Matreshka.Servlet_Registrations.Servlet_Registration_Access is
   begin
      if Path.Length < Index then
         --  Looked path is exactly what this (simple) dispatcher handles.
         --  Request for this path should be processed in another way by one of
         --  parent dispatchers.

         return null;
      end if;

      declare
         Position : constant Dispatcher_Maps.Cursor
           := Self.Children.Find (Path (Index));

      begin
         if Dispatcher_Maps.Has_Element (Position) then
            return
              Dispatcher_Maps.Element (Position).Dispatch (Path, Index + 1);
         end if;
      end;

      return null;
   end Dispatch;

   --------------
   -- Dispatch --
   --------------

   overriding function Dispatch
    (Self  : not null access constant Servlet_Dispatcher;
     Path  : League.String_Vectors.Universal_String_Vector;
     Index : Positive)
       return Matreshka.Servlet_Registrations.Servlet_Registration_Access
   is
      use type Matreshka.Servlet_Registrations.Servlet_Registration_Access;

      Aux : Matreshka.Servlet_Registrations.Servlet_Registration_Access;

   begin
      if Path.Length < Index then
         --  Exact match, use exact match servlet when available.

         return Self.Exact_Servlet;
      end if;

      --  Call inherited subprogram to lookup exact servlet or longest
      --  path-prefix.

      Aux := Segment_Dispatcher (Self.all).Dispatch (Path, Index);

      if Aux /= null then
         --  Exact or longest path-prefix servlet was found, return it.

         return Aux;
      end if;

      --  Use path mapping servlet when available for current path-prefix.

      return Self.Mapping_Servlet;
   end Dispatch;

end Matreshka.Servlet_Dispatchers;
