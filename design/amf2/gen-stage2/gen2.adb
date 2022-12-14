------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Ada Modeling Framework                          --
--                                                                          --
--                              Tools Component                             --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2010-2012, Vadim Godunko <vgodunko@gmail.com>                --
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

with League.Application;

with AMF.Elements.Collections;
with AMF.Facility;
with AMF.URI_Stores;
with XMI.Reader;

with Generator.Analyzer;
with Generator.API;
with Generator.Arguments;
with Generator.Attributes;
with Generator.Constructors;
with Generator.Factories;
with Generator.Holders;
with Generator.Link_Sets;
with Generator.Loader;
with Generator.Metamodel;
with Generator.Reflection;
with Generator.String_Data;
with Generator.Tables;
with Generator.Type_Mapping;
with Generator.Visitors;

procedure Gen2 is
   use Ada.Wide_Wide_Text_IO;

begin
   --  Parse command line arguments.

   Generator.Arguments.Parse_Command_Line_Arguments;

   --  Initialize facility.

   AMF.Facility.Initialize;

   --  Load metamodel.

   Put_Line (Standard_Error, "Loading metamodels...");
   Generator.Loader.Load_Metamodels;

   --  Load type mapping.

   Put_Line (Standard_Error, "Loading type mapping...");
   Generator.Type_Mapping.Load_Mapping;

   --  Analyze metamodels.

   Put_Line (Standard_Error, "Analyzing...");
   Generator.Analyzer.Analyze_Module;

   if Generator.Arguments.Generate_Public_API then
      Put_Line (Standard_Error, "Generating public API...");
      Generator.API.Generate_Public_API;
   end if;

   if Generator.Arguments.Generate_API_Stubs then
      Put_Line (Standard_Error, "Generating API stubs...");
      Generator.API.Generate_Stubs;
   end if;

   if Generator.Arguments.Generate_Attributes then
      Put_Line (Standard_Error, "Generating attributes...");
      Generator.Attributes.Generate_Attributes_Mapping_Specification;
      Generator.Attributes.Generate_Attributes_Specification;
      Generator.Attributes.Generate_Attributes_Implementation;
   end if;

   if Generator.Arguments.Generate_Constructors then
      Put_Line (Standard_Error, "Generating constructors...");
      Generator.Constructors.Generate_Constructors_Specification;
      Generator.Constructors.Generate_Constructors_Implementation;
   end if;

   Put_Line (Standard_Error, "Generating preinitialized string data...");
   Generator.String_Data.Generate_Module_String_Data;

   Put_Line (Standard_Error, "Generating metamodel initialization...");
   Generator.Metamodel.Generate_Metamodel_Specification;
   Generator.Metamodel.Generate_Metamodel_Implementation;

   if Generator.Arguments.Generate_Reflection then
      Put_Line (Standard_Error, "Generating relfection...");
      Generator.Reflection.Generate_Reflection_Specification;
      Generator.Reflection.Generate_Reflection_Implementation;
   end if;

   Put_Line (Standard_Error, "Generating iterator interface...");
   Generator.Visitors.Generate_Visitors_Packages;
   Generator.Visitors.Generate_Iterators_Packages;

   Put_Line (Standard_Error, "Generating factories...");
   Generator.Factories.Generate_Factory_Interface;
   Generator.Factories.Generate_Factory_Implementation;

   Put_Line (Standard_Error, "Generating holders...");
   Generator.Holders.Generate_Holders;

   Put_Line (Standard_Error, "Generating link sets management...");
   Generator.Link_Sets.Generate_Construct_Union;

   Put_Line (Standard_Error, "Generating element table...");
   Generator.Tables.Generate_Types_Package;
   Generator.Tables.Generate_Element_Table_Package;
end Gen2;
