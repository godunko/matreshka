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
with Ada.Wide_Wide_Text_IO;

with Matreshka.XML_Schema.AST.Element_Declarations;
with Matreshka.XML_Schema.AST.Models;
with Matreshka.XML_Schema.AST.Namespaces;
with Matreshka.XML_Schema.AST.Types;

package body Matreshka.XML_Schema.Name_Resolvers is

   -------------------------------
   -- Enter_Element_Declaration --
   -------------------------------

   overriding procedure Enter_Element_Declaration
    (Self    : in out Name_Resolver;
     Node    : not null Matreshka.XML_Schema.AST.Element_Declaration_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control)
   is
      use type Matreshka.XML_Schema.AST.Namespace_Access;
      use type Matreshka.XML_Schema.AST.Type_Definition_Access;
      use type Matreshka.XML_Schema.AST.Types.Scope_Variety;

      Namespace : Matreshka.XML_Schema.AST.Namespace_Access;

   begin
      if Node.Scope.Variety = Matreshka.XML_Schema.AST.Types.Global then
         if Node.Type_Definition = null
           and then not (Node.Type_Name.Namespace_URI.Is_Empty
                           and Node.Type_Name.Local_Name.Is_Empty)
         then
            --  Type of global element declaration is not defined inside
            --  element declaration itself and need to be resolved when 'type'
            --  attribute is present.
            --
            --  XXX Check for namespaceURI is added to process 'facet' element
            --  decalration only. Can non-abstract element declarations be used
            --  without type declaration?

            Ada.Wide_Wide_Text_IO.Put_Line (Node.Name.To_Wide_Wide_String);
            Ada.Wide_Wide_Text_IO.Put_Line
             ('{'
                & Node.Type_Name.Namespace_URI.To_Wide_Wide_String
                & '}'
                & Node.Type_Name.Local_Name.To_Wide_Wide_String);

            Namespace :=
              Self.Model.Get_Namespace (Node.Type_Name.Namespace_URI);

            if Namespace = null then
               raise Program_Error;
            end if;

            Node.Type_Definition :=
              Namespace.Get_Type_Definition (Node.Type_Name.Local_Name);

            if Node.Type_Definition = null then
               raise Program_Error;
            end if;
         end if;

      else
         --  XXX Non-global scope not need to be processed. Exception is raised
         --  for debug purposes only.

         Ada.Wide_Wide_Text_IO.Put_Line (Node.Name.To_Wide_Wide_String);

         raise Program_Error;
      end if;
   end Enter_Element_Declaration;

   -----------------
   -- Enter_Model --
   -----------------

   overriding procedure Enter_Model
    (Self    : in out Name_Resolver;
     Node    : not null Matreshka.XML_Schema.AST.Model_Access;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is
   begin
      Self.Model := Node;
   end Enter_Model;

end Matreshka.XML_Schema.Name_Resolvers;
