with Asis.Definitions;

package body Properties.Definitions.Subtype_Indication is

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

end Properties.Definitions.Subtype_Indication;
