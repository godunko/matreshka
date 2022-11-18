with Types.Taggeds;

package Types.Discriminanteds.Tasks is

   pragma Preelaborate;

   type Task_Type is limited interface
     and Discriminanted_Type
     and Types.Taggeds.Tagged_Type;

   type Task_Type_Access is access all Task_Type'Class
     with Storage_Size => 0;

end Types.Discriminanteds.Tasks;
