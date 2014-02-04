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

   --------------
   -- Add_Node --
   --------------

   procedure Add_Node
    (Node_Vector          : in out Items;
     Type_Difinition_Node : Item)
   is
      Difinition_Node : XSD2Ada.Analyzer.Item;

   begin
      Difinition_Node := Type_Difinition_Node;
      Difinition_Node.Min := False;
      Difinition_Node.Max := False;
      Difinition_Node.Element_Name.Clear;

      if not Node_Vector.Contains (Difinition_Node) then

         if not Type_Difinition_Node.Type_Def.Get_Name.Is_Empty
           or not Type_Difinition_Node.Anonym_Name.Is_Empty
         then
            if not Node_Vector.Contains (Difinition_Node) then
               Node_Vector.Append (Difinition_Node);
            end if;
         end if;
      end if;

      if Type_Difinition_Node.Max then
         Difinition_Node.Max := True;

         if not Node_Vector.Contains (Difinition_Node) then
            Node_Vector.Append (Difinition_Node);
         end if;

         Difinition_Node.Max := False;
      end if;

      if Type_Difinition_Node.Min then
         Difinition_Node.Min := True;

         if not Node_Vector.Contains (Difinition_Node) then
            Node_Vector.Append (Difinition_Node);
         end if;

         Difinition_Node.Min := False;
      end if;

      if not Type_Difinition_Node.Element_Name.Is_Empty
        and then Type_Difinition_Node.Type_Def.Get_Name.To_UTF_8_String /=
          Type_Difinition_Node.Element_Name.To_UTF_8_String
      then
            Difinition_Node.Element_Name.Append
              (Type_Difinition_Node.Element_Name);

            if not Node_Vector.Contains (Difinition_Node) then
               Node_Vector.Append (Difinition_Node);
            end if;

            Difinition_Node.Element_Name.Clear;
      end if;
   end Add_Node;

   -------------------------
   -- Create_Element_Type --
   -------------------------

   procedure Create_Element_Type
    (Model       : XML.Schema.Models.XS_Model;
     Node_Vector : in out Items;
     Mapping     : XSD_To_Ada.Mappings.Mapping)
   is
      Element_Declarations : constant XML.Schema.Named_Maps.XS_Named_Map
        := Model.Get_Components_By_Namespace
            (Object_Type => XML.Schema.Element_Declaration,
             Namespace   => XSD_To_Ada.Utils.Namespace);
      Type_D               : XML.Schema.Type_Definitions.XS_Type_Definition;

   begin
      for J in 1 .. Element_Declarations.Length loop
         Type_D :=
           Element_Declarations.Item
            (J).To_Element_Declaration.Get_Type_Definition;

         Create_Node_Vector
           (Type_D,
            Node_Vector,
            Mapping,
            1, (False, 1),
            Element_Declarations.Item (J).Get_Name);
      end loop;
   end Create_Element_Type;

   ------------------------
   -- Create_Node_Vector --
   ------------------------

   procedure Create_Node_Vector
    (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
     Node_Vector  : in out XSD2Ada.Analyzer.Items;
     Mapping      : XSD_To_Ada.Mappings.Mapping;
     Min_Occurs   : Natural;
     Max_Occurs   : XML.Schema.Particles.Unbounded_Natural;
     Element_Name : League.Strings.Universal_String
       := League.Strings.Empty_Universal_String)
   is
      use XML.Schema.Model_Groups;
      use type XML.Schema.Extended_XML_Schema_Component_Type;

      Type_Difinition_Node : XSD2Ada.Analyzer.Item;

      XS_Particle    : XML.Schema.Particles.XS_Particle;
      XS_Term        : XML.Schema.Terms.XS_Term;
      XS_List        : XML.Schema.Object_Lists.XS_Object_List;

      CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;

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

      if Type_D.Get_Type_Category = XML.Schema.Complex_Type then
         XSD_To_Ada.Utils.Node_Type_Definition
           (Type_D,
            Node_Vector,
            Type_Difinition_Node,
            Type_D.Get_Name,
            Mapping,
            XSD_To_Ada.Utils.Types_Table);

         Add_Node (Node_Vector, Type_Difinition_Node);

      else
         Add_Node (Node_Vector, Type_Difinition_Node);
      end if;
   end Create_Node_Vector;

end XSD2Ada.Analyzer;
