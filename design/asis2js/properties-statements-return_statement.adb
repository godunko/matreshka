with Asis.Declarations;
with Asis.Elements;
with Asis.Statements;

with Properties.Tools;

package body Properties.Statements.Return_Statement is

   ------------
   -- Bounds --
   ------------

   function Bounds
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      Func : constant Asis.Declaration :=
        Properties.Tools.Enclosing_Declaration (Element);
      Return_Type : constant Asis.Element :=
        Asis.Declarations.Result_Profile (Func);
   begin
      return Engine.Text.Get_Property (Return_Type, Name);
   end Bounds;

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      Down   : League.Strings.Universal_String;
      Result : League.Strings.Universal_String;
      Value  : constant Asis.Expression :=
        Asis.Statements.Return_Expression (Element);
   begin
      Result.Append ("return");

      if not Asis.Elements.Is_Nil (Value) then
         Down := Engine.Text.Get_Property (Value, Name);
         Result.Append (" ");
         Result.Append (Down);
      end if;

      Result.Append (";");
      return Result;
   end Code;

end Properties.Statements.Return_Statement;
