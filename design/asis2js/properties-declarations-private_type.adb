with Asis.Declarations;

package body Properties.Declarations.Private_Type is

   ----------------
   -- Initialize --
   ----------------

   function Initialize
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      pragma Unreferenced (Name);

      Full : constant Asis.Declaration :=
        Asis.Declarations.Corresponding_Type_Completion (Element);
   begin
      return Engine.Text.Get_Property (Full, Engines.Initialize);
   end Initialize;

end Properties.Declarations.Private_Type;
