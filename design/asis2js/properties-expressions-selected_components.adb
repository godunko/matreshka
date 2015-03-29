with Asis.Expressions;
with Asis.Elements;

package body Properties.Expressions.Selected_Components is

   ---------------------
   -- Call_Convention --
   ---------------------

   function Call_Convention
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Call_Convention_Property)
      return Engines.Call_Convention_Kind is
   begin
      return Engine.Call_Convention.Get_Property
        (Asis.Expressions.Selector (Element), Name);
   end Call_Convention;

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      Prefix   : constant Asis.Expression := Asis.Expressions.Prefix (Element);
      Selector : constant Asis.Expression :=
        Asis.Expressions.Selector (Element);
      Def_Name : constant Asis.Declaration :=
        Asis.Expressions.Corresponding_Name_Definition (Selector);
      Decl     : Asis.Declaration;
      Kind     : Asis.Declaration_Kinds;
   begin
      if not Asis.Elements.Is_Nil (Def_Name) then
         Decl := Asis.Elements.Enclosing_Element (Def_Name);
         Kind := Asis.Elements.Declaration_Kind (Decl);

         case Kind is
            when Asis.A_Component_Declaration =>
               declare
                  Left  : League.Strings.Universal_String;
                  Right : League.Strings.Universal_String;
               begin
                  Left := Engine.Text.Get_Property (Prefix, Name);

                  Right := Engine.Text.Get_Property (Def_Name, Name);
                  Left.Append (".");
                  Left.Append (Right);

                  return Left;
               end;
            when Asis.A_Function_Declaration |
                 Asis.A_Procedure_Declaration |
                 Asis.A_Private_Extension_Declaration |
                 Asis.An_Enumeration_Literal_Specification =>
               null;
            when others =>
               raise Program_Error with
                 "Unimplemented Selected_Component";
         end case;
      end if;

      return Engine.Text.Get_Property (Selector, Name);
   end Code;

   function Intrinsic_Name
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String is
   begin
      return Engine.Text.Get_Property
        (Asis.Expressions.Selector (Element), Name);
   end Intrinsic_Name;

   function Initialize
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
     renames Intrinsic_Name;

   --------------------
   -- Is_Dispatching --
   --------------------

   function Is_Dispatching
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Boolean_Property) return Boolean is
   begin
      return Engine.Boolean.Get_Property
        (Asis.Expressions.Selector (Element), Name);
   end Is_Dispatching;

end Properties.Expressions.Selected_Components;
