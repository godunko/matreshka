with Asis.Statements;

package body Properties.Statements.While_Loop_Statement is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      Cond  : constant Asis.Declaration :=
        Asis.Statements.While_Condition (Element);
      List  : constant Asis.Statement_List :=
        Asis.Statements.Loop_Statements (Element);
      Text  : League.Strings.Universal_String;
      Down  : League.Strings.Universal_String;
   begin
      Text.Append ("while (");
      Down := Engine.Text.Get_Property (Cond, Name);
      Text.Append (Down);
      Text.Append ("){");

      for N in List'Range loop
         Down := Engine.Text.Get_Property (List (N), Name);

         Text.Append (Down);
      end loop;

      Text.Append ("};");

      return Text;
   end Code;

end Properties.Statements.While_Loop_Statement;
