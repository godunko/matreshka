with Asis.Definitions;

package body Properties.Definitions.Simple_Expression_Range is

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
        (Asis.Definitions.Lower_Bound (Element), Name);
      Text.Append (";");
      Down := Engine.Text.Get_Property
        (Asis.Definitions.Upper_Bound (Element), Name);
      Text.Append (Down);

      return Text;
   end Code;

end Properties.Definitions.Simple_Expression_Range;
