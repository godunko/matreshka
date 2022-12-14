------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Ada Modeling Framework                          --
--                                                                          --
--                              Tools Component                             --
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
private with Ada.Containers.Hashed_Maps;
private with Ada.Containers.Vectors;

with Qt4.Abstract_Item_Models;
private with Qt4.Abstract_Item_Models.Directors;
private with Qt4.Model_Indices;
with Qt4.Objects;
private with Qt4.Variants;

private with AMF.CMOF.Associations;
with AMF.Listeners;
private with AMF.Elements.Hash;
private with AMF.Extents.Hash;

package Modeler.Containment_Tree_Models is

   type Containment_Tree_Model is
     limited new Qt4.Abstract_Item_Models.Q_Abstract_Item_Model
       and AMF.Listeners.Abstract_Listener with private;

   type Containment_Tree_Model_Access is
     access all Containment_Tree_Model'Class;

   package Constructors is

      function Create
       (Parent : access Qt4.Objects.Q_Object'Class := null)
          return not null Containment_Tree_Model_Access;

   end Constructors;

private

   type Node_Kinds is (N_Root, N_Extent, N_Element);

   type Node;
   type Node_Access is access all Node;

   package Node_Vectors is new Ada.Containers.Vectors (Natural, Node_Access);

   package Extent_Node_Maps is
     new Ada.Containers.Hashed_Maps
          (AMF.Extents.Extent_Access,
           Node_Access,
           AMF.Extents.Hash,
           AMF.Extents."=");

   package Element_Node_Maps is
     new Ada.Containers.Hashed_Maps
          (AMF.Elements.Element_Access,
           Node_Access,
           AMF.Elements.Hash,
           AMF.Elements."=");

   type Node (Kind : Node_Kinds) is record
      Parent   : Node_Access;
      Children : Node_Vectors.Vector;

      case Kind is
         when N_Root =>
            null;

         when N_Extent =>
            Extent : AMF.Extents.Extent_Access;

         when N_Element =>
            Element : AMF.Elements.Element_Access;
      end case;
   end record;

   type Containment_Tree_Model is limited
     new Qt4.Abstract_Item_Models.Directors.Q_Abstract_Item_Model_Director
       and AMF.Listeners.Abstract_Listener with
   record
      Root     : Node_Access;
      Extents  : Extent_Node_Maps.Map;
      Elements : Element_Node_Maps.Map;
   end record;

   ----------------------------------------------------
   -- Overrided subprograms of Q_Abstract_Item_Model --
   ----------------------------------------------------

   overriding function Column_Count
    (Self   : not null access constant Containment_Tree_Model;
     Parent : Qt4.Model_Indices.Q_Model_Index) return Qt4.Q_Integer;

   overriding function Data
    (Self  : not null access Containment_Tree_Model;
     Index : Qt4.Model_Indices.Q_Model_Index;
     Role  : Qt4.Item_Data_Role) return Qt4.Variants.Q_Variant;

   overriding function Header_Data
    (Self        : not null access Containment_Tree_Model;
     Section     : Qt4.Q_Integer;
     Orientation : Qt4.Orientations;
     Role        : Qt4.Item_Data_Role) return Qt4.Variants.Q_Variant;

   overriding function Index
    (Self   : not null access constant Containment_Tree_Model;
     Row    : Qt4.Q_Integer;
     Column : Qt4.Q_Integer;
     Parent : Qt4.Model_Indices.Q_Model_Index)
       return Qt4.Model_Indices.Q_Model_Index;

   overriding function Parent
    (Self  : not null access constant Containment_Tree_Model;
     Child : Qt4.Model_Indices.Q_Model_Index)
       return Qt4.Model_Indices.Q_Model_Index;

   overriding function Row_Count
    (Self   : not null access constant Containment_Tree_Model;
     Parent : Qt4.Model_Indices.Q_Model_Index) return Qt4.Q_Integer;

   ------------------------------------------------
   -- Overrided subprograms of Abstract_Listener --
   ------------------------------------------------

   overriding procedure Extent_Create
    (Self   : not null access Containment_Tree_Model;
     Extent : not null AMF.Extents.Extent_Access);

   overriding procedure Extent_Remove
    (Self   : not null access Containment_Tree_Model;
     Extent : not null AMF.Extents.Extent_Access);

   overriding procedure Instance_Create
    (Self    : not null access Containment_Tree_Model;
     Element : not null AMF.Elements.Element_Access);

   overriding procedure Instance_Remove
    (Self    : not null access Containment_Tree_Model;
     Element : not null AMF.Elements.Element_Access);

   overriding procedure Link_Add
    (Self           : not null access Containment_Tree_Model;
     Association    : not null AMF.CMOF.Associations.CMOF_Association_Access;
     First_Element  : not null AMF.Elements.Element_Access;
     Second_Element : not null AMF.Elements.Element_Access);

   overriding procedure Link_Remove
    (Self : not null access Containment_Tree_Model);

end Modeler.Containment_Tree_Models;
