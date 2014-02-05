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

with XSD_To_Ada.Utils;

package body XSD2Ada.Analyzer is

   use type League.Strings.Universal_String;
   use all type XML.Schema.Complex_Type_Definitions.Content_Types;

   procedure Add_Node
    (Node_Vector          : in out Items;
     Type_Difinition_Node : Item);

   function Has_Top_Level_Type
    (Type_D : XML.Schema.Type_Definitions.XS_Type_Definition)
       return Boolean;
   --  This function returns True if Type_D has Top Level Types and
   --  it was not created.

   procedure Node_Type_Definition
    (Type_D               : XML.Schema.Type_Definitions.XS_Type_Definition;
     Node_Vector          : in out Items;
     Type_Difinition_Node : Item;
     Name                 : League.Strings.Universal_String);

   --------------
   -- Add_Node --
   --------------

   procedure Add_Node
    (Node_Vector          : in out Items;
     Type_Difinition_Node : Item)
   is
      function Contains (X : Item'Class) return Boolean;

      --------------
      -- Contains --
      --------------

      function Contains (X : Item'Class) return Boolean is
      begin
         for J of Node_Vector loop
            if J.all = X then
               return True;
            end if;
         end loop;

         return False;
      end Contains;

      Difinition_Node : XSD2Ada.Analyzer.Item;
   begin
      Difinition_Node := Type_Difinition_Node;
      Difinition_Node.Min := False;
      Difinition_Node.Max := False;
      Difinition_Node.Element_Name.Clear;

      if not Contains (Difinition_Node) then

         if not Type_Difinition_Node.Type_Def.Get_Name.Is_Empty
           or not Type_Difinition_Node.Anonym_Name.Is_Empty
         then
            Node_Vector.Append (new Item'(Difinition_Node));
         end if;
      end if;

      if Type_Difinition_Node.Max then
         Difinition_Node.Max := True;

         if not Contains (Difinition_Node) then
            Node_Vector.Append (new Item'(Difinition_Node));
         end if;

         Difinition_Node.Max := False;
      end if;

      if Type_Difinition_Node.Min then
         Difinition_Node.Min := True;

         if not Contains (Difinition_Node) then
            Node_Vector.Append (new Item'(Difinition_Node));
         end if;

         Difinition_Node.Min := False;
      end if;

      if not Type_Difinition_Node.Element_Name.Is_Empty
        and then Type_Difinition_Node.Type_Def.Get_Name /=
          Type_Difinition_Node.Element_Name
      then
         Difinition_Node.Element_Name.Append
           (Type_Difinition_Node.Element_Name);

         if not Contains (Difinition_Node) then
            Node_Vector.Append (new Item'(Difinition_Node));
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
      return Self.Choice;
   end Choice;

   -------------------------
   -- Create_Element_Node --
   -------------------------

   procedure Create_Element_Node
     (Element     : XML.Schema.Element_Declarations.XS_Element_Declaration;
      Node_Vector : in out XSD2Ada.Analyzer.Items)
   is
      Type_D    : XML.Schema.Type_Definitions.XS_Type_Definition;
   begin
      Type_D := Element.Get_Type_Definition;
      XSD2Ada.Analyzer.Create_Node_Vector
        (Type_D,
         Node_Vector,
         1, (False, 1),
         Element.Get_Name);
   end Create_Element_Node;

   -------------------------
   -- Create_Element_Type --
   -------------------------

   procedure Create_Element_Type
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
   end Create_Element_Type;

   ------------------------
   -- Create_Node_Vector --
   ------------------------

   procedure Create_Node_Vector
    (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
     Node_Vector  : in out XSD2Ada.Analyzer.Items;
     Min_Occurs   : Natural;
     Max_Occurs   : XML.Schema.Particles.Unbounded_Natural;
     Element_Name : League.Strings.Universal_String
       := League.Strings.Empty_Universal_String)
   is
      use XML.Schema.Model_Groups;
      use type XML.Schema.Extended_XML_Schema_Component_Type;

      Type_Difinition_Node : XSD2Ada.Analyzer.Item;

   begin
      Type_Difinition_Node.Type_Def := Type_D;
      Type_Difinition_Node.Element_Name := Element_Name;

      if Max_Occurs.Unbounded
        or (not Max_Occurs.Unbounded and then Max_Occurs.Value > 1)
      then
         Type_Difinition_Node.Max := True;
      end if;

      if Min_Occurs = 0 then
         Type_Difinition_Node.Min := True;
      end if;

      if Type_D.To_Complex_Type_Definition.Is_Particle
        and then Type_D.To_Complex_Type_Definition.Get_Particle.Get_Term
          .Is_Model_Group
          and then Type_D.To_Complex_Type_Definition.Get_Particle.Get_Term
            .To_Model_Group.Get_Compositor =
              XML.Schema.Model_Groups.Compositor_Choice
      then
         Type_Difinition_Node.Choice := True;
      end if;

      Node_Type_Definition
        (Type_D,
         Node_Vector,
         Type_Difinition_Node,
         Type_D.Get_Name);

      Add_Node (Node_Vector, Type_Difinition_Node);
   end Create_Node_Vector;

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
     (Self : Item) return League.Strings.Universal_String is
   begin
      return Self.Full_Ada_Package_Name;
   end Full_Ada_Package_Name;

   ------------------------
   -- Full_Ada_Type_Name --
   ------------------------

   function Full_Ada_Type_Name
     (Self : Item) return League.Strings.Universal_String is
   begin
      return Self.Full_Ada_Type_Name;
   end Full_Ada_Type_Name;

   -------------------------
   -- Has_Element_Session --
   -------------------------

   function Has_Element_Session
    (Type_D : XML.Schema.Type_Definitions.XS_Type_Definition) return Boolean
   is
      use type XML.Schema.Type_Definitions.XS_Type_Definition;

      XS_Particle    : XML.Schema.Particles.XS_Particle;
      XS_Term        : XML.Schema.Terms.XS_Term;
      XS_Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
      XS_List        : XML.Schema.Object_Lists.XS_Object_List;

      Decl : XML.Schema.Element_Declarations.XS_Element_Declaration;
      CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;
   begin
      case Type_D.Get_Type_Category is
         when XML.Schema.Complex_Type =>
            CTD := Type_D.To_Complex_Type_Definition;

            if CTD.Get_Content_Type in Element_Only | Mixed then
               XS_Particle    := CTD.Get_Particle;
               XS_Term        := XS_Particle.Get_Term;
               XS_Model_Group := XS_Term.To_Model_Group;
               XS_List        := XS_Model_Group.Get_Particles;

               for J in 1 .. XS_List.Get_Length loop
                  XS_Particle := XS_List.Item (J).To_Particle;
                  XS_Term := XS_Particle.Get_Term;
                  Decl := XS_Term.To_Element_Declaration;

                  if Decl.Get_Name.To_UTF_8_String = "Session" then
                     return True;
                  end if;

                  return Has_Element_Session (Decl.Get_Type_Definition);
               end loop;
            end if;

         when XML.Schema.Simple_Type =>
            null;

         when XML.Schema.None =>
            null;
      end case;

      return False;
   end Has_Element_Session;

   ------------------------
   -- Has_Top_Level_Type --
   ------------------------

   function Has_Top_Level_Type
    (Type_D : XML.Schema.Type_Definitions.XS_Type_Definition)
       return Boolean is
   begin
      return Type_D.Get_Namespace = XSD_To_Ada.Utils.Namespace;
   end Has_Top_Level_Type;

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

   --------------------------
   -- Node_Type_Definition --
   --------------------------

   procedure Node_Type_Definition
     (Type_D               : XML.Schema.Type_Definitions.XS_Type_Definition;
      Node_Vector          : in out Items;
      Type_Difinition_Node : Item;
      Name                 : League.Strings.Universal_String)
   is
      use type XML.Schema.Type_Definitions.XS_Type_Definition;

      procedure Print_Term
       (XS_Term : XML.Schema.Terms.XS_Term;
        Name    : League.Strings.Universal_String);

      XS_Particle    : XML.Schema.Particles.XS_Particle;
      XS_Term        : XML.Schema.Terms.XS_Term;
      XS_Base        : XML.Schema.Type_Definitions.XS_Type_Definition;

      CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;

      Max_Occurs_2 : XML.Schema.Particles.Unbounded_Natural;
      Min_Occurs_2 : Natural;

      ----------------
      -- Print_Term --
      ----------------

      procedure Print_Term
       (XS_Term : XML.Schema.Terms.XS_Term;
        Name    : League.Strings.Universal_String)
      is
         use XML.Schema.Terms.Model_Groups;

         XS_Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
         XS_List        : XML.Schema.Object_Lists.XS_Object_List;
         XS_Particle    : XML.Schema.Particles.XS_Particle;
         Decl           :
           XML.Schema.Element_Declarations.XS_Element_Declaration;
         Type_D         : XML.Schema.Type_Definitions.XS_Type_Definition;

      begin
         if XS_Term.Is_Model_Group then
            XS_Model_Group := XS_Term.To_Model_Group;
            XS_List := XS_Model_Group.Get_Particles;

            for J in 1 .. XS_List.Get_Length loop
               XS_Particle := XS_List.Item (J).To_Particle;

               Max_Occurs_2 := XS_Particle.Get_Max_Occurs;
               Min_Occurs_2 := XS_Particle.Get_Min_Occurs;

               Print_Term (XS_Particle.Get_Term, Name);
            end loop;

         elsif XS_Term.Is_Element_Declaration then

            Decl := XS_Term.To_Element_Declaration;
            Type_D := Decl.Get_Type_Definition;

            if Type_D.Get_Name.Is_Empty then
               Node_Type_Definition
                (Type_D,
                 Node_Vector,
                 Type_Difinition_Node,
                 Name & '_' & Decl.Get_Name);

               declare
                  Anonym_Type_Difinition_Node : XSD2Ada.Analyzer.Item;

               begin
                  Anonym_Type_Difinition_Node.Type_Def := Type_D;

                  if Min_Occurs_2 = 0 then
                     Anonym_Type_Difinition_Node.Min := True;
                  end if;

                  if Max_Occurs_2.Unbounded
                    or else Max_Occurs_2.Value > 1
                  then
                     Anonym_Type_Difinition_Node.Max := True;
                  end if;

                  if Type_D.To_Complex_Type_Definition.Get_Particle.Get_Term
                    .To_Model_Group.Get_Compositor =
                      XML.Schema.Model_Groups.Compositor_Choice
                  then
                     Anonym_Type_Difinition_Node.Choice := True;
                  end if;

                  if not Name.Is_Empty then
                     Anonym_Type_Difinition_Node.Anonym_Name :=
                       (Name & "_" & Decl.Get_Name);
                  else
                     Anonym_Type_Difinition_Node.Anonym_Name :=
                       (Decl.Get_Name);
                  end if;

                  XSD2Ada.Analyzer.Add_Node
                   (Node_Vector, Anonym_Type_Difinition_Node);
               end;

            elsif Has_Top_Level_Type (Type_D) then
               XSD2Ada.Analyzer.Create_Node_Vector
                (Type_D,
                 Node_Vector,
                 Min_Occurs_2,
                 Max_Occurs_2);

            else
               declare
                  Simple_Type_Difinition_Node : XSD2Ada.Analyzer.Item;

               begin
                  Simple_Type_Difinition_Node.Type_Def := Type_D;

                  if Min_Occurs_2 = 0 then
                     Simple_Type_Difinition_Node.Min := True;
                  end if;

                  if Max_Occurs_2.Unbounded
                    or else Max_Occurs_2.Value > 1
                  then
                     Simple_Type_Difinition_Node.Max := True;
                  end if;

                  if Type_D.To_Complex_Type_Definition.Get_Particle.Get_Term
                    .To_Model_Group.Get_Compositor =
                      XML.Schema.Model_Groups.Compositor_Choice
                  then
                     Simple_Type_Difinition_Node.Choice := True;
                  end if;

                  XSD2Ada.Analyzer.Add_Node
                   (Node_Vector, Simple_Type_Difinition_Node);
               end;
            end if;
         end if;
      end Print_Term;

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

               Print_Term (XS_Term, Name);

            end if;

         when XML.Schema.Simple_Type =>
            null;

         when XML.Schema.None =>
            raise Constraint_Error;
      end case;
   end Node_Type_Definition;

   -------------------------
   -- Short_Ada_Type_Name --
   -------------------------

   function Short_Ada_Type_Name
     (Self : Item) return League.Strings.Universal_String is
   begin
      return Self.Short_Ada_Type_Name;
   end Short_Ada_Type_Name;

   --------------
   -- Type_Def --
   --------------

   function Type_Def
     (Self : Item) return XML.Schema.Type_Definitions.XS_Type_Definition is
   begin
      return Self.Type_Def;
   end Type_Def;

end XSD2Ada.Analyzer;
