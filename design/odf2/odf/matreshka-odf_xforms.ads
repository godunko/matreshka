------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Open Document Toolkit                           --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2014, Vadim Godunko <vgodunko@gmail.com>                     --
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
with League.Strings;
with Matreshka.DOM_Attributes;
with Matreshka.DOM_Elements;
with Matreshka.DOM_Nodes;

package Matreshka.ODF_XForms is

   type Abstract_XForms_Attribute_Node is
     abstract new Matreshka.DOM_Attributes.Abstract_Attribute_L2_Node with
   record
      Prefix : League.Strings.Universal_String;
   end record;

   overriding function Get_Namespace_URI
    (Self : not null access constant Abstract_XForms_Attribute_Node)
       return League.Strings.Universal_String;

   type Abstract_XForms_Element_Node is
     abstract new Matreshka.DOM_Elements.Abstract_Element_Node with
   record
      Prefix : League.Strings.Universal_String;
   end record;

   overriding function Get_Namespace_URI
    (Self : not null access constant Abstract_XForms_Element_Node)
       return League.Strings.Universal_String;

   package Constructors is

      procedure Initialize
       (Self     : not null access Abstract_XForms_Attribute_Node'Class;
        Document : not null Matreshka.DOM_Nodes.Document_Access;
        Prefix   : League.Strings.Universal_String)
          with Inline => True;

      procedure Initialize
       (Self     : not null access Abstract_XForms_Element_Node'Class;
        Document : not null Matreshka.DOM_Nodes.Document_Access;
        Prefix   : League.Strings.Universal_String)
          with Inline => True;

   end Constructors;

end Matreshka.ODF_XForms;
