with Ada.Wide_Text_IO;

with Asis.Declarations;
with Asis.Definitions;
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
      pragma Unreferenced (Engine, Name);
      Mark : Asis.Expression;
      List : constant Asis.Declaration_List :=
        Asis.Declarations.Aspect_Specifications (Element);
   begin
      for J in List'Range loop
         Mark := Asis.Definitions.Aspect_Mark (List (J));
         if Asis.Expressions.Name_Image (Mark) = "Convention" then
            declare
               Result : constant Wide_String := Asis.Expressions.Name_Image
                 (Asis.Definitions.Aspect_Definition (List (J)));
            begin
               if Result = "JavaScript_Getter" then
                  return Engines.Property_Types.Call_Convention_Holders
                    .To_Holder (Engines.Property_Types.JavaScript_Getter);
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

end Properties.Declarations.Function_Declarations;
