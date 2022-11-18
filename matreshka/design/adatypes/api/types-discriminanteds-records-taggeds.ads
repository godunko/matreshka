with Types.Taggeds;
with Types.Component_Lists;

package Types.Discriminanteds.Records.Taggeds is

   pragma Preelaborate;

   type Tagged_Record_Type is limited interface
     and Record_Type
     and Types.Taggeds.Tagged_Type;

   type Tagged_Record_Type_Access is access all Tagged_Record_Type'Class
     with Storage_Size => 0;

   not overriding function Extension_Part
    (Self : Tagged_Record_Type)
      return Types.Component_Lists.Component_List_Access
        is abstract;

end Types.Discriminanteds.Records.Taggeds;
