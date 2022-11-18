
package Types.Discretes is

   pragma Preelaborate;

   type Discrete_Type is limited interface;

   type Discrete_Type_Access is access all Discrete_Type'Class
     with Storage_Size => 0;

   type Discrete_Type_Array is
     array (Positive range <>) of Discrete_Type_Access;

end Types.Discretes;
