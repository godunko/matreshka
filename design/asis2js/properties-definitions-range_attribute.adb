with Asis.Definitions;
with Asis.Expressions;

package body Properties.Definitions.Range_Attribute is

   -----------
   -- Lower --
   -----------

   function Lower
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      pragma Unreferenced (Name);
      Attr : constant Asis.Expression :=
        Asis.Definitions.Range_Attribute (Element);
      Text : League.Strings.Universal_String;
   begin
      Text := Engine.Text.Get_Property
        (Asis.Expressions.Prefix (Attr), Engines.Code);
      Text.Append ("._first");
      return Text;
   end Lower;

   -----------
   -- Upper --
   -----------

   function Upper
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      pragma Unreferenced (Name);
      Attr : constant Asis.Expression :=
        Asis.Definitions.Range_Attribute (Element);
      Text : League.Strings.Universal_String;
   begin
      Text := Engine.Text.Get_Property
        (Asis.Expressions.Prefix (Attr), Engines.Code);
      Text.Append ("._last");
      return Text;
   end Upper;

end Properties.Definitions.Range_Attribute;
