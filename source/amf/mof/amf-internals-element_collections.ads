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
-- Copyright © 2010-2012, Vadim Godunko <vgodunko@gmail.com>                --
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
--  Internal table based implementation of collections of elements.
------------------------------------------------------------------------------
with AMF.Internals.Collections.Elements;

package AMF.Internals.Element_Collections is

   function Length (Self : AMF_Collection_Of_Element) return Natural;

   function Element
    (Self : AMF_Collection_Of_Element; Index : Positive) return AMF_Element;

   procedure Add (Self : AMF_Collection_Of_Element; Item : AMF_Element);

   procedure Internal_Append
    (Collection : AMF_Collection_Of_Element;
     Element    : AMF_Element;
     Link       : AMF_Link);
   --  Appends element to collection. This subprogram doesn't construct link.

   function Wrap
    (Collection : AMF_Collection_Of_Element)
       return AMF.Internals.Collections.Elements.Shared_Element_Collection_Access;

   function Allocate_Collections
    (Count : Natural) return AMF.Internals.AMF_Collection_Of_Element;
   --  Allocates specified number of collections and initialize first
   --  allocated collection (this collection is used to handle non-owned link
   --  ends by convention).

   procedure Initialize_Ordered_Set_Collection
    (Element    : AMF_Element;
     Property   : CMOF_Element;
     Collection : AMF.Internals.AMF_Collection_Of_Element);
   --  Initialize specified collection as ordered set.

   procedure Initialize_Set_Collection
    (Element    : AMF_Element;
     Property   : CMOF_Element;
     Collection : AMF.Internals.AMF_Collection_Of_Element);
   --  Initialize specified collection as set.

end AMF.Internals.Element_Collections;
