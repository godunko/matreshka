------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Ada Modeling Framework                          --
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
--  This file is generated, don't edit it.
------------------------------------------------------------------------------
--  MarkedElement is a graphic element that can be decorated at its vertices 
--  with markers (e.g. arrowheads).
------------------------------------------------------------------------------
with AMF.DG.Graphical_Elements;
limited with AMF.DG.Markers;

package AMF.DG.Marked_Elements is

   pragma Preelaborate;

   type DG_Marked_Element is limited interface
     and AMF.DG.Graphical_Elements.DG_Graphical_Element;

   type DG_Marked_Element_Access is
     access all DG_Marked_Element'Class;
   for DG_Marked_Element_Access'Storage_Size use 0;

   not overriding function Get_Start_Marker
    (Self : not null access constant DG_Marked_Element)
       return AMF.DG.Markers.DG_Marker_Access is abstract;
   --  Getter of MarkedElement::startMarker.
   --
   --  an optional start marker that aligns with the first vertex of the 
   --  marked element.

   not overriding procedure Set_Start_Marker
    (Self : not null access DG_Marked_Element;
     To   : AMF.DG.Markers.DG_Marker_Access) is abstract;
   --  Setter of MarkedElement::startMarker.
   --
   --  an optional start marker that aligns with the first vertex of the 
   --  marked element.

   not overriding function Get_End_Marker
    (Self : not null access constant DG_Marked_Element)
       return AMF.DG.Markers.DG_Marker_Access is abstract;
   --  Getter of MarkedElement::endMarker.
   --
   --  an optional end marker that aligns with the last vertex of the marked 
   --  element.

   not overriding procedure Set_End_Marker
    (Self : not null access DG_Marked_Element;
     To   : AMF.DG.Markers.DG_Marker_Access) is abstract;
   --  Setter of MarkedElement::endMarker.
   --
   --  an optional end marker that aligns with the last vertex of the marked 
   --  element.

   not overriding function Get_Mid_Marker
    (Self : not null access constant DG_Marked_Element)
       return AMF.DG.Markers.DG_Marker_Access is abstract;
   --  Getter of MarkedElement::midMarker.
   --
   --  an optional mid marker that aligns with all vertices of the marked 
   --  element except the first and the last.

   not overriding procedure Set_Mid_Marker
    (Self : not null access DG_Marked_Element;
     To   : AMF.DG.Markers.DG_Marker_Access) is abstract;
   --  Setter of MarkedElement::midMarker.
   --
   --  an optional mid marker that aligns with all vertices of the marked 
   --  element except the first and the last.

end AMF.DG.Marked_Elements;
