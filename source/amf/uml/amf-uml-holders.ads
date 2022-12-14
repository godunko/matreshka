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
with League.Holders;

package AMF.UML.Holders is

   pragma Preelaborate;

   --  AggregationKind [0..1]

   function Element
    (Holder : League.Holders.Holder)
       return AMF.UML.Optional_UML_Aggregation_Kind;
   function To_Holder
    (Element : AMF.UML.Optional_UML_Aggregation_Kind)
       return League.Holders.Holder;

   --  CallConcurrencyKind [0..1]

   function Element
    (Holder : League.Holders.Holder)
       return AMF.UML.Optional_UML_Call_Concurrency_Kind;
   function To_Holder
    (Element : AMF.UML.Optional_UML_Call_Concurrency_Kind)
       return League.Holders.Holder;

   --  ConnectorKind [0..1]

   function Element
    (Holder : League.Holders.Holder)
       return AMF.UML.Optional_UML_Connector_Kind;
   function To_Holder
    (Element : AMF.UML.Optional_UML_Connector_Kind)
       return League.Holders.Holder;

   --  ExpansionKind [0..1]

   function Element
    (Holder : League.Holders.Holder)
       return AMF.UML.Optional_UML_Expansion_Kind;
   function To_Holder
    (Element : AMF.UML.Optional_UML_Expansion_Kind)
       return League.Holders.Holder;

   --  InteractionOperatorKind [0..1]

   function Element
    (Holder : League.Holders.Holder)
       return AMF.UML.Optional_UML_Interaction_Operator_Kind;
   function To_Holder
    (Element : AMF.UML.Optional_UML_Interaction_Operator_Kind)
       return League.Holders.Holder;

   --  MessageKind [0..1]

   function Element
    (Holder : League.Holders.Holder)
       return AMF.UML.Optional_UML_Message_Kind;
   function To_Holder
    (Element : AMF.UML.Optional_UML_Message_Kind)
       return League.Holders.Holder;

   --  MessageSort [0..1]

   function Element
    (Holder : League.Holders.Holder)
       return AMF.UML.Optional_UML_Message_Sort;
   function To_Holder
    (Element : AMF.UML.Optional_UML_Message_Sort)
       return League.Holders.Holder;

   --  ObjectNodeOrderingKind [0..1]

   function Element
    (Holder : League.Holders.Holder)
       return AMF.UML.Optional_UML_Object_Node_Ordering_Kind;
   function To_Holder
    (Element : AMF.UML.Optional_UML_Object_Node_Ordering_Kind)
       return League.Holders.Holder;

   --  ParameterDirectionKind [0..1]

   function Element
    (Holder : League.Holders.Holder)
       return AMF.UML.Optional_UML_Parameter_Direction_Kind;
   function To_Holder
    (Element : AMF.UML.Optional_UML_Parameter_Direction_Kind)
       return League.Holders.Holder;

   --  ParameterEffectKind [0..1]

   function Element
    (Holder : League.Holders.Holder)
       return AMF.UML.Optional_UML_Parameter_Effect_Kind;
   function To_Holder
    (Element : AMF.UML.Optional_UML_Parameter_Effect_Kind)
       return League.Holders.Holder;

   --  PseudostateKind [0..1]

   function Element
    (Holder : League.Holders.Holder)
       return AMF.UML.Optional_UML_Pseudostate_Kind;
   function To_Holder
    (Element : AMF.UML.Optional_UML_Pseudostate_Kind)
       return League.Holders.Holder;

   --  TransitionKind [0..1]

   function Element
    (Holder : League.Holders.Holder)
       return AMF.UML.Optional_UML_Transition_Kind;
   function To_Holder
    (Element : AMF.UML.Optional_UML_Transition_Kind)
       return League.Holders.Holder;

   --  VisibilityKind [0..1]

   function Element
    (Holder : League.Holders.Holder)
       return AMF.UML.Optional_UML_Visibility_Kind;
   function To_Holder
    (Element : AMF.UML.Optional_UML_Visibility_Kind)
       return League.Holders.Holder;

end AMF.UML.Holders;
