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
with AMF.CMOF.Elements;
with AMF.DI.Styles;
with AMF.Internals.UMLDI_UML_Compartmentable_Shapes;
with AMF.UML.Classifiers;
with AMF.UML.Elements.Collections;
with AMF.UMLDI.UML_Classifier_Shapes;
with AMF.UMLDI.UML_Compartments.Collections;
with AMF.UMLDI.UML_Styles;
with AMF.Visitors;

package AMF.Internals.UMLDI_UML_Classifier_Shapes is

   type UMLDI_UML_Classifier_Shape_Proxy is
     limited new AMF.Internals.UMLDI_UML_Compartmentable_Shapes.UMLDI_UML_Compartmentable_Shape_Proxy
       and AMF.UMLDI.UML_Classifier_Shapes.UMLDI_UML_Classifier_Shape with null record;

   overriding function Get_Is_Double_Sided
    (Self : not null access constant UMLDI_UML_Classifier_Shape_Proxy)
       return Boolean;
   --  Getter of UMLClassifierShape::isDoubleSided.
   --
   --  For modelElements that are Classes with true as a value for isActive 
   --  that are shown as rectangles, indicates whether the vertical sides 
   --  shall be rendered as double lines.

   overriding procedure Set_Is_Double_Sided
    (Self : not null access UMLDI_UML_Classifier_Shape_Proxy;
     To   : Boolean);
   --  Setter of UMLClassifierShape::isDoubleSided.
   --
   --  For modelElements that are Classes with true as a value for isActive 
   --  that are shown as rectangles, indicates whether the vertical sides 
   --  shall be rendered as double lines.

   overriding function Get_Is_Indent_For_Visibility
    (Self : not null access constant UMLDI_UML_Classifier_Shape_Proxy)
       return Boolean;
   --  Getter of UMLClassifierShape::isIndentForVisibility.
   --
   --  For modelElements that are shown with feature compartments, indicates 
   --  whether features are shown indented under visibility headings.

   overriding procedure Set_Is_Indent_For_Visibility
    (Self : not null access UMLDI_UML_Classifier_Shape_Proxy;
     To   : Boolean);
   --  Setter of UMLClassifierShape::isIndentForVisibility.
   --
   --  For modelElements that are shown with feature compartments, indicates 
   --  whether features are shown indented under visibility headings.

   overriding function Get_Model_Element
    (Self : not null access constant UMLDI_UML_Classifier_Shape_Proxy)
       return AMF.UML.Classifiers.UML_Classifier_Access;
   --  Getter of UMLClassifierShape::modelElement.
   --
   --  Restricts UMLClassifierShapes to showing exactly one Classifier.

   overriding procedure Set_Model_Element
    (Self : not null access UMLDI_UML_Classifier_Shape_Proxy;
     To   : AMF.UML.Classifiers.UML_Classifier_Access);
   --  Setter of UMLClassifierShape::modelElement.
   --
   --  Restricts UMLClassifierShapes to showing exactly one Classifier.

   overriding function Get_Compartment
    (Self : not null access constant UMLDI_UML_Classifier_Shape_Proxy)
       return AMF.UMLDI.UML_Compartments.Collections.Ordered_Set_Of_UMLDI_UML_Compartment;
   --  Getter of UMLCompartmentableShape::compartment.
   --
   --  Separated portions of the shape.

   overriding function Get_Is_Icon
    (Self : not null access constant UMLDI_UML_Classifier_Shape_Proxy)
       return Boolean;
   --  Getter of UMLDiagramElement::isIcon.
   --
   --  For modelElements that have an option to be shown with shapes other 
   --  than rectangles, such as Actors, or with other identifying shapes 
   --  inside them, such as arrows distinguishing InputPins and OutputPins, or 
   --  edges that have an option to be shown with lines other than solid with 
   --  open arrow heads, such as Realization.  A value of true for isIcon 
   --  indicates the alternative notation shall be shown.

   overriding procedure Set_Is_Icon
    (Self : not null access UMLDI_UML_Classifier_Shape_Proxy;
     To   : Boolean);
   --  Setter of UMLDiagramElement::isIcon.
   --
   --  For modelElements that have an option to be shown with shapes other 
   --  than rectangles, such as Actors, or with other identifying shapes 
   --  inside them, such as arrows distinguishing InputPins and OutputPins, or 
   --  edges that have an option to be shown with lines other than solid with 
   --  open arrow heads, such as Realization.  A value of true for isIcon 
   --  indicates the alternative notation shall be shown.

   overriding function Get_Local_Style
    (Self : not null access constant UMLDI_UML_Classifier_Shape_Proxy)
       return AMF.UMLDI.UML_Styles.UMLDI_UML_Style_Access;
   --  Getter of UMLDiagramElement::localStyle.
   --
   --  Restricts owned styles to UMLStyles.

   overriding procedure Set_Local_Style
    (Self : not null access UMLDI_UML_Classifier_Shape_Proxy;
     To   : AMF.UMLDI.UML_Styles.UMLDI_UML_Style_Access);
   --  Setter of UMLDiagramElement::localStyle.
   --
   --  Restricts owned styles to UMLStyles.

   overriding function Get_Model_Element
    (Self : not null access constant UMLDI_UML_Classifier_Shape_Proxy)
       return AMF.UML.Elements.Collections.Set_Of_UML_Element;
   --  Getter of UMLDiagramElement::modelElement.
   --
   --  Restricts UMLDiagramElements to show UML Elements, rather than other 
   --  language elements. 

   overriding function Get_Model_Element
    (Self : not null access constant UMLDI_UML_Classifier_Shape_Proxy)
       return AMF.CMOF.Elements.CMOF_Element_Access;
   --  Getter of DiagramElement::modelElement.
   --
   --  a reference to a depicted model element, which can be any MOF-based 
   --  element

   overriding function Get_Local_Style
    (Self : not null access constant UMLDI_UML_Classifier_Shape_Proxy)
       return AMF.DI.Styles.DI_Style_Access;
   --  Getter of DiagramElement::localStyle.
   --
   --  a reference to an optional locally-owned style for this diagram element.

   overriding procedure Set_Local_Style
    (Self : not null access UMLDI_UML_Classifier_Shape_Proxy;
     To   : AMF.DI.Styles.DI_Style_Access);
   --  Setter of DiagramElement::localStyle.
   --
   --  a reference to an optional locally-owned style for this diagram element.

   overriding procedure Enter_Element
    (Self    : not null access constant UMLDI_UML_Classifier_Shape_Proxy;
     Visitor : in out AMF.Visitors.Abstract_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control);

   overriding procedure Leave_Element
    (Self    : not null access constant UMLDI_UML_Classifier_Shape_Proxy;
     Visitor : in out AMF.Visitors.Abstract_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control);

   overriding procedure Visit_Element
    (Self     : not null access constant UMLDI_UML_Classifier_Shape_Proxy;
     Iterator : in out AMF.Visitors.Abstract_Iterator'Class;
     Visitor  : in out AMF.Visitors.Abstract_Visitor'Class;
     Control  : in out AMF.Visitors.Traverse_Control);

end AMF.Internals.UMLDI_UML_Classifier_Shapes;
