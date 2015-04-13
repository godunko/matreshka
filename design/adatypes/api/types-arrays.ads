with Types.Discrites;

package Types.Arrays is

   pragma Preelaborate;

   type Array_Type is limited interface and Ada_Type;

   type Array_Type_Access is access all Array_Type'Class
     with Storage_Size => 0;

   not overriding function Dimensions
    (Self : Array_Type) return Positive is abstract;
   --  Returns number of dimensions.

   not overriding function Dimension_Types
    (Self : Array_Type) return Types.Discrites.Discrite_Type_Array
      is abstract;

   not overriding function Element_Type
    (Self : Array_Type) return Types.Type_Access is abstract;

   not overriding function Is_String
    (Self : Array_Type) return Boolean is abstract;

end Types.Arrays;
