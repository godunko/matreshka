with Asis.Declarations;

with League.Holders;

package body Properties.Declarations.Procedure_Body_Declarations is

   ----------
   -- Code --
   ----------

   procedure Code
     (Engine  : in out Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String)
   is
      Subprogram_Name : constant League.Strings.Universal_String :=
        League.Holders.Element
          (Engine.Get_Property
             (Element => Asis.Declarations.Names (Element) (1),
              Name    => Name));

      Text : League.Strings.Universal_String;
      Value : League.Holders.Holder;
   begin
      Text.Append ("function ");
      Text.Append (Subprogram_Name);
      Text.Append (" (){}");

      Value := League.Holders.To_Holder (Text);

      Engine.Set_Property
        (Element => Element,
         Name    => Name,
         Value   => Value);
   end Code;

end Properties.Declarations.Procedure_Body_Declarations;
