with Types.Taggeds;
with Types.Components;

package Types.Discriminanteds.Protecteds is

   pragma Preelaborate;

   type Protected_Type is limited interface
     and Discriminanted_Type
     and Types.Taggeds.Tagged_Type;

   type Protected_Type_Access is access all Protected_Type'Class
     with Storage_Size => 0;

   not overriding function Components
    (Self : Protected_Type) return Types.Components.Component_Access_Array
      is abstract;

end Types.Discriminanteds.Protecteds;
