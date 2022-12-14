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
-- Copyright © 2011-2012, Vadim Godunko <vgodunko@gmail.com>                --
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
with League.Holders;

with AMF.CMOF.Associations;
with AMF.CMOF.Properties;
with AMF.Elements;
with AMF.Extents;

package AMF.Listeners is

   pragma Preelaborate;

   type Abstract_Listener is limited interface;

   type Listener_Access is access all Abstract_Listener'Class;

   not overriding procedure Facility_Start
    (Self : not null access Abstract_Listener) is null;

   not overriding procedure Facility_Shutdown
    (Self : not null access Abstract_Listener) is null;

   not overriding procedure Transaction_Start
    (Self : not null access Abstract_Listener) is null;

   not overriding procedure Transaction_Commit
    (Self : not null access Abstract_Listener) is null;

   not overriding procedure Transaction_Rollback
    (Self : not null access Abstract_Listener) is null;

   not overriding procedure Extent_Create
    (Self   : not null access Abstract_Listener;
     Extent : not null AMF.Extents.Extent_Access) is null;

   not overriding procedure Extent_Remove
    (Self   : not null access Abstract_Listener;
     Extent : not null AMF.Extents.Extent_Access) is null;

   not overriding procedure Instance_Create
    (Self    : not null access Abstract_Listener;
     Element : not null AMF.Elements.Element_Access) is null;

   not overriding procedure Instance_Remove
    (Self    : not null access Abstract_Listener;
     Element : not null AMF.Elements.Element_Access) is null;

   not overriding procedure Attribute_Add
    (Self      : not null access Abstract_Listener;
     Property  : not null AMF.CMOF.Properties.CMOF_Property_Access;
     Position  : AMF.Optional_Integer;
     Old_Value : League.Holders.Holder;
     New_Value : League.Holders.Holder) is null;

   not overriding procedure Attribute_Remove
    (Self      : not null access Abstract_Listener;
     Property  : not null AMF.CMOF.Properties.CMOF_Property_Access;
     Position  : AMF.Optional_Integer;
     Old_Value : League.Holders.Holder;
     New_Value : League.Holders.Holder) is null;

   not overriding procedure Attribute_Set
    (Self      : not null access Abstract_Listener;
     Element   : not null AMF.Elements.Element_Access;
     Property  : not null AMF.CMOF.Properties.CMOF_Property_Access;
     Position  : AMF.Optional_Integer;
     Old_Value : League.Holders.Holder;
     New_Value : League.Holders.Holder) is null;
   --  Called when attribute value is changed.

   not overriding procedure Link_Add
    (Self           : not null access Abstract_Listener;
     Association    : not null AMF.CMOF.Associations.CMOF_Association_Access;
     First_Element  : not null AMF.Elements.Element_Access;
     Second_Element : not null AMF.Elements.Element_Access) is null;
   --  Called when link between two elements is created.

   not overriding procedure Link_Remove
    (Self : not null access Abstract_Listener) is null;

   procedure Register_Listener (Listener : not null Listener_Access);

   procedure Register_Instance_Listener
    (Listener : not null Listener_Access;
     Instance : not null AMF.Elements.Element_Access);

end AMF.Listeners;
