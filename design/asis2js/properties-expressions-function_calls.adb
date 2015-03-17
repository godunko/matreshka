with Ada.Wide_Wide_Text_IO;

with Asis.Expressions;

package body Properties.Expressions.Function_Calls is

   function Intrinsic
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

   ---------------------
   -- Call_Convention --
   ---------------------

   function Call_Convention
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Call_Convention_Property)
      return Engines.Call_Convention_Kind is
   begin
      return Engine.Call_Convention.Get_Property
        (Asis.Expressions.Prefix (Element), Name);
   end Call_Convention;

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
          (Element, Engines.Call_Convention);
   begin
      if Conv = Engines.Intrinsic then
         return Intrinsic (Engine, Element, Name);
      end if;

--        if Asis.Statements.Is_Dispatching_Call (Element) then
      declare
         Arg    : League.Strings.Universal_String;
         Prefix : League.Strings.Universal_String;
         List   : constant Asis.Association_List :=
           Asis.Expressions.Function_Call_Parameters
             (Element, Normalized => False);
      begin
         Prefix := Engine.Text.Get_Property
           (Asis.Expressions.Prefix (Element), Name);

         Text := Engine.Text.Get_Property
           (Asis.Expressions.Actual_Parameter (List (1)), Name);
         Text.Append (".");
         Text.Append (Prefix);

         if Conv /= Engines.JavaScript_Property_Getter then
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
         end if;
      end;

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
      Func : constant League.Strings.Universal_String :=
        Engine.Text.Get_Property
          (Asis.Expressions.Prefix (Element),
           Engines.Intrinsic_Name);

      List   : constant Asis.Association_List :=
        Asis.Expressions.Function_Call_Parameters
          (Element, Normalized => False);
      Args   : array (List'Range) of League.Strings.Universal_String;
   begin
      for J in List'Range loop
         Args (J) := Engine.Text.Get_Property
           (Asis.Expressions.Actual_Parameter (List (J)), Name);
      end loop;

      if Func.To_Wide_Wide_String = "League.Strings.To_Universal_String" then
         return Args (1);
      elsif Func.To_Wide_Wide_String = """=""" then
         declare
            Text : League.Strings.Universal_String;
         begin
            Text.Append (Args (1));
            Text.Append (" === ");
            Text.Append (Args (2));

            return Text;
         end;
      elsif Func.To_Wide_Wide_String = """&""" then
         declare
            Text : League.Strings.Universal_String;
         begin
            Text.Append (Args (1));
            Text.Append (" + ");
            Text.Append (Args (2));

            return Text;
         end;
      else
         Ada.Wide_Wide_Text_IO.Put ("Unimplemented Intrinsic: ");
         Ada.Wide_Wide_Text_IO.Put (Func.To_Wide_Wide_String);
         raise Program_Error;
      end if;
   end Intrinsic;

end Properties.Expressions.Function_Calls;
