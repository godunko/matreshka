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

package body AMF.Internals.UML_Template_Parameter_Substitutions is

   -------------------
   -- Enter_Element --
   -------------------

   overriding procedure Enter_Element
    (Self    : not null access constant UML_Template_Parameter_Substitution_Proxy;
     Visitor : in out AMF.Visitors.Abstract_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      if Visitor in AMF.Visitors.UML_Visitors.UML_Visitor'Class then
         AMF.Visitors.UML_Visitors.UML_Visitor'Class
          (Visitor).Enter_Template_Parameter_Substitution
            (AMF.UML.Template_Parameter_Substitutions.UML_Template_Parameter_Substitution_Access (Self),
           Control);
      end if;
   end Enter_Element;

   -------------------
   -- Leave_Element --
   -------------------

   overriding procedure Leave_Element
    (Self    : not null access constant UML_Template_Parameter_Substitution_Proxy;
     Visitor : in out AMF.Visitors.Abstract_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control) is
   begin
      if Visitor in AMF.Visitors.UML_Visitors.UML_Visitor'Class then
         AMF.Visitors.UML_Visitors.UML_Visitor'Class
          (Visitor).Leave_Template_Parameter_Substitution
            (AMF.UML.Template_Parameter_Substitutions.UML_Template_Parameter_Substitution_Access (Self),
           Control);
      end if;
   end Leave_Element;

   -------------------
   -- Visit_Element --
   -------------------

   overriding procedure Visit_Element
    (Self     : not null access constant UML_Template_Parameter_Substitution_Proxy;
     Iterator : in out AMF.Visitors.Abstract_Iterator'Class;
     Visitor  : in out AMF.Visitors.Abstract_Visitor'Class;
     Control  : in out AMF.Visitors.Traverse_Control) is
   begin
      if Iterator in AMF.Visitors.UML_Iterators.UML_Iterator'Class then
         AMF.Visitors.UML_Iterators.UML_Iterator'Class
          (Iterator).Visit_Template_Parameter_Substitution
            (Visitor,
             AMF.UML.Template_Parameter_Substitutions.UML_Template_Parameter_Substitution_Access (Self),
             Control);
      end if;
   end Visit_Element;

   ----------------
   -- Get_Actual --
   ----------------

   overriding function Get_Actual
    (Self : not null access constant UML_Template_Parameter_Substitution_Proxy)
       return AMF.UML.Parameterable_Elements.UML_Parameterable_Element_Access is
   begin
      return
        AMF.UML.Parameterable_Elements.UML_Parameterable_Element_Access
         (AMF.Internals.Helpers.To_Element
           (AMF.Internals.Tables.UML_Attributes.Internal_Get_Actual
             (Self.Element)));
   end Get_Actual;

   ----------------
   -- Set_Actual --
   ----------------

   overriding procedure Set_Actual
    (Self : not null access UML_Template_Parameter_Substitution_Proxy;
     To   : AMF.UML.Parameterable_Elements.UML_Parameterable_Element_Access) is
   begin
      AMF.Internals.Tables.UML_Attributes.Internal_Set_Actual
       (Self.Element,
        AMF.Internals.Helpers.To_Element
         (AMF.Elements.Element_Access (To)));
   end Set_Actual;

   ----------------
   -- Get_Formal --
   ----------------

   overriding function Get_Formal
    (Self : not null access constant UML_Template_Parameter_Substitution_Proxy)
       return AMF.UML.Template_Parameters.UML_Template_Parameter_Access is
   begin
      return
        AMF.UML.Template_Parameters.UML_Template_Parameter_Access
         (AMF.Internals.Helpers.To_Element
           (AMF.Internals.Tables.UML_Attributes.Internal_Get_Formal
             (Self.Element)));
   end Get_Formal;

   ----------------
   -- Set_Formal --
   ----------------

   overriding procedure Set_Formal
    (Self : not null access UML_Template_Parameter_Substitution_Proxy;
     To   : AMF.UML.Template_Parameters.UML_Template_Parameter_Access) is
   begin
      AMF.Internals.Tables.UML_Attributes.Internal_Set_Formal
       (Self.Element,
        AMF.Internals.Helpers.To_Element
         (AMF.Elements.Element_Access (To)));
   end Set_Formal;

   ----------------------
   -- Get_Owned_Actual --
   ----------------------

   overriding function Get_Owned_Actual
    (Self : not null access constant UML_Template_Parameter_Substitution_Proxy)
       return AMF.UML.Parameterable_Elements.UML_Parameterable_Element_Access is
   begin
      return
        AMF.UML.Parameterable_Elements.UML_Parameterable_Element_Access
         (AMF.Internals.Helpers.To_Element
           (AMF.Internals.Tables.UML_Attributes.Internal_Get_Owned_Actual
             (Self.Element)));
   end Get_Owned_Actual;

   ----------------------
   -- Set_Owned_Actual --
   ----------------------

   overriding procedure Set_Owned_Actual
    (Self : not null access UML_Template_Parameter_Substitution_Proxy;
     To   : AMF.UML.Parameterable_Elements.UML_Parameterable_Element_Access) is
   begin
      AMF.Internals.Tables.UML_Attributes.Internal_Set_Owned_Actual
       (Self.Element,
        AMF.Internals.Helpers.To_Element
         (AMF.Elements.Element_Access (To)));
   end Set_Owned_Actual;

   --------------------------
   -- Get_Template_Binding --
   --------------------------

   overriding function Get_Template_Binding
    (Self : not null access constant UML_Template_Parameter_Substitution_Proxy)
       return AMF.UML.Template_Bindings.UML_Template_Binding_Access is
   begin
      return
        AMF.UML.Template_Bindings.UML_Template_Binding_Access
         (AMF.Internals.Helpers.To_Element
           (AMF.Internals.Tables.UML_Attributes.Internal_Get_Template_Binding
             (Self.Element)));
   end Get_Template_Binding;

   --------------------------
   -- Set_Template_Binding --
   --------------------------

   overriding procedure Set_Template_Binding
    (Self : not null access UML_Template_Parameter_Substitution_Proxy;
     To   : AMF.UML.Template_Bindings.UML_Template_Binding_Access) is
   begin
      AMF.Internals.Tables.UML_Attributes.Internal_Set_Template_Binding
       (Self.Element,
        AMF.Internals.Helpers.To_Element
         (AMF.Elements.Element_Access (To)));
   end Set_Template_Binding;

end AMF.Internals.UML_Template_Parameter_Substitutions;
