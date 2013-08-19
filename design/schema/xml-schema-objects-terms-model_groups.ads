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

with XML.Schema.Annotations;
with XML.Schema.Object_Lists;

package XML.Schema.Objects.Terms.Model_Groups is

   pragma Preelaborate;

   type XS_Model_Group is new XS_Term with private;

   Null_XS_Model_Group : constant XS_Model_Group;

   type Compositor_Kins is
     (Compositor_Sequence,
      --  This constant value signifies a sequence operator.
      Compositor_Choice,
      --  This constant value signifies a choice operator.
      Compositor_All);
   --  This content model represents a simplified version of the
   --  SGML &-Connector and is limited to the top-level of any content model.
   --  No element in the all content model may appear more than once.
   
   function Get_Compositor
    (Self : XS_Model_Group'Class)
       return Compositor_Kins;
   --  [compositor]: one of all, choice or sequence..

   function Get_Particles
    (Self : XS_Model_Group'Class)
       return XML.Schema.Object_Lists.XS_Object_List;
   --  A list of [particles] if it exists, otherwise an empty XSObjectList. 

   function Get_Annotation
    (Self : XS_Model_Group'Class)
       return XML.Schema.Annotations.XS_Annotation;
   --  An annotation if it exists, otherwise null.

private

   type XS_Model_Group is new XS_Term with null record;

   Null_XS_Model_Group : constant XS_Model_Group
     := (Ada.Finalization.Controlled with Node => null);

end XML.Schema.Objects.Terms.Model_Groups;
