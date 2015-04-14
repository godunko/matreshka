with League.Strings;

limited with Types.Variants;

package Types.Variant_Parts is

   pragma Preelaborate;

   type Variant_Part is limited interface;

   type Variant_Part_Access is access all Variant_Part'Class
     with Storage_Size => 0;

   not overriding function Discriminant_Name
    (Self : Variant_Part) return League.Strings.Universal_String
      is abstract;

   not overriding function Variants
    (Self : Variant_Part) return Types.Variants.Variant_Access
      is abstract;

end Types.Variant_Parts;
