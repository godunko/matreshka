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
with AMF.Internals.UML_Named_Elements;
with AMF.UML.Connectors;
with AMF.UML.Dependencies.Collections;
with AMF.UML.Interactions;
with AMF.UML.Message_Ends;
with AMF.UML.Messages;
with AMF.UML.Named_Elements;
with AMF.UML.Namespaces;
with AMF.UML.Packages.Collections;
with AMF.UML.String_Expressions;
with AMF.UML.Value_Specifications.Collections;
with AMF.Visitors;

package AMF.Internals.UML_Messages is

   type UML_Message_Proxy is
     limited new AMF.Internals.UML_Named_Elements.UML_Named_Element_Proxy
       and AMF.UML.Messages.UML_Message with null record;

   overriding function Get_Argument
    (Self : not null access constant UML_Message_Proxy)
       return AMF.UML.Value_Specifications.Collections.Ordered_Set_Of_UML_Value_Specification;
   --  Getter of Message::argument.
   --
   --  The arguments of the Message

   overriding function Get_Connector
    (Self : not null access constant UML_Message_Proxy)
       return AMF.UML.Connectors.UML_Connector_Access;
   --  Getter of Message::connector.
   --
   --  The Connector on which this Message is sent.

   overriding procedure Set_Connector
    (Self : not null access UML_Message_Proxy;
     To   : AMF.UML.Connectors.UML_Connector_Access);
   --  Setter of Message::connector.
   --
   --  The Connector on which this Message is sent.

   overriding function Get_Interaction
    (Self : not null access constant UML_Message_Proxy)
       return AMF.UML.Interactions.UML_Interaction_Access;
   --  Getter of Message::interaction.
   --
   --  The enclosing Interaction owning the Message

   overriding procedure Set_Interaction
    (Self : not null access UML_Message_Proxy;
     To   : AMF.UML.Interactions.UML_Interaction_Access);
   --  Setter of Message::interaction.
   --
   --  The enclosing Interaction owning the Message

   overriding function Get_Message_Kind
    (Self : not null access constant UML_Message_Proxy)
       return AMF.UML.UML_Message_Kind;
   --  Getter of Message::messageKind.
   --
   --  The derived kind of the Message (complete, lost, found or unknown)

   overriding function Get_Message_Sort
    (Self : not null access constant UML_Message_Proxy)
       return AMF.UML.UML_Message_Sort;
   --  Getter of Message::messageSort.
   --
   --  The sort of communication reflected by the Message

   overriding procedure Set_Message_Sort
    (Self : not null access UML_Message_Proxy;
     To   : AMF.UML.UML_Message_Sort);
   --  Setter of Message::messageSort.
   --
   --  The sort of communication reflected by the Message

   overriding function Get_Receive_Event
    (Self : not null access constant UML_Message_Proxy)
       return AMF.UML.Message_Ends.UML_Message_End_Access;
   --  Getter of Message::receiveEvent.
   --
   --  References the Receiving of the Message

   overriding procedure Set_Receive_Event
    (Self : not null access UML_Message_Proxy;
     To   : AMF.UML.Message_Ends.UML_Message_End_Access);
   --  Setter of Message::receiveEvent.
   --
   --  References the Receiving of the Message

   overriding function Get_Send_Event
    (Self : not null access constant UML_Message_Proxy)
       return AMF.UML.Message_Ends.UML_Message_End_Access;
   --  Getter of Message::sendEvent.
   --
   --  References the Sending of the Message.

   overriding procedure Set_Send_Event
    (Self : not null access UML_Message_Proxy;
     To   : AMF.UML.Message_Ends.UML_Message_End_Access);
   --  Setter of Message::sendEvent.
   --
   --  References the Sending of the Message.

   overriding function Get_Signature
    (Self : not null access constant UML_Message_Proxy)
       return AMF.UML.Named_Elements.UML_Named_Element_Access;
   --  Getter of Message::signature.
   --
   --  The signature of the Message is the specification of its content. It
   --  refers either an Operation or a Signal.

   overriding procedure Set_Signature
    (Self : not null access UML_Message_Proxy;
     To   : AMF.UML.Named_Elements.UML_Named_Element_Access);
   --  Setter of Message::signature.
   --
   --  The signature of the Message is the specification of its content. It
   --  refers either an Operation or a Signal.

   overriding function Get_Client_Dependency
    (Self : not null access constant UML_Message_Proxy)
       return AMF.UML.Dependencies.Collections.Set_Of_UML_Dependency;
   --  Getter of NamedElement::clientDependency.
   --
   --  Indicates the dependencies that reference the client.

   overriding function Get_Name_Expression
    (Self : not null access constant UML_Message_Proxy)
       return AMF.UML.String_Expressions.UML_String_Expression_Access;
   --  Getter of NamedElement::nameExpression.
   --
   --  The string expression used to define the name of this named element.

   overriding procedure Set_Name_Expression
    (Self : not null access UML_Message_Proxy;
     To   : AMF.UML.String_Expressions.UML_String_Expression_Access);
   --  Setter of NamedElement::nameExpression.
   --
   --  The string expression used to define the name of this named element.

   overriding function Get_Namespace
    (Self : not null access constant UML_Message_Proxy)
       return AMF.UML.Namespaces.UML_Namespace_Access;
   --  Getter of NamedElement::namespace.
   --
   --  Specifies the namespace that owns the NamedElement.

   overriding function Get_Qualified_Name
    (Self : not null access constant UML_Message_Proxy)
       return AMF.Optional_String;
   --  Getter of NamedElement::qualifiedName.
   --
   --  A name which allows the NamedElement to be identified within a
   --  hierarchy of nested Namespaces. It is constructed from the names of the
   --  containing namespaces starting at the root of the hierarchy and ending
   --  with the name of the NamedElement itself.

   overriding function Message_Kind
    (Self : not null access constant UML_Message_Proxy)
       return AMF.UML.UML_Message_Kind;
   --  Operation Message::messageKind.
   --
   --  Missing derivation for Message::/messageKind : MessageKind

   overriding function All_Owning_Packages
    (Self : not null access constant UML_Message_Proxy)
       return AMF.UML.Packages.Collections.Set_Of_UML_Package;
   --  Operation NamedElement::allOwningPackages.
   --
   --  The query allOwningPackages() returns all the directly or indirectly
   --  owning packages.

   overriding function Is_Distinguishable_From
    (Self : not null access constant UML_Message_Proxy;
     N : AMF.UML.Named_Elements.UML_Named_Element_Access;
     Ns : AMF.UML.Namespaces.UML_Namespace_Access)
       return Boolean;
   --  Operation NamedElement::isDistinguishableFrom.
   --
   --  The query isDistinguishableFrom() determines whether two NamedElements
   --  may logically co-exist within a Namespace. By default, two named
   --  elements are distinguishable if (a) they have unrelated types or (b)
   --  they have related types but different names.

   overriding function Namespace
    (Self : not null access constant UML_Message_Proxy)
       return AMF.UML.Namespaces.UML_Namespace_Access;
   --  Operation NamedElement::namespace.
   --
   --  Missing derivation for NamedElement::/namespace : Namespace

   overriding procedure Enter_Element
    (Self    : not null access constant UML_Message_Proxy;
     Visitor : in out AMF.Visitors.Abstract_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Leave_Element
    (Self    : not null access constant UML_Message_Proxy;
     Visitor : in out AMF.Visitors.Abstract_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Visit_Element
    (Self     : not null access constant UML_Message_Proxy;
     Iterator : in out AMF.Visitors.Abstract_Iterator'Class;
     Visitor  : in out AMF.Visitors.Abstract_Visitor'Class;
     Control  : in out AMF.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of iterator interface.

end AMF.Internals.UML_Messages;
