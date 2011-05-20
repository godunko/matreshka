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
--  An add variable value action is a write variable action for adding values 
--  to a variable.
------------------------------------------------------------------------------
limited with AMF.UML.Input_Pins;
with AMF.UML.Write_Variable_Actions;

package AMF.UML.Add_Variable_Value_Actions is

   pragma Preelaborate;

   type UML_Add_Variable_Value_Action_Interface is limited interface
     and AMF.UML.Write_Variable_Actions.UML_Write_Variable_Action_Interface;

   type UML_Add_Variable_Value_Action is
     access all UML_Add_Variable_Value_Action_Interface'Class;
   for UML_Add_Variable_Value_Action'Storage_Size use 0;

   not overriding function Get_Insert_At
    (Self : not null access constant UML_Add_Variable_Value_Action_Interface)
       return AMF.UML.Input_Pins.UML_Input_Pin is abstract;
   --  Gives the position at which to insert a new value or move an existing 
   --  value in ordered variables. The types is UnlimitedINatural, but the 
   --  value cannot be zero. This pin is omitted for unordered variables.

   not overriding procedure Set_Insert_At
    (Self : not null access UML_Add_Variable_Value_Action_Interface;
     To   : AMF.UML.Input_Pins.UML_Input_Pin) is abstract;

   not overriding function Get_Is_Replace_All
    (Self : not null access constant UML_Add_Variable_Value_Action_Interface)
       return Boolean is abstract;
   --  Specifies whether existing values of the variable should be removed 
   --  before adding the new value.

   not overriding procedure Set_Is_Replace_All
    (Self : not null access UML_Add_Variable_Value_Action_Interface;
     To   : Boolean) is abstract;

end AMF.UML.Add_Variable_Value_Actions;
