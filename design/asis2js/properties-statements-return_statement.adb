with Asis.Elements;
with Asis.Statements;

package body Properties.Statements.Return_Statement is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Expression;
      Name    : League.Strings.Universal_String)
      return League.Holders.Holder
   is
      Down   : League.Strings.Universal_String;
      Result : League.Strings.Universal_String;
      Value  : constant Asis.Expression :=
        Asis.Statements.Return_Expression (Element);
   begin
      Result.Append ("return");

      if not Asis.Elements.Is_Nil (Value) then
         Down := League.Holders.Element (Engine.Get_Property (Value, Name));
         Result.Append (" ");
         Result.Append (Down);
      end if;

      Result.Append (";");
      return League.Holders.To_Holder (Result);
   end Code;

end Properties.Statements.Return_Statement;
