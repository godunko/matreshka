with Asis.Declarations;

package body Properties.Declarations.Defining_Expanded_Name is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      Selector : constant Asis.Defining_Name :=
        Asis.Declarations.Defining_Selector (Element);
   begin
      return Engine.Text.Get_Property (Selector, Name);
   end Code;

end Properties.Declarations.Defining_Expanded_Name;
