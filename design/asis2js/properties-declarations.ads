with Asis;
with Engines.Contexts;

package Properties.Declarations is

   function Inside_Package
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Boolean_Property) return Boolean;

end Properties.Declarations;
