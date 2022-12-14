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
--  This file is generated, don't edit it.
------------------------------------------------------------------------------
--  An abstraction is a relationship that relates two elements or sets of 
--  elements that represent the same concept at different levels of 
--  abstraction or from different viewpoints.
------------------------------------------------------------------------------
with AMF.UML.Dependencies;
limited with AMF.UML.Opaque_Expressions;

package AMF.UML.Abstractions is

   pragma Preelaborate;

   type UML_Abstraction is limited interface
     and AMF.UML.Dependencies.UML_Dependency;

   type UML_Abstraction_Access is
     access all UML_Abstraction'Class;
   for UML_Abstraction_Access'Storage_Size use 0;

   not overriding function Get_Mapping
    (Self : not null access constant UML_Abstraction)
       return AMF.UML.Opaque_Expressions.UML_Opaque_Expression_Access is abstract;
   --  Getter of Abstraction::mapping.
   --
   --  An composition of an Expression that states the abstraction 
   --  relationship between the supplier and the client. In some cases, such 
   --  as Derivation, it is usually formal and unidirectional; in other cases, 
   --  such as Trace, it is usually informal and bidirectional. The mapping 
   --  expression is optional and may be omitted if the precise relationship 
   --  between the elements is not specified.

   not overriding procedure Set_Mapping
    (Self : not null access UML_Abstraction;
     To   : AMF.UML.Opaque_Expressions.UML_Opaque_Expression_Access) is abstract;
   --  Setter of Abstraction::mapping.
   --
   --  An composition of an Expression that states the abstraction 
   --  relationship between the supplier and the client. In some cases, such 
   --  as Derivation, it is usually formal and unidirectional; in other cases, 
   --  such as Trace, it is usually informal and bidirectional. The mapping 
   --  expression is optional and may be omitted if the precise relationship 
   --  between the elements is not specified.

end AMF.UML.Abstractions;
