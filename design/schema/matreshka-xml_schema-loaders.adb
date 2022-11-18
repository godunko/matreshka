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
-- Copyright © 2012-2014, Vadim Godunko <vgodunko@gmail.com>                --
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
with XML.SAX.File_Input_Sources;
with XML.SAX.Simple_Readers;

with Matreshka.XML_Schema.AST.Models;
with Matreshka.XML_Schema.AST.Namespaces;
with Matreshka.XML_Schema.AST.Schemas;
with Matreshka.XML_Schema.Containment_Iterators;
with Matreshka.XML_Schema.Handlers;
with Matreshka.XML_Schema.Name_Resolvers;
with Matreshka.XML_Schema.Namespace_Builders;
with Matreshka.XML_Schema.URI_Rewriter;
with Matreshka.XML_Schema.Visitors;

package body Matreshka.XML_Schema.Loaders is

   ----------------------
   -- Enqueue_Document --
   ----------------------

   procedure Enqueue_Document
    (Self            : in out Model_Loader'Class;
     Namespace_URI   : League.Strings.Universal_String;
     Base_URI        : League.IRIs.IRI;
     Schema_Location : League.Strings.Universal_String)
   is
      Location_Hint : League.Strings.Universal_String;

   begin
      if not Schema_Location.Is_Empty then
         Location_Hint :=
           Base_URI.Resolve
            (League.IRIs.From_Universal_String
              (Schema_Location)).To_Universal_String;
      end if;

      --  When schema document is imported multiple times (from different
      --  schema documents) it need to be included to the list of documents
      --  only once.

      if not Self.Documents.Contains (Namespace_URI) then
         Self.Documents.Insert
          (Namespace_URI,
           new Document_Record'(Namespace_URI, Location_Hint, null));
      end if;
   end Enqueue_Document;

   ----------
   -- Load --
   ----------

   function Load
    (Self : in out Model_Loader'Class;
     URI  : League.Strings.Universal_String)
       return Matreshka.XML_Schema.AST.Model_Access
   is
      use type Matreshka.XML_Schema.AST.Schema_Access;

      Source  : aliased XML.SAX.File_Input_Sources.File_Input_Source;
      Handler : aliased
        Matreshka.XML_Schema.Handlers.XML_Schema_Handler (Self'Access);
      Reader  : aliased XML.SAX.Simple_Readers.Simple_Reader;
      Schema  : Matreshka.XML_Schema.AST.Schema_Access;
      Next    : Document_Access;
      Failure : Boolean;
      Model   : Matreshka.XML_Schema.AST.Model_Access;

   begin
      --  Load root document.

      Reader.Set_Content_Handler (Handler'Unchecked_Access);
      Reader.Set_Error_Handler (Handler'Unchecked_Access);
      Source.Open_By_File_Name (URI);
      Reader.Parse (Source'Unchecked_Access);
      Source.Close;
      Schema := Handler.Get_Schema;

      --  Register root document.

      Self.Documents.Insert
       (Schema.Target_Namespace,
        new Document_Record'(Schema.Target_Namespace, URI, Schema));

      loop
         Next := null;

         for Document of Self.Documents loop
            if Document.Schema = null then
               Next := Document;

               exit;
            end if;
         end loop;

         exit when Next = null;

         Schema := null;

         --  Try to open document by location hint.

         if not Next.Hint.Is_Empty then
            begin
               Source.Open_By_URI
                (Matreshka.XML_Schema.URI_Rewriter.Rewrite_URI (Next.Hint));
               Source.Set_System_Id (Next.Hint);
               Failure := False;

            exception
               when others =>
                  Failure := True;
            end;

            if not Failure then
               Reader.Parse (Source'Unchecked_Access);
               Source.Close;
               Schema := Handler.Get_Schema;
            end if;
         end if;

         --  Load document by URI.

         if Schema = null then
            Source.Open_By_URI
             (Matreshka.XML_Schema.URI_Rewriter.Rewrite_URI (Next.URI));
            Source.Set_System_Id (Next.URI);
            Reader.Parse (Source'Unchecked_Access);
            Source.Close;
            Schema := Handler.Get_Schema;
         end if;

         Next.Schema := Schema;
      end loop;

      --  Allocate Model.

      Model := new Matreshka.XML_Schema.AST.Models.Model_Node;

      --  Create NamespaceItems.

      for Document of Self.Documents loop
         --  Construct namespace.

         declare
            Iterator :
              Matreshka.XML_Schema.Containment_Iterators.Containment_Iterator;
            Visitor  :
              Matreshka.XML_Schema.Namespace_Builders.Namespace_Builder;
            Control  : Matreshka.XML_Schema.Visitors.Traverse_Control
              := Matreshka.XML_Schema.Visitors.Continue;

         begin
            Matreshka.XML_Schema.Visitors.Visit
             (Iterator,
              Visitor,
              Matreshka.XML_Schema.AST.Node_Access (Document.Schema),
              Control);
            Model.Namespaces.Insert
             (Document.Schema.Target_Namespace, Visitor.Get_Namespace);
         end;
      end loop;

      --  Resolve names.

      declare
         Iterator :
           Matreshka.XML_Schema.Containment_Iterators.Containment_Iterator;
         Visitor  : Matreshka.XML_Schema.Name_Resolvers.Name_Resolver;
         Control  : Matreshka.XML_Schema.Visitors.Traverse_Control
           := Matreshka.XML_Schema.Visitors.Continue;

      begin
         Matreshka.XML_Schema.Visitors.Visit
          (Iterator,
           Visitor,
           Matreshka.XML_Schema.AST.Node_Access (Model),
           Control);
      end;

      return Model;
   end Load;

end Matreshka.XML_Schema.Loaders;
