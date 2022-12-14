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
-- Copyright © 2012-2013, Vadim Godunko <vgodunko@gmail.com>                --
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
with AMF.OCL.Call_Exps;
limited with AMF.OCL.Ocl_Expressions;
limited with AMF.OCL.Variables.Collections;

package AMF.OCL.Loop_Exps is

   pragma Preelaborate;

   type OCL_Loop_Exp is limited interface
     and AMF.OCL.Call_Exps.OCL_Call_Exp;

   type OCL_Loop_Exp_Access is
     access all OCL_Loop_Exp'Class;
   for OCL_Loop_Exp_Access'Storage_Size use 0;

   not overriding function Get_Body
    (Self : not null access constant OCL_Loop_Exp)
       return AMF.OCL.Ocl_Expressions.OCL_Ocl_Expression_Access is abstract;
   --  Getter of LoopExp::body.
   --

   not overriding procedure Set_Body
    (Self : not null access OCL_Loop_Exp;
     To   : AMF.OCL.Ocl_Expressions.OCL_Ocl_Expression_Access) is abstract;
   --  Setter of LoopExp::body.
   --

   not overriding function Get_Iterator
    (Self : not null access constant OCL_Loop_Exp)
       return AMF.OCL.Variables.Collections.Ordered_Set_Of_OCL_Variable is abstract;
   --  Getter of LoopExp::iterator.
   --

end AMF.OCL.Loop_Exps;
