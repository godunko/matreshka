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
-- Copyright © 2011, Vadim Godunko <vgodunko@gmail.com>                     --
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
--  An association describes a set of tuples whose values refer to typed 
--  instances. An instance of an association is called a link.A link is a 
--  tuple with one value for each end of the association, where each value is 
--  an instance of the type of the end.
--  An association describes a set of tuples whose values refer to typed 
--  instances. An instance of an association is called a link. A link is a 
--  tuple with one value for each end of the association, where each value is 
--  an instance of the type of the end.
------------------------------------------------------------------------------
with AMF.UML.Classifiers;
limited with AMF.UML.Properties;
with AMF.UML.Relationships;
limited with AMF.UML.Types;

package AMF.UML.Associations is

   pragma Preelaborate;

   type UML_Association_Interface is limited interface
     and AMF.UML.Relationships.UML_Relationship_Interface
     and AMF.UML.Classifiers.UML_Classifier_Interface;

   type UML_Association is
     access all UML_Association_Interface'Class;

   type Set_Of_UML_Association is null record;
   type Ordered_Set_Of_UML_Association is null record;

   not overriding function Get_End_Type
    (Self : not null access constant UML_Association_Interface)
       return AMF.UML.Types.Ordered_Set_Of_UML_Type is abstract;
   --  References the classifiers that are used as types of the ends of the 
   --  association.

   not overriding function Get_Is_Derived
    (Self : not null access constant UML_Association_Interface)
       return Boolean is abstract;
   --  Specifies whether the association is derived from other model elements 
   --  such as other associations or constraints.

   not overriding procedure Set_Is_Derived
    (Self : not null access UML_Association_Interface;
     To   : Boolean) is abstract;

   not overriding function Get_Member_End
    (Self : not null access constant UML_Association_Interface)
       return AMF.UML.Properties.Ordered_Set_Of_UML_Property is abstract;
   --  Each end represents participation of instances of the classifier 
   --  connected to the end in links of the association.

   not overriding function Get_Navigable_Owned_End
    (Self : not null access constant UML_Association_Interface)
       return AMF.UML.Properties.Set_Of_UML_Property is abstract;
   --  The navigable ends that are owned by the association itself.

   not overriding function Get_Owned_End
    (Self : not null access constant UML_Association_Interface)
       return AMF.UML.Properties.Ordered_Set_Of_UML_Property is abstract;
   --  The ends that are owned by the association itself.

end AMF.UML.Associations;
