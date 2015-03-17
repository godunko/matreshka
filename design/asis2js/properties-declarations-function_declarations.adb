with Ada.Wide_Text_IO;

with Asis.Compilation_Units;
with Asis.Declarations;
with Asis.Elements;

with Properties.Tools;

package body Properties.Declarations.Function_Declarations is

   ---------------------
   -- Call_Convention --
   ---------------------

   function Call_Convention
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Call_Convention_Property)
      return Engines.Call_Convention_Kind is
   begin
      if Asis.Elements.Is_Part_Of_Inherited (Element) then
         return Call_Convention
           (Engine,
            Asis.Declarations.Corresponding_Subprogram_Derivation (Element),
            Name);
      end if;

      if Asis.Elements.Is_Part_Of_Implicit (Element) then
         return Engines.Intrinsic;
      end if;

      if Asis.Compilation_Units.Unit_Full_Name
        (Asis.Elements.Enclosing_Compilation_Unit (Element))
          = "League.Strings"
      then
         return Engines.Intrinsic;
      end if;

      declare
         Result : constant Wide_String :=
           Properties.Tools.Get_Aspect (Element, "Convention");
      begin
         if Result = "" then
            null;
         elsif Result = "JavaScript_Property_Getter" then
            return Engines.JavaScript_Property_Getter;
         elsif Result = "JavaScript_Getter" then
            return Engines.JavaScript_Getter;
         elsif Result = "JavaScript_Function" then
            return Engines.JavaScript_Function;
         else
            Ada.Wide_Text_IO.Put ("Unknown call conv: ");
            Ada.Wide_Text_IO.Put_Line (Result);
            raise Program_Error;
         end if;
      end;

      return Engines.Unspecified;
   end Call_Convention;

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      pragma Unreferenced (Engine, Element, Name);
   begin
      return League.Strings.Empty_Universal_String;
   end Code;

   ------------
   -- Export --
   ------------

   function Export
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Boolean_Property) return Boolean
   is
      pragma Unreferenced (Engine, Name);
      Result : constant Wide_String :=
        Properties.Tools.Get_Aspect (Element, "Export");
   begin
      return Result = "True";
   end Export;

   --------------------
   -- Intrinsic_Name --
   --------------------

   function Intrinsic_Name
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      pragma Unreferenced (Engine, Name);
      Result : League.Strings.Universal_String;
      Unit : constant Wide_String := Asis.Compilation_Units.Unit_Full_Name
        (Asis.Elements.Enclosing_Compilation_Unit (Element));
      Func : constant Wide_String := Asis.Declarations.Defining_Name_Image
        (Asis.Declarations.Names (Element) (1));
   begin
      if Unit = "League.Strings" then
         Result := League.Strings.From_UTF_16_Wide_String (Unit);
      end if;

      Result.Append (".");
      Result.Append (League.Strings.From_UTF_16_Wide_String (Func));

      return Result;
   end Intrinsic_Name;

end Properties.Declarations.Function_Declarations;
