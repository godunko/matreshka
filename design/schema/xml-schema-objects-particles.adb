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
-- Copyright © 2013, Vadim Godunko <vgodunko@gmail.com>                     --
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

with XML.Schema.Objects.Terms.Internals;
with Matreshka.XML_Schema.AST.Particles;

package body XML.Schema.Objects.Particles is

   function "+"
    (Self : Matreshka.XML_Schema.AST.Object_Access)
      return Matreshka.XML_Schema.AST.Particle_Access;

   ---------
   -- "+" --
   ---------

   function "+"
    (Self : Matreshka.XML_Schema.AST.Object_Access)
      return Matreshka.XML_Schema.AST.Particle_Access is
   begin
      return Matreshka.XML_Schema.AST.Particle_Access (Self);
   end "+";

   --------------------
   -- Get_Max_Occurs --
   --------------------

   function Get_Max_Occurs
     (Self : XS_Particle'Class)
      return Unbounded_Natural
   is
      use type Matreshka.XML_Schema.AST.Particle_Access;

      Node : constant Matreshka.XML_Schema.AST.Particle_Access := +Self.Node;
   begin
      if Node = null then
         return (Unbounded => True);

      elsif Node.Max_Occurs = Natural'Last then
         return (Unbounded => True);
      else
         return (Unbounded => False, Value => Node.Max_Occurs);
      end if;
   end Get_Max_Occurs;

   --------------------
   -- Get_Min_Occurs --
   --------------------

   function Get_Min_Occurs (Self : XS_Particle'Class) return Natural is
      use type Matreshka.XML_Schema.AST.Particle_Access;

      Node : constant Matreshka.XML_Schema.AST.Particle_Access := +Self.Node;
   begin
      if Node = null then
         return 0;
      else
         return Node.Min_Occurs;
      end if;
   end Get_Min_Occurs;

   --------------
   -- Get_Term --
   --------------

   function Get_Term
     (Self : XS_Particle'Class)
      return XML.Schema.Objects.Terms.XS_Term
   is
      use type Matreshka.XML_Schema.AST.Particle_Access;

      Node : constant Matreshka.XML_Schema.AST.Particle_Access := +Self.Node;
   begin
      if Node = null then
         return XML.Schema.Objects.Terms.Null_XS_Term;
      else
         return XML.Schema.Objects.Terms.Internals.Create (Node.Term);
      end if;
   end Get_Term;

end XML.Schema.Objects.Particles;
