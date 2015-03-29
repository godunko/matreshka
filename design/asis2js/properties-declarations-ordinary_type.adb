with Asis.Declarations;

package body Properties.Declarations.Ordinary_Type is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
   begin
      return Engine.Text.Get_Property
        (Asis.Declarations.Type_Declaration_View (Element), Name);
   end Code;

   --------------------
   -- Is_Simple_Type --
   --------------------

   function Is_Simple_Type
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Boolean_Property) return Boolean is
   begin
      return Engine.Boolean.Get_Property
        (Asis.Declarations.Type_Declaration_View (Element), Name);
   end Is_Simple_Type;

end Properties.Declarations.Ordinary_Type;
