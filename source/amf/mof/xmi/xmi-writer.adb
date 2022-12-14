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
with Ada.Containers.Hashed_Sets;

with League.Holders;
with League.Strings;
with XML.SAX.Attributes;
with XML.SAX.Pretty_Writers;
with XML.SAX.String_Output_Destinations;
with XML.SAX.Writers;

with AMF.CMOF.Associations;
with AMF.CMOF.Classes.Collections;
with AMF.CMOF.Data_Types;
with AMF.CMOF.Elements.Collections;
with AMF.CMOF.Elements.Hash;
with AMF.CMOF.Enumerations;
with AMF.Objects;
with AMF.CMOF.Packages;
with AMF.CMOF.Primitive_Types;
with AMF.CMOF.Properties.Collections;
with AMF.CMOF.Types;
with AMF.CMOF.Tags;
with AMF.Elements.Collections;
with AMF.Extents;
with AMF.Holders.Elements;
with AMF.Holders.Reflective_Collections;
with AMF.Reflective_Collections;
with AMF.URI_Extents;

function XMI.Writer
 (Store : not null access AMF.URI_Stores.URI_Store'Class)
    return League.Strings.Universal_String
is
   use type AMF.CMOF.Properties.CMOF_Property_Access;
   use type AMF.CMOF.Tags.CMOF_Tag_Access;
   use type AMF.Elements.Element_Access;
   use type League.Strings.Universal_String;

   XSI_Prefix        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("xsi");
   XSI_Namespace_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("http://www.w3.org/2001/XMLSchema-instance");
   XMI_Prefix        : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("xmi");
   XMI_Namespace_URI : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String
         ("http://www.omg.org/spec/XMI/20100901");

   XMI_Element    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("XMI");

   Id_Attribute   : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("id");
   Nil_Attribute  : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("nil");
   Type_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("type");
   Href_Attribute : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("href");

   True_Literal : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("true");

   Include_Nils_Tag : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("org.omg.xmi.includeNils");
   NS_Prefix_Tag    : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("org.omg.xmi.nsPrefix");
   NS_URI_Tag       : constant League.Strings.Universal_String
     := League.Strings.To_Universal_String ("org.omg.xmi.nsURI");

   function Hash
    (Item : AMF.CMOF.Properties.CMOF_Property_Access)
       return Ada.Containers.Hash_Type;

   package Property_Sets is
     new Ada.Containers.Hashed_Sets
          (AMF.CMOF.Properties.CMOF_Property_Access,
           Hash,
           AMF.CMOF.Properties."=",
           AMF.CMOF.Properties."=");

   function Lookup_Tag
    (Name        : League.Strings.Universal_String;
     The_Element : not null access AMF.CMOF.Elements.CMOF_Element'Class)
       return AMF.CMOF.Tags.CMOF_Tag_Access;
   --  Returns instance of CMOF::Tag which is applied to given element.

   function Namespace_Prefix
    (The_Package : not null AMF.CMOF.Packages.CMOF_Package_Access)
       return League.Strings.Universal_String;
   --  Returns namespace prefix for the package.

   function Namespace_URI
    (The_Package : not null AMF.CMOF.Packages.CMOF_Package_Access)
       return League.Strings.Universal_String;
   --  Returns namespace URI for the package.

   function Include_Nils
    (The_Property : not null AMF.CMOF.Properties.CMOF_Property_Access)
       return Boolean;
   --  Returns value of includeNuls tag for the property.

   function Identifier
    (Element : not null AMF.Elements.Element_Access)
       return League.Strings.Universal_String;
   --  Returns identifier of the element in the extent.

   function Serializable_Attributes
    (Class : not null AMF.CMOF.Classes.CMOF_Class_Access)
       return Property_Sets.Set;
   --  Returns class's properties that should be serialized as XML attributes.

   procedure Serialize
    (Writer    : in out XML.SAX.Writers.SAX_Writer'Class;
     Ownership : AMF.CMOF.Properties.CMOF_Property_Access;
     Element   : not null AMF.Elements.Element_Access);
   --  Serialize element.
   --
   --  When Ownership attribute is null it mean that element is root level
   --  element, otherwise it means what element is owned by another element in
   --  Ownership attribute.

   function Subsets_Composite_Serializable
    (Attribute    : not null access AMF.CMOF.Properties.CMOF_Property'Class;
     Serializable : Property_Sets.Set)
       return Boolean;
   --  Returns True when one of subsetted properties is composite and
   --  serializable.

   ----------
   -- Hash --
   ----------

   function Hash
    (Item : AMF.CMOF.Properties.CMOF_Property_Access)
       return Ada.Containers.Hash_Type is
   begin
      return
        AMF.CMOF.Elements.Hash (AMF.CMOF.Elements.CMOF_Element_Access (Item));
   end Hash;

   ----------------
   -- Identifier --
   ----------------

   function Identifier
    (Element : not null AMF.Elements.Element_Access)
       return League.Strings.Universal_String
   is
      URI       : constant League.Strings.Universal_String
        := Store.URI (Element);
      Separator : constant Natural := URI.Index ('#');

   begin
      return URI.Slice (Separator + 1, URI.Length);
   end Identifier;

   ------------------
   -- Include_Nils --
   ------------------

   function Include_Nils
    (The_Property : not null AMF.CMOF.Properties.CMOF_Property_Access)
       return Boolean
   is
      Tag : constant AMF.CMOF.Tags.CMOF_Tag_Access
        := Lookup_Tag (Include_Nils_Tag, The_Property);

   begin
      if Tag /= null then
         return Boolean'Wide_Wide_Value (Tag.Get_Value.To_Wide_Wide_String);

      else
         return True;
      end if;
   end Include_Nils;

   ----------------
   -- Lookup_Tag --
   ----------------

   function Lookup_Tag
    (Name        : League.Strings.Universal_String;
     The_Element : not null access AMF.CMOF.Elements.CMOF_Element'Class)
       return AMF.CMOF.Tags.CMOF_Tag_Access
   is
      Extent       : constant AMF.Extents.Extent_Access
        := AMF.Elements.Element_Access (The_Element).Extent;
      Elements     : constant AMF.Elements.Collections.Set_Of_Element
        := Extent.Elements;
      Element      : AMF.Elements.Element_Access;
      Tag          : AMF.CMOF.Tags.CMOF_Tag_Access;
      Tag_Elements : AMF.CMOF.Elements.Collections.Set_Of_CMOF_Element;

   begin
      for J in 1 .. Elements.Length loop
         Element := Elements.Element (J);

         if Element.all in AMF.CMOF.Tags.CMOF_Tag'Class then
            Tag := AMF.CMOF.Tags.CMOF_Tag_Access (Element);
            Tag_Elements := Tag.Get_Element;

            if Tag.Get_Name = Name
              and then Tag_Elements.Includes (The_Element)
            then
               return Tag;
            end if;
         end if;
      end loop;

      return null;
   end Lookup_Tag;

   ----------------------
   -- Namespace_Prefix --
   ----------------------

   function Namespace_Prefix
    (The_Package : not null AMF.CMOF.Packages.CMOF_Package_Access)
       return League.Strings.Universal_String
   is
      Tag : constant AMF.CMOF.Tags.CMOF_Tag_Access
        := Lookup_Tag (NS_Prefix_Tag, The_Package);

   begin
      if Tag /= null then
         return Tag.Get_Value;

      else
         raise Program_Error;
         --  XXX Assigning of unique prefix is not implemented.
      end if;
   end Namespace_Prefix;

   -------------------
   -- Namespace_URI --
   -------------------

   function Namespace_URI
    (The_Package : not null AMF.CMOF.Packages.CMOF_Package_Access)
       return League.Strings.Universal_String
   is
      Tag : constant AMF.CMOF.Tags.CMOF_Tag_Access
        := Lookup_Tag (NS_URI_Tag, The_Package);

   begin
      if Tag /= null then
         return Tag.Get_Value;

      else
         return The_Package.Get_URI.Value;
      end if;
   end Namespace_URI;

   -----------------------------
   -- Serializable_Attributes --
   -----------------------------

   function Serializable_Attributes
    (Class : not null AMF.CMOF.Classes.CMOF_Class_Access)
       return Property_Sets.Set
   is
      Attributes : Property_Sets.Set;
      Redefined  : Property_Sets.Set;
      Composite  : Property_Sets.Set;
      Derived    : Property_Sets.Set;

      procedure Collect_Attributes
       (Class : not null AMF.CMOF.Classes.CMOF_Class_Access);

      ------------------------
      -- Collect_Attributes --
      ------------------------

      procedure Collect_Attributes
       (Class : not null AMF.CMOF.Classes.CMOF_Class_Access)
      is
         use type AMF.CMOF.Associations.CMOF_Association_Access;

         Owned_Attributes     : constant
           AMF.CMOF.Properties.Collections.Ordered_Set_Of_CMOF_Property
             := Class.Get_Owned_Attribute;
         Super_Classes        : constant
           AMF.CMOF.Classes.Collections.Set_Of_CMOF_Class
             := Class.Get_Super_Class;
         Attribute            : AMF.CMOF.Properties.CMOF_Property_Access;
         Association          : AMF.CMOF.Associations.CMOF_Association_Access;
         Opposite             : AMF.CMOF.Properties.CMOF_Property_Access;
         Redefined_Properties :
           AMF.CMOF.Properties.Collections.Set_Of_CMOF_Property;

      begin
         for J in 1 .. Owned_Attributes.Length loop
            Attribute := Owned_Attributes.Element (J);
            Association := Attribute.Get_Association;
            Redefined_Properties := Attribute.Get_Redefined_Property;
            Attributes.Include (Attribute);

            if Association /= null then
               if Association.Get_Member_End.Element (1) = Attribute then
                  Opposite := Association.Get_Member_End.Element (2);

               else
                  Opposite := Association.Get_Member_End.Element (1);
               end if;

            else
               Opposite := null;
            end if;

            if Attribute.Get_Is_Derived then
               Derived.Include (Attribute);
            end if;

            if Opposite /= null and then Opposite.Get_Is_Composite then
               Composite.Include (Attribute);
            end if;

            for K in 1 .. Redefined_Properties.Length loop
               Redefined.Include (Redefined_Properties.Element (K));
            end loop;
         end loop;

         for K in 1 .. Super_Classes.Length loop
            Collect_Attributes (Super_Classes.Element (K));
         end loop;
      end Collect_Attributes;

   begin
      Collect_Attributes (Class);

      Attributes.Difference (Derived);
      Attributes.Difference (Composite);
      Attributes.Difference (Redefined);

      return Attributes;
   end Serializable_Attributes;

   ---------------
   -- Serialize --
   ---------------

   procedure Serialize
    (Writer    : in out XML.SAX.Writers.SAX_Writer'Class;
     Ownership : AMF.CMOF.Properties.CMOF_Property_Access;
     Element   : not null AMF.Elements.Element_Access)
   is
      use type AMF.CMOF.Types.CMOF_Type_Access;
      use type AMF.Extents.Extent_Access;

      Meta_Attribute      : AMF.CMOF.Properties.CMOF_Property_Access;
      Meta_All_Attributes : Property_Sets.Set;
      Meta_Attributes     : Property_Sets.Set;
      Meta_Class          : AMF.CMOF.Classes.CMOF_Class_Access;
      Meta_Package        : AMF.CMOF.Packages.CMOF_Package_Access;
      Meta_Type           : AMF.CMOF.Types.CMOF_Type_Access;
      Position            : Property_Sets.Cursor;
      Attributes          : XML.SAX.Attributes.SAX_Attributes;
      Value               : League.Holders.Holder;
      Collection          : AMF.Reflective_Collections.Reflective_Collection;
      Value_Element       : AMF.Elements.Element_Access;
      Value_String        : League.Strings.Universal_String;
      Value_Extent        : AMF.Extents.Extent_Access;

   begin
      Value_Extent := Element.Extent;
      Meta_Class := Element.Get_Meta_Class;
      Meta_All_Attributes := Serializable_Attributes (Meta_Class);
      Meta_Package := Meta_Class.Get_Package;

      --  Add xmi:type attribute, it is required always.

      Attributes.Set_Value
       (XMI_Namespace_URI,
        Type_Attribute,
        Namespace_Prefix (Meta_Package) & ':' & Meta_Class.Get_Name.Value);

      if Value_Extent = AMF.Extents.Extent_Access (Store) then
         --  When element belongs to serialized extent add xmi:id attribute and
         --  serialize element's attributes as XML attributes.

         Attributes.Set_Value
          (XMI_Namespace_URI, Id_Attribute, Identifier (Element));

         --  Prepare for serialization of element's attributes which should be
         --  serialized as XML attributes and compute set of attributes which
         --  is serialized as XML elements.

         Position := Meta_All_Attributes.First;

         while Property_Sets.Has_Element (Position) loop
            Meta_Attribute := Property_Sets.Element (Position);
            Meta_Type := Meta_Attribute.Get_Type;

            if Meta_Type.all in AMF.CMOF.Classes.CMOF_Class'Class then
               if Meta_Attribute.Get_Is_Composite
                 and then not Subsets_Composite_Serializable
                               (Meta_Attribute, Meta_All_Attributes)
               then
                  --  All composite attributes are serialized as
                  --  2a:XMIObjectElement.
                  --
                  --  Note, when composite attribute subsets another
                  --  serializable composite attribute the first is serialized
                  --  as XML attribute. It is extension of XMI specification
                  --  required to process UML models (for example,
                  --  UML::Operation::bodyCondition is serialized as XML
                  --  attribute, and UML::Operation::ownedRule is serialized as
                  --  XML element).

                  Meta_Attributes.Insert (Meta_Attribute);

               else
                  --  For non-composite attributes prefered serialization
                  --  method is 2j:XMIReferenceAttribute; but serialization is
                  --  postponed and serialization method 2c:XMIReferenceElement
                  --  is used when element from another extent is detected.

                  Value := Element.Get (Meta_Attribute);
                  Value_String.Clear;

                  if Meta_Attribute.Is_Multivalued then
                     --  XMI 9.5.2  Object Structure
                     --
                     --  "The order of the elements for properties must follow
                     --  any prescribed XML Schema ordering as defined in
                     --  Section 5 – even if no XML Schema has actually been
                     --  generated.  Furthermore if the ordered tag is true,
                     --  the values of multi-valued properties must follow the
                     --  order in the model (if isOrdered is true for the
                     --  property) otherwise alphabetic order of the string
                     --  rendition of that property value."
                     --
                     --  XXX Alphabetial sorting is not implemented.

                     Collection :=
                       AMF.Holders.Reflective_Collections.Element (Value);

                     for J in 1 .. Collection.Length loop
                        if not Value_String.Is_Empty then
                           Value_String.Append (' ');
                        end if;

                        Value_Element :=
                          AMF.Holders.Elements.Element
                           (Collection.Element (J));
                        Value_Extent := Value_Element.Extent;

                        if Value_Extent
                             = AMF.Extents.Extent_Access (Store)
                        then
                           Value_String.Append (Identifier (Value_Element));

                        else
                           --  Stop processing when element belongs to another
                           --  extent and use serialization method
                           --  2c:XMIReferenceElement.

                           Meta_Attributes.Include (Meta_Attribute);
                           Value_String.Clear;

                           exit;
                        end if;
                     end loop;

                  else
                     Value_Element := AMF.Holders.Elements.Element (Value);

                     if Value_Element /= null then
                        Value_Extent := Value_Element.Extent;

                        if Value_Extent
                             = AMF.Extents.Extent_Access (Store)
                        then
                           Value_String.Append (Identifier (Value_Element));

                        else
                           --  Stop processing when element belongs to another
                           --  extent and use serialization method
                           --  2c:XMIReferenceElement.

                           Meta_Attributes.Include (Meta_Attribute);
                        end if;
                     end if;
                  end if;

                  if not Value_String.Is_Empty then
                     Attributes.Set_Value
                      (Meta_Attribute.Get_Name.Value, Value_String);
                  end if;
               end if;

            else
               if Meta_Attribute.Is_Multivalued
                 or (Meta_Type.all
                       not in AMF.CMOF.Primitive_Types.CMOF_Primitive_Type'Class
                       and Meta_Type.all
                         not in AMF.CMOF.Enumerations.CMOF_Enumeration'Class)
               then
                  --  For multivalued properties or properties of
                  --  CMOF::DataType serialization method 2b:XMIValueElement is
                  --  used.

                  Meta_Attributes.Insert (Meta_Attribute);

               else
                  --  Prefered serialization method for attributes of DataType
                  --  is 2i:XMIValueAttribute.

                  Value := Element.Get (Meta_Attribute);

                  if League.Holders.Is_Empty (Value) then
                     --  Attributes with null value are serialized as empty
                     --  2b:XMIValueElement.

                     if Include_Nils (Meta_Attribute) then
                        Meta_Attributes.Insert (Meta_Attribute);
                     end if;

                  else
                     Value_String :=
                       Store.Convert_To_String
                        (AMF.CMOF.Data_Types.CMOF_Data_Type_Access (Meta_Type),
                         Value);

                     if Meta_Attribute.Get_Default.Is_Empty
                       or else Meta_Attribute.Get_Default.Value /= Value_String
                     then
                        Attributes.Set_Value
                         (Meta_Attribute.Get_Name.Value, Value_String);
                     end if;
                  end if;
               end if;
            end if;

            Property_Sets.Next (Position);
         end loop;

      else
         --  When elements belongs to another extent serialize href.

         Attributes.Set_Value
          (Href_Attribute,
           AMF.URI_Extents.URI_Extent'Class (Value_Extent.all).URI (Element));
      end if;

      --  Open XML element.

      if Ownership = null then
         Writer.Start_Element
          (Namespace_URI (Meta_Package),
           Meta_Class.Get_Name.Value,
           League.Strings.Empty_Universal_String,
           Attributes);

      else
         Writer.Start_Element
          (League.Strings.Empty_Universal_String,
           League.Strings.Empty_Universal_String,
           Ownership.Get_Name.Value,
           Attributes);
      end if;

      --  Serialize element's attributes which should be serialized as XML
      --  elements.

      Position := Meta_Attributes.First;

      while Property_Sets.Has_Element (Position) loop
         Meta_Attribute := Property_Sets.Element (Position);
         Meta_Type := Meta_Attribute.Get_Type;
         Value := Element.Get (Meta_Attribute);

         if Meta_Type.all in AMF.CMOF.Classes.CMOF_Class'Class then
            if Meta_Attribute.Is_Multivalued then
               Collection :=
                 AMF.Holders.Reflective_Collections.Element (Value);

               for J in 1 .. Collection.Length loop
                  Serialize
                   (Writer,
                    Meta_Attribute,
                    AMF.Holders.Elements.Element (Collection.Element (J)));
               end loop;

            else
               Value_Element := AMF.Holders.Elements.Element (Value);

               if Value_Element /= null then
                  Serialize (Writer, Meta_Attribute, Value_Element);
               end if;
            end if;

         else
            if Meta_Attribute.Is_Multivalued then
               --  Multivalued attributes of DataType are serialized as XML
               --  elements.

               Collection :=
                 AMF.Holders.Reflective_Collections.Element (Value);

               for J in 1 .. Collection.Length loop
                  Writer.Start_Element
                   (League.Strings.Empty_Universal_String,
                    League.Strings.Empty_Universal_String,
                    Meta_Attribute.Get_Name.Value,
                    XML.SAX.Attributes.Empty_SAX_Attributes);
                  Writer.Characters
                   (Store.Convert_To_String
                     (AMF.CMOF.Data_Types.CMOF_Data_Type_Access (Meta_Type),
                      Collection.Element (J)));
                  Writer.End_Element
                   (League.Strings.Empty_Universal_String,
                    League.Strings.Empty_Universal_String,
                    Meta_Attribute.Get_Name.Value);
               end loop;

            elsif League.Holders.Is_Empty (Value) then
               --  Serialization of null values.

               Attributes.Clear;
               Attributes.Set_Value
                (XSI_Namespace_URI, Nil_Attribute, True_Literal);
               Writer.Start_Element
                (League.Strings.Empty_Universal_String,
                 League.Strings.Empty_Universal_String,
                 Meta_Attribute.Get_Name.Value,
                 Attributes);
               Writer.End_Element
                (League.Strings.Empty_Universal_String,
                 League.Strings.Empty_Universal_String,
                 Meta_Attribute.Get_Name.Value);

            else
               --  XXX Simplified method of serialization of CMOF::DataType is
               --  used here. It must be extended to support inheritance of
               --  CMOF::DataTypes.
               --
               --  XXX Inheritance is not supported for generation of xmi:type
               --  attribute.

               declare
                  Owned_Attributes : constant
                    AMF.CMOF.Properties.Collections.Ordered_Set_Of_CMOF_Property
                      := AMF.CMOF.Data_Types.CMOF_Data_Type_Access
                          (Meta_Type).Get_Owned_Attribute;
                  Aux_Package      : AMF.CMOF.Packages.CMOF_Package_Access;
                  Member_Type      : AMF.CMOF.Types.CMOF_Type_Access;

               begin
                  Attributes.Clear;

                  --  Add xmi:type attribute, it is required always.

                  Aux_Package :=Meta_Type.Get_Package;

                  Attributes.Set_Value
                   (XMI_Namespace_URI,
                    Type_Attribute,
                    Namespace_Prefix (Aux_Package)
                      & ':' & Meta_Type.Get_Name.Value);

                  for J in 1 .. Owned_Attributes.Length loop
                     Member_Type := Owned_Attributes.Element (J).Get_Type;
                     Attributes.Set_Value
                      (Owned_Attributes.Element (J).Get_Name.Value,
                       Store.Convert_To_String
                        (AMF.CMOF.Data_Types.CMOF_Data_Type_Access
                          (Member_Type),
                         AMF.Objects.Get
                          (Value, Owned_Attributes.Element (J))));
                  end loop;

                  Writer.Start_Element
                   (League.Strings.Empty_Universal_String,
                    League.Strings.Empty_Universal_String,
                    Meta_Attribute.Get_Name.Value,
                    Attributes);
                  Writer.End_Element
                   (League.Strings.Empty_Universal_String,
                    League.Strings.Empty_Universal_String,
                    Meta_Attribute.Get_Name.Value);
               end;
            end if;
         end if;

         Property_Sets.Next (Position);
      end loop;

      --  Close XML element.

      if Ownership = null then
         Writer.End_Element
          (Namespace_URI (Meta_Package),
           Meta_Class.Get_Name.Value,
           League.Strings.Empty_Universal_String);

      else
         Writer.End_Element
          (League.Strings.Empty_Universal_String,
           League.Strings.Empty_Universal_String,
           Ownership.Get_Name.Value);
      end if;
   end Serialize;

   ------------------------------------
   -- Subsets_Composite_Serializable --
   ------------------------------------

   function Subsets_Composite_Serializable
    (Attribute    : not null access AMF.CMOF.Properties.CMOF_Property'Class;
     Serializable : Property_Sets.Set)
       return Boolean
   is
      Subsetted : constant AMF.CMOF.Properties.Collections.Set_Of_CMOF_Property
        := Attribute.Get_Subsetted_Property;
      Other     : AMF.CMOF.Properties.CMOF_Property_Access;

   begin
      for J in 1 .. Subsetted.Length loop
         Other := Subsetted.Element (J);

         if Other.Get_Is_Composite then
            if Serializable.Contains (Other) then
               return True;

            elsif Subsets_Composite_Serializable (Other, Serializable) then
               return True;
            end if;
         end if;
      end loop;

      return False;
   end Subsets_Composite_Serializable;

   Elements    : constant AMF.Elements.Collections.Set_Of_Element
     := Store.Elements;
   Element     : AMF.Elements.Element_Access;
   The_Package : AMF.CMOF.Packages.CMOF_Package_Access;
   Output      : aliased
     XML.SAX.String_Output_Destinations.String_Output_Destination;
   Writer      : XML.SAX.Pretty_Writers.XML_Pretty_Writer;

begin
   Writer.Set_Output_Destination (Output'Unchecked_Access);
   Writer.Set_Offset (2);
   Writer.Start_Document;

   --  Register used namespaces.

   Writer.Start_Prefix_Mapping (XMI_Prefix, XMI_Namespace_URI);
   Writer.Start_Prefix_Mapping (XSI_Prefix, XSI_Namespace_URI);

   for J in 1 .. Elements.Length loop
      The_Package := Elements.Element (J).Get_Meta_Class.Get_Package;
      Writer.Start_Prefix_Mapping
       (Namespace_Prefix (The_Package), Namespace_URI (The_Package));
   end loop;

   --  Open root element of XMI document.

   Writer.Start_Element
    (XMI_Namespace_URI,
     XMI_Element,
     League.Strings.Empty_Universal_String,
     XML.SAX.Attributes.Empty_SAX_Attributes);

   --  Serialize root elements of the model.

   for J in 1 .. Elements.Length loop
      Element := Elements.Element (J);

      if Element.Container = null then
         Serialize (Writer, null, Element);
      end if;
   end loop;

   --  Close root element of XMI document.

   Writer.End_Element
    (XMI_Namespace_URI, XMI_Element, League.Strings.Empty_Universal_String);

   Writer.End_Document;

   return Output.Get_Text;
end XMI.Writer;
