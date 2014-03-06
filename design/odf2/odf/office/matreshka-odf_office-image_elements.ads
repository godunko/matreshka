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
with XML.DOM.Visitors;

with ODF.DOM.Office_Image_Elements;

package Matreshka.ODF_Office.Image_Elements is

   type Office_Image_Element_Node is
     new Matreshka.ODF_Office.Abstract_Office_Element_Node
       and ODF.DOM.Office_Image_Elements.ODF_Office_Image
         with null record;

   overriding function Create
    (Parameters : not null access Matreshka.DOM_Elements.Element_L2_Parameters)
       return Office_Image_Element_Node;

   overriding function Get_Local_Name
    (Self : not null access constant Office_Image_Element_Node)
       return League.Strings.Universal_String;

   overriding procedure Enter_Node
    (Self    : not null access Office_Image_Element_Node;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Leave_Node
    (Self    : not null access Office_Image_Element_Node;
     Visitor : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control : in out XML.DOM.Visitors.Traverse_Control);

   overriding procedure Visit_Node
    (Self     : not null access Office_Image_Element_Node;
     Iterator : in out XML.DOM.Visitors.Abstract_Iterator'Class;
     Visitor  : in out XML.DOM.Visitors.Abstract_Visitor'Class;
     Control  : in out XML.DOM.Visitors.Traverse_Control);

end Matreshka.ODF_Office.Image_Elements;
