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
-- Copyright © 2011-2012, Vadim Godunko <vgodunko@gmail.com>                --
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
--  This file is generated, don't edit it.
------------------------------------------------------------------------------
--  An operation template parameter exposes an operation as a formal parameter 
--  for a template.
------------------------------------------------------------------------------
limited with AMF.UML.Operations;
with AMF.UML.Template_Parameters;

package AMF.UML.Operation_Template_Parameters is

   pragma Preelaborate;

   type UML_Operation_Template_Parameter is limited interface
     and AMF.UML.Template_Parameters.UML_Template_Parameter;

   type UML_Operation_Template_Parameter_Access is
     access all UML_Operation_Template_Parameter'Class;
   for UML_Operation_Template_Parameter_Access'Storage_Size use 0;

   not overriding function Get_Parametered_Element
    (Self : not null access constant UML_Operation_Template_Parameter)
       return AMF.UML.Operations.UML_Operation_Access is abstract;
   --  Getter of OperationTemplateParameter::parameteredElement.
   --
   --  The operation for this template parameter.

   not overriding procedure Set_Parametered_Element
    (Self : not null access UML_Operation_Template_Parameter;
     To   : AMF.UML.Operations.UML_Operation_Access) is abstract;
   --  Setter of OperationTemplateParameter::parameteredElement.
   --
   --  The operation for this template parameter.

end AMF.UML.Operation_Template_Parameters;
