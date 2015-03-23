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
      Text := Engine.Text.Get_Property
        (Asis.Expressions.Prefix (Element), Name);
      Text.Append (" [");
      Down := Engine.Text.Get_Property
        (Asis.Expressions.Index_Expressions (Element) (1),
         Name);
      Text.Append (Down);
      --  FIXME: if type is string then
      --  Text.Append (" -1]");
      Text.Append ("]");

      return Text;
   end Code;

end Properties.Expressions.Indexed_Component;
