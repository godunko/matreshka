
package Types.Discretes.Integers is

   pragma Preelaborate;

   type Integer_Type is limited interface and Discrete_Type;

   type Integer_Type_Access is access all Integer_Type'Class
     with Storage_Size => 0;

   not overriding function Is_Signed_Integer
    (Self : Integer_Type) return Boolean is abstract;

   not overriding function Is_Modular_Integer
    (Self : Integer_Type) return Boolean is abstract;

end Types.Discretes.Integers;
