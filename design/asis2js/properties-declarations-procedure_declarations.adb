with League.Holders;

package body Properties.Declarations.Procedure_Declarations is

   ----------
   -- Code --
   ----------

   procedure Code
     (Engine  : in out Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String)
   is
      Text : constant League.Strings.Universal_String :=
        League.Strings.To_Universal_String ("function Aaa (){}");

      Value : constant League.Holders.Holder :=
        League.Holders.To_Holder (Text);
   begin
      Engine.Set_Property
        (Element => Element,
         Name    => Name,
         Value   => Value);
   end Code;

end Properties.Declarations.Procedure_Declarations;
