
package Types.Accesses is

   pragma Preelaborate;

   type Access_Type is limited interface and Ada_Type;

   type Access_Type_Access is access all Access_Type'Class
     with Storage_Size => 0;

end Types.Accesses;
