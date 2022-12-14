------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--         Localization, Internationalization, Globalization for Ada        --
--                                                                          --
--                              Tools Component                             --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2011-2015, Vadim Godunko <vgodunko@gmail.com>                --
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
with League.String_Vectors;
with League.Strings;
with Ada.Containers.Ordered_Maps;
with Ada.Containers.Vectors;
with Matreshka.Internals.Finite_Automatons;

package UAFLEX.Nodes is

   type Node_Kind is (Text, Rule, Macro, Name_List);

   type Node (Kind : Node_Kind := Node_Kind'First) is record
      case Kind is
         when Text =>
            Value : League.Strings.Universal_String;
         when Rule =>
            Regexp : League.Strings.Universal_String;
            Action : League.Strings.Universal_String;
         when Macro =>
            Name : League.Strings.Universal_String;
            Text : League.Strings.Universal_String;
         when Name_List =>
            List : League.String_Vectors.Universal_String_Vector;
      end case;
   end record;

   subtype Rule_Node is Node (Rule);

   function To_Node (Value : League.Strings.Universal_String) return Node;
   function To_Action (Value : League.Strings.Universal_String) return Node;

   Empty_Name_List : constant Node (Name_List) :=
     (Kind => Name_List, List => <>);

   use type League.Strings.Universal_String;

   package Macro_Maps is new Ada.Containers.Ordered_Maps
     (League.Strings.Universal_String,   --  Macro name
      League.Strings.Universal_String);  --  Macro value

   package Positive_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Positive,
      Element_Type => Positive);

   type Start_Condition is record
      Exclusive : Boolean;
      Rules     : Positive_Vectors.Vector;
   end record;

   package Start_Condition_Maps is new Ada.Containers.Ordered_Maps
     (League.Strings.Universal_String,   --  Condition name
      Start_Condition);

   type Shared_Pattern_Array_Access is access all
     Matreshka.Internals.Finite_Automatons.Shared_Pattern_Array;

   --  List of regexp from input file
   Rules      : League.String_Vectors.Universal_String_Vector;
   --  List of DISTINCT action from input file
   Actions    : League.String_Vectors.Universal_String_Vector;
   --  Map rule index to action index
   Indexes    : Positive_Vectors.Vector;
   --  Map rule index to input file line number
   Lines      : Positive_Vectors.Vector;
   --  Map condition name to Start_Condition
   Conditions : Start_Condition_Maps.Map;
   --  Map macros name to macros value
   Macros     : Macro_Maps.Map;
   --  Array of compiled regexps
   Regexp     : Shared_Pattern_Array_Access;

   Success : Boolean := True;

   procedure Add_Start_Conditions
     (List      : League.String_Vectors.Universal_String_Vector;
      Exclusive : Boolean);

   procedure Add_Rule
     (RegExp : League.Strings.Universal_String;
      Action : League.Strings.Universal_String;
      Line   : Positive);

end UAFLEX.Nodes;
