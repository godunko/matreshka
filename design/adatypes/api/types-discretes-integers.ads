
package Types.Discretes.Integers is

   pragma Preelaborate;

   type Integer_Type is limited interface and Discrete_Type;

   type Integer_Type_Access is access all Integer_Type'Class
     with Storage_Size => 0;

end Types.Discretes.Integers;
