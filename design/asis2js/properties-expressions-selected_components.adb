with Asis.Expressions;
with Asis.Elements;

package body Properties.Expressions.Selected_Components is

   ---------------------
   -- Call_Convention --
   ---------------------

   function Call_Convention
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String)
      return League.Holders.Holder
   is
   begin
      return Engine.Get_Property (Asis.Expressions.Selector (Element), Name);
   end Call_Convention;

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Expression;
      Name    : League.Strings.Universal_String)
      return League.Holders.Holder
   is
      Prefix   : constant Asis.Expression := Asis.Expressions.Prefix (Element);
      Selector : constant Asis.Expression :=
        Asis.Expressions.Selector (Element);
      Def_Name : constant Asis.Declaration :=
        Asis.Expressions.Corresponding_Name_Definition (Selector);
      Decl     : Asis.Declaration;
   begin
      if not Asis.Elements.Is_Nil (Def_Name) then
         Decl := Asis.Elements.Enclosing_Element (Def_Name);

         case Asis.Elements.Declaration_Kind (Decl) is
            when Asis.A_Component_Declaration =>
               declare
                  Left  : League.Strings.Universal_String;
                  Right : League.Strings.Universal_String;
               begin
                  Left := League.Holders.Element
                    (Engine.Get_Property (Prefix, Name));

                  Right := League.Holders.Element
                    (Engine.Get_Property (Def_Name, Name));
                  Left.Append (".");
                  Left.Append (Right);

                  return League.Holders.To_Holder (Left);
               end;
            when others =>
               raise Constraint_Error with
                 "Unimplemented Selected_Component";
         end case;
      end if;

      return Engine.Get_Property (Selector, Name);
   end Code;

   function Intrinsic_Name
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String) return League.Holders.Holder
     renames Call_Convention;

end Properties.Expressions.Selected_Components;
