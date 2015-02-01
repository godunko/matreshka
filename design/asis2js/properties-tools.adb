with Asis.Compilation_Units;
with Asis.Declarations;
with Asis.Definitions;
with Asis.Elements;
with Asis.Expressions;

package body Properties.Tools is

   ----------------
   -- Get_Aspect --
   ----------------

   function Get_Aspect
     (Element : Asis.Declaration;
      Name    : Wide_String)
      return Wide_String
   is
      Mark : Asis.Expression;
      List : constant Asis.Declaration_List :=
        Asis.Declarations.Aspect_Specifications (Element);
   begin
      for J in List'Range loop
         Mark := Asis.Definitions.Aspect_Mark (List (J));
         if Asis.Expressions.Name_Image (Mark) = Name then
            declare
               Exp : constant Asis.Expression :=
                 Asis.Definitions.Aspect_Definition (List (J));
            begin
               case Asis.Elements.Expression_Kind (Exp) is
                  when Asis.An_Integer_Literal |
                       Asis.A_Real_Literal =>
                     return Asis.Expressions.Value_Image (Exp);
                  when Asis.A_String_Literal =>
                     declare
                        Result : constant Wide_String :=
                          Asis.Expressions.Value_Image (Exp);
                     begin
                        return Result (2 .. Result'Last - 1);
                     end;
                  when others =>
                     return Asis.Expressions.Name_Image (Exp);
               end case;
            end;
         end if;
      end loop;

      return "";
   end Get_Aspect;

   --------------------------
   -- Library_Level_Header --
   --------------------------

   function Library_Level_Header
     (Unit : Asis.Compilation_Unit) return League.Strings.Universal_String
   is
      Text : League.Strings.Universal_String;

      Parent : constant Asis.Compilation_Unit :=
        Asis.Compilation_Units.Corresponding_Parent_Declaration (Unit);

      Full_Name : constant League.Strings.Universal_String :=
        League.Strings.From_UTF_16_Wide_String
          (Asis.Compilation_Units.Unit_Full_Name (Unit)).To_Lowercase;

      Parent_Name : constant League.Strings.Universal_String :=
        League.Strings.From_UTF_16_Wide_String
          (Asis.Compilation_Units.Unit_Full_Name (Parent)).To_Lowercase;
   begin
      Text.Append ("define('standard.");
      Text.Append (Full_Name);
      Text.Append ("', ['");
      Text.Append (Parent_Name);
      Text.Append ("'], ");

      return Text;
   end Library_Level_Header;

end Properties.Tools;
