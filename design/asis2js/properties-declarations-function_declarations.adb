with Ada.Wide_Text_IO;

with Asis.Compilation_Units;
with Asis.Declarations;
with Asis.Definitions;
with Asis.Elements;
with Asis.Expressions;

with Engines.Property_Types;

package body Properties.Declarations.Function_Declarations is

   ---------------------
   -- Call_Convention --
   ---------------------

   function Call_Convention
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String)
      return League.Holders.Holder
   is
      Mark : Asis.Expression;
      List : constant Asis.Declaration_List :=
        Asis.Declarations.Aspect_Specifications (Element);
   begin
      if Asis.Elements.Is_Part_Of_Inherited (Element) then
         return Call_Convention
           (Engine,
            Asis.Declarations.Corresponding_Subprogram_Derivation (Element),
            Name);
      end if;

      if Asis.Elements.Is_Part_Of_Implicit (Element) then
         return Engines.Property_Types.Call_Convention_Holders
           .To_Holder (Engines.Property_Types.Intrinsic);
      end if;

      if Asis.Compilation_Units.Unit_Full_Name
        (Asis.Elements.Enclosing_Compilation_Unit (Element))
          = "League.Strings"
      then
         return Engines.Property_Types.Call_Convention_Holders
           .To_Holder (Engines.Property_Types.Intrinsic);
      end if;

      for J in List'Range loop
         Mark := Asis.Definitions.Aspect_Mark (List (J));
         if Asis.Expressions.Name_Image (Mark) = "Convention" then
            declare
               Result : constant Wide_String := Asis.Expressions.Name_Image
                 (Asis.Definitions.Aspect_Definition (List (J)));
            begin
               if Result = "JavaScript_Property_Getter" then
                  return Engines.Property_Types.Call_Convention_Holders
                    .To_Holder
                      (Engines.Property_Types.JavaScript_Property_Getter);
               elsif Result = "JavaScript_Getter" then
                  return Engines.Property_Types.Call_Convention_Holders
                    .To_Holder (Engines.Property_Types.JavaScript_Getter);
               elsif Result = "JavaScript_Function" then
                  return Engines.Property_Types.Call_Convention_Holders
                    .To_Holder (Engines.Property_Types.JavaScript_Function);
               else
                  Ada.Wide_Text_IO.Put ("Unknown call conv: ");
                  Ada.Wide_Text_IO.Put_Line (Result);
                  raise Program_Error;
               end if;
            end;
         end if;
      end loop;

      return Engines.Property_Types.Call_Convention_Holders
        .To_Holder (Engines.Property_Types.Unspecified);
   end Call_Convention;

   --------------------
   -- Intrinsic_Name --
   --------------------

   function Intrinsic_Name
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String) return League.Holders.Holder
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

      return League.Holders.To_Holder (Result);
   end Intrinsic_Name;

end Properties.Declarations.Function_Declarations;
