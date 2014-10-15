with Asis.Declarations;
with Asis.Statements;

package body Properties.Statements.For_Loop_Statement is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Expression;
      Name    : League.Strings.Universal_String)
      return League.Holders.Holder
   is
      Iter  : constant Asis.Declaration :=
        Asis.Statements.For_Loop_Parameter_Specification (Element);
      List  : constant Asis.Statement_List :=
        Asis.Statements.Loop_Statements (Element);
      Text  : League.Strings.Universal_String;
      Down  : League.Strings.Universal_String;
      Index : League.Strings.Universal_String;
   begin
      Text.Append ("for (var ");
      Index := League.Holders.Element
        (Engine.Get_Property
           (Asis.Declarations.Names (Iter) (1), Name));

      Text.Append (Index);
      Text.Append (" = ");
      Down := League.Holders.Element
        (Engine.Get_Property
           (Asis.Declarations.Specification_Subtype_Definition (Iter), Name));

      Text.Append (Down);
      Text.Append (" >= ");
      Text.Append (Index);
      Text.Append ("; ");
      Text.Append (Index);
      Text.Append ("++){");

      for N in List'Range loop
         Down := League.Holders.Element
           (Engine.Get_Property (List (N), Name));

         Text.Append (Down);
      end loop;

      Text.Append ("}");

      return League.Holders.To_Holder (Text);
   end Code;

end Properties.Statements.For_Loop_Statement;
