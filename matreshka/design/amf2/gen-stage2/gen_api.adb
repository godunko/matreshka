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
-- Copyright © 2011, Vadim Godunko <vgodunko@gmail.com>                     --
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
--  Generates public API of the model.
with Ada.Command_Line;
with Ada.Containers.Ordered_Sets;
with Ada.Wide_Wide_Text_IO;

with CMOF.Classes;
with CMOF.Collections;
with CMOF.Comments;
with CMOF.Elements;
with CMOF.Extents;
with CMOF.Properties;
with CMOF.Reflection;
with CMOF.Multiplicity_Elements;
with CMOF.Named_Elements;
with CMOF.Typed_Elements;
with CMOF.XMI_Helper;
with League.Strings;
with XMI.Reader;

with Generator.Names;
with Generator.Wide_Wide_Text_IO;

procedure Gen_API is

   use Ada.Wide_Wide_Text_IO;
   use CMOF;
   use CMOF.Classes;
   use CMOF.Collections;
   use CMOF.Comments;
   use CMOF.Elements;
   use CMOF.Properties;
   use CMOF.Reflection;
   use CMOF.Multiplicity_Elements;
   use CMOF.Named_Elements;
   use CMOF.Typed_Elements;
   use CMOF.XMI_Helper;
   use Generator.Names;
   use Generator.Wide_Wide_Text_IO;
   use League.Strings;

   procedure Generate_Class (Class : CMOF.CMOF_Element);

   procedure Generate_Element
    (Position : CMOF.Extents.CMOF_Element_Sets.Cursor);

   package Universal_String_Sets is
     new Ada.Containers.Ordered_Sets
          (League.Strings.Universal_String,
           League.Strings."<",
           League.Strings."=");

   function Split_Text
    (Text : Universal_String; Width : Positive) return Universal_String_Vector;

   --------------------
   -- Generate_Class --
   --------------------

   procedure Generate_Class (Class : CMOF.CMOF_Element) is
      Super_Classes : constant Set_Of_CMOF_Class := Get_Super_Class (Class);
      Attributes    : constant Ordered_Set_Of_CMOF_Property
        := Get_Owned_Attribute (Class);
--      Operations    : constant Ordered_Set_Of_CMOF_Operation
--        := Get_Owned_Operation (Class);
      Ordinary_With : Universal_String_Sets.Set;
      All_With      : Universal_String_Sets.Set;

      function Ada_API_Package_Name
       (Element : CMOF_Class) return League.Strings.Universal_String;

      function Ada_API_Type_Name
       (Element : CMOF_Class) return League.Strings.Universal_String;

      procedure Compute_With_For_Super_Classes;

      procedure Compute_With_For_Attributes;

      procedure Generate_With_Clause (Position : Universal_String_Sets.Cursor);

      procedure Generate_Attribute (Attribute : CMOF_Property);

      --------------------------
      -- Ada_API_Package_Name --
      --------------------------

      function Ada_API_Package_Name
       (Element : CMOF_Class) return League.Strings.Universal_String is
      begin
         return
           To_Universal_String
            ("AMF.CMOF." & Plural (To_Ada_Identifier (Get_Name (Element))));
      end Ada_API_Package_Name;

      -----------------------
      -- Ada_API_Type_Name --
      -----------------------

      function Ada_API_Type_Name
       (Element : CMOF_Class) return League.Strings.Universal_String is
      begin
         return
           To_Universal_String
            ("CMOF_" & To_Ada_Identifier (Get_Name (Element)));
      end Ada_API_Type_Name;

      ---------------------------------
      -- Compute_With_For_Attributes --
      ---------------------------------

      procedure Compute_With_For_Attributes is
         Attribute : CMOF_Property;
         The_Type  : CMOF_Classifier;
         Name      : League.Strings.Universal_String;

      begin
         for J in 1 .. Length (Attributes) loop
            Attribute := Element (Attributes, J);
            The_Type := Get_Type (Attribute);

            if not Is_Data_Type (The_Type)
              and The_Type /= Class
            then
               Name := Ada_API_Package_Name (The_Type);

               if not All_With.Contains (Name) then
                  All_With.Insert (Name);
               end if;
            end if;
         end loop;
      end Compute_With_For_Attributes;

      ------------------------------------
      -- Compute_With_For_Super_Classes --
      ------------------------------------

      procedure Compute_With_For_Super_Classes is
         Name : League.Strings.Universal_String;

      begin
         for J in 1 .. Length (Super_Classes) loop
            Name := Ada_API_Package_Name (Element (Super_Classes, J));
            Ordinary_With.Insert (Name);
            All_With.Insert (Name);
         end loop;
      end Compute_With_For_Super_Classes;

      ------------------------
      -- Generate_Attribute --
      ------------------------

      procedure Generate_Attribute (Attribute : CMOF_Property) is
         Redefines       : constant Set_Of_CMOF_Property
           := Get_Redefined_Property (Attribute);
         Class_Type_Name : constant Wide_Wide_String
           := Ada_API_Type_Name (Class).To_Wide_Wide_String;
         Attribute_Name  : constant Wide_Wide_String
           := To_Ada_Identifier (Get_Name (Attribute));
         Ada_Overriding  : Boolean := False;

         function Type_Qualified_Name return Wide_Wide_String is
         begin
            if Is_Multivalued (Attribute) then
               if Is_Data_Type (Get_Type (Attribute)) then
                  if Get_Name (Get_Type (Attribute))
                       = To_Universal_String ("String")
                  then
                     if Get_Is_Ordered (Attribute)
                       and Get_Is_Unique (Attribute)
                     then
                        return "Ordered_Set_Of_String";

                     elsif Get_Is_Ordered (Attribute) then
                        return "Sequence_Of_String";
                     end if;
                  end if;

                  Put_Line
                   (Standard_Error,
                    Get_Name (Get_Type (Attribute)).To_Wide_Wide_String
                      & " "
                      & Boolean'Wide_Wide_Image (Get_Is_Unique (Attribute))
                      & " "
                      & Boolean'Wide_Wide_Image (Get_Is_Ordered (Attribute)));

               else
                  if Get_Is_Ordered (Attribute)
                    and Get_Is_Unique (Attribute)
                  then
                     return
                       Ada_API_Package_Name
                        (Get_Type (Attribute)).To_Wide_Wide_String
                         & ".Ordered_Set_Of_"
                         & Ada_API_Type_Name
                            (Get_Type (Attribute)).To_Wide_Wide_String;

                  elsif Get_Is_Ordered (Attribute) then
                     return
                       Ada_API_Package_Name
                        (Get_Type (Attribute)).To_Wide_Wide_String
                         & ".Sequence_Of_"
                         & Ada_API_Type_Name
                            (Get_Type (Attribute)).To_Wide_Wide_String;

                  elsif Get_Is_Unique (Attribute) then
                     return
                       Ada_API_Package_Name
                        (Get_Type (Attribute)).To_Wide_Wide_String
                         & ".Set_Of_"
                         & Ada_API_Type_Name
                            (Get_Type (Attribute)).To_Wide_Wide_String;

                  else
                     return
                       Ada_API_Package_Name
                        (Get_Type (Attribute)).To_Wide_Wide_String
                         & ".Bag_Of_"
                         & Ada_API_Type_Name
                            (Get_Type (Attribute)).To_Wide_Wide_String;
                  end if;
               end if;

            else
               if Is_Data_Type (Get_Type (Attribute)) then
                  if Get_Name (Get_Type (Attribute))
                       = To_Universal_String ("Boolean")
                  then
                     if Get_Lower (Attribute) = 0 then
                        return "Optional_Boolean";

                     else
                        return "Boolean";
                     end if;

                  elsif Get_Name (Get_Type (Attribute))
                       = To_Universal_String ("Integer")
                  then
                     if Get_Lower (Attribute) = 0 then
                        return "Optional_Integer";

                     else
                        return "Integer";
                     end if;

                  elsif Get_Name (Get_Type (Attribute))
                       = To_Universal_String ("UnlimitedNatural")
                  then
                     if Get_Lower (Attribute) = 0 then
                        return "Optional_Unlimited_Natural";

                     else
                        return "UnlimitedNatural";
                     end if;

                  elsif Get_Name (Get_Type (Attribute))
                       = To_Universal_String ("String")
                  then
                     if Get_Lower (Attribute) = 0 then
                        return "Optional_String";

                     else
                        return "Universal_String";
                     end if;

                  else
                     if Get_Lower (Attribute) = 0 then
                        return
                          "Optional_"
                            & Ada_API_Type_Name
                               (Get_Type (Attribute)).To_Wide_Wide_String;

                     else
                        return
                          Ada_API_Type_Name
                           (Get_Type (Attribute)).To_Wide_Wide_String;
                     end if;
                  end if;

               else
                  return
                    Ada_API_Package_Name
                     (Get_Type (Attribute)).To_Wide_Wide_String
                      & "."
                      & Ada_API_Type_Name
                         (Get_Type (Attribute)).To_Wide_Wide_String;
               end if;
            end if;
         end Type_Qualified_Name;

      begin
         for J in 1 .. Length (Redefines) loop
            if Get_Name (Element (Redefines, J)) = Get_Name (Attribute) then
               Ada_Overriding := True;

               exit;
            end if;
         end loop;

         New_Line;

         if Ada_Overriding then
            Put_Line ("   overriding function Get_" & Attribute_Name);

         else
            Put_Line ("   not overriding function Get_" & Attribute_Name);
         end if;

         Put_Line
          ("    (Self : not null access constant "
             & Class_Type_Name
             & "_Interface)");
         Put_Line ("       return " & Type_Qualified_Name & " is abstract;");

         --  Generate comment.

         --  XXX Here is good opportunity to use line break cursor to format
         --  text.

         declare
            Owned_Comments : constant Set_Of_CMOF_Comment
              := Get_Owned_Comment (Attribute);
            Lines          : Universal_String_Vector;

         begin
            for J in 1 .. Length (Owned_Comments) loop
               Lines :=
                 Split_Text (Get_Body (Element (Owned_Comments, J)), 71);

               for J in 1 .. Lines.Length loop
                  Put_Line ("   --  " & Lines.Element (J).To_Wide_Wide_String);
               end loop;
            end loop;
         end;

         --  Generate setters for attributes which can be modified by
         --  application and which is not a collections (because changes of
         --  collection, which is returned by getter automatically applied to
         --  attribute's value.

         if Get_Is_Read_Only (Attribute) or Is_Multivalued (Attribute) then
            return;
         end if;

         New_Line;

         if Ada_Overriding then
            Put_Line ("   overriding procedure Set_" & Attribute_Name);

         else
            Put_Line ("   not overriding procedure Set_" & Attribute_Name);
         end if;

         Put_Line
          ("    (Self : not null access " & Class_Type_Name & "_Interface;");
         Put_Line
          ("     To   : " & Type_Qualified_Name & ") is abstract;");
      end Generate_Attribute;

      --------------------------
      -- Generate_With_Clause --
      --------------------------

      procedure Generate_With_Clause
       (Position : Universal_String_Sets.Cursor)
      is
         Name : constant Universal_String
           := Universal_String_Sets.Element (Position);

      begin
         if Ordinary_With.Contains (Name) then
            Put_Line ("with " & Name.To_Wide_Wide_String & ";");

         else
            Put_Line ("limited with " & Name.To_Wide_Wide_String & ";");
         end if;
      end Generate_With_Clause;

      Package_Name  : constant Wide_Wide_String
        := Ada_API_Package_Name (Class).To_Wide_Wide_String;
      Type_Name     : constant Wide_Wide_String
        := Ada_API_Type_Name (Class).To_Wide_Wide_String;

   begin
      Compute_With_For_Super_Classes;
      Compute_With_For_Attributes;

      Put_Line (Standard_Error, Get_Name (Class).To_Wide_Wide_String);

      Put_Header (Year_2010 => False);
      All_With.Iterate (Generate_With_Clause'Access);

      New_Line;
      Put_Line ("package " & Package_Name & " is");
      New_Line;
      Put_Line ("   pragma Preelaborate;");
      New_Line;

      --  Generate interface type.

      Put ("   type " & Type_Name & "_Interface is limited interface");

      for J in 1 .. Length (Super_Classes) loop
         New_Line;
         Put
          ("     and "
             & Ada_API_Package_Name
                (Element (Super_Classes, J)).To_Wide_Wide_String
             & "."
             & Ada_API_Type_Name
                (Element (Super_Classes, J)).To_Wide_Wide_String
             & "_Interface");
      end loop;

      Put_Line (";");

      --  Generate access type.

      New_Line;
      Put_Line ("   type " & Type_Name & " is");
      Put_Line ("     access all " & Type_Name & "_Interface'Class;");

      --  Generate types foe collections.
      --
      --  XXX Collections will be declared in own packages.

      New_Line;
      Put_Line ("   type Set_Of_" & Type_Name & " is null record;");
      Put_Line ("   type Ordered_Set_Of_" & Type_Name & " is null record;");

      --  Generate setters and getters.

      for J in 1 .. Length (Attributes) loop
         Generate_Attribute (Element (Attributes, J));
      end loop;

      New_Line;
      Put_Line ("end " & Package_Name & ";");
   end Generate_Class;

   ----------------------
   -- Generate_Element --
   ----------------------

   procedure Generate_Element
    (Position : CMOF.Extents.CMOF_Element_Sets.Cursor)
   is
      Element : constant CMOF.CMOF_Element
        := CMOF.Extents.CMOF_Element_Sets.Element (Position);

   begin
      if Is_Class (Element) then
         Generate_Class (Element);
      end if;
   end Generate_Element;

   ----------------
   -- Split_Text --
   ----------------

   function Split_Text
    (Text : Universal_String; Width : Positive) return Universal_String_Vector
   is
      --  XXX It would be interesting to use line break iterator here to
      --  look for places of potencial line breaks.

      Result : Universal_String_Vector;
      First  : Positive := 1;
      Last   : Natural  := 0;

   begin
      while First <= Text.Length loop
         Last := Integer'Min (First + Width, Text.Length);

         if Last /= Text.Length then
            while Text.Element (Last) /= ' ' loop
               Last := Last - 1;
            end loop;
         end if;

         Result.Append (Text.Slice (First, Last));
         First := Last + 1;
      end loop;

      return Result;
   end Split_Text;

   Extent   : constant CMOF.CMOF_Extent
     := XMI.Reader (Ada.Command_Line.Argument (1));
   Elements : CMOF.Extents.CMOF_Element_Sets.Set
     := CMOF.Extents.Elements (Extent);

begin
   Elements.Iterate (Generate_Element'Access);
end Gen_API;
