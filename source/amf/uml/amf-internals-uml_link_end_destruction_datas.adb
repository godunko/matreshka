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
with AMF.Elements;
with AMF.Internals.Element_Collections;
with AMF.Internals.Helpers;
with AMF.Internals.Tables.UML_Attributes;
with AMF.Visitors.UML_Iterators;
with AMF.Visitors.UML_Visitors;

package body AMF.Internals.UML_Link_End_Destruction_Datas is

   -------------------
   -- Enter_Element --
   -------------------

   overriding procedure Enter_Element
    (Self    : not null access constant UML_Link_End_Destruction_Data_Proxy;
     Visitor : in out AMF.Visitors.Abstract_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      if Visitor in AMF.Visitors.UML_Visitors.UML_Visitor'Class then
         AMF.Visitors.UML_Visitors.UML_Visitor'Class
          (Visitor).Enter_Link_End_Destruction_Data
            (AMF.UML.Link_End_Destruction_Datas.UML_Link_End_Destruction_Data_Access (Self),
           Control);
      end if;
   end Enter_Element;

   -------------------
   -- Leave_Element --
   -------------------

   overriding procedure Leave_Element
    (Self    : not null access constant UML_Link_End_Destruction_Data_Proxy;
     Visitor : in out AMF.Visitors.Abstract_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      if Visitor in AMF.Visitors.UML_Visitors.UML_Visitor'Class then
         AMF.Visitors.UML_Visitors.UML_Visitor'Class
          (Visitor).Leave_Link_End_Destruction_Data
            (AMF.UML.Link_End_Destruction_Datas.UML_Link_End_Destruction_Data_Access (Self),
           Control);
      end if;
   end Leave_Element;

   -------------------
   -- Visit_Element --
   -------------------

   overriding procedure Visit_Element
    (Self     : not null access constant UML_Link_End_Destruction_Data_Proxy;
     Iterator : in out AMF.Visitors.Abstract_Iterator'Class;
     Visitor  : in out AMF.Visitors.Abstract_Visitor'Class;
     Control  : in out AMF.Visitors.Traverse_Control) is
   begin
      if Iterator in AMF.Visitors.UML_Iterators.UML_Iterator'Class then
         AMF.Visitors.UML_Iterators.UML_Iterator'Class
          (Iterator).Visit_Link_End_Destruction_Data
            (Visitor,
             AMF.UML.Link_End_Destruction_Datas.UML_Link_End_Destruction_Data_Access (Self),
             Control);
      end if;
   end Visit_Element;

   --------------------
   -- Get_Destroy_At --
   --------------------

   overriding function Get_Destroy_At
    (Self : not null access constant UML_Link_End_Destruction_Data_Proxy)
       return AMF.UML.Input_Pins.UML_Input_Pin_Access is
   begin
      return
        AMF.UML.Input_Pins.UML_Input_Pin_Access
         (AMF.Internals.Helpers.To_Element
           (AMF.Internals.Tables.UML_Attributes.Internal_Get_Destroy_At
             (Self.Element)));
   end Get_Destroy_At;

   --------------------
   -- Set_Destroy_At --
   --------------------

   overriding procedure Set_Destroy_At
    (Self : not null access UML_Link_End_Destruction_Data_Proxy;
     To   : AMF.UML.Input_Pins.UML_Input_Pin_Access) is
   begin
      AMF.Internals.Tables.UML_Attributes.Internal_Set_Destroy_At
       (Self.Element,
        AMF.Internals.Helpers.To_Element
         (AMF.Elements.Element_Access (To)));
   end Set_Destroy_At;

   -------------------------------
   -- Get_Is_Destroy_Duplicates --
   -------------------------------

   overriding function Get_Is_Destroy_Duplicates
    (Self : not null access constant UML_Link_End_Destruction_Data_Proxy)
       return Boolean is
   begin
      return
        AMF.Internals.Tables.UML_Attributes.Internal_Get_Is_Destroy_Duplicates
         (Self.Element);
   end Get_Is_Destroy_Duplicates;

   -------------------------------
   -- Set_Is_Destroy_Duplicates --
   -------------------------------

   overriding procedure Set_Is_Destroy_Duplicates
    (Self : not null access UML_Link_End_Destruction_Data_Proxy;
     To   : Boolean) is
   begin
      AMF.Internals.Tables.UML_Attributes.Internal_Set_Is_Destroy_Duplicates
       (Self.Element, To);
   end Set_Is_Destroy_Duplicates;

   -------------
   -- Get_End --
   -------------

   overriding function Get_End
    (Self : not null access constant UML_Link_End_Destruction_Data_Proxy)
       return AMF.UML.Properties.UML_Property_Access is
   begin
      return
        AMF.UML.Properties.UML_Property_Access
         (AMF.Internals.Helpers.To_Element
           (AMF.Internals.Tables.UML_Attributes.Internal_Get_End
             (Self.Element)));
   end Get_End;

   -------------
   -- Set_End --
   -------------

   overriding procedure Set_End
    (Self : not null access UML_Link_End_Destruction_Data_Proxy;
     To   : AMF.UML.Properties.UML_Property_Access) is
   begin
      AMF.Internals.Tables.UML_Attributes.Internal_Set_End
       (Self.Element,
        AMF.Internals.Helpers.To_Element
         (AMF.Elements.Element_Access (To)));
   end Set_End;

   -------------------
   -- Get_Qualifier --
   -------------------

   overriding function Get_Qualifier
    (Self : not null access constant UML_Link_End_Destruction_Data_Proxy)
       return AMF.UML.Qualifier_Values.Collections.Set_Of_UML_Qualifier_Value is
   begin
      return
        AMF.UML.Qualifier_Values.Collections.Wrap
         (AMF.Internals.Element_Collections.Wrap
           (AMF.Internals.Tables.UML_Attributes.Internal_Get_Qualifier
             (Self.Element)));
   end Get_Qualifier;

   ---------------
   -- Get_Value --
   ---------------

   overriding function Get_Value
    (Self : not null access constant UML_Link_End_Destruction_Data_Proxy)
       return AMF.UML.Input_Pins.UML_Input_Pin_Access is
   begin
      return
        AMF.UML.Input_Pins.UML_Input_Pin_Access
         (AMF.Internals.Helpers.To_Element
           (AMF.Internals.Tables.UML_Attributes.Internal_Get_Value
             (Self.Element)));
   end Get_Value;

   ---------------
   -- Set_Value --
   ---------------

   overriding procedure Set_Value
    (Self : not null access UML_Link_End_Destruction_Data_Proxy;
     To   : AMF.UML.Input_Pins.UML_Input_Pin_Access) is
   begin
      AMF.Internals.Tables.UML_Attributes.Internal_Set_Value
       (Self.Element,
        AMF.Internals.Helpers.To_Element
         (AMF.Elements.Element_Access (To)));
   end Set_Value;

end AMF.Internals.UML_Link_End_Destruction_Datas;
