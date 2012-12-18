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
with Matreshka.XML_Schema.AST.Element_Declarations;
with Matreshka.XML_Schema.AST.Models;
with Matreshka.XML_Schema.AST.Namespaces;
with Matreshka.XML_Schema.AST.Schemas;

package body Matreshka.XML_Schema.Containment_Iterators is

   use type Matreshka.XML_Schema.Visitors.Traverse_Control;

   -----------------
   -- Visit_Model --
   -----------------

   overriding procedure Visit_Model
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Model_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is
   begin
      --  Visit namespaces.

      for Item of Node.Namespaces loop
         Matreshka.XML_Schema.Visitors.Visit
          (Self,
           Visitor,
           Matreshka.XML_Schema.AST.Node_Access (Item),
           Control);

         exit when Control /= Matreshka.XML_Schema.Visitors.Continue;
      end loop;
   end Visit_Model;

   ---------------------
   -- Visit_Namespace --
   ---------------------

   overriding procedure Visit_Namespace
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Namespace_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is
   begin
      --  Visit element declarations.

      for Item of Node.Element_Declarations loop
         Matreshka.XML_Schema.Visitors.Visit
          (Self,
           Visitor,
           Matreshka.XML_Schema.AST.Node_Access (Item),
           Control);

         exit when Control /= Matreshka.XML_Schema.Visitors.Continue;
      end loop;
   end Visit_Namespace;

   ------------------
   -- Visit_Schema --
   ------------------

   overriding procedure Visit_Schema
    (Self    : in out Containment_Iterator;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Node    : not null Matreshka.XML_Schema.AST.Schema_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is
   begin
      --  Visit type definitions.

      for Item of Node.Type_Definitions loop
         Matreshka.XML_Schema.Visitors.Visit
          (Self,
           Visitor,
           Matreshka.XML_Schema.AST.Node_Access (Item),
           Control);

         exit when Control /= Matreshka.XML_Schema.Visitors.Continue;
      end loop;

      --  Visit element declarations.

      for Item of Node.Element_Declarations loop
         Matreshka.XML_Schema.Visitors.Visit
          (Self,
           Visitor,
           Matreshka.XML_Schema.AST.Node_Access (Item),
           Control);

         exit when Control /= Matreshka.XML_Schema.Visitors.Continue;
      end loop;
   end Visit_Schema;

end Matreshka.XML_Schema.Containment_Iterators;