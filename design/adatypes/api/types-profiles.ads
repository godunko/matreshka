with Types.Conventions;
with Types.Parameter_Specifications;

package Types.Profiles is

   pragma Preelaborate;

   type Profile is limited interface;

   type Profile_Access is access all Profile'Class
     with Storage_Size => 0;

   not overriding function Parameters
    (Self : Profile)
     return Parameter_Specifications.Parameter_Specification_Access_Array
      is abstract;

   not overriding function Return_Type
    (Self : Profile) return Types.Type_Access is abstract;

   not overriding function Calling_Convention
    (Self : Profile) return Types.Conventions.Convention_Access is abstract;

   not overriding function Are_Type_Conformant
    (Self  : Profile;
     Value : access Profile'Class) return Boolean is abstract;

   not overriding function Are_Mode_Conformant
    (Self  : Profile;
     Value : access Profile'Class) return Boolean is abstract;

--     not overriding function Are_Subtype_Conformant
--       (Self  : Profile;
--        Value : Profile'Class) return Boolean is abstract;
--  XXX We will use this when subtype information is implemented

--     not overriding function Are_Fully_Conformant
--       (Self  : Profile;
--        Value : Profile'Class) return Boolean is abstract;
--  XXX We will use this when subtype information is implemented

end Types.Profiles;
