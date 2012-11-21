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
-- Copyright © 2012, Vadim Godunko <vgodunko@gmail.com>                     --
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
with AMF.CMOF.Properties;
with AMF.CMOF.Types;

with Generator.Attribute_Mapping;
with Generator.Names;
with Generator.Type_Mapping;
with Generator.Units;

package body Generator.Tables is

   type Member_Information is record
      Member_Kind : League.Strings.Universal_String;
      Member_Name : League.Strings.Universal_String;
      Member_Type : League.Strings.Universal_String;
   end record;

   package Universal_String_Ordered_Maps is
     new Ada.Containers.Ordered_Maps
          (League.Strings.Universal_String,
           Member_Information);

   ------------------------------------
   -- Generate_Element_Table_Package --
   ------------------------------------

   procedure Generate_Element_Table_Package is
      Package_Name : constant League.Strings.Universal_String
        := "AMF.Internals.Tables." & Module_Info.Ada_Name & "_Element_Table";
      Types_Name   : constant League.Strings.Universal_String
        := "AMF.Internals.Tables." & Module_Info.Ada_Name & "_Types";
      Unit         : Generator.Units.Unit;

   begin
      if Module_Info.Non_Abstract_Classes.Is_Empty then
         --  All classes are abstract, types package is empty.

         return;
      end if;

      Unit.Add_Unit_Header (2010, 2012);

      Unit.Context.Add (+"AMF.Internals.Generic_Element_Table");
      Unit.Context.Add (Types_Name);

      Unit.Add_Line;
      Unit.Add_Line ("package " & Package_Name & " is");
      Unit.Add_Line (+"  new AMF.Internals.Generic_Element_Table");
      Unit.Add_Line ("       (" & Types_Name & ".Element_Record);");
      Unit.Add_Line ("pragma Preelaborate (" & Package_Name & ");");

      Unit.Context.Instantiate (Package_Name);
      Unit.Put;
   end Generate_Element_Table_Package;

   ----------------------------
   -- Generate_Types_Package --
   ----------------------------

   procedure Generate_Types_Package is
      Package_Name   : constant League.Strings.Universal_String
        := "AMF.Internals.Tables." & Module_Info.Ada_Name & "_Types";
      Attribute_Type : AMF.CMOF.Types.CMOF_Type_Access;
      Unit           : Generator.Units.Unit;
      First          : Boolean;
      Class_Info     : Class_Information_Access;
      Members        : Universal_String_Ordered_Maps.Map;
      Kind           : League.Strings.Universal_String;
      Representation : Representation_Kinds;

   begin
      if Module_Info.Non_Abstract_Classes.Is_Empty then
         --  All classes are abstract, types package is empty.

         return;
      end if;

      Unit.Add_Unit_Header (2010, 2012);

      Unit.Add_Line;
      Unit.Add_Line ("package " & Package_Name & " is");
      Unit.Add_Line;
      Unit.Add_Line (+"   pragma Preelaborate;");

      --  Generate set of kinds of records in elements table.

      Unit.Add_Line;
      Unit.Add_Line (+"   type Element_Kinds is");
      Unit.Add (+"    (E_None");

      First := True;

      for Class of Module_Info.Non_Abstract_Classes loop
         Unit.Add_Line (+",");
         Unit.Add (+"     E_");
         Unit.Add (Generator.Names.Owning_Metamodel_Ada_Name (Class));
         Unit.Add (+"_");
         Unit.Add (+Generator.Names.To_Ada_Identifier (Class.Get_Name.Value));
      end loop;

      Unit.Add_Line (+");");

      --  Generate set of kinds of members.

      Unit.Add_Line;
      Unit.Add_Line (+"   type Member_Kinds is");
      Unit.Add (+"    (M_None");

      Members.Include
       (+"M_Collection_Of_Element",
        (+"M_Collection_Of_Element",
         +"Collection",
         +"AMF.Internals.AMF_Collection_Of_Element"));
      --  Insert collection of elements into the mapping, it is used for first
      --  (special) member of any element.

      for Class of Module_Info.Non_Abstract_Classes loop
         Class_Info := Generator.Class_Info.Element (Class);

         for Attribute of Class_Info.All_Attributes loop
            Attribute_Type := Attribute.Get_Type;
            Representation :=
              Generator.Attribute_Mapping.Representation (Attribute);
            Kind :=
              Generator.Type_Mapping.Member_Kind_Name
               (Attribute.Get_Type, Representation);

            if Attribute_Type.all in AMF.CMOF.Classes.CMOF_Class'Class
              and then Representation in Value | Holder
            then
               --  For value and holder representations we use AMF_Link type
               --  for member, while internal type is AMF_Element.

               Unit.Context.Add (+"AMF.Internals");
               Members.Include
                (Kind,
                 (Kind,
                  Generator.Type_Mapping.Member_Name
                   (Attribute_Type, Representation),
                 +"AMF.Internals.AMF_Link"));

            else
               Unit.Context.Add
                (Generator.Type_Mapping.Internal_Ada_Package_Name
                  (Attribute_Type, Representation));
               Members.Include
                (Kind,
                 (Kind,
                  Generator.Type_Mapping.Member_Name
                   (Attribute_Type, Representation),
                 Generator.Type_Mapping.Internal_Ada_Type_Qualified_Name
                  (Attribute_Type, Representation)));
            end if;
         end loop;
      end loop;

      for Member of Members loop
         Unit.Add_Line (+",");
         Unit.Add (+"     ");
         Unit.Add (Member.Member_Kind);
      end loop;

      Unit.Add_Line (+");");

      --  Generate elements table record type.

      Unit.Add_Line;
      Unit.Add_Line
       (+"   type Member_Record (Kind : Member_Kinds := M_None) is record");
      Unit.Add_Line (+"      case Kind is");
      Unit.Add_Line (+"         when M_None =>");
      Unit.Add_Line (+"            null;");

      for Member of Members loop
         Unit.Add_Line;
         Unit.Add_Line ("         when " & Member.Member_Kind & " =>");
         Unit.Add_Line
          ("            "
             & Member.Member_Name
             & " : "
             & Member.Member_Type
             & ";");
      end loop;

      Unit.Add_Line (+"      end case;");
      Unit.Add_Line (+"   end record;");

      --  Generate array of members.

      Unit.Add_Line;
      Unit.Add_Line
       (+"   type Member_Array is array (Natural range 0 .."
           & Integer'Wide_Wide_Image (Module_Info.Member_Count)
           & ") of Member_Record;");

      --  Generate element record type.

      Unit.Context.Add (+"AMF.Elements");

      Unit.Add_Line;
      Unit.Add_Line (+"   type Element_Record is record");
      Unit.Add_Line (+"      Kind   : Element_Kinds := E_None;");
      Unit.Add_Line (+"      Extent : AMF.Internals.AMF_Extent;");
      Unit.Add_Line (+"      Proxy  : AMF.Elements.Element_Access;");
      Unit.Add_Line (+"      Member : Member_Array;");
      Unit.Add_Line (+"   end record;");

      Unit.Add_Line;
      Unit.Add_Line ("end " & Package_Name & ";");

      Unit.Context.Instantiate (Package_Name);
      Unit.Put;
   end Generate_Types_Package;

end Generator.Tables;
