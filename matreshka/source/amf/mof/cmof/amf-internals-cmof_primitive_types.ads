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
with AMF.CMOF.Primitive_Types;
with AMF.Internals.CMOF_Data_Types;
with AMF.Visitors.CMOF_Visitors;

package AMF.Internals.CMOF_Primitive_Types is

   type CMOF_Primitive_Type_Proxy is
     limited new AMF.Internals.CMOF_Data_Types.CMOF_Data_Type_Proxy
       and AMF.CMOF.Primitive_Types.CMOF_Primitive_Type
         with null record;

   overriding procedure Enter_CMOF_Element
    (Self    : not null access constant CMOF_Primitive_Type_Proxy;
     Visitor : not null access AMF.Visitors.CMOF_Visitors.CMOF_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Leave_CMOF_Element
    (Self    : not null access constant CMOF_Primitive_Type_Proxy;
     Visitor : not null access AMF.Visitors.CMOF_Visitors.CMOF_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

end AMF.Internals.CMOF_Primitive_Types;
