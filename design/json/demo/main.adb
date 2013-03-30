with League.JSON.Objects; use League.JSON.Objects;
with League.JSON.Values;  use League.JSON.Values;
with League.Strings;      use League.Strings;

procedure Main is
   Object : JSON_Object;
   Value  : JSON_Value;

begin
   Value := To_JSON_Value (10);
   Object.Insert (To_Universal_String ("id"), Value);
end Main;
