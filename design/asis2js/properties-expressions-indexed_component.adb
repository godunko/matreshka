with Asis.Expressions;

package body Properties.Expressions.Indexed_Component is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String)
      return League.Holders.Holder
   is
      Text  : League.Strings.Universal_String;
      Down  : League.Strings.Universal_String;
   begin
      Text := League.Holders.Element
        (Engine.Get_Property (Asis.Expressions.Prefix (Element), Name));
      Text.Append (" (");
      Down := League.Holders.Element
        (Engine.Get_Property (Asis.Expressions.Index_Expressions (Element) (1),
         Name));
      Text.Append (Down);
      Text.Append (")");

      return League.Holders.To_Holder (Text);
   end Code;

end Properties.Expressions.Indexed_Component;
