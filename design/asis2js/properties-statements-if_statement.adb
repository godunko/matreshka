with Asis.Elements;
with Asis.Statements;

package body Properties.Statements.If_Statement is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Expression;
      Name    : League.Strings.Universal_String)
      return League.Holders.Holder
   is
      List  : constant Asis.Path_List :=
        Asis.Statements.Statement_Paths (Element);
      Text  : League.Strings.Universal_String;
      Down  : League.Strings.Universal_String;
   begin
      for J in List'Range loop
         case Asis.Elements.Path_Kind (List (J)) is
            when Asis.An_If_Path =>
               Text.Append ("if (");

               Down := League.Holders.Element
                 (Engine.Get_Property
                    (Asis.Statements.Condition_Expression (List (J)), Name));

               Text.Append (Down);
               Text.Append (") {");
            when Asis.An_Elsif_Path =>
               Text.Append ("} else if (");

               Down := League.Holders.Element
                 (Engine.Get_Property
                    (Asis.Statements.Condition_Expression (List (J)), Name));

               Text.Append (Down);
               Text.Append (") {");
            when Asis.An_Else_Path =>
               Text.Append ("} else {");
            when others =>
               raise Program_Error;
         end case;

         declare
            Nested : constant Asis.Statement_List :=
              Asis.Statements.Sequence_Of_Statements (List (J));
         begin
            for N in Nested'Range loop
               Down := League.Holders.Element
                 (Engine.Get_Property (Nested (N), Name));

               Text.Append (Down);
            end loop;
         end;
      end loop;

      Text.Append ("};");

      return League.Holders.To_Holder (Text);
   end Code;

end Properties.Statements.If_Statement;
