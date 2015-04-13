
package Types is

   pragma Preelaborate;

   type Ada_Type is limited interface;

   type Type_Access is access all Ada_Type'Class with Storage_Size => 0;

   not overriding function Is_Anonymous
    (Self : Ada_Type) return Boolean is abstract;
   --  Returns whether type is anonymous. Anonymous types can be:
   --   - access types
   --   - array type declared as part of object declaration
   --   - XXX may be task/protected objects

   --     not overriding function Is_The_Same
   --      (Self : Ada_Type; Left : Ada_Type) return Boolean is abstract;
   --  We need a way to compare two type to be the same

   not overriding function Is_Derived
    (Self : Ada_Type) return Boolean is abstract;
   --  Check if given type is derived from another. See ARM 3.4 (2/2)

   not overriding function Parent_Type
    (Self : Ada_Type) return Type_Access is abstract;
   --  Return parent type if given type Is_Derived or null otherwise

end Types;
