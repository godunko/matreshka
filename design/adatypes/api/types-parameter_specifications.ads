with League.Strings;

package Types.Parameter_Specifications is

   pragma Preelaborate;

   type Parameter_Specification is limited interface;

   type Parameter_Specification_Access is
     access all Parameter_Specification'Class
       with Storage_Size => 0;

   type Parameter_Specification_Access_Array is
     array (Positive range <>) of Parameter_Specification_Access;

   not overriding function Name
    (Self : Parameter_Specification) return League.Strings.Universal_String
      is abstract;

   not overriding function Is_Aliased
    (Self : Parameter_Specification) return Boolean
      is abstract;

   type Parameter_Mode is (In_Mode, In_Out_Mode, Out_Mode);

   not overriding function Mode
    (Self : Parameter_Specification) return Parameter_Mode
      is abstract;

   not overriding function Parameter_Type
    (Self : Parameter_Specification) return Types.Type_Access
      is abstract;

   not overriding function Has_Default
    (Self : Parameter_Specification) return Boolean
      is abstract;

end Types.Parameter_Specifications;
