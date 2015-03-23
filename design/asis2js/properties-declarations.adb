with Asis.Elements;

package body Properties.Declarations is

   --------------------
   -- Inside_Package --
   --------------------

   function Inside_Package
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Boolean_Property)
      return Boolean
   is
      pragma Unreferenced (Engine, Name);
      Up : constant Asis.Element := Asis.Elements.Enclosing_Element (Element);
      Kind : constant Asis.Declaration_Kinds :=
        Asis.Elements.Declaration_Kind (Up);
   begin
      if Asis.Elements.Is_Nil (Up) then
         return True;
      end if;

      case Kind is
         when Asis.A_Package_Declaration |
              Asis.A_Package_Body_Declaration =>
            return True;
         when others =>
            return False;
      end case;
   end Inside_Package;

end Properties.Declarations;
