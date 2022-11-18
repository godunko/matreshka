
package Types.Taggeds.Interfaces is

   pragma Preelaborate;

   type Interface_Type is limited interface and Tagged_Type;

   type Interface_Type_Access is access all Interface_Type'Class
     with Storage_Size => 0;

   type Interface_Access_Array is
     array (Positive range <>) of Interface_Type_Access;

   not overriding function Is_Synchronized
    (Self : Interface_Type) return Boolean is abstract;

end Types.Taggeds.Interfaces;
