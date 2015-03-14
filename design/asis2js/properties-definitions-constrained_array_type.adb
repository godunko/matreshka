package body Properties.Definitions.Constrained_Array_Type is

   ----------------
   -- Initialize --
   ----------------

   function Initialize
     (Engine  : access Engines.Engine;
      Element : Asis.Definition;
      Name    : League.Strings.Universal_String)
      return League.Holders.Holder
   is
      pragma Unreferenced (Engine, Element, Name);
   begin
      return League.Holders.To_Holder
        (League.Strings.To_Universal_String ("[]"));
   end Initialize;

end Properties.Definitions.Constrained_Array_Type;
