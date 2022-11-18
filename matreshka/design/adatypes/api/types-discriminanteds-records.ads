with Types.Component_Lists;

package Types.Discriminanteds.Records is

   pragma Preelaborate;

   type Record_Type is limited interface and Discriminanted_Type;

   type Record_Type_Access is access all Record_Type'Class
     with Storage_Size => 0;

   not overriding function Component_List
    (Self : Record_Type) return Types.Component_Lists.Component_List_Access
      is abstract;
   --  For tagged type result includes both extension and inherited components

   not overriding function Is_Abstract (Self : Record_Type) return Boolean
     is abstract;

end Types.Discriminanteds.Records;
