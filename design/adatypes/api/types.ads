limited with Types.Visiters;

package Types is

   pragma Preelaborate;

   type Ada_Type is limited interface;

   type Type_Access is access all Ada_Type'Class with Storage_Size => 0;
   --  Equal types always have the same access value

   not overriding function Is_Anonymous
    (Self : Ada_Type) return Boolean is abstract;
   --  Returns whether type is anonymous. Anonymous types can be:
   --   - access types
   --   - array type declared as part of object declaration
   --   - XXX may be task/protected objects

   not overriding function Is_Derived
    (Self : Ada_Type) return Boolean is abstract;
   --  Check if given type is derived from another. See ARM 3.4 (2/2)

   not overriding function Parent_Type
    (Self : Ada_Type) return Type_Access is abstract;
   --  Return parent type if given type Is_Derived or null otherwise

   not overriding function Is_Enumeration
    (Self : Ada_Type) return Boolean is abstract;

   not overriding function Is_Boolean
    (Self : Ada_Type) return Boolean is abstract;
   --  This implies Is_Enumeration

   not overriding function Is_Character
    (Self : Ada_Type) return Boolean is abstract;
   --  This implies Is_Enumeration

   --  Category tests functions:
   not overriding function Is_Signed_Integer
    (Self : Ada_Type) return Boolean is abstract;

   not overriding function Is_Modular_Integer
    (Self : Ada_Type) return Boolean is abstract;

   not overriding function Is_Floating_Point
    (Self : Ada_Type) return Boolean is abstract;

   not overriding function Is_Fixed_Point
    (Self : Ada_Type) return Boolean is abstract;

   not overriding function Is_Decimal_Fixed_Point
    (Self : Ada_Type) return Boolean is abstract;
   --  This implies Is_Fixed_Point

   not overriding function Is_Object_Access
    (Self : Ada_Type) return Boolean is abstract;

   not overriding function Is_Subprogram_Access
    (Self : Ada_Type) return Boolean is abstract;

   not overriding function Is_Array
    (Self : Ada_Type) return Boolean is abstract;

   not overriding function Is_String
    (Self : Ada_Type) return Boolean is abstract;
   --  This implies Is_String

   not overriding function Is_Record
    (Self : Ada_Type) return Boolean is abstract;

   not overriding function Is_Tagged_Record
    (Self : Ada_Type) return Boolean is abstract;
   --  This implies Is_Record

   not overriding function Is_Task
    (Self : Ada_Type) return Boolean is abstract;

   not overriding function Is_Protected
    (Self : Ada_Type) return Boolean is abstract;

   not overriding function Is_Interface
    (Self : Ada_Type) return Boolean is abstract;

   --  Visiter support:
   not overriding procedure Enumeration_Type
    (Self    : not null access Ada_Type;
     Visiter : not null access Types.Visiters.Type_Visiter)
      is abstract;

end Types;
