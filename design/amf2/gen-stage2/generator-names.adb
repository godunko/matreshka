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
-- Copyright © 2010-2012, Vadim Godunko <vgodunko@gmail.com>                --
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
with Ada.Characters.Conversions;
with Ada.Characters.Handling;
with Ada.Tags;

with AMF.CMOF.Properties.Collections;
with AMF.Elements;

package body Generator.Names is

   use type League.Strings.Universal_String;

   function Get_Type_Ada_Name
    (Attribute : not null AMF.CMOF.Properties.CMOF_Property_Access)
       return League.Strings.Universal_String;
   --  Returns name of class or data type which owns property.

   -------------------------------
   -- Association_Constant_Name --
   -------------------------------

   function Association_Constant_Name
    (Association : not null AMF.CMOF.Associations.CMOF_Association_Access)
       return League.Strings.Universal_String
   is
      function Get_Ada_Name
       (Attribute : not null AMF.CMOF.Properties.CMOF_Property_Access)
          return League.Strings.Universal_String;

      ------------------
      -- Get_Ada_Name --
      ------------------

      function Get_Ada_Name
       (Attribute : not null AMF.CMOF.Properties.CMOF_Property_Access)
          return League.Strings.Universal_String
      is
         Name : constant AMF.Optional_String := Attribute.Get_Name;

      begin
         if Name.Is_Empty then
            return League.Strings.Empty_Universal_String;

         else
            return
              League.Strings.To_Universal_String
               (To_Ada_Identifier (Name.Value));
         end if;
      end Get_Ada_Name;

      Member_End  : constant
        AMF.CMOF.Properties.Collections.Ordered_Set_Of_CMOF_Property
          := Association.Get_Member_End;
      First_End   : constant AMF.CMOF.Properties.CMOF_Property_Access
        := Member_End.Element (1);
      Second_End  : constant AMF.CMOF.Properties.CMOF_Property_Access
        := Member_End.Element (2);
      First_Name  : constant League.Strings.Universal_String
        := Get_Ada_Name (First_End);
      Second_Name : constant League.Strings.Universal_String
        := Get_Ada_Name (Second_End);
      Ada_Name    : League.Strings.Universal_String;

   begin
      Ada_Name.Append (Get_Type_Ada_Name (First_End));

      if not First_Name.Is_Empty then
         Ada_Name.Append ('_');
         Ada_Name.Append (First_Name);
      end if;

      Ada_Name.Append ('_');

      if Second_Name.Is_Empty then
         Ada_Name.Append (Get_Type_Ada_Name (Second_End));

      else
         Ada_Name.Append (Second_Name);
      end if;

      return
        "MA_"
          & Owning_Metamodel_Ada_Name (Association)
          & "_"
          & Ada_Name;
   end Association_Constant_Name;

   ---------------------------------------
   -- Association_Constant_Package_Name --
   ---------------------------------------

   function Association_Constant_Package_Name
    (Association : not null AMF.CMOF.Associations.CMOF_Association_Access)
       return League.Strings.Universal_String is
   begin
      return
        "AMF.Internals.Tables."
          & Owning_Metamodel_Ada_Name (Association)
          & "_Metamodel";
   end Association_Constant_Package_Name;

   -----------------------------------------
   -- Association_Constant_Qualified_Name --
   -----------------------------------------

   function Association_Constant_Qualified_Name
    (Association : not null AMF.CMOF.Associations.CMOF_Association_Access)
       return League.Strings.Universal_String is
   begin
      return
        Association_Constant_Package_Name (Association)
          & "."
          & Association_Constant_Name (Association);
   end Association_Constant_Qualified_Name;

   -----------------------------------
   -- Element_Constant_Package_Name --
   -----------------------------------

   function Element_Constant_Package_Name
    (Element : not null AMF.CMOF.Elements.CMOF_Element_Access)
       return League.Strings.Universal_String is
   begin
      if Element.all in AMF.CMOF.Types.CMOF_Type'Class then
         return
           Type_Constant_Package_Name
            (AMF.CMOF.Types.CMOF_Type_Access (Element));

      elsif Element.all in AMF.CMOF.Packages.CMOF_Package'Class then
         return
           Package_Constant_Package_Name
            (AMF.CMOF.Packages.CMOF_Package_Access (Element));

      elsif Element.all in AMF.CMOF.Properties.CMOF_Property'Class then
         return
           Property_Constant_Package_Name
            (AMF.CMOF.Properties.CMOF_Property_Access (Element));

      else
         raise Program_Error with Ada.Tags.External_Tag (Element'Tag);
      end if;
   end Element_Constant_Package_Name;

   -------------------------------------
   -- Element_Constant_Qualified_Name --
   -------------------------------------

   function Element_Constant_Qualified_Name
    (Element : not null AMF.CMOF.Elements.CMOF_Element_Access)
       return League.Strings.Universal_String is
   begin
      if Element.all in AMF.CMOF.Types.CMOF_Type'Class then
         return
           Type_Constant_Qualified_Name
            (AMF.CMOF.Types.CMOF_Type_Access (Element));

      elsif Element.all in AMF.CMOF.Packages.CMOF_Package'Class then
         return
           Package_Constant_Qualified_Name
            (AMF.CMOF.Packages.CMOF_Package_Access (Element));

      elsif Element.all in AMF.CMOF.Properties.CMOF_Property'Class then
         return
           Property_Constant_Qualified_Name
            (AMF.CMOF.Properties.CMOF_Property_Access (Element));

      else
         raise Program_Error with Ada.Tags.External_Tag (Element'Tag);
      end if;
   end Element_Constant_Qualified_Name;

   -----------------------
   -- Get_Type_Ada_Name --
   -----------------------

   function Get_Type_Ada_Name
    (Attribute : not null AMF.CMOF.Properties.CMOF_Property_Access)
       return League.Strings.Universal_String
   is
      use type AMF.CMOF.Classes.CMOF_Class_Access;
      use type AMF.CMOF.Data_Types.CMOF_Data_Type_Access;
      use type AMF.CMOF.Types.CMOF_Type_Access;

      The_Class     : constant AMF.CMOF.Classes.CMOF_Class_Access
        := Attribute.Get_Class;
      The_Data_Type : constant AMF.CMOF.Data_Types.CMOF_Data_Type_Access
        := Attribute.Get_Datatype;
      The_Type      : AMF.CMOF.Types.CMOF_Type_Access;

   begin
      if The_Class /= null then
         The_Type := AMF.CMOF.Types.CMOF_Type_Access (The_Class);

      elsif The_Data_Type /= null then
         The_Type := AMF.CMOF.Types.CMOF_Type_Access (The_Data_Type);

      else
         --  CMOF::Property is owned by association.

         return League.Strings.To_Universal_String ("A");
      end if;

      return
        League.Strings.To_Universal_String
         (To_Ada_Identifier (The_Type.Get_Name.Value));
   end Get_Type_Ada_Name;

   -------------------------------
   -- Owning_Metamodel_Ada_Name --
   -------------------------------

   function Owning_Metamodel_Ada_Name
    (Element : not null access AMF.CMOF.Elements.CMOF_Element'Class)
       return League.Strings.Universal_String is
   begin
      return +To_Ada_Identifier (Owning_Metamodel_Name (Element));
   end Owning_Metamodel_Ada_Name;

   ---------------------------
   -- Owning_Metamodel_Name --
   ---------------------------

   function Owning_Metamodel_Name
    (Element : not null access AMF.CMOF.Elements.CMOF_Element'Class)
       return League.Strings.Universal_String
   is
      use type AMF.Elements.Element_Access;

      Current : AMF.Elements.Element_Access
        := AMF.Elements.Element_Access (Element);

   begin
      while Current /= null loop
         if Current.all in AMF.CMOF.Packages.CMOF_Package'Class then
            return
              AMF.CMOF.Packages.CMOF_Package'Class
               (Current.all).Get_Name.Value;
         end if;

         Current := Current.Container;
      end loop;

      raise Program_Error;
   end Owning_Metamodel_Name;

   ---------------------------
   -- Package_Constant_Name --
   ---------------------------

   function Package_Constant_Name
    (Element : not null AMF.CMOF.Packages.CMOF_Package_Access)
       return League.Strings.Universal_String is
   begin
      return
        "MM_"
          & Owning_Metamodel_Ada_Name (Element)
          & "_"
          & To_Ada_Identifier (Element.Get_Name.Value);
   end Package_Constant_Name;

   -----------------------------------
   -- Package_Constant_Package_Name --
   -----------------------------------

   function Package_Constant_Package_Name
    (Element : not null AMF.CMOF.Packages.CMOF_Package_Access)
       return League.Strings.Universal_String is
   begin
      return
        "AMF.Internals.Tables."
          & Owning_Metamodel_Ada_Name (Element)
          & "_Metamodel";
   end Package_Constant_Package_Name;

   -------------------------------------
   -- Package_Constant_Qualified_Name --
   -------------------------------------

   function Package_Constant_Qualified_Name
    (Element : not null AMF.CMOF.Packages.CMOF_Package_Access)
       return League.Strings.Universal_String is
   begin
      return
        Package_Constant_Package_Name (Element)
          & '.'
          & Package_Constant_Name (Element);
   end Package_Constant_Qualified_Name;

   ------------
   -- Plural --
   ------------

   function Plural (Name : Wide_Wide_String) return Wide_Wide_String is
   begin
      --  Some exceptions.

      if Name = "Bounds" then
         return Name;
      end if;

      if Name (Name'Last) = 'y' then
         return Name (Name'First .. Name'Last - 1) & "ies";

      elsif Name (Name'Last) = 's' then
         return Name & "es";

      else
         return Name & "s";
      end if;
   end Plural;

   ----------------------------
   -- Property_Constant_Name --
   ----------------------------

   function Property_Constant_Name
    (Property : not null AMF.CMOF.Properties.CMOF_Property_Access)
       return League.Strings.Universal_String
   is
      use type AMF.CMOF.Associations.CMOF_Association_Access;
      use type AMF.CMOF.Properties.CMOF_Property_Access;

      function Name
       (First_End  : not null AMF.CMOF.Properties.CMOF_Property_Access;
        Second_End : not null AMF.CMOF.Properties.CMOF_Property_Access)
          return League.Strings.Universal_String;

      ----------
      -- Name --
      ----------

      function Name
       (First_End  : not null AMF.CMOF.Properties.CMOF_Property_Access;
        Second_End : not null AMF.CMOF.Properties.CMOF_Property_Access)
          return League.Strings.Universal_String
      is
         First_Name  : constant League.Strings.Universal_String
           := League.Strings.To_Universal_String
               (To_Ada_Identifier (First_End.Get_Name.Value));
         Second_Name : constant League.Strings.Universal_String
           := League.Strings.To_Universal_String
               (To_Ada_Identifier (Second_End.Get_Name.Value));
         Ada_Name    : League.Strings.Universal_String;

      begin
         Ada_Name := Get_Type_Ada_Name (First_End);
         Ada_Name.Append ('_');
         Ada_Name.Append (First_Name);
         Ada_Name.Append ('_');
         Ada_Name.Append (Get_Type_Ada_Name (Second_End));
         Ada_Name.Append ('_');
         Ada_Name.Append (Second_Name);

         return Ada_Name;
      end Name;

      Association        : constant
        AMF.CMOF.Associations.CMOF_Association_Access
          := Property.Get_Association;
      Ada_Name    : League.Strings.Universal_String;

   begin
      if Association /= null then
         declare
            Member_End  : constant
              AMF.CMOF.Properties.Collections.Ordered_Set_Of_CMOF_Property
                := Association.Get_Member_End;
            First_End   : constant
              not null AMF.CMOF.Properties.CMOF_Property_Access
                := Member_End.Element (1);
            Second_End  : constant
              not null AMF.CMOF.Properties.CMOF_Property_Access
                := Member_End.Element (2);

         begin
            if Property = First_End then
               Ada_Name := Name (First_End, Second_End);

            else
               Ada_Name := Name (Second_End, First_End);
            end if;
         end;

      else
         declare
            use type AMF.CMOF.Classes.CMOF_Class_Access;

            Class     : constant AMF.CMOF.Classes.CMOF_Class_Access
              := Property.Get_Class;
            Data_Type : constant AMF.CMOF.Data_Types.CMOF_Data_Type_Access
                := Property.Get_Datatype;
            Name      : League.Strings.Universal_String;

         begin
            if Class /= null then
               Name := Class.Get_Name.Value;

            else
               Name := Data_Type.Get_Name.Value;
            end if;

            Ada_Name :=
              League.Strings.To_Universal_String
               (To_Ada_Identifier (Name)
                  & '_'
                  & To_Ada_Identifier (Property.Get_Name.Value));
         end;
      end if;

      return
        "MP_"
          & Owning_Metamodel_Ada_Name (Property)
          & "_"
          & Ada_Name;
   end Property_Constant_Name;

   ------------------------------------
   -- Property_Constant_Package_Name --
   ------------------------------------

   function Property_Constant_Package_Name
    (Property : not null AMF.CMOF.Properties.CMOF_Property_Access)
       return League.Strings.Universal_String is
   begin
      return
        "AMF.Internals.Tables."
          & Owning_Metamodel_Ada_Name (Property)
          & "_Metamodel";
   end Property_Constant_Package_Name;

   --------------------------------------
   -- Property_Constant_Qualified_Name --
   --------------------------------------

   function Property_Constant_Qualified_Name
    (Property : not null AMF.CMOF.Properties.CMOF_Property_Access)
       return League.Strings.Universal_String is
   begin
      return
        Property_Constant_Package_Name (Property)
          & "."
          & Property_Constant_Name (Property);
   end Property_Constant_Qualified_Name;

   -----------------------
   -- To_Ada_Identifier --
   -----------------------

   function To_Ada_Identifier
    (Name : Wide_Wide_String) return Wide_Wide_String
   is
      use Ada.Characters.Conversions;
      use Ada.Characters.Handling;

      Aux  : Wide_Wide_String (1 .. Name'Length * 2);
      Last : Natural := 0;

   begin
      for J in Name'Range loop
         if J = Name'First then
            Last := Last + 1;
            Aux (Last) :=
              To_Wide_Wide_Character (To_Upper (To_Character (Name (J))));

         else
            if Is_Upper (To_Character (Name (J)))
              and then ((J /= Name'First
                           and not Is_Upper (To_Character (Name (J - 1))))
                           or (J < Name'Last
                                 and then
                                   not Is_Upper (To_Character (Name (J + 1)))))
            then
               if Last > 0 and then Aux (Last) /= '_' then
                  Last := Last + 1;
                  Aux (Last) := '_';
               end if;
            end if;

            Last := Last + 1;
            Aux (Last) := Name (J);
         end if;
      end loop;

      --  Remove trailing underscores.

      loop
         exit when Aux (Last) /= '_';

         Last := Last - 1;
      end loop;

      return Aux (Aux'First .. Last);
   end To_Ada_Identifier;

   -----------------------
   -- To_Ada_Identifier --
   -----------------------

   function To_Ada_Identifier
    (Name : League.Strings.Universal_String) return Wide_Wide_String is
   begin
      return To_Ada_Identifier (Name.To_Wide_Wide_String);
   end To_Ada_Identifier;

   ------------------------
   -- Type_Constant_Name --
   ------------------------

   function Type_Constant_Name
    (Element : not null access constant AMF.CMOF.Types.CMOF_Type'Class)
       return League.Strings.Universal_String is
   begin
      return
        "MC_"
          & Owning_Metamodel_Ada_Name (Element)
          & "_"
          & To_Ada_Identifier (Element.Get_Name.Value);
   end Type_Constant_Name;

   --------------------------------
   -- Type_Constant_Package_Name --
   --------------------------------

   function Type_Constant_Package_Name
    (Element : not null access constant AMF.CMOF.Types.CMOF_Type'Class)
       return League.Strings.Universal_String is
   begin
      return
        "AMF.Internals.Tables."
          & Owning_Metamodel_Ada_Name (Element)
          & "_Metamodel";
   end Type_Constant_Package_Name;

   ----------------------------------
   -- Type_Constant_Qualified_Name --
   ----------------------------------

   function Type_Constant_Qualified_Name
    (Element : not null access constant AMF.CMOF.Types.CMOF_Type'Class)
       return League.Strings.Universal_String is
   begin
      return
        Type_Constant_Package_Name (Element)
          & '.'
          & Type_Constant_Name (Element);
   end Type_Constant_Qualified_Name;

end Generator.Names;
