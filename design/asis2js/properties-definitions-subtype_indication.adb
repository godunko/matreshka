with Asis.Definitions;
with Asis.Elements;

package body Properties.Definitions.Subtype_Indication is

   ------------
   -- Bounds --
   ------------

   function Bounds
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      Mark : constant Asis.Definition :=
        Asis.Definitions.Subtype_Mark (Element);
      Constr : constant Asis.Definition :=
        Asis.Definitions.Subtype_Constraint (Element);
   begin
      if Asis.Elements.Is_Nil (Constr) then
         return Engine.Text.Get_Property (Mark, Name);
      else
         return Engine.Text.Get_Property (Constr, Name);
      end if;
   end Bounds;

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      Mark : constant Asis.Definition :=
        Asis.Definitions.Subtype_Mark (Element);
   begin
      return Engine.Text.Get_Property (Mark, Name);
   end Code;

   ----------------
   -- Initialize --
   ----------------

   function Initialize
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      use type League.Strings.Universal_String;

      Mark : constant Asis.Definition :=
        Asis.Definitions.Subtype_Mark (Element);
      Result : constant League.Strings.Universal_String :=
        Engine.Text.Get_Property (Mark, Name);
   begin
      if Result.Is_Empty then
         return " new " &
           Engine.Text.Get_Property (Mark, Engines.Code) & "()";
      else
         return Result;
      end if;
   end Initialize;

   function Is_Simple_Type
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Boolean_Property) return Boolean
   is
      Mark : constant Asis.Definition :=
        Asis.Definitions.Subtype_Mark (Element);
   begin
      return Engine.Boolean.Get_Property (Mark, Name);
   end Is_Simple_Type;

end Properties.Definitions.Subtype_Indication;
