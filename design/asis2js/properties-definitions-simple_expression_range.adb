with Asis.Definitions;

package body Properties.Definitions.Simple_Expression_Range is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Expression;
      Name    : League.Strings.Universal_String)
      return League.Holders.Holder
   is
      Text  : League.Strings.Universal_String;
      Down  : League.Strings.Universal_String;
   begin
      Text := League.Holders.Element
        (Engine.Get_Property (Asis.Definitions.Lower_Bound (Element), Name));
      Text.Append (";");
      Down := League.Holders.Element
        (Engine.Get_Property (Asis.Definitions.Upper_Bound (Element), Name));
      Text.Append (Down);

      return League.Holders.To_Holder (Text);
   end Code;

end Properties.Definitions.Simple_Expression_Range;
