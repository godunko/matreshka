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

pragma Style_Checks ("N");

package body XSD2Ada.Analyzer is

   use type League.Strings.Universal_String;
   use all type XML.Schema.Complex_Type_Definitions.Content_Types;

   procedure Add_Node
    (Vector : in out Items;
     Value  : Item);

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
         for Index of Vector loop
            if Index.all = X then
               return True;
            end if;
         end loop;

         return False;
      end Contains;

      Definition_Node : XSD2Ada.Analyzer.Item;
   begin
      Definition_Node := Value;
      Definition_Node.Min := False;
      Definition_Node.Max := False;
      Definition_Node.Element_Name.Clear;

      Definition_Node.Short_Ada_Type_Name := Value.Short_Ada_Type_Name;

      if Value.Element_Name.To_Wide_Wide_String /=
        Value.Object.Get_Name.To_Wide_Wide_String
          and then not Value.Object.Get_Name.Is_Empty
      then
         Definition_Node.Element_Name := Value.Element_Name;
      end if;

      if not Contains (Definition_Node) then
         Vector.Append (new Item'(Definition_Node));
      end if;

      if Value.Max then
         Definition_Node.Max := True;

         Definition_Node.Short_Ada_Type_Name :=
           Definition_Node.Short_Ada_Type_Name & "_Vector";

         if not Contains (Definition_Node) then
            Vector.Append (new Item'(Definition_Node));
         end if;

         Definition_Node.Max := False;
      end if;

      if Value.Min then
         Definition_Node.Min := True;

         Definition_Node.Short_Ada_Type_Name :=
           "Optional_" & Definition_Node.Short_Ada_Type_Name;

         if not Contains (Definition_Node) then
            Vector.Append (new Item'(Definition_Node));
         end if;

         Definition_Node.Min := False;
      end if;
   end Add_Node;

   ------------
   -- Choice --
   ------------

   function Choice (Self : Item) return Boolean is
      use type XML.Schema.Model_Groups.Compositor_Kinds;
   begin
      if Self.Object.Is_Type_Definition then
         return XSD_To_Ada.Utils.Is_Choice (Self.Type_Def);
      else
         return Self.Object.To_Model_Group.Get_Compositor =
           XML.Schema.Model_Groups.Compositor_Choice;
      end if;
   end Choice;

   -------------------------
   -- Short_Ada_Type_Name --
   -------------------------

   function Short_Ada_Type_Name
     (Self : Item) return League.Strings.Universal_String is
   begin
      return Self.Short_Ada_Type_Name;
   end Short_Ada_Type_Name;

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
     (Object           : XML.Schema.Objects.XS_Object'Class;
      Node_Vector      : in out XSD2Ada.Analyzer.Items;
      Min_Occurs       : Natural;
      Max_Occurs       : XML.Schema.Particles.Unbounded_Natural;
      Element_Name     : League.Strings.Universal_String
      := League.Strings.Empty_Universal_String;
      Anonym_Name      : League.Strings.Universal_String
      := League.Strings.Empty_Universal_String;
      Short_Ada_Type_Name : League.Strings.Universal_String
      := League.Strings.Empty_Universal_String);

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
           (XS_Term       => XS_Particle.Get_Term,
            Node_Vector   => Node_Vector,
            Anonym_Prefix => Anonym_Prefix,
            Max_Occurs    => XS_Particle.Get_Max_Occurs,
            Min_Occurs    => XS_Particle.Get_Min_Occurs);
      end loop;
   end Traverse_Model_Group;

   -------------------------
   -- Create_Element_Node --
   -------------------------

   procedure Create_Element_Node
     (Element     : XML.Schema.Element_Declarations.XS_Element_Declaration;
      Node_Vector : in out XSD2Ada.Analyzer.Items) is
   begin
      XSD2Ada.Analyzer.Create_Node_Vector
        (Object       => Element.Get_Type_Definition,
         Node_Vector  => Node_Vector,
         Min_Occurs   => 1,
         Max_Occurs   => (False, 1),
         Element_Name => Element.Get_Name,
         Short_Ada_Type_Name => Element.Get_Name);
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
      := League.Strings.Empty_Universal_String;
      Short_Ada_Type_Name : League.Strings.Universal_String
      := League.Strings.Empty_Universal_String)
   is
      use type XML.Schema.Particles.Unbounded_Natural;

      Item : XSD2Ada.Analyzer.Item;

   begin
      Item.Object       := XML.Schema.Objects.XS_Object (Object);
      Item.Element_Name := Element_Name;

      Item.Short_Ada_Type_Name := Short_Ada_Type_Name;

      Item.Max := Max_Occurs /= (False, 1);
      Item.Min := Min_Occurs = 0;

      if Object.Is_Type_Definition then
         if Object.Get_Name.Is_Empty then
            Traverse_Type_Definition
              (Type_D        => Object.To_Type_Definition,
               Node_Vector   => Node_Vector,
               Anonym_Prefix => Short_Ada_Type_Name);
         else
         Traverse_Type_Definition
           (Type_D        => Object.To_Type_Definition,
            Node_Vector   => Node_Vector,
            Anonym_Prefix =>
              XSD_To_Ada.Utils.Add_Separator (Object.Get_Name));
         end if;
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
      Node_Vector : in out XSD2Ada.Analyzer.Items;
      Mapping     : XSD_To_Ada.Mappings.Mapping) is
   begin
      Analyzer_Mapping := Mapping;

      Create_Node_Vector
        (Object       => Type_D,
         Node_Vector  => Node_Vector,
         Min_Occurs   => 1,
         Max_Occurs   => (False, 1),
         Short_Ada_Type_Name => Type_D.Get_Name);
   end Create_Type_Node;

   ------------------
   -- Element_Name --
   ------------------

   function Element_Name
     (Self : Item) return League.Strings.Universal_String is
   begin
      return Self.Element_Name;
   end Element_Name;

   -----------------
   -- Find_Object --
   -----------------

   function Find_Object
     (Node_Vector : XSD2Ada.Analyzer.Items;
      Object : XML.Schema.Objects.XS_Object'Class;
      Min_Occurs : Boolean;
      Max_Occurs : Boolean)
      return XSD2Ada.Analyzer.Item_Access
   is
      Item : XSD2Ada.Analyzer.Item_Access;

   begin
      for Index in 1 .. Natural (Node_Vector.Length) loop
         Item := Node_Vector.Element (Index);
         if Object.Is_Equal (Item.Object)
           and then Min_Occurs = Item.Min
           and then Max_Occurs = Item.Max
           and then Item.Element_Name.Is_Empty
         then
            return Item;
         end if;
      end loop;

      return Item;
   end Find_Object;
   -------------------
   -- Get_Type_Name --
   -------------------

   function Get_Type_Name
     (Item : XSD2Ada.Analyzer.Item_Access)
      return League.Strings.Universal_String is
   begin
      if Item.Object.Get_Name.Is_Empty then
         return Item.Full_Ada_Type_Name;
      else
         return
           Analyzer_Mapping.Ada_Type_Qualified_Name
             (XSD_Type_Name => Item.Object.Get_Name,
              Min_Occurs    => Item.Min,
              Max_Occurs    => Item.Max);
      end if;
   end Get_Type_Name;

   ---------------------------
   -- Full_Ada_Package_Name --
   ---------------------------

   function Full_Ada_Package_Name
     (Self : Item) return League.Strings.Universal_String
   is
      pragma Unreferenced (Self);
   begin
      return League.Strings.To_Universal_String ("IATS_Types");
   end Full_Ada_Package_Name;

   ------------------------
   -- Full_Ada_Type_Name --
   ------------------------

   function Full_Ada_Type_Name
     (Self : Item) return League.Strings.Universal_String is
   begin
      return Self.Full_Ada_Package_Name & "."
        & XSD_To_Ada.Utils.Add_Separator (Self.Short_Ada_Type_Name);
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
      use type XML.Schema.Model_Groups.Compositor_Kinds;
      use type XML.Schema.Objects.XS_Object;

      Decl        : XML.Schema.Element_Declarations.XS_Element_Declaration;
      Type_D      : XML.Schema.Type_Definitions.XS_Type_Definition;
      Anonym_Name : League.Strings.Universal_String;
   begin
      if XS_Term.Is_Model_Group then

         if XS_Term.To_Model_Group.Get_Compositor =
           XML.Schema.Model_Groups.Compositor_Choice
         then
            Create_Node_Vector
              (Object       => XS_Term,
               Node_Vector  => Node_Vector,
               Min_Occurs   => Min_Occurs,
               Max_Occurs   => Max_Occurs,
               Anonym_Name  => Anonym_Prefix & "Case",
               Short_Ada_Type_Name => Anonym_Prefix & "Case_Anonym");
         else
            Traverse_Model_Group (XS_Model_Group => XS_Term.To_Model_Group,
                                  Node_Vector    => Node_Vector,
                                  Anonym_Prefix  => Anonym_Prefix);
         end if;

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

            if not Anonym_Prefix.Is_Empty then
               Anonym_Name.Append ("_Anonym");
            end if;

            Create_Node_Vector
              (Object              => Type_D,
               Node_Vector         => Node_Vector,
               Min_Occurs          => Min_Occurs,
               Max_Occurs          => Max_Occurs,
               Anonym_Name         => Anonym_Name,
               Short_Ada_Type_Name => Anonym_Name);
         else
            Create_Node_Vector
              (Object              => Type_D,
               Node_Vector         => Node_Vector,
               Min_Occurs          => Min_Occurs,
               Max_Occurs          => Max_Occurs,
               Anonym_Name         => Anonym_Name,
               Short_Ada_Type_Name => Type_D.Get_Name);
         end if;
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
              (Object      => XS_Base,
               Node_Vector => Node_Vector,
               Min_Occurs  => 1,
               Max_Occurs  => (False, 1),
               Short_Ada_Type_Name => XS_Base.Get_Name);
         end if;
      end if;

      case Type_D.Get_Type_Category is
         when XML.Schema.Complex_Type =>
            CTD := Type_D.To_Complex_Type_Definition;

            if CTD.Get_Content_Type in Element_Only | Mixed then
               XS_Particle := CTD.Get_Particle;
               XS_Term := XS_Particle.Get_Term;

               Traverse_Model_Group (XS_Model_Group => XS_Term.To_Model_Group,
                                     Node_Vector    => Node_Vector,
                                     Anonym_Prefix  => Anonym_Prefix);
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

   ---------------
   -- Type_Name --
   ---------------

   function Type_Name
     (Name : League.Strings.Universal_String)
      return League.Strings.Universal_String is
   begin
      if Name.Slice (1, 9).To_Wide_Wide_String = "Optional_" then
         return Name.Slice (10, Name.Length);

      elsif Name.Ends_With ("_Vector") then
         return Name.Slice (1, Name.Length - 7);

      else
         return Name;
      end if;
   end Type_Name;

end XSD2Ada.Analyzer;
