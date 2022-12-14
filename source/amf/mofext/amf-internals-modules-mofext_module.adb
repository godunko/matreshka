------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Ada Modeling Framework                          --
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
with AMF.Internals.Factories.MOF_Factories;
with AMF.Internals.Factories.MOFEXT_Module_Factory;
with AMF.Internals.Tables.MOFEXT_Element_Table;
with AMF.Internals.Tables.MOF_Metamodel.Links;
with AMF.Internals.Tables.MOF_Metamodel.Objects;
with AMF.Internals.Tables.MOF_Metamodel.Properties;

with AMF.Internals.Modules.UML_Module;
pragma Unreferenced (AMF.Internals.Modules.UML_Module);
pragma Elaborate_All (AMF.Internals.Modules.UML_Module);
--  UML nodule package and all its dependencies must be elaborated before
--  elaboration of this package.

package body AMF.Internals.Modules.MOFEXT_Module is

   --  Global object of factory for supported metamodel.

   MOF_Module_Factory : aliased
     AMF.Internals.Factories.MOFEXT_Module_Factory.MOF_Module_Factory;
   Module             : AMF_Metamodel;

begin
   --  Register module's factory.

   AMF.Internals.Factories.Register (MOF_Module_Factory'Access, Module);

   --  Initialize metamodels.

   AMF.Internals.Tables.MOF_Metamodel.Objects.Initialize;
   AMF.Internals.Tables.MOF_Metamodel.Properties.Initialize;
   AMF.Internals.Tables.MOF_Metamodel.Links.Initialize;

   --  Initialize element table of MOF metamodel.

   AMF.Internals.Tables.MOFEXT_Element_Table.Initialize (Module);

   --  Register factories.

   AMF.Internals.Factories.Register
    (AMF.Internals.Factories.MOF_Factories.Get_Package,
     AMF.Internals.Factories.MOF_Factories.Constructor'Access);
end AMF.Internals.Modules.MOFEXT_Module;
