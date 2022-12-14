------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Ada Modeling Framework                          --
--                                                                          --
--                            Testsuite Component                           --
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
with Matreshka.Internals.Strings;

with AMF.Extents;
with AMF.Internals.Collections.Elements;
with AMF.URI_Stores;

package AMF.Internals.Extents is

   function Allocate_Extent
    (Context_URI : not null Matreshka.Internals.Strings.Shared_String_Access)
       return AMF_Extent;
   --  Allocates new empty extent.

   function Allocate_URI_Store
    (Context_URI : not null Matreshka.Internals.Strings.Shared_String_Access)
       return not null AMF.URI_Stores.URI_Store_Access;
   --  Allocates new empty store.

   function Proxy
    (Extent : AMF_Extent) return not null AMF.Extents.Extent_Access;
   --  Returns proxy object for extent.

   function All_Elements
    (Self : AMF_Extent)
       return not null AMF.Internals.Collections.Elements.Shared_Element_Collection_Access;
   --  Returns all elements in the specified extent.

   procedure Internal_Append (Extent : AMF_Extent; Element : AMF_Element);
   --  Adds specified element to the set of elements contained in the specified
   --  extent.

   function Get_Id
    (Extent  : AMF_Extent;
     Element : AMF_Element) return League.Strings.Universal_String;
   --  Returns identifier to the element.

   procedure Set_Id
    (Extent  : AMF_Extent;
     Element : AMF_Element;
     Id      : League.Strings.Universal_String);
   --  Set specified identifier to the element.

   function Element
    (Self : AMF_Extent;
     Name : League.Strings.Universal_String) return AMF_Element;
   --  Returns the Element identified by the given URI in the extent. Returns
   --  Null if there is no element in the extent with the given URI. Note the
   --  Element does not (necessarily) contain a property corresponding to the
   --  URI. The URI identifies the element in the context of the extent. The
   --  same element may have a different identifier in another extent.

   function URI
    (Extent  : AMF_Extent;
     Element : AMF_Element) return League.Strings.Universal_String;
   --  Returns the URI of the given element in the extent. Returns Null if the
   --  element is not in the extent.

end AMF.Internals.Extents;
