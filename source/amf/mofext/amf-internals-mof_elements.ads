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
with AMF.CMOF.Classes;
with AMF.CMOF.Properties;
with AMF.Extents;
with AMF.Internals.Elements;
with League.Holders;

package AMF.Internals.MOF_Elements is

   type MOF_Element_Proxy is
     abstract limited new AMF.Internals.Elements.Element_Base with null record;

   overriding function Get
    (Self     : not null access constant MOF_Element_Proxy;
     Property : not null AMF.CMOF.Properties.CMOF_Property_Access)
       return League.Holders.Holder;

   overriding function Get_Meta_Class
    (Self : not null access constant MOF_Element_Proxy)
       return AMF.CMOF.Classes.CMOF_Class_Access;

--   overriding function Get_Owned_Comment
--    (Self : not null access constant CMOF_Element_Proxy)
--       return AMF.CMOF.Comments.Collections.Set_Of_CMOF_Comment;
--
--   overriding function Get_Owned_Element
--    (Self : not null access constant CMOF_Element_Proxy)
--       return AMF.CMOF.Elements.Collections.Set_Of_CMOF_Element;
--
--   overriding function Get_Owner
--    (Self : not null access constant CMOF_Element_Proxy)
--       return AMF.CMOF.Elements.CMOF_Element_Access;

   overriding procedure Set
    (Self     : not null access MOF_Element_Proxy;
     Property : not null AMF.CMOF.Properties.CMOF_Property_Access;
     Value    : League.Holders.Holder);

   overriding function Extent
    (Self : not null access constant MOF_Element_Proxy)
       return AMF.Extents.Extent_Access;

--   overriding function Must_Be_Owned
--    (Self : not null access constant MOF_Element_Proxy) return Boolean;
--   --  Operation Element::mustBeOwned.
--   --
--   --  The query mustBeOwned() indicates whether elements of this type must
--   --  have an owner. Subclasses of Element that do not require an owner must
--   --  override this operation.

end AMF.Internals.MOF_Elements;
