with League.Strings;

package Forge.Admin.Repository is

   pragma Preelaborate;

   type Status is tagged limited record
      Success      : Boolean := True;
      Error_String : League.Strings.Universal_String;
   end record;

   procedure Create_Repository
    (Path   : League.Strings.Universal_String;
     Status : in out Forge.Admin.Repository.Status);

end Forge.Admin.Repository;
