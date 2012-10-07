------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
--                              Tools Component                             --
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
with League.Application;

with XML.SAX.Input_Sources.Streams.Files;
with XML.SAX.Simple_Readers;

with WSDL.AST;
with WSDL.Debug;
with WSDL.Iterators.Containment;
with WSDL.Parsers;
with WSDL.Name_Resolvers;

procedure WSDL.Driver is
   Source  : aliased XML.SAX.Input_Sources.Streams.Files.File_Input_Source;
   Handler : aliased WSDL.Parsers.WSDL_Parser;
   Reader  : aliased XML.SAX.Simple_Readers.SAX_Simple_Reader;

begin
   --  Load document.

   Reader.Set_Content_Handler (Handler'Unchecked_Access);
   Source.Open_By_File_Name (League.Application.Arguments.Element (1));
   Reader.Parse (Source'Unchecked_Access);

   --  Resolve names.

   declare
      Resolver : WSDL.Name_Resolvers.Name_Resolver;
      Iterator : WSDL.Iterators.Containment.Containment_Iterator;
      Control  : WSDL.Iterators.Traverse_Control := WSDL.Iterators.Continue;

   begin
      Resolver.Set_Root (Handler.Get_Description);
      Iterator.Visit
       (Resolver, WSDL.AST.Node_Access (Handler.Get_Description), Control);
   end;

   WSDL.Debug.Dump (Handler.Get_Description);
end WSDL.Driver;
