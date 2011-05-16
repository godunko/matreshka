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
-- Copyright © 2011, Vadim Godunko <vgodunko@gmail.com>                     --
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
--  An execution occurrence specification represents moments in time at which 
--  actions or behaviors start or finish.
------------------------------------------------------------------------------
limited with AMF.UML.Execution_Specifications;
with AMF.UML.Occurrence_Specifications;

package AMF.UML.Execution_Occurrence_Specifications is

   pragma Preelaborate;

   type UML_Execution_Occurrence_Specification_Interface is limited interface
     and AMF.UML.Occurrence_Specifications.UML_Occurrence_Specification_Interface;

   type UML_Execution_Occurrence_Specification is
     access all UML_Execution_Occurrence_Specification_Interface'Class;

   type Set_Of_UML_Execution_Occurrence_Specification is null record;
   type Ordered_Set_Of_UML_Execution_Occurrence_Specification is null record;

   not overriding function Get_Execution
    (Self : not null access constant UML_Execution_Occurrence_Specification_Interface)
       return AMF.UML.Execution_Specifications.UML_Execution_Specification is abstract;
   --  References the execution specification describing the execution that is 
   --  started or finished at this execution event.

   not overriding procedure Set_Execution
    (Self : not null access UML_Execution_Occurrence_Specification_Interface;
     To   : AMF.UML.Execution_Specifications.UML_Execution_Specification) is abstract;

end AMF.UML.Execution_Occurrence_Specifications;
