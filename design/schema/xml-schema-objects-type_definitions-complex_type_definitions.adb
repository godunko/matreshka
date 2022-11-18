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
-- Copyright © 2012-2014, Vadim Godunko <vgodunko@gmail.com>                --
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
with Matreshka.XML_Schema.AST.Complex_Types;
with XML.Schema.Object_Lists.Internals;
with XML.Schema.Objects.Particles.Internals;

package body XML.Schema.Objects.Type_Definitions.Complex_Type_Definitions is

   use type Matreshka.XML_Schema.AST.Complex_Type_Definition_Access;

   ------------------
   -- Get_Abstract --
   ------------------

   function Get_Abstract
     (Self : XS_Complex_Type_Definition'Class)
      return Boolean
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Abstract unimplemented");
      raise Program_Error with "Unimplemented function Get_Abstract";
      return Get_Abstract (Self);
   end Get_Abstract;

   --------------------
   -- Get_Annotation --
   --------------------

   function Get_Annotation
     (Self : XS_Complex_Type_Definition'Class)
      return XML.Schema.Annotations.XS_Annotation
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Annotation unimplemented");
      raise Program_Error with "Unimplemented function Get_Annotation";
      return Get_Annotation (Self);
   end Get_Annotation;

   ------------------------
   -- Get_Attribute_Uses --
   ------------------------

   function Get_Attribute_Uses
    (Self : XS_Complex_Type_Definition'Class)
       return XML.Schema.Object_Lists.XS_Object_List
   is
      Node : constant Matreshka.XML_Schema.AST.Complex_Type_Definition_Access
        := Matreshka.XML_Schema.AST.Complex_Type_Definition_Access (Self.Node);

   begin
      if Node = null then
         return XML.Schema.Object_Lists.Empty_XS_Object_List;

      else
         return
           XML.Schema.Object_Lists.Internals.Create
            (Node.Attribute_Uses'Access);
      end if;
   end Get_Attribute_Uses;

   ----------------------
   -- Get_Content_Type --
   ----------------------

   function Get_Content_Type
     (Self : XS_Complex_Type_Definition'Class) return Content_Types
   is
      package T renames Matreshka.XML_Schema.AST.Complex_Types;

      Convert : constant array (T.Content_Type_Variety) of Content_Types
        := (T.Empty        => Empty,
            T.Simple       => Simple,
            T.Element_Only => Element_Only,
            T.Mixed        => Mixed);

      Node : constant Matreshka.XML_Schema.AST.Complex_Type_Definition_Access
        := Matreshka.XML_Schema.AST.Complex_Type_Definition_Access (Self.Node);

   begin
      if Node = null then
         return Empty;

      else
         return Convert (Node.Content_Type.Variety);
      end if;
   end Get_Content_Type;

   ------------------
   -- Get_Particle --
   ------------------

   function Get_Particle
    (Self : XS_Complex_Type_Definition'Class)
       return XML.Schema.Objects.Particles.XS_Particle
   is
      Node : constant Matreshka.XML_Schema.AST.Complex_Type_Definition_Access
        := Matreshka.XML_Schema.AST.Complex_Type_Definition_Access (Self.Node);

   begin
      if Node = null then
         return XML.Schema.Objects.Particles.Null_XS_Particle;

      else
         return XML.Schema.Objects.Particles.Internals.Create
            (Node.Content_Type.Particle);
      end if;
   end Get_Particle;

end XML.Schema.Objects.Type_Definitions.Complex_Type_Definitions;
