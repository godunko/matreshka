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
with Matreshka.XML_Schema.AST.Model_Groups;
with XML.Schema.Object_Lists.Internals;

package body XML.Schema.Objects.Terms.Model_Groups is

   function "+"
    (Self : Matreshka.XML_Schema.AST.Object_Access)
      return Matreshka.XML_Schema.AST.Model_Group_Access;

   ---------
   -- "+" --
   ---------

   function "+"
    (Self : Matreshka.XML_Schema.AST.Object_Access)
      return Matreshka.XML_Schema.AST.Model_Group_Access is
   begin
      return Matreshka.XML_Schema.AST.Model_Group_Access (Self);
   end "+";

   --------------------
   -- Get_Annotation --
   --------------------

   function Get_Annotation
    (Self : XS_Model_Group'Class)
       return XML.Schema.Annotations.XS_Annotation is
   begin
      raise Program_Error;
      return X : XML.Schema.Annotations.XS_Annotation;
   end Get_Annotation;

   --------------------
   -- Get_Compositor --
   --------------------

   function Get_Compositor
    (Self : XS_Model_Group'Class)
       return Compositor_Kinds
   is
      use type Matreshka.XML_Schema.AST.Model_Group_Access;

      package M renames Matreshka.XML_Schema.AST.Model_Groups;

      Convert : constant array (M.Compositor_Kind) of Compositor_Kinds
        := (M.Sequence => Compositor_Sequence,
            M.Choice   => Compositor_Choice,
            M.Al1      => Compositor_All);

      Node : constant Matreshka.XML_Schema.AST.Model_Group_Access
        := +Self.Node;
   begin
      if Node = null then
         return Compositor_Kinds'First;
      else
         return Convert (Node.Compositor);
      end if;
   end Get_Compositor;

   -------------------
   -- Get_Particles --
   -------------------

   function Get_Particles
    (Self : XS_Model_Group'Class)
       return XML.Schema.Object_Lists.XS_Object_List
   is
      use type Matreshka.XML_Schema.AST.Model_Group_Access;

      Node : constant Matreshka.XML_Schema.AST.Model_Group_Access
        := +Self.Node;
   begin
      if Node = null then
         return XML.Schema.Object_Lists.Empty_XS_Object_List;
      else
         return XML.Schema.Object_Lists.Internals.Create (Node.Particles);
      end if;
   end Get_Particles;

end XML.Schema.Objects.Terms.Model_Groups;
