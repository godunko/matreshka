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
--  An opaque expression is an uninterpreted textual statement that denotes a 
--  (possibly empty) set of values when evaluated in a context.
------------------------------------------------------------------------------
with AMF.CMOF.Value_Specifications;
with AMF.String_Collections;

package AMF.CMOF.Opaque_Expressions is

   pragma Preelaborate;

   type CMOF_Opaque_Expression is limited interface
     and AMF.CMOF.Value_Specifications.CMOF_Value_Specification;

   type CMOF_Opaque_Expression_Access is
     access all CMOF_Opaque_Expression'Class;
   for CMOF_Opaque_Expression_Access'Storage_Size use 0;

   not overriding function Get_Body
    (Self : not null access constant CMOF_Opaque_Expression)
       return AMF.String_Collections.Sequence_Of_String is abstract;
   --  Getter of OpaqueExpression::body.
   --
   --  The text of the expression, possibly in multiple languages.

   not overriding function Get_Language
    (Self : not null access constant CMOF_Opaque_Expression)
       return AMF.String_Collections.Ordered_Set_Of_String is abstract;
   --  Getter of OpaqueExpression::language.
   --
   --  Specifies the languages in which the expression is stated. The 
   --  interpretation of the expression body depends on the languages. If the 
   --  languages are unspecified, they might be implicit from the expression 
   --  body or the context. Languages are matched to body strings by order.

end AMF.CMOF.Opaque_Expressions;
