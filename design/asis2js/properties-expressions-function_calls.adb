with Ada.Wide_Wide_Text_IO;

with Asis.Expressions;

with League.String_Vectors;

package body Properties.Expressions.Function_Calls is

   function Intrinsic
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

   From : League.String_Vectors.Universal_String_Vector;
   To   : League.String_Vectors.Universal_String_Vector;

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

      Text   : League.Strings.Universal_String;
      Prefix : constant Asis.Expression := Asis.Expressions.Prefix (Element);
      Conv   : constant Engines.Call_Convention_Kind :=
        Engine.Call_Convention.Get_Property
          (Element, Engines.Call_Convention);
      Is_Dispatching : Boolean;
   begin
      if Conv = Engines.Intrinsic then
         return Intrinsic (Engine, Element, Name);
      end if;

      Is_Dispatching := Engine.Boolean.Get_Property
        (Prefix, Engines.Is_Dispatching);

      if Is_Dispatching then
         declare
            Arg    : League.Strings.Universal_String;
            List   : constant Asis.Association_List :=
              Asis.Expressions.Function_Call_Parameters
                (Element, Normalized => False);
         begin
            Text := Engine.Text.Get_Property
              (Asis.Expressions.Actual_Parameter (List (1)), Name);
            Text.Append (".");
            Text.Append (Engine.Text.Get_Property (Prefix, Name));

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
      else
         declare
            Arg    : League.Strings.Universal_String;
            List   : constant Asis.Association_List :=
              Asis.Expressions.Function_Call_Parameters
                (Element, Normalized => False);
         begin
            Text := Engine.Text.Get_Property (Prefix, Name);

            Text.Append ("(");

            for J in 1 .. List'Last loop
               Arg := Engine.Text.Get_Property
                 (Asis.Expressions.Actual_Parameter (List (J)), Name);

               Text.Append (Arg);

               if J /= List'Last then
                  Text.Append (", ");
               end if;
            end loop;

            Text.Append (")");
         end;
      end if;

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

      Index  : Natural;
      List   : constant Asis.Association_List :=
        Asis.Expressions.Function_Call_Parameters
          (Element, Normalized => False);
      Args   : array (List'Range) of League.Strings.Universal_String;
   begin
      for J in List'Range loop
         Args (J) := Engine.Text.Get_Property
           (Asis.Expressions.Actual_Parameter (List (J)), Name);
      end loop;

      Index := From.Index (Func);

      if Func.To_Wide_Wide_String = "League.Strings.To_Universal_String"
        or else Func.To_Wide_Wide_String = "League.Strings.To_UTF_8_String"
        or else Func.Starts_With ("System.Address_To_Access_Conversions.")
      then
         return Args (1);
      elsif Args'Length = 2 and Index > 0 then
         declare
            Text : League.Strings.Universal_String;
         begin
            Text.Append (Args (1));
            Text.Append (To.Element (Index));
            Text.Append (Args (2));

            return Text;
         end;
      elsif Index > 0 then
         declare
            Text : League.Strings.Universal_String;
         begin
            Text.Append (To.Element (Index));
            Text.Append (Args (1));

            return Text;
         end;
      elsif Func.To_Wide_Wide_String = "System.Storage_Elements.""+""" then
         declare
            Text : League.Strings.Universal_String;
         begin
            Text.Append (Args (1));
            Text.Append ("[");
            Text.Append (Args (2));
            Text.Append ("]");

            return Text;
         end;
      elsif Func.To_Wide_Wide_String = "AN_IMAGE_ATTRIBUTE" then
         declare
            Text : League.Strings.Universal_String;
         begin
            Text.Append ("_ec._image(");
            Text.Append (Args (1));
            Text.Append (")");

            return Text;
         end;
      else
         Ada.Wide_Wide_Text_IO.Put ("Unimplemented Intrinsic: ");
         Ada.Wide_Wide_Text_IO.Put (Func.To_Wide_Wide_String);
         raise Program_Error;
      end if;
   end Intrinsic;

begin
   From.Append (League.Strings.To_Universal_String ("""="""));
   To.Append (League.Strings.To_Universal_String ("==="));
   From.Append (League.Strings.To_Universal_String ("""/="""));
   To.Append (League.Strings.To_Universal_String ("!=="));
   From.Append (League.Strings.To_Universal_String ("""&"""));
   To.Append (League.Strings.To_Universal_String ("+"));
   From.Append (League.Strings.To_Universal_String ("""+"""));
   To.Append (League.Strings.To_Universal_String ("+"));
   From.Append (League.Strings.To_Universal_String ("""-"""));
   To.Append (League.Strings.To_Universal_String ("-"));
   From.Append (League.Strings.To_Universal_String ("""*"""));
   To.Append (League.Strings.To_Universal_String ("*"));
   From.Append (League.Strings.To_Universal_String ("""/"""));
   To.Append (League.Strings.To_Universal_String ("/"));
   From.Append (League.Strings.To_Universal_String (""">"""));
   To.Append (League.Strings.To_Universal_String (">"));
end Properties.Expressions.Function_Calls;
