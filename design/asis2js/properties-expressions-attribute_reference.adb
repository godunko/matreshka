with Asis.Elements;
with Asis.Expressions;

package body Properties.Expressions.Attribute_Reference is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Expression;
      Name    : League.Strings.Universal_String)
      return League.Holders.Holder
   is
      Prefix : constant Asis.Expression :=
        Asis.Expressions.Prefix (Element);
      Kind   : constant Asis.Attribute_Kinds :=
        Asis.Elements.Attribute_Kind (Element);
   begin
      case Kind is
         when Asis.An_Access_Attribute |
            Asis.An_Unchecked_Access_Attribute =>
            return Engine.Get_Property (Prefix, Name);
         when others =>
            raise Program_Error with "Unimplemented attribute: " &
              Asis.Attribute_Kinds'Image (Kind);
      end case;
   end Code;

end Properties.Expressions.Attribute_Reference;
