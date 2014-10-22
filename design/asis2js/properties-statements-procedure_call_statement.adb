with Ada.Wide_Wide_Text_IO;

with Asis.Expressions;
with Asis.Statements;

with Engines.Property_Names;
with Engines.Property_Types;

package body Properties.Statements.Procedure_Call_Statement is

   function Intrinsic
     (Engine  : access Engines.Engine;
      Element : Asis.Expression;
      Name    : League.Strings.Universal_String) return League.Holders.Holder;

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Expression;
      Name    : League.Strings.Universal_String) return League.Holders.Holder
   is
      use type Engines.Property_Types.Call_Convention;

      Text  : League.Strings.Universal_String;
      Value : League.Holders.Holder;
      Conv  : constant Engines.Property_Types.Call_Convention :=
        Engines.Property_Types.Call_Convention_Holders.Element
          (Engine.Get_Property
             (Asis.Statements.Called_Name (Element),
              Engines.Property_Names.Call_Convention));
   begin
      case Conv is
         when Engines.Property_Types.Intrinsic =>
            return Intrinsic (Engine, Element, Name);

         when Engines.Property_Types.Unspecified =>
            declare
               Arg    : League.Strings.Universal_String;
               List   : constant Asis.Association_List :=
                 Asis.Statements.Call_Statement_Parameters
                   (Element, Normalized => False);
            begin
               Text := League.Holders.Element
                 (Engine.Get_Property
                    (Asis.Statements.Called_Name (Element), Name));

               Text.Append ("(");

               for J in List'Range loop
                  Arg := League.Holders.Element
                    (Engine.Get_Property
                       (Asis.Expressions.Actual_Parameter (List (J)), Name));

                  Text.Append (Arg);

                  if J /= List'Last then
                     Text.Append (", ");
                  end if;
               end loop;

               Text.Append (")");
            end;

         when Engines.Property_Types.JavaScript_Function =>
            declare
               Arg    : League.Strings.Universal_String;
               Prefix : League.Strings.Universal_String;
               List   : constant Asis.Association_List :=
                 Asis.Statements.Call_Statement_Parameters
                   (Element, Normalized => False);
            begin
               Prefix := League.Holders.Element
                 (Engine.Get_Property
                    (Asis.Statements.Called_Name (Element), Name));

               Text := League.Holders.Element
                 (Engine.Get_Property
                    (Asis.Expressions.Actual_Parameter (List (1)), Name));
               Text.Append (".");
               Text.Append (Prefix);

               Text.Append ("(");

               for J in 2 .. List'Last loop
                  Arg := League.Holders.Element
                    (Engine.Get_Property
                       (Asis.Expressions.Actual_Parameter (List (J)), Name));

                  Text.Append (Arg);

                  if J /= List'Last then
                     Text.Append (", ");
                  end if;
               end loop;

               Text.Append (")");
            end;

         when Engines.Property_Types.JavaScript_Property_Getter |
              Engines.Property_Types.JavaScript_Property_Setter |
              Engines.Property_Types.JavaScript_Getter =>

            raise Program_Error with "not implemented";

      end case;

      Text.Append (";");
      Value := League.Holders.To_Holder (Text);
      return Value;
   end Code;

   ---------------
   -- Intrinsic --
   ---------------

   function Intrinsic
     (Engine  : access Engines.Engine;
      Element : Asis.Expression;
      Name    : League.Strings.Universal_String) return League.Holders.Holder
   is
      pragma Unreferenced (Name);
      Func : constant League.Strings.Universal_String :=
        League.Holders.Element
          (Engine.Get_Property
             (Asis.Statements.Called_Name (Element),
              Engines.Property_Names.Intrinsic_Name));

      List   : constant Asis.Association_List :=
        Asis.Statements.Call_Statement_Parameters
          (Element, Normalized => False);
   begin
      Ada.Wide_Wide_Text_IO.Put ("Unimplemented Intrinsic: ");
      Ada.Wide_Wide_Text_IO.Put (Func.To_Wide_Wide_String);
      raise Program_Error;
      return E : League.Holders.Holder;
   end Intrinsic;

end Properties.Statements.Procedure_Call_Statement;
