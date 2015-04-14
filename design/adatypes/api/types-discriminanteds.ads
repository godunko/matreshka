with Types.Components;

package Types.Discriminanteds is

   pragma Preelaborate;

   type Discriminanted_Type is limited interface;

   type Discriminanted_Type_Access is access all Discriminanted_Type'Class
     with Storage_Size => 0;

   not overriding function Is_Limited
    (Self : Discriminanted_Type) return Boolean is abstract;

   not overriding function Has_Unknown_Discriminants
    (Self : Discriminanted_Type) return Boolean is abstract;

   not overriding function Discriminants
    (Self : Discriminanted_Type)
      return Types.Components.Component_Access_Array
        is abstract;
   --  Return list of known discriminants if Has_Unknown_Discriminants = False
   --  and empty list otherwise

end Types.Discriminanteds;
