with Asis.Expressions;

package body Properties.Expressions.Indexed_Component is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      Text  : League.Strings.Universal_String;
      Down  : League.Strings.Universal_String;
   begin
      Down := Engine.Text.Get_Property
        (Asis.Expressions.Prefix (Element), Name);
      Text.Append (Down);
      Text.Append (" [_ec._pos(");
      Text.Append (Engine.Text.Get_Property
        (Asis.Expressions.Index_Expressions (Element) (1),
         Name));
      Text.Append (")-_ec._pos(");
      Text.Append (Down);
      Text.Append ("._first)]");

      return Text;
   end Code;

end Properties.Expressions.Indexed_Component;
