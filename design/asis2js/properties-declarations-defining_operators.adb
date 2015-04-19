with Asis.Elements;

package body Properties.Declarations.Defining_Operators is

   Map : constant array (Asis.Operator_Kinds)
     of League.Strings.Universal_String :=
       (
--          Asis.Not_An_Operator,                   -- An unexpected element
--          Asis.An_And_Operator,                   -- and
--          Asis.An_Or_Operator,                    -- or
--          Asis.An_Xor_Operator,                   -- xor
--          Asis.An_Equal_Operator,                 -- =
--          Asis.A_Not_Equal_Operator,              -- /=
--          Asis.A_Less_Than_Operator,              -- <
--          Asis.A_Less_Than_Or_Equal_Operator,     -- <=
--          Asis.A_Greater_Than_Operator,           -- >
--          Asis.A_Greater_Than_Or_Equal_Operator,  -- >=
        Asis.A_Plus_Operator =>
          League.Strings.To_Universal_String ("_plus"),
        Asis.A_Minus_Operator =>
          League.Strings.To_Universal_String ("_minus"),
--          Asis.A_Concatenate_Operator,            -- &
--          Asis.A_Unary_Plus_Operator,             -- +
--          Asis.A_Unary_Minus_Operator,            -- -
        Asis.A_Multiply_Operator =>
          League.Strings.To_Universal_String ("_mul"),
        Asis.A_Divide_Operator =>
          League.Strings.To_Universal_String ("_div"),
--          Asis.A_Mod_Operator,                    -- mod
--          Asis.A_Rem_Operator,                    -- rem
--          Asis.An_Exponentiate_Operator,          -- **
        Asis.An_Abs_Operator =>
          League.Strings.To_Universal_String ("_abs"),
--          Asis.A_Not_Operator);                   -- not
        others => League.Strings.Empty_Universal_String);

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      pragma Unreferenced (Name, Engine);
      Kind : constant Asis.Operator_Kinds :=
        Asis.Elements.Operator_Kind (Element);
   begin
      return Map (Kind);
   end Code;

end Properties.Declarations.Defining_Operators;
