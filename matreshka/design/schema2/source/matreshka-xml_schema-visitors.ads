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
with Matreshka.XML_Schema.AST;

package Matreshka.XML_Schema.Visitors is

   pragma Preelaborate;

   type Traverse_Control is
    (Continue,
     Abandon_Children,
     Abandon_Sibling,
     Terminate_Immediately);

   ----------------------
   -- Abstract_Visitor --
   ----------------------

   type Abstract_Visitor is limited interface;

   not overriding procedure Enter_Model
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Model_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Model
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Model_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Namespace
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Namespace_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Namespace
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Namespace_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Schema
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Schema_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Schema
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Schema_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Enter_Simple_Type
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Simple_Type_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Leave_Simple_Type
    (Self    : in out Abstract_Visitor;
     Node    : not null Matreshka.XML_Schema.AST.Simple_Type_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   -----------------------
   -- Abstract_Iterator --
   -----------------------

   type Abstract_Iterator is limited interface;

   not overriding procedure Visit_Model
    (Self    : in out Abstract_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Model_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Namespace
    (Self    : in out Abstract_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Namespace_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Schema
    (Self    : in out Abstract_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Schema_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

   not overriding procedure Visit_Simple_Type
    (Self    : in out Abstract_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Simple_Type_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is null;

end Matreshka.XML_Schema.Visitors;
