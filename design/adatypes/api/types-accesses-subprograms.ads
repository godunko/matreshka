with Types.Profiles;

package Types.Accesses.Subprograms is

   pragma Preelaborate;

   type Subprogram_Access_Type is limited interface and Access_Type;

   type Subprogram_Access_Type_Access is access all
     Subprogram_Access_Type'Class
       with Storage_Size => 0;

   not overriding function Designated_Profile
    (Self : Subprogram_Access_Type) return Types.Profiles.Profile_Access
      is abstract;

end Types.Accesses.Subprograms;
