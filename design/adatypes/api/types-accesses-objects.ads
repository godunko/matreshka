package Types.Accesses.Objects is

   pragma Preelaborate;

   type Object_Access_Type is limited interface and Access_Type;

   type Object_Access_Type_Access is access all
     Object_Access_Type'Class
       with Storage_Size => 0;

   not overriding function Designated_Type
    (Self : Object_Access_Type) return Types.Type_Access
      is abstract;

end Types.Accesses.Objects;
