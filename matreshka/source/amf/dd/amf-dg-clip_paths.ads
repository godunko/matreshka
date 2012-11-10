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
--  ClipPath is a kind of group whose members collectively define a painting 
--  mask for its referencing graphical elements.
------------------------------------------------------------------------------
limited with AMF.DG.Graphical_Elements;
with AMF.DG.Groups;

package AMF.DG.Clip_Paths is

   pragma Preelaborate;

   type DG_Clip_Path is limited interface
     and AMF.DG.Groups.DG_Group;

   type DG_Clip_Path_Access is
     access all DG_Clip_Path'Class;
   for DG_Clip_Path_Access'Storage_Size use 0;

   not overriding function Get_Clipped_Element
    (Self : not null access constant DG_Clip_Path)
       return AMF.DG.Graphical_Elements.DG_Graphical_Element_Access is abstract;
   --  Getter of ClipPath::clippedElement.
   --
   --  a reference to the owning element that is clipped by this clip path.

   not overriding procedure Set_Clipped_Element
    (Self : not null access DG_Clip_Path;
     To   : AMF.DG.Graphical_Elements.DG_Graphical_Element_Access) is abstract;
   --  Setter of ClipPath::clippedElement.
   --
   --  a reference to the owning element that is clipped by this clip path.

end AMF.DG.Clip_Paths;
