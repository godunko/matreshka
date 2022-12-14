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
-- Copyright © 2011-2014, Vadim Godunko <vgodunko@gmail.com>                --
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
with Ada.Wide_Wide_Text_IO;

with XML.SAX.Input_Sources.Streams.Files;
with XML.SAX.Simple_Readers;

with AMF.CMOF.Data_Types;
with AMF.CMOF.Enumerations;
with AMF.CMOF.Primitive_Types;
with AMF.Extents;
with AMF.URI_Extents;

with Generator.Arguments;
with Generator.Names;
with Generator.Type_Mapping.Handlers;

package body Generator.Type_Mapping is

   use Ada.Wide_Wide_Text_IO;
   use Generator.Names;
   use type League.Strings.Universal_String;

   ----------------------------------
   -- Ada_Enumeration_Literal_Name --
   ----------------------------------

   function Ada_Enumeration_Literal_Name
    (Element : not null access
       AMF.CMOF.Enumeration_Literals.CMOF_Enumeration_Literal'Class)
       return League.Strings.Universal_String
   is
      Position : constant Enumeration_Literal_Maps.Cursor
        := Literal.Find (AMF.CMOF.Elements.CMOF_Element_Access (Element));

   begin
      if Enumeration_Literal_Maps.Has_Element (Position)
        and then
          not Enumeration_Literal_Maps.Element (Position).Ada_Name.Is_Empty
      then
         return Enumeration_Literal_Maps.Element (Position).Ada_Name;

      else
         --  Generate name then it is not specified explicitly.

         return
           League.Strings.To_Universal_String
            (To_Ada_Identifier (Element.Get_Name.Value));
      end if;
   end Ada_Enumeration_Literal_Name;

   --------------------------------------------
   -- Ada_Enumeration_Literal_Qualified_Name --
   --------------------------------------------

   function Ada_Enumeration_Literal_Qualified_Name
    (Element : not null access
       AMF.CMOF.Enumeration_Literals.CMOF_Enumeration_Literal'Class)
       return League.Strings.Universal_String is
   begin
      return
        "AMF."
          & Owning_Metamodel_Ada_Name (Element)
          & "."
          & Ada_Enumeration_Literal_Name (Element);
   end Ada_Enumeration_Literal_Qualified_Name;

   -----------------------------
   -- Public_Ada_Package_Name --
   -----------------------------

   function Public_Ada_Package_Name
    (The_Type       : not null access AMF.CMOF.Types.CMOF_Type'Class;
     Representation : Representation_Kinds)
       return League.Strings.Universal_String
   is
      Type_Element : constant AMF.CMOF.Elements.CMOF_Element_Access
        := AMF.CMOF.Elements.CMOF_Element_Access (The_Type);

   begin
      --  Use user specified mapping if any.

      if Mapping.Contains (Type_Element)
        and then Mapping.Element
                  (Type_Element).Mapping (Representation) /= null
        and then Mapping.Element
                      (Type_Element).Mapping (Representation).Has_Ada_Package
      then
         return
           Mapping.Element
            (Type_Element).Mapping (Representation).Ada_Package;
      end if;

      --  Otherwise synthesize it.

      if The_Type.all in AMF.CMOF.Classes.CMOF_Class'Class then
         if Representation in Value .. Holder then
            return
              "AMF."
                & Owning_Metamodel_Ada_Name (The_Type)
                & "."
                & Plural (To_Ada_Identifier (The_Type.Get_Name.Value));

         else
            return
              "AMF."
                & Owning_Metamodel_Ada_Name (The_Type)
                & "."
                & Plural (To_Ada_Identifier (The_Type.Get_Name.Value))
                & ".Collections";
         end if;

      else
         return "AMF." & Owning_Metamodel_Ada_Name (The_Type);
      end if;
   end Public_Ada_Package_Name;

   --------------------------
   -- Public_Ada_Type_Name --
   --------------------------

   function Public_Ada_Type_Name
    (The_Type       : not null access AMF.CMOF.Types.CMOF_Type'Class;
     Representation : Representation_Kinds)
       return League.Strings.Universal_String is
   begin
      if The_Type.all in AMF.CMOF.Classes.CMOF_Class'Class then
         case Representation is
            when Value | Holder =>
               return
                 Owning_Metamodel_Ada_Name (The_Type)
                   & "_"
                   & To_Ada_Identifier (The_Type.Get_Name.Value)
                   & "_Access";

            when Set =>
               return
                 "Set_Of_"
                   & Owning_Metamodel_Ada_Name (The_Type)
                   & "_"
                   & To_Ada_Identifier (The_Type.Get_Name.Value);

            when Ordered_Set =>
               return
                 "Ordered_Set_Of_"
                   & Owning_Metamodel_Ada_Name (The_Type)
                   & "_"
                   & To_Ada_Identifier (The_Type.Get_Name.Value);

            when Bag =>
               return
                 "Bag_Of_"
                   & Owning_Metamodel_Ada_Name (The_Type)
                   & "_"
                   & To_Ada_Identifier (The_Type.Get_Name.Value);

            when Sequence =>
               return
                 "Sequence_Of_"
                   & Owning_Metamodel_Ada_Name (The_Type)
                   & "_"
                   & To_Ada_Identifier (The_Type.Get_Name.Value);
         end case;

      else
         if Mapping.Contains
             (AMF.CMOF.Elements.CMOF_Element_Access (The_Type))
           and then Mapping.Element
                     (AMF.CMOF.Elements.CMOF_Element_Access
                       (The_Type)).Mapping (Representation) /= null
           and then not Mapping.Element
                         (AMF.CMOF.Elements.CMOF_Element_Access
                           (The_Type)).Mapping
                             (Representation).Ada_Type.Is_Empty
         then
            return
              Mapping.Element
               (AMF.CMOF.Elements.CMOF_Element_Access
                 (The_Type)).Mapping (Representation).Ada_Type;

         else
            case Representation is
               when Value =>
                  return
                    Owning_Metamodel_Ada_Name (The_Type)
                      & "_"
                      & To_Ada_Identifier (The_Type.Get_Name.Value);

               when Holder =>
                  return
                    "Optional_"
                      & Owning_Metamodel_Ada_Name (The_Type)
                      & "_"
                      & To_Ada_Identifier (The_Type.Get_Name.Value);

               when others =>
                  raise Program_Error;
            end case;
         end if;
      end if;
   end Public_Ada_Type_Name;

   ------------------------------------
   -- Public_Ada_Type_Qualified_Name --
   ------------------------------------

   function Public_Ada_Type_Qualified_Name
    (The_Type       : not null access AMF.CMOF.Types.CMOF_Type'Class;
     Representation : Representation_Kinds)
       return League.Strings.Universal_String
   is
      Package_Name : constant League.Strings.Universal_String
        := Public_Ada_Package_Name (The_Type, Representation);

   begin
      if Package_Name.Is_Empty then
         return Public_Ada_Type_Name (The_Type, Representation);

      else
         return
           Package_Name
             & "."
             & Public_Ada_Type_Name (The_Type, Representation);
      end if;
   end Public_Ada_Type_Qualified_Name;

   -------------------------------
   -- Internal_Ada_Package_Name --
   -------------------------------

   function Internal_Ada_Package_Name
    (The_Type       : not null access AMF.CMOF.Types.CMOF_Type'Class;
     Representation : Representation_Kinds)
       return League.Strings.Universal_String
   is
      Type_Element : constant AMF.CMOF.Elements.CMOF_Element_Access
        := AMF.CMOF.Elements.CMOF_Element_Access (The_Type);

   begin
      --  Use user specified mapping if any.

      if Mapping.Contains (Type_Element)
        and then Mapping.Element
                  (Type_Element).Mapping (Representation) /= null
        and then Mapping.Element
                      (Type_Element).Mapping
                        (Representation).Has_Internal_Ada_Package
      then
         return
           Mapping.Element
            (Type_Element).Mapping (Representation).Internal_Ada_Package;
      end if;

      --  Otherwise synthesize it.

      if The_Type.all in AMF.CMOF.Classes.CMOF_Class'Class then
         --  Classes are represented by internal data types.

         return +"AMF.Internals";

      elsif The_Type.all in AMF.CMOF.Enumerations.CMOF_Enumeration'Class then
         --  Enumeration types are declared in AMF.<metamodel> package.

         return Public_Ada_Package_Name (The_Type, Representation);

      elsif The_Type.all in AMF.CMOF.Data_Types.CMOF_Data_Type'Class then
         --  Data types are mapped according to specified mapping rules.

         if Mapping.Contains (AMF.CMOF.Elements.CMOF_Element_Access (The_Type))
           and then Mapping.Element
                     (AMF.CMOF.Elements.CMOF_Element_Access
                       (The_Type)).Mapping (Representation) /= null
           and then not Mapping.Element
                         (AMF.CMOF.Elements.CMOF_Element_Access
                           (The_Type)).Mapping
                             (Representation).Internal_Ada_Package.Is_Empty
         then
            return
              Mapping.Element
               (AMF.CMOF.Elements.CMOF_Element_Access
                 (The_Type)).Mapping (Representation).Internal_Ada_Package;


         else
            return Public_Ada_Package_Name (The_Type, Representation);
         end if;

      else
         raise Program_Error;
      end if;
   end Internal_Ada_Package_Name;

   --------------------------------------
   -- Internal_Ada_Type_Qualified_Name --
   --------------------------------------

   function Internal_Ada_Type_Qualified_Name
    (The_Type       : not null access AMF.CMOF.Types.CMOF_Type'Class;
     Representation : Representation_Kinds)
       return League.Strings.Universal_String is
   begin
      if The_Type.all in AMF.CMOF.Classes.CMOF_Class'Class then
         --  Classes are represented by internal data types.

         case Representation is
            when Value | Holder =>
               return +"AMF.Internals.AMF_Element";

            when Set | Ordered_Set | Bag | Sequence =>
               return +"AMF.Internals.AMF_Collection_Of_Element";
         end case;

      elsif The_Type.all in AMF.CMOF.Enumerations.CMOF_Enumeration'Class then
         --  Enumeration types are declared in AMF.<metamodel> package and
         --  has <metamodel>_<type> name.

         return
           Public_Ada_Package_Name (The_Type, Representation)
             & "."
             & Public_Ada_Type_Name (The_Type, Representation);

      elsif The_Type.all in AMF.CMOF.Data_Types.CMOF_Data_Type'Class then
         --  Data types are mapped according to specified mapping rules.

         if Mapping.Contains (AMF.CMOF.Elements.CMOF_Element_Access(The_Type))
           and then Mapping.Element
                     (AMF.CMOF.Elements.CMOF_Element_Access
                       (The_Type)).Mapping (Representation) /= null
           and then not Mapping.Element
                         (AMF.CMOF.Elements.CMOF_Element_Access
                           (The_Type)).Mapping
                             (Representation).Internal_Ada_Type.Is_Empty
         then
            if not Internal_Ada_Package_Name
                    (The_Type, Representation).Is_Empty
            then
               return
                 Internal_Ada_Package_Name (The_Type, Representation)
                   & "."
                   & Mapping.Element
                      (AMF.CMOF.Elements.CMOF_Element_Access
                        (The_Type)).Mapping (Representation).Internal_Ada_Type;

            else
               return
                 Mapping.Element
                  (AMF.CMOF.Elements.CMOF_Element_Access
                    (The_Type)).Mapping (Representation).Internal_Ada_Type;
            end if;

         else
            return Public_Ada_Type_Qualified_Name (The_Type, Representation);
         end if;

      else
         raise Program_Error;
      end if;
   end Internal_Ada_Type_Qualified_Name;

   ------------------
   -- Load_Mapping --
   ------------------

   procedure Load_Mapping is
      Reader  : aliased XML.SAX.Simple_Readers.Simple_Reader;
      Input   : aliased XML.SAX.Input_Sources.Streams.Files.File_Input_Source;
      Handler : aliased Generator.Type_Mapping.Handlers.Mapping_Handler;

   begin
      Input.Open_By_File_Name (Generator.Arguments.Type_Mapping_File);
      Reader.Set_Content_Handler (Handler'Unchecked_Access);
--      Reader.Set_Error_Handler (Handler'Unchecked_Access);
      Reader.Parse (Input'Unchecked_Access);
   end Load_Mapping;

   -----------------
   -- Member_Name --
   -----------------

   function Member_Name
    (Element        : not null access AMF.CMOF.Elements.CMOF_Element'Class;
     Representation : Representation_Kinds)
       return League.Strings.Universal_String
   is
      Position : constant Mapping_Maps.Cursor
        := Mapping.Find (AMF.CMOF.Elements.CMOF_Element_Access (Element));
      Ada_Name : constant League.Strings.Universal_String
        := +To_Ada_Identifier
             (AMF.CMOF.Named_Elements.CMOF_Named_Element'Class
               (Element.all).Get_Name.Value);

   begin
      if Mapping_Maps.Has_Element (Position)
        and then Mapping_Maps.Element (Position).Mapping (Representation)
                   /= null
        and then not Mapping_Maps.Element
                      (Position).Mapping (Representation).Member_Name.Is_Empty
      then
         return
           Mapping.Element
            (AMF.CMOF.Elements.CMOF_Element_Access (Element)).Mapping
              (Representation).Member_Name;

      else
         if Element.all in AMF.CMOF.Classes.CMOF_Class'Class then
            case Representation is
               when Value | Holder =>
                  return +"Link";

               when Set | Ordered_Set | Bag | Sequence =>
                  return +"Collection";
            end case;

         else
            case Representation is
               when Value =>
                  return Ada_Name & "_Value";

               when Holder =>
                  return Ada_Name & "_Holder";

               when Set | Ordered_Set | Bag | Sequence =>
                  return Ada_Name & "_Collection";
            end case;
         end if;
      end if;
   end Member_Name;

   ----------------------
   -- Member_Kind_Name --
   ----------------------

   function Member_Kind_Name
    (Element        : not null access AMF.CMOF.Elements.CMOF_Element'Class;
     Representation : Representation_Kinds)
       return League.Strings.Universal_String
   is
      Position : constant Mapping_Maps.Cursor
        := Mapping.Find (AMF.CMOF.Elements.CMOF_Element_Access (Element));
      Ada_Name : constant League.Strings.Universal_String
        := +To_Ada_Identifier
             (AMF.CMOF.Named_Elements.CMOF_Named_Element'Class
               (Element.all).Get_Name.Value);

   begin
      if Mapping_Maps.Has_Element (Position)
        and then Mapping_Maps.Element (Position).Mapping (Representation)
                   /= null
        and then not Mapping_Maps.Element
                      (Position).Mapping
                        (Representation).Member_Kind_Name.Is_Empty
      then
         return
           Mapping.Element
            (AMF.CMOF.Elements.CMOF_Element_Access (Element)).Mapping
              (Representation).Member_Kind_Name;

      else
         if Element.all in AMF.CMOF.Classes.CMOF_Class'Class then
            case Representation is
               when Value | Holder =>
                  return +"M_Element";

               when Set | Ordered_Set | Bag | Sequence =>
                  return +"M_Collection_Of_Element";
            end case;

         else
            case Representation is
               when Value =>
                  return "M_" & Ada_Name;

               when Holder =>
                  return "M_Holder_Of_" & Ada_Name;

               when Set | Ordered_Set | Bag | Sequence =>
                  return "M_Collection_Of_" & Ada_Name;
            end case;
         end if;
      end if;
   end Member_Kind_Name;

end Generator.Type_Mapping;
