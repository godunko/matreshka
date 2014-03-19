------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               XML Processor                              --
--                                                                          --
--                              Tools Component                             --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2014, Vadim Godunko <vgodunko@gmail.com>                     --
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
--  $Revision: 4279 $ $Date: 2013-11-19 14:27:35 +0200 (Вт., 19 нояб. 2013) $
------------------------------------------------------------------------------

with Ada.Wide_Wide_Text_IO;
with Ada.Containers.Hashed_Maps;

with XML.Schema;
with XML.Schema.Objects.Hash;
with XML.Schema.Type_Definitions;
with XML.Schema.Complex_Type_Definitions;
with XML.Schema.Particles;
with XML.Schema.Terms;

with XSD_To_Ada.Writers;

package body XSD_To_Ada.Decoder is

   type Type_Info is record
      First_State : Positive;
   end record;

   package Object_Hash_Maps is new Ada.Containers.Hashed_Maps
     (Key_Type        => XML.Schema.Objects.XS_Object,
      Element_Type    => Type_Info,
      Hash            => XML.Schema.Objects.Hash,
      Equivalent_Keys => XML.Schema.Objects."=",
      "="             => "=");

   procedure Traverse_Object
     (Object : XML.Schema.Objects.XS_Object;
      Map    : in out Object_Hash_Maps.Map;
      State  : in out Positive);

   --------------
   -- Generate --
   --------------

   procedure Generate (Items : XSD2Ada.Analyzer.Items) is
      Map   : Object_Hash_Maps.Map;
      Spec  : XSD_To_Ada.Writers.Writer;
      Impl  : XSD_To_Ada.Writers.Writer;
      State : Positive := 1;
      Info  : Type_Info;
   begin
      for X of Items loop
         Info.First_State := State;
         Traverse_Object (X.Object, Map, State);
         Map.Insert (X.Object, Info);
         State := State + 1;
      end loop;

      Spec.P ("with League.Strings;");
      Spec.P ("with Web_Services.SOAP.Payloads.Decoders;");
      Spec.P ("with XML.SAX.Attributes;");
      Spec.P;
      Spec.P ("package Decoder is");
      Impl.P ("package body Decoder is");
      Spec.P;
      Spec.P ("   type Decoder is");
      Spec.P ("     limited new Web_Services.SOAP.Payloads.Decoders."
                & "SOAP_Payload_Decoder");
      Spec.P ("   with private;");
      Spec.P;
      Spec.P ("private");
      Spec.P;
      Spec.P ("   type State_Array is array (1 .. 10) of Natural;");
      Spec.P;

      Spec.P ("   type Decoder is");
      Spec.P ("     limited new Web_Services.SOAP.Payloads.Decoders."
                & "SOAP_Payload_Decoder");
      Spec.P ("   with record");
      Spec.P ("       --  State stack");
      Spec.P ("       States : State_Array := (1 => 0, others => <>);");
      Spec.P ("       Top    : Positive := 1;");
      Spec.P ("       --  Current payload element");
      Spec.P ("       Payload : Web_Services.SOAP.Payloads."
                & "SOAP_Payload_Access;");
      Spec.P ("       --  Place to collect characters text");
      Spec.P ("       Characters     : League.Strings.Universal_String;");
--      Spec.P ("       Has_Characters : Boolean;");
      Spec.P ("       --  For each payload define access component");
      Spec.P ("       P_Close_Session : Close_Session_Access;");
      Spec.P ("       --  For each type define value component");
      Spec.P ("       V_Session_Identifier : League.Strings."
        & "Universal_String;");
      Spec.P ("   end record;");
      Spec.P;
      Spec.P ("   overriding procedure Characters", Impl);
      Spec.P ("    (Self    : in out Decoder;", Impl);
      Spec.P ("     Text    : League.Strings.Universal_String;", Impl);
      Spec.N ("     Success : in out Boolean)", Impl);
      Spec.P (";");
      Impl.P (" is");
      Impl.P ("   begin");
      Impl.P ("      Self.Characters.Append (Text);");
--      Impl.P ("      Self.Has_Characters := True;");
      Impl.P ("   end Characters;");
      Impl.P;

      Spec.P;
      Spec.P ("   overriding function Create", Impl);
      Spec.P
        ("    (URI : not null access League.Strings.Universal_String)", Impl);
      Spec.N ("       return Decoder", Impl);
      Spec.P (";");
      Impl.P;
      Impl.P ("   is");
      Impl.P ("      pragma Unreferenced (URI);");
      Impl.P ("   begin");
      Impl.P ("      return X : Decoder;");
      Impl.P ("   end Create;");
      Impl.P;

      Spec.P;
      Spec.P ("   overriding function Payload", Impl);
      Spec.P ("    (Self : Decoder)", Impl);
      Spec.N ("       return not null Web_Services.SOAP.Payloads."
              & "SOAP_Payload_Access", Impl);
      Spec.P (";");
      Impl.P (" is");
      Impl.P ("   begin");
      Impl.P ("      return Self.Payload;");
      Impl.P ("   end Payload;");
      Impl.P;

      Spec.P;
      Spec.P ("   overriding procedure End_Element", Impl);
      Spec.P ("    (Self          : in out Decoder;", Impl);
      Spec.P ("     Namespace_URI : League.Strings.Universal_String;", Impl);
      Spec.P ("     Local_Name    : League.Strings.Universal_String;", Impl);
      Spec.N ("     Success       : in out Boolean)", Impl);
      Spec.P (";");
      Impl.P (" is");
      Impl.P ("   begin");
      Impl.P ("      null;");
      Impl.P ("   end End_Element;");
      Impl.P;

      Spec.P;
      Spec.P ("   overriding procedure Start_Element", Impl);
      Spec.P ("    (Self          : in out Decoder;", Impl);
      Spec.P ("     Namespace_URI : League.Strings.Universal_String;", Impl);
      Spec.P ("     Local_Name    : League.Strings.Universal_String;", Impl);
      Spec.P ("     Attributes    : XML.SAX.Attributes.SAX_Attributes;", Impl);
      Spec.N ("     Success       : in out Boolean)", Impl);
      Spec.P (";");
      Impl.P (" is");
      Impl.P ("   begin");
      Impl.P ("      Self.Characters.Clear;");
      Impl.P ("   end Start_Element;");
      Impl.P;
      Spec.P;

      Spec.P ("end Decoder;", Impl);

      Ada.Wide_Wide_Text_IO.Put_Line (Spec.Text.To_Wide_Wide_String);
      Ada.Wide_Wide_Text_IO.Put_Line (Impl.Text.To_Wide_Wide_String);
   end Generate;

   ---------------------
   -- Traverse_Object --
   ---------------------

   procedure Traverse_Object
     (Object : XML.Schema.Objects.XS_Object;
      Map    : in out Object_Hash_Maps.Map;
      State  : in out Positive)
   is
      use XML.Schema.Complex_Type_Definitions;

      procedure Traverse_Term
        (Term       : XML.Schema.Terms.XS_Term;
         Max_Occurs : XML.Schema.Particles.Unbounded_Natural;
         Min_Occurs : Natural) is null;

      XS_Particle    : XML.Schema.Particles.XS_Particle;
      Type_D : XML.Schema.Type_Definitions.XS_Type_Definition;
      CTD    : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;
   begin
      if Object.Is_Type_Definition then
         Type_D := Object.To_Type_Definition;

         case Type_D.Get_Type_Category is
            when XML.Schema.Complex_Type =>
               CTD := Type_D.To_Complex_Type_Definition;

               if CTD.Get_Content_Type in Element_Only | Mixed then
                  XS_Particle := CTD.Get_Particle;

                  Traverse_Term
                    (XS_Particle.Get_Term,
                     XS_Particle.Get_Max_Occurs,
                     XS_Particle.Get_Min_Occurs);

               end if;

            when XML.Schema.Simple_Type =>
               null;

            when XML.Schema.None =>
               raise Constraint_Error;
         end case;
         --      elsif Object.Is_Model_Group
      end if;

      Map.Insert (Object, (First_State => State));
      State := State + 1;
   end Traverse_Object;

end XSD_To_Ada.Decoder;
