with League.Application;
with Matreshka.CLDR.Collation_Loader;
with Matreshka.Internals.Locales;

procedure MLC is
   Locale : constant Matreshka.Internals.Locales.Locale_Data_Access
     := Matreshka.Internals.Locales.Get_Locale;

begin
   Matreshka.CLDR.Collation_Loader.Load_Collation_Data
    (League.Application.Arguments.Element (1),
     Locale);
end MLC;
