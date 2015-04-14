with League.Strings;

package Types.Components is

   pragma Preelaborate;

   type Component is limited interface;

   type Component_Access is access all Component'Class
     with Storage_Size => 0;

   type Component_Access_Array is
     array (Positive range <>) of Component_Access;

   not overriding function Name
     (Self : Component) return League.Strings.Universal_String
      is abstract;

   not overriding function Component_Type
    (Self : Component) return Types.Type_Access
      is abstract;

   not overriding function Is_Aliased (Self : Component) return Boolean
      is abstract;

   not overriding function Has_Default (Self : Component) return Boolean
      is abstract;

end Types.Components;
