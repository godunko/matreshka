with Ada.Wide_Wide_Text_IO;

with Asis.Expressions;
with Asis.Statements;

package body Properties.Statements.Procedure_Call_Statement is

   function Intrinsic
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      use type Engines.Call_Convention_Kind;

      Text  : League.Strings.Universal_String;
      Conv  : constant Engines.Call_Convention_Kind :=
        Engine.Call_Convention.Get_Property
          (Asis.Statements.Called_Name (Element),
           Engines.Call_Convention);
   begin
      case Conv is
         when Engines.Intrinsic =>
            return Intrinsic (Engine, Element, Name);

         when Engines.Unspecified =>
            declare
               Arg    : League.Strings.Universal_String;
               List   : constant Asis.Association_List :=
                 Asis.Statements.Call_Statement_Parameters
                   (Element, Normalized => False);
            begin
               Text := Engine.Text.Get_Property
                 (Asis.Statements.Called_Name (Element), Name);

               Text.Append ("(");

               for J in List'Range loop
                  Arg := Engine.Text.Get_Property
                    (Asis.Expressions.Actual_Parameter (List (J)), Name);

                  Text.Append (Arg);

                  if J /= List'Last then
                     Text.Append (", ");
                  end if;
               end loop;

               Text.Append (")");
            end;

         when Engines.JavaScript_Function =>
            declare
               Arg    : League.Strings.Universal_String;
               Prefix : League.Strings.Universal_String;
               List   : constant Asis.Association_List :=
                 Asis.Statements.Call_Statement_Parameters
                   (Element, Normalized => False);
            begin
               Prefix := Engine.Text.Get_Property
                 (Asis.Statements.Called_Name (Element), Name);

               Text := Engine.Text.Get_Property
                 (Asis.Expressions.Actual_Parameter (List (1)), Name);
               Text.Append (".");
               Text.Append (Prefix);

               Text.Append ("(");

               for J in 2 .. List'Last loop
                  Arg := Engine.Text.Get_Property
                    (Asis.Expressions.Actual_Parameter (List (J)), Name);

                  Text.Append (Arg);

                  if J /= List'Last then
                     Text.Append (", ");
                  end if;
               end loop;

               Text.Append (")");
            end;

         when Engines.JavaScript_Property_Getter |
              Engines.JavaScript_Property_Setter |
              Engines.JavaScript_Getter =>

            raise Program_Error with "not implemented";

      end case;

      Text.Append (";");
      return Text;
   end Code;

   ---------------
   -- Intrinsic --
   ---------------

   function Intrinsic
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      pragma Unreferenced (Name);
      Func : constant League.Strings.Universal_String :=
        Engine.Text.Get_Property
          (Asis.Statements.Called_Name (Element),
           Engines.Intrinsic_Name);

      List   : constant Asis.Association_List :=
        Asis.Statements.Call_Statement_Parameters
          (Element, Normalized => False);
      pragma Unreferenced (List);
   begin
      Ada.Wide_Wide_Text_IO.Put ("Unimplemented Intrinsic: ");
      Ada.Wide_Wide_Text_IO.Put (Func.To_Wide_Wide_String);
      raise Program_Error;
      return League.Strings.Empty_Universal_String;
   end Intrinsic;

end Properties.Statements.Procedure_Call_Statement;
