------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               XML Processor                              --
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
with XML.Schema.Annotations;
with XML.Schema.Objects.Particles;

package XML.Schema.Objects.Type_Definitions.Complex_Type_Definitions is

   pragma Preelaborate;

   type Content_Types is
     (Empty,
      --  Represents an empty content type. A content type with the
      --  distinguished value empty validates elements with no character or
      --  element information item children.
      Simple,
      --  Represents a simple content type. A content type which is simple
      --  validates elements with character-only children.
      Element_Only,
      --  Represents an element-only content type. An element-only content type
      --  validates elements with children that conform to the supplied content
      --  model.
      Mixed);
      --  Represents a mixed content type.

   type XS_Complex_Type_Definition is new XS_Type_Definition with private;

   Null_XS_Complex_Type_Definition : constant XS_Complex_Type_Definition;

   function Get_Abstract
    (Self : XS_Complex_Type_Definition'Class) return Boolean;
   --  {abstract} A boolean. Complex types for which abstract is true must not
   --  be used as the type definition for the validation of element information
   --  items.

   function Get_Annotation
    (Self : XS_Complex_Type_Definition'Class)
       return XML.Schema.Annotations.XS_Annotation;
   --  An annotation if it exists, otherwise null.

   function Get_Content_Type
    (Self : XS_Complex_Type_Definition'Class)
       return Content_Types;
   --  content type: one of empty (Empty), a simple type definition (Simple),
   --  mixed (Mixed), or element-only (Element_Only).

   function Get_Particle
    (Self : XS_Complex_Type_Definition'Class)
       return XML.Schema.Objects.Particles.XS_Particle;
   --  particle of type XSParticle, readonly
   --  A particle for a mixed or element-only content model, otherwise null.

private

   type XS_Complex_Type_Definition is
     new XS_Type_Definition with null record;

   Null_XS_Complex_Type_Definition : constant XS_Complex_Type_Definition
     := (Ada.Finalization.Controlled with Node => null);

end XML.Schema.Objects.Type_Definitions.Complex_Type_Definitions;
