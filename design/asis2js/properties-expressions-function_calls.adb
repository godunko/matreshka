with Ada.Wide_Wide_Text_IO;

with Asis.Expressions;
with Asis.Statements;

with Engines.Property_Names;
with Engines.Property_Types;

package body Properties.Expressions.Function_Calls is

   function Intrinsic
     (Engine  : access Engines.Engine;
      Element : Asis.Expression;
      Name    : League.Strings.Universal_String) return League.Holders.Holder;

   ---------------------
   -- Call_Convention --
   ---------------------

   function Call_Convention
     (Engine  : access Engines.Engine;
      Element : Asis.Expression;
      Name    : League.Strings.Universal_String) return League.Holders.Holder
   is
   begin
      return Engine.Get_Property
        (Asis.Expressions.Prefix (Element), Name);
   end Call_Convention;

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
          (Engine.Get_Property (Element,
                                Engines.Property_Names.Call_Convention));
   begin
      if Conv = Engines.Property_Types.Intrinsic then
         return Intrinsic (Engine, Element, Name);
      end if;

      if Asis.Statements.Is_Dispatching_Call (Element) then
         declare
            Arg    : League.Strings.Universal_String;
            Prefix : League.Strings.Universal_String;
            List   : constant Asis.Association_List :=
              Asis.Expressions.Function_Call_Parameters
                (Element, Normalized => False);
         begin
            Prefix := League.Holders.Element
              (Engine.Get_Property
                 (Asis.Expressions.Prefix (Element), Name));

            Text := League.Holders.Element
              (Engine.Get_Property
                 (Asis.Expressions.Actual_Parameter (List (1)), Name));
            Text.Append (".");
            Text.Append (Prefix);

            if Conv /= Engines.Property_Types.JavaScript_Getter then
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
            end if;
         end;
      else
         raise Program_Error with "not implemented";
      end if;

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
      Func : constant League.Strings.Universal_String :=
        League.Holders.Element
          (Engine.Get_Property
             (Asis.Expressions.Prefix (Element),
              Engines.Property_Names.Intrinsic_Name));

      List   : constant Asis.Association_List :=
        Asis.Expressions.Function_Call_Parameters
          (Element, Normalized => False);
   begin
      if Func.To_Wide_Wide_String = "League.Strings.To_Universal_String" then
         return Engine.Get_Property
           (Asis.Expressions.Actual_Parameter (List (1)), Name);
      else
         Ada.Wide_Wide_Text_IO.Put ("Unimplemented Intrinsic: ");
         Ada.Wide_Wide_Text_IO.Put (Func.To_Wide_Wide_String);
         raise Program_Error;
      end if;
   end Intrinsic;

end Properties.Expressions.Function_Calls;
