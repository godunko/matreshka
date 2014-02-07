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
--  $Revision$ $Date$
------------------------------------------------------------------------------

with XML.Schema.Complex_Type_Definitions;
with XML.Schema.Model_Groups;
with XML.Schema.Named_Maps;
with XML.Schema.Object_Lists;
with XML.Schema.Terms;
with XML.Schema.Particles;

with XSD_To_Ada.Utils;

package body XSD2Ada.Analyzer is

   use type League.Strings.Universal_String;
   use all type XML.Schema.Complex_Type_Definitions.Content_Types;

   procedure Add_Node
    (Vector : in out Items;
     Value  : Item);

   procedure Traverse_Type_Definition
    (Type_D        : XML.Schema.Type_Definitions.XS_Type_Definition;
     Node_Vector   : in out Items;
     Anonym_Prefix : League.Strings.Universal_String);
   --  Recursive find all types in dependency for Type_D and add them to
   --  Node_Vector. Use Anonym_Prefix to name anonymous items

   procedure Traverse_Model_Group
     (XS_Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
      Node_Vector    : in out Items;
      Anonym_Prefix  : League.Strings.Universal_String);
   --  Recursive find all types in dependency for XS_Model_Group and add them
   --  to Node_Vector. Use Anonym_Prefix to name anonymous items

   procedure Traverse_Term
     (XS_Term       : XML.Schema.Terms.XS_Term;
      Node_Vector   : in out Items;
      Anonym_Prefix : League.Strings.Universal_String;
      Max_Occurs    : XML.Schema.Particles.Unbounded_Natural;
      Min_Occurs    : Natural);
   --  Recursive find all types in dependency for XS_Term and add them
   --  to Node_Vector. Use Anonym_Prefix to name anonymous items

   procedure Create_Node_Vector
     (Object       : XML.Schema.Objects.XS_Object'Class;
      Node_Vector  : in out XSD2Ada.Analyzer.Items;
      Min_Occurs   : Natural;
      Max_Occurs   : XML.Schema.Particles.Unbounded_Natural;
      Element_Name : League.Strings.Universal_String
        := League.Strings.Empty_Universal_String;
      Anonym_Name  : League.Strings.Universal_String
        := League.Strings.Empty_Universal_String);

   --------------
   -- Add_Node --
   --------------

   procedure Add_Node
    (Vector : in out Items;
     Value  : Item)
   is
      function Contains (X : Item'Class) return Boolean;

      --------------
      -- Contains --
      --------------

      function Contains (X : Item'Class) return Boolean is
      begin
         for J of Vector loop
            if J.all = X then
               return True;
            end if;
         end loop;

         return False;
      end Contains;

      Difinition_Node : XSD2Ada.Analyzer.Item;
   begin
      Difinition_Node := Value;
      Difinition_Node.Min := False;
      Difinition_Node.Max := False;
      Difinition_Node.Element_Name.Clear;

      if not Value.Anonym_Name.Is_Empty then
         Difinition_Node.Short_Ada_Type_Name := XSD_To_Ada.Utils.Add_Separator
           (Value.Anonym_Name) & "_Anonym";
      else
         Difinition_Node.Short_Ada_Type_Name := XSD_To_Ada.Utils.Add_Separator
           (Value.Object.Get_Name);
      end if;

      if not Contains (Difinition_Node) then

         if not Value.Object.Get_Name.Is_Empty
           or not Value.Anonym_Name.Is_Empty
         then
            Vector.Append (new Item'(Difinition_Node));
         end if;
      end if;

      if Value.Max then
         Difinition_Node.Max := True;

         if not Contains (Difinition_Node) then
            Vector.Append (new Item'(Difinition_Node));
         end if;

         Difinition_Node.Max := False;
      end if;

      if Value.Min then
         Difinition_Node.Min := True;

         if not Contains (Difinition_Node) then
            Vector.Append (new Item'(Difinition_Node));
         end if;

         Difinition_Node.Min := False;
      end if;

      if not Value.Element_Name.Is_Empty
        and then Value.Type_Def.Get_Name /=
          Value.Element_Name
      then
         Difinition_Node.Element_Name.Append
           (Value.Element_Name);

         if not Contains (Difinition_Node) then
            Vector.Append (new Item'(Difinition_Node));
         end if;

         Difinition_Node.Element_Name.Clear;
      end if;
   end Add_Node;

   -----------------
   -- Anonym_Name --
   -----------------

   function Anonym_Name (Self : Item) return League.Strings.Universal_String is
   begin
      return Self.Anonym_Name;
   end Anonym_Name;

   ------------
   -- Choice --
   ------------

   function Choice (Self : Item) return Boolean is
   begin
      return XSD_To_Ada.Utils.Is_Choice (Self.Type_Def);
   end Choice;

   -------------------------
   -- Create_Element_Node --
   -------------------------

   procedure Create_Element_Node
     (Element     : XML.Schema.Element_Declarations.XS_Element_Declaration;
      Node_Vector : in out XSD2Ada.Analyzer.Items) is
   begin
      XSD2Ada.Analyzer.Create_Node_Vector
        (Element.Get_Type_Definition,
         Node_Vector,
         1, (False, 1),
         Element.Get_Name);
   end Create_Element_Node;

   -------------------------
   -- Create_Element_Type --
   -------------------------

   procedure Create_Element_Nodes
    (Model       : XML.Schema.Models.XS_Model;
     Node_Vector : in out Items)
   is
      Element_Declarations : constant XML.Schema.Named_Maps.XS_Named_Map
        := Model.Get_Components_By_Namespace
            (Object_Type => XML.Schema.Element_Declaration,
             Namespace   => XSD_To_Ada.Utils.Namespace);
   begin
      for J in 1 .. Element_Declarations.Length loop
         Create_Element_Node
           (Element_Declarations.Item (J).To_Element_Declaration,
            Node_Vector);
      end loop;
   end Create_Element_Nodes;

   ------------------------
   -- Create_Node_Vector --
   ------------------------

   procedure Create_Node_Vector
     (Object       : XML.Schema.Objects.XS_Object'Class;
      Node_Vector  : in out XSD2Ada.Analyzer.Items;
      Min_Occurs   : Natural;
      Max_Occurs   : XML.Schema.Particles.Unbounded_Natural;
      Element_Name : League.Strings.Universal_String
        := League.Strings.Empty_Universal_String;
      Anonym_Name  : League.Strings.Universal_String
        := League.Strings.Empty_Universal_String)
   is
      use type XML.Schema.Particles.Unbounded_Natural;

      Item : XSD2Ada.Analyzer.Item;

   begin
      Item.Object := XML.Schema.Objects.XS_Object (Object);
      Item.Element_Name := Element_Name;
      Item.Anonym_Name := Anonym_Name;

      Item.Max := Max_Occurs /= (False, 1);
      Item.Min := Min_Occurs = 0;

      if Object.Is_Type_Definition then
         Traverse_Type_Definition
           (Object.To_Type_Definition,
            Node_Vector,
            XSD_To_Ada.Utils.Add_Separator (Object.Get_Name));
      elsif Object.Is_Model_Group then
         Traverse_Model_Group
           (Object.To_Model_Group,
            Node_Vector,
            Anonym_Name);
      else
         raise Constraint_Error;
      end if;

      Add_Node (Node_Vector, Item);
   end Create_Node_Vector;

   ----------------------
   -- Create_Type_Node --
   ----------------------

   procedure Create_Type_Node
     (Type_D      : XML.Schema.Type_Definitions.XS_Type_Definition;
      Node_Vector : in out XSD2Ada.Analyzer.Items) is
   begin
      Create_Node_Vector
        (Object       => Type_D,
         Node_Vector  => Node_Vector,
         Min_Occurs   => 1,
         Max_Occurs   => (False, 1));
   end Create_Type_Node;

   ------------------
   -- Element_Name --
   ------------------

   function Element_Name
     (Self : Item) return League.Strings.Universal_String is
   begin
      return Self.Element_Name;
   end Element_Name;

   ---------------------------
   -- Full_Ada_Package_Name --
   ---------------------------

   function Full_Ada_Package_Name
     (Self : Item) return League.Strings.Universal_String
   is
      pragma Unreferenced (Self);
   begin
      return League.Strings.To_Universal_String ("Payloads");
   end Full_Ada_Package_Name;

   ------------------------
   -- Full_Ada_Type_Name --
   ------------------------

   function Full_Ada_Type_Name
     (Self : Item) return League.Strings.Universal_String is
   begin
      return Self.Full_Ada_Package_Name & "." & Self.Short_Ada_Type_Name;
   end Full_Ada_Type_Name;

   ---------
   -- Max --
   ---------

   function Max (Self : Item) return Boolean is
   begin
      return Self.Max;
   end Max;

   ---------
   -- Min --
   ---------

   function Min (Self : Item) return Boolean is
   begin
      return Self.Min;
   end Min;

   ------------
   -- Object --
   ------------

   function Object (Self : Item) return XML.Schema.Objects.XS_Object is
   begin
      return Self.Object;
   end Object;

   -------------------------
   -- Short_Ada_Type_Name --
   -------------------------

   function Short_Ada_Type_Name
     (Self : Item) return League.Strings.Universal_String is
   begin
      return Self.Short_Ada_Type_Name;
   end Short_Ada_Type_Name;

   --------------------------
   -- Traverse_Model_Group --
   --------------------------

   procedure Traverse_Model_Group
     (XS_Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
      Node_Vector    : in out Items;
      Anonym_Prefix  : League.Strings.Universal_String)
   is
      XS_Particle : XML.Schema.Particles.XS_Particle;
      XS_List     : constant XML.Schema.Object_Lists.XS_Object_List :=
        XS_Model_Group.Get_Particles;
   begin
      for J in 1 .. XS_List.Get_Length loop
         XS_Particle := XS_List.Item (J).To_Particle;

         Traverse_Term
           (XS_Particle.Get_Term,
            Node_Vector,
            Anonym_Prefix,
            XS_Particle.Get_Max_Occurs,
            XS_Particle.Get_Min_Occurs);
      end loop;
   end Traverse_Model_Group;

   ----------------
   -- Print_Term --
   ----------------

   procedure Traverse_Term
     (XS_Term       : XML.Schema.Terms.XS_Term;
      Node_Vector   : in out Items;
      Anonym_Prefix : League.Strings.Universal_String;
      Max_Occurs    : XML.Schema.Particles.Unbounded_Natural;
      Min_Occurs    : Natural)
   is
      Decl        : XML.Schema.Element_Declarations.XS_Element_Declaration;
      Type_D      : XML.Schema.Type_Definitions.XS_Type_Definition;
      Anonym_Name : League.Strings.Universal_String;
   begin
      if XS_Term.Is_Model_Group then
         Create_Node_Vector
           (Object       => XS_Term,
            Node_Vector  => Node_Vector,
            Min_Occurs   => Min_Occurs,
            Max_Occurs   => Max_Occurs,
            Anonym_Name  => Anonym_Prefix);

      elsif XS_Term.Is_Element_Declaration then

         Decl := XS_Term.To_Element_Declaration;
         Type_D := Decl.Get_Type_Definition;

         if Type_D.Get_Name.Is_Empty then
            if not Anonym_Prefix.Is_Empty then
               Anonym_Name := Anonym_Prefix;
               Anonym_Name.Append ("_");
            end if;

            Anonym_Name.Append
              (XSD_To_Ada.Utils.Add_Separator (Decl.Get_Name));

         end if;

         Create_Node_Vector
           (Object       => Type_D,
            Node_Vector  => Node_Vector,
            Min_Occurs   => Min_Occurs,
            Max_Occurs   => Max_Occurs,
            Anonym_Name  => Anonym_Name);
      end if;
   end Traverse_Term;

   --------------------------
   -- Node_Type_Definition --
   --------------------------

   procedure Traverse_Type_Definition
     (Type_D        : XML.Schema.Type_Definitions.XS_Type_Definition;
      Node_Vector   : in out Items;
      Anonym_Prefix : League.Strings.Universal_String)
   is
      use type XML.Schema.Type_Definitions.XS_Type_Definition;

      XS_Particle    : XML.Schema.Particles.XS_Particle;
      XS_Term        : XML.Schema.Terms.XS_Term;
      XS_Base        : XML.Schema.Type_Definitions.XS_Type_Definition;

      CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;

   begin
      XS_Base := Type_D.Get_Base_Type;

      if XS_Base.Get_Type_Category in
        XML.Schema.Complex_Type and XS_Base /= Type_D
      then

         if XS_Base.Get_Name.To_UTF_8_String /= "anyType" then
            XSD2Ada.Analyzer.Create_Node_Vector
              (XS_Base,
               Node_Vector,
               1, (False, 1));
         end if;
      end if;

      case Type_D.Get_Type_Category is
         when XML.Schema.Complex_Type =>
            CTD := Type_D.To_Complex_Type_Definition;

            if CTD.Get_Content_Type in Element_Only | Mixed then
               XS_Particle := CTD.Get_Particle;
               XS_Term := XS_Particle.Get_Term;

               Traverse_Term
                 (XS_Term,
                  Node_Vector,
                  Anonym_Prefix,
                  XS_Particle.Get_Max_Occurs,
                  XS_Particle.Get_Min_Occurs);

            end if;

         when XML.Schema.Simple_Type =>
            null;

         when XML.Schema.None =>
            raise Constraint_Error;
      end case;
   end Traverse_Type_Definition;

   --------------
   -- Type_Def --
   --------------

   function Type_Def
     (Self : Item) return XML.Schema.Type_Definitions.XS_Type_Definition is
   begin
      return Self.Object.To_Type_Definition;
   end Type_Def;

end XSD2Ada.Analyzer;
