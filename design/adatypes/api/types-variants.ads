with Types.Component_Lists;

package Types.Variants is

   pragma Preelaborate;

   type Variant is limited interface;

   type Variant_Access is access all Variant'Class
     with Storage_Size => 0;

   type Variant_Access_Array is array (Positive range <>) of Variant_Access;

   not overriding function Component_List
    (Self : Variant) return Types.Component_Lists.Component_List_Access
      is abstract;

end Types.Variants;
