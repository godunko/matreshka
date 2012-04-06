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
--  This file is generated, don't edit it.
------------------------------------------------------------------------------
with AMF.Elements;
with AMF.Internals.Helpers;
with AMF.Internals.Tables.Utp_Attributes;
with AMF.UML.Read_Structural_Feature_Actions;
with AMF.Visitors.Utp_Iterators;
with AMF.Visitors.Utp_Visitors;

package body AMF.Internals.Utp_Get_Timezone_Actions is

   ---------------------------------------------
   -- Get_Base_Read_Structural_Feature_Action --
   ---------------------------------------------

   overriding function Get_Base_Read_Structural_Feature_Action
    (Self : not null access constant Utp_Get_Timezone_Action_Proxy)
       return AMF.UML.Read_Structural_Feature_Actions.UML_Read_Structural_Feature_Action_Access is
   begin
      return
        AMF.UML.Read_Structural_Feature_Actions.UML_Read_Structural_Feature_Action_Access
         (AMF.Internals.Helpers.To_Element
           (AMF.Internals.Tables.Utp_Attributes.Internal_Get_Base_Read_Structural_Feature_Action
             (Self.Element)));
   end Get_Base_Read_Structural_Feature_Action;

   ---------------------------------------------
   -- Set_Base_Read_Structural_Feature_Action --
   ---------------------------------------------

   overriding procedure Set_Base_Read_Structural_Feature_Action
    (Self : not null access Utp_Get_Timezone_Action_Proxy;
     To   : AMF.UML.Read_Structural_Feature_Actions.UML_Read_Structural_Feature_Action_Access) is
   begin
      AMF.Internals.Tables.Utp_Attributes.Internal_Set_Base_Read_Structural_Feature_Action
       (Self.Element,
        AMF.Internals.Helpers.To_Element
         (AMF.Elements.Element_Access (To)));
   end Set_Base_Read_Structural_Feature_Action;

   -------------------
   -- Enter_Element --
   -------------------

   overriding procedure Enter_Element
    (Self    : not null access constant Utp_Get_Timezone_Action_Proxy;
     Visitor : in out AMF.Visitors.Abstract_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      if Visitor in AMF.Visitors.Utp_Visitors.Utp_Visitor'Class then
         AMF.Visitors.Utp_Visitors.Utp_Visitor'Class
          (Visitor).Enter_Get_Timezone_Action
            (AMF.Utp.Get_Timezone_Actions.Utp_Get_Timezone_Action_Access (Self),
           Control);
      end if;
   end Enter_Element;

   -------------------
   -- Leave_Element --
   -------------------

   overriding procedure Leave_Element
    (Self    : not null access constant Utp_Get_Timezone_Action_Proxy;
     Visitor : in out AMF.Visitors.Abstract_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      if Visitor in AMF.Visitors.Utp_Visitors.Utp_Visitor'Class then
         AMF.Visitors.Utp_Visitors.Utp_Visitor'Class
          (Visitor).Leave_Get_Timezone_Action
            (AMF.Utp.Get_Timezone_Actions.Utp_Get_Timezone_Action_Access (Self),
           Control);
      end if;
   end Leave_Element;

   -------------------
   -- Visit_Element --
   -------------------

   overriding procedure Visit_Element
    (Self     : not null access constant Utp_Get_Timezone_Action_Proxy;
     Iterator : in out AMF.Visitors.Abstract_Iterator'Class;
     Visitor  : in out AMF.Visitors.Abstract_Visitor'Class;
     Control  : in out AMF.Visitors.Traverse_Control) is
   begin
      if Iterator in AMF.Visitors.Utp_Iterators.Utp_Iterator'Class then
         AMF.Visitors.Utp_Iterators.Utp_Iterator'Class
          (Iterator).Visit_Get_Timezone_Action
            (Visitor,
             AMF.Utp.Get_Timezone_Actions.Utp_Get_Timezone_Action_Access (Self),
           Control);
      end if;
   end Visit_Element;

end AMF.Internals.Utp_Get_Timezone_Actions;
