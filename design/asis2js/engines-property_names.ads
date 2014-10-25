package Engines.Property_Names is
   Code : League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("Code");
   Call_Convention : League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("Call_Convention");
   Export : League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("Export");
   Intrinsic_Name : League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("Intrinsic_Name");
   Declaration_Prefix : League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("Declaration_Prefix");
   --  String to prefix declaration. it could be 'var ' or 'pkg_name.'
end Engines.Property_Names;
