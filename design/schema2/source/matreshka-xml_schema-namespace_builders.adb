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
with League.Strings;
with XML.SAX.Parse_Exceptions.Internals;

with Matreshka.XML_Schema.AST.Models;
with Matreshka.XML_Schema.AST.Namespaces;
with Matreshka.XML_Schema.AST.Schemas;

package body Matreshka.XML_Schema.Namespace_Builders is

   -------------
   -- Analyze --
   -------------

   procedure Analyze
    (Self          : in out Namespace_Builder'Class;
     Namespace     : not null Matreshka.XML_Schema.AST.Namespace_Access;
     Schema        : not null Matreshka.XML_Schema.AST.Schema_Access;
     Error_Handler :
       not null access XML.SAX.Error_Handlers.SAX_Error_Handler'Class)
   is
      use type League.Strings.Universal_String;
      use type Matreshka.XML_Schema.AST.Schema_Access;

      Processor       : Namespace_Builder;
      Included_Schema : Matreshka.XML_Schema.AST.Schema_Access;
      Is_Resolved     : Boolean;
      Location        : League.Strings.Universal_String;

   begin
      --  All components of the current schema document are processed before
      --  processing of include and redefine components.

      --  Merge content of included schema documents.

      for Included of Schema.Includes loop
         for Info of Namespace.Owning_Model.Schema_Documents loop
            if Info.Location = Included.Location then
               Included_Schema := Info.Schema;
               Is_Resolved     := Info.Is_Resolved;
               Location        := Info.Location;

               exit;
            end if;
         end loop;

         if Is_Resolved and Included_Schema = null then
            --  [XS] 4.2.1 Assembling a schema for a single target namespace
            --  from multiple schema definition documents
            --
            --  "It is not an error for the ·actual value· of the
            --  schemaLocation [attribute] to fail to resolve it all, in which
            --  case no corresponding inclusion is performed. It is an error
            --  for it to resolve but the rest of clause 1 above to fail to be
            --  satisfied."
            --
            --  Schema document was resolved but not parsed due to error.
            --  Report fatal error.

            Error_Handler.Fatal_Error
             (XML.SAX.Parse_Exceptions.Internals.Create
               (League.Strings.Empty_Universal_String,
                Location,
                0,
                0,
                League.Strings.To_Universal_String
                 ("resolved schema document doesn't provide valid schema")));

            return;

         elsif Included_Schema /= null then
            --  [XS] 4.2.1 Assembling a schema for a single target namespace
            --  from multiple schema definition documents
            --
            --  "Schema Representation Constraint: Inclusion Constraints and
            --  Semantics
            --
            --  2 One of the following must be true:
            --  2.1 SII has a targetNamespace [attribute], and its ·actual
            --    value· is identical to the ·actual value· of the
            --    targetNamespace [attribute] of SII’ (which must have such an
            --    [attribute]).
            --  2.2 Neither SII nor SII’ have a targetNamespace [attribute].
            --  2.3 SII has no targetNamespace [attribute] (but SII’ does)."

            if Included_Schema.Target_Namespace_Defined
              and Schema.Target_Namespace_Defined
              and Included_Schema.Target_Namespace /= Schema.Target_Namespace
            then
               Error_Handler.Fatal_Error
                (XML.SAX.Parse_Exceptions.Internals.Create
                  (League.Strings.Empty_Universal_String,
                   Included_Schema.System_Id,
                   Included_Schema.Line,
                   Included_Schema.Column,
                   League.Strings.To_Universal_String
                    ("value of targetNamespace attribute but me identical to"
                       & " its value of including schema")));

               return;

            elsif Included_Schema.Target_Namespace_Defined
              and not Schema.Target_Namespace_Defined
            then
               Error_Handler.Fatal_Error
                (XML.SAX.Parse_Exceptions.Internals.Create
                  (League.Strings.Empty_Universal_String,
                   Included_Schema.System_Id,
                   Included_Schema.Line,
                   Included_Schema.Column,
                   League.Strings.To_Universal_String
                    ("included schema can't have targetNamespace attribute")));

               return;
            end if;

            Processor.Analyze (Namespace, Included_Schema, Error_Handler);
         end if;
      end loop;
   end Analyze;

end Matreshka.XML_Schema.Namespace_Builders;
