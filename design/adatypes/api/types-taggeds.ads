limited with Types.Taggeds.Interfaces;

package Types.Taggeds is

   pragma Preelaborate;

   type Tagged_Type is limited interface;

   type Tagged_Type_Access is access all Tagged_Type'Class
     with Storage_Size => 0;

   not overriding function Progenitors
    (Self : Tagged_Type) return Types.Taggeds.Interfaces.Interface_Access_Array
      is abstract;
   --  Return list of interfaces provided by this type/interface. ARM 3.4(3/2)

end Types.Taggeds;
