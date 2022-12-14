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
-- Copyright © 2011-2013, Vadim Godunko <vgodunko@gmail.com>                --
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
with Ada.Strings.Wide_Wide_Fixed;
with Ada.Wide_Wide_Text_IO;

with AMF.CMOF.Enumeration_Literals.Collections;
with AMF.CMOF.Enumerations;
with AMF.CMOF.Properties.Collections;
with AMF.CMOF.Types;

with Generator.Attribute_Mapping;
with Generator.Names;
with Generator.Type_Mapping;
with Generator.Units;
with Generator.Wide_Wide_Text_IO;

package body Generator.Constructors is

   use Ada.Strings;
   use Ada.Strings.Wide_Wide_Fixed;
   use Ada.Wide_Wide_Text_IO;
   use Generator.Attribute_Mapping;
   use Generator.Names;
   use Generator.Wide_Wide_Text_IO;
   use type League.Strings.Universal_String;

   Boolean_Name           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("Boolean");
   Integer_Name           : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("Integer");
   Real_Name              : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("Real");
   String_Name            : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("String");
   Unlimited_Natural_Name : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("UnlimitedNatural");

   Unlimited_Image : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("*");

   ------------------------------------------
   -- Generate_Constructors_Implementation --
   ------------------------------------------

   procedure Generate_Constructors_Implementation is

      procedure Generate_Create (Position : Class_Information_Maps.Cursor);

      Unit : Generator.Units.Unit;

      ---------------------
      -- Generate_Create --
      ---------------------

      procedure Generate_Create (Position : Class_Information_Maps.Cursor) is
         use type AMF.Optional_String;
         use type AMF.CMOF.Properties.CMOF_Property_Access;

         Class          : constant Class_Information_Access
           := Class_Information_Maps.Element (Position);
         Class_Name     : constant League.Strings.Universal_String
           := Class.Class.Get_Name.Value;
         Name           : constant League.Strings.Universal_String
           := "Create_"
                & Owning_Metamodel_Ada_Name (Class.Class)
                & '_'
                & To_Ada_Identifier (Class.Class.Get_Name.Value);
         Types_Package  : constant League.Strings.Universal_String
           := "AMF.Internals.Tables." & Module_Info.Ada_Name & "_Types";
         Element_Kind   : constant League.Strings.Universal_String
           := "AMF.Internals.Tables."
                & Module_Info.Ada_Name
                & "_Types.E_"
                & Owning_Metamodel_Ada_Name (Class.Class)
                & '_'
                & To_Ada_Identifier (Class.Class.Get_Name.Value);
         Attribute      : AMF.CMOF.Properties.CMOF_Property_Access;
         Attribute_Type : AMF.CMOF.Types.CMOF_Type_Access;
         Default        : AMF.Optional_String;
         Image          : League.Strings.Universal_String;
         Attribute_Position : CMOF_Property_Sets.Cursor
           := Class.All_Attributes.First;
         Original_Attribute : AMF.CMOF.Properties.CMOF_Property_Access;
         Redefined          : AMF.CMOF.Properties.Collections.Set_Of_CMOF_Property;
         Generated          : CMOF_Property_Sets.Set;
         Generate           : Boolean;

      begin
         Unit.Add_Header (Name, 3);
         Unit.Context.Add (Types_Package);
         Unit.Add_Line;
         Unit.Add_Line
          ("   function "
             & Name
             & " return "
             & Generator.Type_Mapping.Internal_Ada_Type_Qualified_Name
                (Class.Class, Value)
             & " is");
         Unit.Add_Line
          ("      Self : "
             & Generator.Type_Mapping.Internal_Ada_Type_Qualified_Name
                (Class.Class, Value)
             & ";");
         Unit.Add_Line;
         Unit.Add_Line (+"   begin");
         Unit.Context.Add
          ("AMF.Internals.Tables." & Module_Info.Ada_Name & "_Element_Table");
         Unit.Add_Line
          ("      " & Module_Info.Ada_Name & "_Element_Table.Increment_Last;");
         Unit.Add_Line
          ("      Self := " & Module_Info.Ada_Name & "_Element_Table.Last;");
         Unit.Add_Line;
         Unit.Add_Line
          ("      "
             & Module_Info.Ada_Name
             & "_Element_Table.Table (Self).all :=");
         Unit.Add_Line ("       (Kind     => " & Element_Kind & ",");
         Unit.Add_Line (+"        Extent   => 0,");
         Unit.Add_Line (+"        Proxy    =>");
         Unit.Context.Add
          ("AMF.Internals."
             & Owning_Metamodel_Ada_Name (Class.Class)
             & "_"
             & Plural (To_Ada_Identifier (Class_Name)));
         Unit.Add_Line
          ("          new AMF.Internals."
             & Owning_Metamodel_Ada_Name (Class.Class)
             & "_"
             & Plural (To_Ada_Identifier (Class_Name))
             & "."
             & Owning_Metamodel_Ada_Name (Class.Class)
             & "_"
             & To_Ada_Identifier (Class_Name)
             & "_Proxy'(Element => Self),");
         Unit.Add_Line (+"        Member   =>");
         Unit.Add_Line
          ("         (0      => (Kind => "
             & Types_Package
             & ".M_None),");

         while CMOF_Property_Sets.Has_Element (Attribute_Position) loop
            Attribute          :=
              CMOF_Property_Sets.Element (Attribute_Position);
            Attribute_Type     := Attribute.Get_Type;
            Default            := Attribute.Get_Default;
            Original_Attribute := Attribute;
            Redefined          := Original_Attribute.Get_Redefined_Property;
            Generate           := False;

            --  Unwind to original property definition.

            while not Redefined.Is_Empty loop
               Original_Attribute := Redefined.Element (1);
               Redefined := Original_Attribute.Get_Redefined_Property;
            end loop;

            --  Attributes of type CMOF::Class never share slots/collections,
            --  thus redifinition chain is not important here; slot
            --  initialization is generated when current attribute occupy
            --  member slot.

            if Attribute_Type.all in AMF.CMOF.Classes.CMOF_Class'Class then
               Original_Attribute := Attribute;
               Generate := Module_Info.Attribute_Member.Contains (Attribute);

            --  Generate slot initialization for attributes of non-CMOF::Class
            --  type which original attributes occupies member and nor original
            --  attribute nor current attribute are not redefined.

            elsif not Class.Redefined_Attributes.Contains (Original_Attribute)
                        or not Class.Redefined_Attributes.Contains (Attribute)
            then
              Generate :=
                Module_Info.Attribute_Member.Contains (Original_Attribute);
            end if;

            if Generate then
               Image :=
                 League.Strings.To_Universal_String
                  (Integer'Wide_Wide_Image
                    (Module_Info.Attribute_Member.Element (Attribute)));
               Unit.Add
                ("         "
                   & Image
                   & ((8 - Image.Length) * ' ')
                   & "=>");

               Unit.Add
                (" ("
                   & Types_Package
                   & '.'
                   & Generator.Type_Mapping.Member_Kind_Name
                      (Attribute_Type,
                       Representation (Original_Attribute))
                   & ',');

               if Attribute_Type.all in AMF.CMOF.Classes.CMOF_Class'Class then
                  case Representation (Original_Attribute) is
                     when Value =>
                        if Default.Is_Empty then
                           Unit.Add (+" No_AMF_Link),");

                        else
                           raise Program_Error;
                        end if;

                     when Holder =>
                        if Default.Is_Empty then
                           Unit.Add (+" No_AMF_Link),");

                        else
                           raise Program_Error;
                        end if;

                     when Set | Ordered_Set | Bag | Sequence =>
                        --  Collections of elements never occupy slots.

                        raise Program_Error;
                  end case;

               elsif Attribute_Type.all
                       in AMF.CMOF.Enumerations.CMOF_Enumeration'Class
               then
                  --  Enumeration type

                  case Representation (Original_Attribute) is
                     when Value =>
                        if Default.Is_Empty then
                           --  There is no default value specified, initialize
                           --  to the value of first enumeration literal.

                           Unit.Context.Add
                            ("AMF."
                               & Owning_Metamodel_Ada_Name (Attribute_Type));
                           Unit.Add
                            (" AMF."
                               & Owning_Metamodel_Ada_Name (Attribute_Type)
                               & '.'
                               & Type_Mapping.Ada_Enumeration_Literal_Name
                                  (AMF.CMOF.Enumerations.CMOF_Enumeration'Class
                                    (Attribute_Type.all).
                                      Get_Owned_Literal.Element (1))
                               & "),");

                        else
                           declare
                              use type AMF.CMOF.Enumeration_Literals.CMOF_Enumeration_Literal_Access;

                              Literals : constant
                                AMF.CMOF.Enumeration_Literals.Collections.Ordered_Set_Of_CMOF_Enumeration_Literal
                                    := AMF.CMOF.Enumerations.CMOF_Enumeration'Class
                                        (Attribute_Type.all).Get_Owned_Literal;
                              Literal  :
                                AMF.CMOF.Enumeration_Literals.CMOF_Enumeration_Literal_Access;

                           begin
                              for J in 1 .. Literals.Length loop
                                 if Literals.Element (J).Get_Name = Default then
                                    Literal := Literals.Element (J);

                                    exit;
                                 end if;
                              end loop;

                              if Literal = null then
                                 raise Program_Error;
                              end if;

                              Unit.Context.Add
                               ("AMF." & Owning_Metamodel_Ada_Name (Literal));
                              Unit.Add
                               (" AMF."
                                  & Owning_Metamodel_Ada_Name (Literal)
                                  & "."
                                  & Type_Mapping.Ada_Enumeration_Literal_Name
                                     (Literal)
                                  & "),");
                           end;
                        end if;

                     when Holder =>
                        if Default.Is_Empty then
                           Unit.Add (+" (Is_Empty => True)),");

                        else
                           declare
                              use type AMF.CMOF.Enumeration_Literals.CMOF_Enumeration_Literal_Access;

                              Literals : constant
                                AMF.CMOF.Enumeration_Literals.Collections.Ordered_Set_Of_CMOF_Enumeration_Literal
                                    := AMF.CMOF.Enumerations.CMOF_Enumeration'Class
                                        (Attribute_Type.all).Get_Owned_Literal;
                              Literal  :
                                AMF.CMOF.Enumeration_Literals.CMOF_Enumeration_Literal_Access;

                           begin
                              for J in 1 .. Literals.Length loop
                                 if Literals.Element (J).Get_Name = Default then
                                    Literal := Literals.Element (J);

                                    exit;
                                 end if;
                              end loop;

                              if Literal = null then
                                 raise Program_Error;
                              end if;

                              Unit.Context.Add
                               ("AMF." & Owning_Metamodel_Ada_Name (Literal));
                              Unit.Add
                               (" (False, "
                                  & Type_Mapping.Ada_Enumeration_Literal_Qualified_Name
                                     (Literal)
                                  & ")),");
                           end;
                        end if;

                     when Set =>
                        raise Program_Error;

                     when Ordered_Set =>
                        raise Program_Error;

                     when Bag =>
                        raise Program_Error;

                     when Sequence =>
                        raise Program_Error;
                  end case;

               elsif Attribute_Type.Get_Name = Boolean_Name then
                  case Representation (Original_Attribute) is
                     when Value =>
                        if Default.Is_Empty then
                           --  There is no default value specified, initialize
                           --  to some valid value.

                           Unit.Add (+" False),");

                        else
                           if Boolean'Wide_Wide_Value
                               (Default.Value.To_Wide_Wide_String)
                           then
                              Unit.Add (+" True),");

                           else
                              Unit.Add (+" False),");
                           end if;
                        end if;

                     when Holder =>
                        if Default.Is_Empty then
                           Unit.Add (+" (Is_Empty => True)),");

                        else
                           if Boolean'Wide_Wide_Value
                               (Default.Value.To_Wide_Wide_String)
                           then
                              Unit.Add (+" (False, True)),");

                           else
                              Unit.Add (+" (False, False)),");
                           end if;
                        end if;

                     when Set | Ordered_Set | Bag | Sequence =>
                        Unit.Add (+" 0),");
                  end case;

               elsif Attribute_Type.Get_Name = Integer_Name then
                  case Representation (Original_Attribute) is
                     when Value =>
                        if Default.Is_Empty then
                           --  There is no default value specified, initialize
                           --  to some valid value.

                           Unit.Add (+" 0),");

                        else
                           Unit.Add
                            (+Integer'Wide_Wide_Image
                               (Integer'Wide_Wide_Value
                                 (Default.Value.To_Wide_Wide_String))
                                & "),");
                        end if;

                     when Holder =>
                        if Default.Is_Empty then
                           raise Program_Error;

                        else
                           Unit.Add
                            (+" (False,"
                                & Integer'Wide_Wide_Image
                                   (Integer'Wide_Wide_Value
                                     (Default.Value.To_Wide_Wide_String))
                                & ")),");
                        end if;

                     when Set =>
                        raise Program_Error;

                     when Ordered_Set =>
                        raise Program_Error;

                     when Bag =>
                        raise Program_Error;

                     when Sequence =>
                        raise Program_Error;
                  end case;

               elsif Attribute_Type.Get_Name = String_Name then
                  case Representation (Original_Attribute) is
                     when Value =>
                        if Default.Is_Empty
                          or else Default.Value.Is_Empty
                        then
                           Unit.Context.Add (+"Matreshka.Internals.Strings");
                           Unit.Add
                            (+" Matreshka.Internals.Strings.Shared_Empty"
                                & "'Access),");

                        else
                           raise Program_Error;
                        end if;

                     when Holder =>
                        if Default.Is_Empty then
                           Unit.Add (+" null),");

                        else
                           raise Program_Error;
                        end if;

                     when Set | Ordered_Set | Bag | Sequence =>
                        Unit.Add (+" 0),");
                  end case;

               elsif Attribute_Type.Get_Name = Real_Name then
                  case Representation (Original_Attribute) is
                     when Value =>
                        if Default.Is_Empty then
                           Unit.Add (+" 0.0),");

                        else
                           Unit.Add
                            (+Long_Float'Wide_Wide_Image
                               (Long_Float'Wide_Wide_Value
                                 (Default.Value.To_Wide_Wide_String))
                                & "),");
                        end if;

                     when Holder =>
                        if Default.Is_Empty then
                           Unit.Add (+" (Is_Empty => True)),");

                        else
                           raise Program_Error;
                        end if;

                     when Set | Ordered_Set | Bag | Sequence =>
                        Unit.Add (+" 0),");
                  end case;

               elsif Attribute_Type.Get_Name = Unlimited_Natural_Name then
                  case Representation (Original_Attribute) is
                     when Value =>
                        if Default.Is_Empty then
                           --  There is no default value specified, initialize
                           --  to some valid value.

                           Unit.Add (+" (False, 0)),");

                        else
                           Unit.Add
                            (+" (False,"
                                & Integer'Wide_Wide_Image
                                   (Integer'Wide_Wide_Value
                                     (Default.Value.To_Wide_Wide_String))
                                & ")),");
                        end if;

                     when Holder =>
                        if Default.Is_Empty then
                           raise Program_Error;

                        else
                           if Default = Unlimited_Image then
                              raise Program_Error;

                           else
                              Unit.Add
                               (+" (False, (False,"
                                   & Integer'Wide_Wide_Image
                                      (Integer'Wide_Wide_Value
                                        (Default.Value.To_Wide_Wide_String))
                                   & "))),");
                           end if;
                        end if;

                     when Set =>
                        raise Program_Error;

                     when Ordered_Set =>
                        raise Program_Error;

                     when Bag =>
                        raise Program_Error;

                     when Sequence =>
                        raise Program_Error;
                  end case;

               else
                  --  Arbitrary data type.

                  case Representation (Original_Attribute) is
                     when Value =>
                        if Default.Is_Empty then
                           Unit.Add (+" (others => <>)),");

                        else
                           raise Program_Error;
                        end if;

                     when Holder =>
                        if Default.Is_Empty then
                           Unit.Add (+" (Is_Empty => True)),");

                        else
                           raise Program_Error;
                        end if;

                     when Set | Ordered_Set | Bag | Sequence =>
                        Unit.Add (+" 0),");
                  end case;

               end if;

               Unit.Add_Line;
               Unit.Add_Line
                ("                       --  " & Attribute.Get_Name.Value);

            end if;

            CMOF_Property_Sets.Next (Attribute_Position);
         end loop;

         Unit.Add_Line
          ("          others => (Kind => "
             & Types_Package
             & ".M_None)));");
         Unit.Add_Line
          ("      "
             & Module_Info.Ada_Name
             & "_Element_Table.Table (Self).Member (0) :=");
         Unit.Add_Line
          ("       (" & Types_Package & ".M_Collection_Of_Element,");
         Unit.Context.Add (+"AMF.Internals.Element_Collections");
         Unit.Add_Line
          (+"        AMF.Internals.Element_Collections.Allocate_Collections ("
              & Trim
                 (Ada.Containers.Count_Type'Wide_Wide_Image
                   (Module_Info.Attribute_Collection.Length),
                  Both)
              & "));");

         Attribute_Position := Class.All_Attributes.First;

         while CMOF_Property_Sets.Has_Element (Attribute_Position) loop
            Attribute          :=
              CMOF_Property_Sets.Element (Attribute_Position);
--            Original_Attribute := Attribute;
--            Redefined          := Original_Attribute.Get_Redefined_Property;
--
--            --  Unwind to original property definition.
--
--            while not Redefined.Is_Empty loop
--               Original_Attribute := Redefined.Element (1);
--               Redefined := Original_Attribute.Get_Redefined_Property;
--            end loop;
--
--            if Attribute = Original_Attribute
--              and then Module_Info.Attribute_Collection.Contains (Attribute)
--            then
            if Module_Info.Attribute_Collection.Contains (Attribute) then
               Unit.Add_Line;
               Unit.Add_Line ("      --  " & Attribute.Get_Name.Value);
               Unit.Add_Line;

               case Representation (Attribute) is
                  when Value =>
                     raise Program_Error;

                  when Holder =>
                     raise Program_Error;

                  when Set =>
                     Unit.Add_Line
                      (+"      "
                          & "AMF.Internals.Element_Collections"
                          & ".Initialize_Set_Collection");

                  when Ordered_Set =>
                     Unit.Add_Line
                      (+"      "
                          & "AMF.Internals.Element_Collections"
                          & ".Initialize_Ordered_Set_Collection");

                  when Bag =>
                     raise Program_Error;

                  when Sequence =>
                     raise Program_Error;
               end case;

               Unit.Add_Line (+"       (Self,");
               Unit.Context.Add (Property_Constant_Package_Name (Attribute));
               Unit.Add_Line
                ("        "
                   & Property_Constant_Qualified_Name (Attribute)
                   & ",");
               Unit.Add_Line
                ("        "
                   & Module_Info.Ada_Name
                   & "_Element_Table.Table (Self).Member (0).Collection +"
                   & Integer'Wide_Wide_Image
                      (Module_Info.Attribute_Collection.Element (Attribute))
                   & ");");
            end if;

            CMOF_Property_Sets.Next (Attribute_Position);
         end loop;

         Unit.Add_Line;
         Unit.Add_Line (+"      return Self;");
         Unit.Add_Line ("   end " & Name & ";");
      end Generate_Create;

      Package_Name : constant League.Strings.Universal_String
        := "AMF.Internals.Tables." & Module_Info.Ada_Name & "_Constructors";

   begin
      if Module_Info.Non_Abstract_Classes.Is_Empty then
         --  All classes are abstract, constructors package is empty.

         return;
      end if;

      Unit.Add_Unit_Header (2010, 2013);

      Unit.Add_Line;
      Unit.Add_Line ("package body " & Package_Name & " is");
      Unit.Add_Line;
      --  XXX Usage of 'use' clauses should be reviewed.
      Unit.Add_Line (+"   use AMF.Internals.Tables;");
      Unit.Add_Line (+"   use type AMF.Internals.AMF_Collection_Of_Element;");
      Class_Info.Iterate (Generate_Create'Access);
      Unit.Add_Line;
      Unit.Add_Line ("end " & Package_Name & ";");

      Unit.Context.Instantiate (Package_Name);
      Unit.Put;
   end Generate_Constructors_Implementation;

   -----------------------------------------
   -- Generate_Constructors_Specification --
   -----------------------------------------

   procedure Generate_Constructors_Specification is

      procedure Generate_Create (Position : Class_Information_Maps.Cursor);

      ---------------------
      -- Generate_Create --
      ---------------------

      procedure Generate_Create (Position : Class_Information_Maps.Cursor) is
         Class : constant Class_Information_Access
           := Class_Information_Maps.Element (Position);
         Name  : constant League.Strings.Universal_String
           := "Create_"
                & Owning_Metamodel_Ada_Name (Class.Class)
                & '_'
                & To_Ada_Identifier (Class.Class.Get_Name.Value);

      begin
         New_Line;
         Put_Line
          ("   function "
             & Name
             & " return "
             & Generator.Type_Mapping.Internal_Ada_Type_Qualified_Name
                (Class.Class, Value)
             & ";");
      end Generate_Create;

   begin
      if Module_Info.Non_Abstract_Classes.Is_Empty then
         --  All classes are abstract, constructors package is empty.

         return;
      end if;

      Put_Header (2010, 2012);

      New_Line;
      Put_Line
       ("package AMF.Internals.Tables."
          & Module_Info.Ada_Name
          & "_Constructors is");
      Class_Info.Iterate (Generate_Create'Access);
      New_Line;
      Put_Line
       ("end AMF.Internals.Tables."
          & Module_Info.Ada_Name
          & "_Constructors;");
   end Generate_Constructors_Specification;

end Generator.Constructors;
