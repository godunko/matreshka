with Types.Components;
with Types.Variant_Parts;

package Types.Component_Lists is

   pragma Preelaborate;

   type Component_List is limited interface;

   type Component_List_Access is access all Component_List'Class
     with Storage_Size => 0;

   not overriding function Components
    (Self : Component_List) return Types.Components.Component_Access_Array
      is abstract;

   not overriding function Variant_Part
    (Self : Component_List) return Types.Variant_Parts.Variant_Part_Access
      is abstract;

end Types.Component_Lists;
