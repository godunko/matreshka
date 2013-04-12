with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with League.JSON.Arrays;    use League.JSON.Arrays;
with League.JSON.Documents; use League.JSON.Documents;
with League.JSON.Objects;   use League.JSON.Objects;
with League.JSON.Values;    use League.JSON.Values;
with League.Strings;        use League.Strings;

procedure Main is
   S      : Universal_String;
   Object : JSON_Object;
   Value  : JSON_Value;
   Arr    : JSON_Array;
   Doc    : JSON_Document;
   Str    : Universal_String;

begin
   S := To_Universal_String ("xyz");
   Arr.Append (To_JSON_Value (S));
   Arr.Append (To_JSON_Value (True));
   Object.Insert (To_Universal_String ("id"), To_JSON_Value (10));
   Object.Insert (To_Universal_String ("data"), To_JSON_Value (Arr));

   Put_Line (To_JSON_Document (Object).To_JSON.To_Wide_Wide_String);
end Main;
