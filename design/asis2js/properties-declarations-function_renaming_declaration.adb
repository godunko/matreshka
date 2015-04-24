with Asis.Declarations;

package body Properties.Declarations.Function_Renaming_Declaration is

   ---------------------
   -- Call_Convention --
   ---------------------

   function Call_Convention
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Call_Convention_Property)
      return Engines.Call_Convention_Kind
   is
   begin
      return Engine.Call_Convention.Get_Property
        (Asis.Declarations.Renamed_Entity (Element), Name);
   end Call_Convention;

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      Subprogram_Name : constant League.Strings.Universal_String :=
        Engine.Text.Get_Property
          (Element => Asis.Declarations.Names (Element) (1),
           Name    => Name);

      Inside_Package : constant Boolean := Engine.Boolean.Get_Property
        (Element, Engines.Inside_Package);

      Text : League.Strings.Universal_String;
   begin
      if Inside_Package then
         Text.Append ("_ec.");
      else
         Text.Append ("var ");
      end if;
      Text.Append (Subprogram_Name);
      Text.Append ("=");

      Text.Append
        (Engine.Text.Get_Property
           (Asis.Declarations.Renamed_Entity (Element), Name));
      Text.Append (";");

      return Text;
   end Code;

   --------------------
   -- Intrinsic_Name --
   --------------------

   function Intrinsic_Name
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
   begin
      return Engine.Text.Get_Property
        (Asis.Declarations.Renamed_Entity (Element), Name);
   end Intrinsic_Name;

   --------------------
   -- Is_Dispatching --
   --------------------

   function Is_Dispatching
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Boolean_Property) return Boolean is
   begin
      return Engine.Boolean.Get_Property
        (Asis.Declarations.Renamed_Entity (Element), Name);
   end Is_Dispatching;

end Properties.Declarations.Function_Renaming_Declaration;
