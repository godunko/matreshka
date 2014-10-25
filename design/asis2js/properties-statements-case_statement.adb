with Asis.Elements;
with Asis.Statements;

package body Properties.Statements.Case_Statement is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Expression;
      Name    : League.Strings.Universal_String)
      return League.Holders.Holder
   is
      use type Asis.Path_Kinds;
      use type Asis.Definition_Kinds;
      use type Asis.Element_Kinds;

      List  : constant Asis.Path_List :=
        Asis.Statements.Statement_Paths (Element);
      Text  : League.Strings.Universal_String;
      Down  : League.Strings.Universal_String;
   begin
      Text.Append ("switch (");
      Down := League.Holders.Element
        (Engine.Get_Property
           (Asis.Statements.Case_Expression (Element), Name));

      Text.Append (Down);
      Text.Append (") {");

      for J in List'Range loop
         pragma Assert
           (Asis.Elements.Path_Kind (List (J)) = Asis.A_Case_Path);

         declare
            Nested : constant Asis.Statement_List :=
              Asis.Statements.Sequence_Of_Statements (List (J));
            Alt : constant Asis.Element_List :=
              Asis.Statements.Case_Path_Alternative_Choices (List (J));
         begin
            for K in Alt'Range loop
               if Asis.Elements.Element_Kind (Alt (K)) =
                 Asis.An_Expression
               then
                  Down := League.Holders.Element
                    (Engine.Get_Property (Alt (K), Name));

                  Text.Append ("case ");
                  Text.Append (Down);
                  Text.Append (" : ");
               elsif Asis.Elements.Definition_Kind (Alt (K)) =
                 Asis.An_Others_Choice
               then
                  Text.Append ("default: ");
               else
                  raise Constraint_Error;
               end if;

               for N in Nested'Range loop
                  Down := League.Holders.Element
                    (Engine.Get_Property (Nested (N), Name));

                  Text.Append (Down);
               end loop;

               Text.Append ("break;");
            end loop;
         end;
      end loop;

      Text.Append ("};");

      return League.Holders.To_Holder (Text);
   end Code;

end Properties.Statements.Case_Statement;
