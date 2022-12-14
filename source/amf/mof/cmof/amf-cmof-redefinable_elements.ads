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
--  A redefinable element is an element that, when defined in the context of a 
--  classifier, can be redefined more specifically or differently in the 
--  context of another classifier that specializes (directly or indirectly) 
--  the context classifier.
------------------------------------------------------------------------------
limited with AMF.CMOF.Classifiers.Collections;
with AMF.CMOF.Named_Elements;
limited with AMF.CMOF.Redefinable_Elements.Collections;

package AMF.CMOF.Redefinable_Elements is

   pragma Preelaborate;

   type CMOF_Redefinable_Element is limited interface
     and AMF.CMOF.Named_Elements.CMOF_Named_Element;

   type CMOF_Redefinable_Element_Access is
     access all CMOF_Redefinable_Element'Class;
   for CMOF_Redefinable_Element_Access'Storage_Size use 0;

   not overriding function Get_Redefinition_Context
    (Self : not null access constant CMOF_Redefinable_Element)
       return AMF.CMOF.Classifiers.Collections.Set_Of_CMOF_Classifier is abstract;
   --  Getter of RedefinableElement::redefinitionContext.
   --
   --  References the contexts that this element may be redefined from.

   not overriding function Get_Redefined_Element
    (Self : not null access constant CMOF_Redefinable_Element)
       return AMF.CMOF.Redefinable_Elements.Collections.Set_Of_CMOF_Redefinable_Element is abstract;
   --  Getter of RedefinableElement::redefinedElement.
   --
   --  The redefinable element that is being redefined by this element.

   not overriding function Get_Is_Leaf
    (Self : not null access constant CMOF_Redefinable_Element)
       return Boolean is abstract;
   --  Getter of RedefinableElement::isLeaf.
   --
   --  Indicates whether it is possible to further redefine a 
   --  RedefinableElement. If the value is true, then it is not possible to 
   --  further redefine the RedefinableElement. Note that this property is 
   --  preserved through package merge operations; that is, the capability to 
   --  redefine a RedefinableElement (i.e., isLeaf=false) must be preserved in 
   --  the resulting RedefinableElement of a package merge operation where a 
   --  RedefinableElement with isLeaf=false is merged with a matching 
   --  RedefinableElement with isLeaf=true: the resulting RedefinableElement 
   --  will have isLeaf=false. Default value is false.

   not overriding procedure Set_Is_Leaf
    (Self : not null access CMOF_Redefinable_Element;
     To   : Boolean) is abstract;
   --  Setter of RedefinableElement::isLeaf.
   --
   --  Indicates whether it is possible to further redefine a 
   --  RedefinableElement. If the value is true, then it is not possible to 
   --  further redefine the RedefinableElement. Note that this property is 
   --  preserved through package merge operations; that is, the capability to 
   --  redefine a RedefinableElement (i.e., isLeaf=false) must be preserved in 
   --  the resulting RedefinableElement of a package merge operation where a 
   --  RedefinableElement with isLeaf=false is merged with a matching 
   --  RedefinableElement with isLeaf=true: the resulting RedefinableElement 
   --  will have isLeaf=false. Default value is false.

   not overriding function Is_Consistent_With
    (Self : not null access constant CMOF_Redefinable_Element;
     Redefinee : AMF.CMOF.Redefinable_Elements.CMOF_Redefinable_Element_Access)
       return Boolean is abstract;
   --  Operation RedefinableElement::isConsistentWith.
   --
   --  The query isConsistentWith() specifies, for any two RedefinableElements 
   --  in a context in which redefinition is possible, whether redefinition 
   --  would be logically consistent. By default, this is false; this 
   --  operation must be overridden for subclasses of RedefinableElement to 
   --  define the consistency conditions.

   not overriding function Is_Redefinition_Context_Valid
    (Self : not null access constant CMOF_Redefinable_Element;
     Redefined : AMF.CMOF.Redefinable_Elements.CMOF_Redefinable_Element_Access)
       return Boolean is abstract;
   --  Operation RedefinableElement::isRedefinitionContextValid.
   --
   --  The query isRedefinitionContextValid() specifies whether the 
   --  redefinition contexts of this RedefinableElement are properly related 
   --  to the redefinition contexts of the specified RedefinableElement to 
   --  allow this element to redefine the other. By default at least one of 
   --  the redefinition contexts of this element must be a specialization of 
   --  at least one of the redefinition contexts of the specified element.

end AMF.CMOF.Redefinable_Elements;
