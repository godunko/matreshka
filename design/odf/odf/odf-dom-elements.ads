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
with XML.DOM.Nodes.Elements;
--with XML.DOM.Visitors;

package ODF.DOM.Elements is

   type ODF_Element is abstract new XML.DOM.Nodes.Elements.DOM_Element with private;

   type ODF_Element_Access is access all ODF_Element'Class;

--   not overriding procedure Enter_Element
--    (Self    : not null access ODF_Element;
--     Visitor : in out ODF.DOM.Visitors.DOM_Visitor'Class;
--     Control : in out ODF.DOM.Visitors.Traverse_Control) is abstract;
--   --  Dispatch call to corresponding subprogram of visitor interface.
--
--   not overriding procedure Leave_Element
--    (Self    : not null access ODF_Element;
--     Visitor : in out ODF.DOM.Visitors.DOM_Visitor'Class;
--     Control : in out ODF.DOM.Visitors.Traverse_Control) is abstract;
--   --  Dispatch call to corresponding subprogram of visitor interface.
--
--   not overriding procedure Visit_Element
--    (Self     : not null access ODF_Element;
--     Iterator : in out ODF.DOM.Visitors.DOM_Iterator'Class;
--     Visitor  : in out ODF.DOM.Visitors.DOM_Visitor'Class;
--     Control  : in out ODF.DOM.Visitors.Traverse_Control) is abstract;
--   --  Dispatch call to corresponding subprogram of iterator interface.

private

   type ODF_Element is
     abstract new XML.DOM.Nodes.Elements.DOM_Element with null record;

end ODF.DOM.Elements;
