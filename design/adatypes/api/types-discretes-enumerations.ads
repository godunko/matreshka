
package Types.Discretes.Enumerations is

   pragma Preelaborate;

   type Enumeration_Type is limited interface and Discrete_Type;

   type Enumeration_Type_Access is access all Enumeration_Type'Class
     with Storage_Size => 0;

   not overriding function Is_Predefined_Character
    (Self : Enumeration_Type) return Boolean is abstract;
   --  One of predefined Character, Wide_Character, Wide_Wide_Character types.

end Types.Discretes.Enumerations;
