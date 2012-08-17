------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Ada Modeling Framework                          --
--                                                                          --
--                              Tools Component                             --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2010-2011, Vadim Godunko <vgodunko@gmail.com>                --
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
with Ada.Text_IO;

with Generator.Utilities;

package body Generator.Reflection is

   use Ada.Text_IO;
   use type Ada.Strings.Unbounded.Unbounded_String;
   use Generator.Utilities;

   procedure Generate_Get_Meta_Class;

   procedure Generate_Get;

   procedure Generate_Set;

   -----------------------------
   -- Generate_Get_Meta_Class --
   -----------------------------

   procedure Generate_Get_Meta_Class is

      procedure Generate_Class (Position : Class_Sets.Cursor);

      --------------------
      -- Generate_Class --
      --------------------

      procedure Generate_Class (Position : Class_Sets.Cursor) is
         Class : constant Class_Access := Class_Sets.Element (Position);

      begin
         if not Class.Is_Abstract then
            New_Line;
            Put_Line ("         when E_" & To_Ada_Identifier (Class.Name) & " =>");
            Put_Line ("            return " & Constant_Name_In_Metamodel (Class) & ";");
         end if;
      end Generate_Class;

   begin
      New_Line;
      Put_Line ("   --------------------");
      Put_Line ("   -- Get_Meta_Class --");
      Put_Line ("   --------------------");
      New_Line;
      Put_Line ("   function Get_Meta_Class (Self : CMOF_Element) return CMOF_Class is");
      Put_Line ("   begin");
      Put_Line ("      case Elements.Table (Self).Kind is");
      Put_Line ("         when E_None =>");
      Put_Line ("            return Null_CMOF_Element;");
      Classes.Iterate (Generate_Class'Access);
      Put_Line ("      end case;");
      Put_Line ("   end Get_Meta_Class;");
   end Generate_Get_Meta_Class;

   ------------------
   -- Generate_Get --
   ------------------

   procedure Generate_Get is

      procedure Generate_Class_Get (Position : Class_Sets.Cursor);

      procedure Generate_Class_Selection (Position : Class_Sets.Cursor);

      ------------------------
      -- Generate_Class_Get --
      ------------------------

      procedure Generate_Class_Get (Position : Class_Sets.Cursor) is
         Class : constant Class_Access := Class_Sets.Element (Position);
         First : Boolean := True;

         procedure Generate_Property_Get
          (Position : Property_Full_Sets.Cursor);

         ---------------------------
         -- Generate_Property_Get --
         ---------------------------

         procedure Generate_Property_Get
          (Position : Property_Full_Sets.Cursor)
         is
            Property : constant Property_Access
              := Property_Full_Sets.Element (Position);

         begin
            if First then
               Put_Line ("         if Property = " & Constant_Name_In_Metamodel (Property) & " then");
               First := False;

            else
               New_Line;
               Put_Line ("         elsif Property = " & Constant_Name_In_Metamodel (Property) & " then");
            end if;

            if Get_Type (Property).all in Primitive_Type_Record'Class then
               if Has_Boolean_Type (Property) then
                  Put_Line ("            return");
                  Put_Line ("             (AMF.Values.Value_Boolean,");
                  Put_Line
                   ("              Internal_Get_"
                      & To_Ada_Identifier (Property.Name)
                      & " (Self));");

               elsif Has_Integer_Type (Property) then
                  Put_Line ("            return");
                  Put_Line ("             (AMF.Values.Value_Integer,");
                  Put_Line
                   ("              Internal_Get_"
                      & To_Ada_Identifier (Property.Name)
                      & " (Self));");

               elsif Has_Unlimited_Natural_Type (Property) then
                  Put_Line ("            return");
                  Put_Line
                   ("             (AMF.Values.Value_Unlimited_Natural,");
                  Put_Line
                   ("              Internal_Get_"
                      & To_Ada_Identifier (Property.Name)
                      & " (Self));");

               elsif Has_String_Type (Property) then
                  if Is_Multivalued (Property) then
                     Put_Line ("            return (Kind => AMF.Values.Value_None);");

                  else
                     Put_Line ("            return");
                     Put_Line ("             (AMF.Values.Value_String,");
                     Put_Line ("              Internal_Get_" & To_Ada_Identifier (Property.Name) & " (Self));");
                  end if;

               else
                  Put_Line ("            return (Kind => AMF.Values.Value_None);");
               end if;

            elsif Get_Type (Property).all in Enumeration_Record'Class then
               if Property.Type_Id
                    = "Core-Constructs-ParameterDirectionKind"
               then
                  Put_Line ("            return");
                  Put_Line ("             (AMF.Values.Value_CMOF_Parameter_Direction_Kind,");
                  Put_Line
                   ("              Internal_Get_"
                      & To_Ada_Identifier (Property.Name)
                      & " (Self));");

               else
                  Put_Line ("            return (Kind => AMF.Values.Value_None);");
               end if;

            else
               if Is_Multivalued (Property) then
                  Put_Line ("            return");
                  Put_Line ("             (AMF.Values.Value_Collection_Of_Element,");
                  Put_Line ("              Internal_Get_" & To_Ada_Identifier (Property.Name) & " (Self));");

               else
                  Put_Line ("            return");
                  Put_Line ("             (AMF.Values.Value_Element,");
                  Put_Line ("              Internal_Get_" & To_Ada_Identifier (Property.Name) & " (Self));");
               end if;
            end if;
         end Generate_Property_Get;

      begin
         if not Class.Is_Abstract then
            New_Line;
            Put_Line ("      function Get_" & To_Ada_Identifier (Class.Name) & " return AMF.Values.Value is");
            Put_Line ("      begin");
            Class.All_Properties.Iterate (Generate_Property_Get'Access);
            New_Line;
            Put_Line ("         else");
            Put_Line ("            raise Program_Error;");
            Put_Line ("         end if;");
            Put_Line ("      end Get_" & To_Ada_Identifier (Class.Name) & ";");
         end if;
      end Generate_Class_Get;

      ------------------------------
      -- Generate_Class_Selection --
      ------------------------------

      procedure Generate_Class_Selection (Position : Class_Sets.Cursor) is
         Class : constant Class_Access := Class_Sets.Element (Position);

      begin
         if not Class.Is_Abstract then
            New_Line;
            Put_Line ("         when E_" & To_Ada_Identifier (Class.Name) & " =>");
            Put_Line ("            return Get_" & To_Ada_Identifier (Class.Name) & ";");
         end if;
      end Generate_Class_Selection;

   begin
      New_Line;
      Put_Line ("   ---------");
      Put_Line ("   -- Get --");
      Put_Line ("   ---------");
      New_Line;
      Put_Line ("   function Get");
      Put_Line ("    (Self     : CMOF_Element;");
      Put_Line ("     Property : CMOF_Property) return AMF.Values.Value");
      Put_Line ("   is");
      Classes.Iterate (Generate_Class_Get'Access);
      New_Line;
      Put_Line ("   begin");
      Put_Line ("      case Elements.Table (Self).Kind is");
      Put_Line ("         when E_None =>");
      Put_Line ("            return (Kind => AMF.Values.Value_None);");
      Classes.Iterate (Generate_Class_Selection'Access);
      Put_Line ("      end case;");
      Put_Line ("   end Get;");
   end Generate_Get;

   ------------------
   -- Generate_Set --
   ------------------

   procedure Generate_Set is

      procedure Generate_Class_Selection (Position : Class_Sets.Cursor);

      procedure Generate_Class_Set (Position : Class_Sets.Cursor);

      ------------------------------
      -- Generate_Class_Selection --
      ------------------------------

      procedure Generate_Class_Selection (Position : Class_Sets.Cursor) is
         Class : constant Class_Access := Class_Sets.Element (Position);

      begin
         if not Class.Is_Abstract then
            New_Line;
            Put_Line ("         when E_" & To_Ada_Identifier (Class.Name) & " =>");
            Put_Line ("            Set_" & To_Ada_Identifier (Class.Name) & ";");
         end if;
      end Generate_Class_Selection;

      ------------------------
      -- Generate_Class_Set --
      ------------------------

      procedure Generate_Class_Set (Position : Class_Sets.Cursor) is
         Class : constant Class_Access := Class_Sets.Element (Position);
         First : Boolean := True;

         procedure Generate_Property_Set
          (Position : Property_Full_Sets.Cursor);

         ---------------------------
         -- Generate_Property_Set --
         ---------------------------

         procedure Generate_Property_Set
          (Position : Property_Full_Sets.Cursor)
         is
            Property : constant Property_Access
              := Property_Full_Sets.Element (Position);

         begin
            if Is_Multivalued (Property) or Property.Is_Read_Only or Property.Is_Derived then
               return;
            end if;

            if First then
               Put_Line ("         if Property = " & Constant_Name_In_Metamodel (Property) & " then");
               First := False;

            else
               New_Line;
               Put_Line ("         elsif Property = " & Constant_Name_In_Metamodel (Property) & " then");
            end if;

            if Get_Type (Property).all in Primitive_Type_Record'Class then
               if Has_Boolean_Type (Property) then
                  Put_Line
                   ("            Internal_Set_"
                      & To_Ada_Identifier (Property.Name)
                      & " (Self, Value.Boolean_Value);");

               elsif Has_Integer_Type (Property) then
                  Put_Line
                   ("            Internal_Set_"
                      & To_Ada_Identifier (Property.Name)
                      & " (Self, Value.Integer_Value);");

               elsif Has_Unlimited_Natural_Type (Property) then
                  Put_Line
                   ("            Internal_Set_"
                      & To_Ada_Identifier (Property.Name)
                      & " (Self, Value.Unlimited_Natural_Value);");

               elsif Has_String_Type (Property) then
                  Put_Line
                   ("            Internal_Set_"
                      & To_Ada_Identifier (Property.Name)
                      & " (Self, Value.String_Value);");

               else
                  Put_Line ("            null;");
               end if;

            elsif Get_Type (Property).all in Enumeration_Record'Class then
               if Property.Type_Id
                    = "Core-Constructs-ParameterDirectionKind"
               then
                  Put_Line
                   ("            Internal_Set_"
                      & To_Ada_Identifier (Property.Name)
                      & " (Self, Value.Parameter_Direction_Value);");

               else
                  Put_Line ("            null;");
               end if;

            else
               Put_Line ("            Internal_Set_" & To_Ada_Identifier (Property.Name) & " (Self, Value.Element_Value);");
            end if;
         end Generate_Property_Set;

      begin
         if not Class.Is_Abstract then
            New_Line;
            Put_Line ("      procedure Set_" & To_Ada_Identifier (Class.Name) & " is");
            Put_Line ("      begin");
            Class.All_Properties.Iterate (Generate_Property_Set'Access);
            New_Line;
            Put_Line ("         else");
            Put_Line ("            raise Program_Error;");
            Put_Line ("         end if;");
            Put_Line ("      end Set_" & To_Ada_Identifier (Class.Name) & ";");
         end if;
      end Generate_Class_Set;

   begin
      New_Line;
      Put_Line ("   ---------");
      Put_Line ("   -- Set --");
      Put_Line ("   ---------");
      New_Line;
      Put_Line ("   procedure Set");
      Put_Line ("    (Self     : CMOF_Element;");
      Put_Line ("     Property : CMOF_Property;");
      Put_Line ("     Value    : AMF.Values.Value)");
      Put_Line ("   is");
      Classes.Iterate (Generate_Class_Set'Access);
      New_Line;
      Put_Line ("   begin");
      Put_Line ("      case Elements.Table (Self).Kind is");
      Put_Line ("         when E_None =>");
      Put_Line ("            null;");
      Classes.Iterate (Generate_Class_Selection'Access);
      Put_Line ("      end case;");
      Put_Line ("   end Set;");
   end Generate_Set;

   ----------------------------------------
   -- Generate_Reflection_Implementation --
   ----------------------------------------

   procedure Generate_Reflection_Implementation is
   begin
      Put_Line ("with CMOF.Internals.Attributes;");
      Put_Line ("with CMOF.Internals.Metamodel;");
      Put_Line ("with CMOF.Internals.Tables;");
      Put_Line ("with CMOF.Internals.Types;");

      New_Line;
      Put_Line ("package body CMOF.Internals.Reflection is");
      New_Line;
      Put_Line ("   use CMOF.Internals.Attributes;");
      Put_Line ("   use CMOF.Internals.Metamodel;");
      Put_Line ("   use CMOF.Internals.Tables;");
      Put_Line ("   use CMOF.Internals.Types;");

      Generate_Get;
      Generate_Get_Meta_Class;
      Generate_Set;
      New_Line;
      Put_Line ("end CMOF.Internals.Reflection;");
   end Generate_Reflection_Implementation;

end Generator.Reflection;