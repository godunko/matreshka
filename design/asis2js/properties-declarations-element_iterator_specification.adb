with Asis.Declarations;

package body Properties.Declarations.Element_Iterator_Specification is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      pragma Unreferenced (Name);

      Text   : League.Strings.Universal_String;
      Index : constant League.Strings.Universal_String :=
        Engine.Unique.Get (Element, "_ind");
   begin
      Text.Append (Index);
      Text.Append ("++");
      return Text;
   end Code;

   ---------------
   -- Condition --
   ---------------

   function Condition
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      pragma Unreferenced (Name);

      Text   : League.Strings.Universal_String;
      Down   : League.Strings.Universal_String;
      Names  : constant Asis.Defining_Name_List :=
        Asis.Declarations.Names (Element);
      Arr    : constant League.Strings.Universal_String :=
        Engine.Unique.Get (Element, "_arr");
      Length : constant League.Strings.Universal_String :=
        Engine.Unique.Get (Element, "_len");
      Index : constant League.Strings.Universal_String :=
        Engine.Unique.Get (Element, "_ind");
   begin
      Text.Append (Index);
      Text.Append ("<");
      Text.Append (Length);
      Text.Append ("&&(");
      Down := Engine.Text.Get_Property (Names (1), Engines.Code);
      Text.Append (Down);
      Text.Append ("=");
      Text.Append (Arr);
      Text.Append ("[");
      Text.Append (Index);
      Text.Append ("],true)");

      return Text;
   end Condition;

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

      Text   : League.Strings.Universal_String;
      Down   : League.Strings.Universal_String;
      Names  : constant Asis.Defining_Name_List :=
        Asis.Declarations.Names (Element);
      Arr    : constant League.Strings.Universal_String :=
        Engine.Unique.Get (Element, "_arr");
      Length : constant League.Strings.Universal_String :=
        Engine.Unique.Get (Element, "_len");
      Index : constant League.Strings.Universal_String :=
        Engine.Unique.Get (Element, "_ind");
      Iter   : constant Asis.Discrete_Subtype_Definition :=
        Asis.Declarations.Iteration_Scheme_Name (Element);
   begin
      Text.Append ("var ");
      Text.Append (Arr);
      Text.Append ("=");
      Down := Engine.Text.Get_Property (Iter, Engines.Code);
      Text.Append (Down);
      Text.Append (",");
      Text.Append (Length);
      Text.Append ("=");
      Text.Append (Arr);
      Text.Append (".length,");
      Text.Append (Index);
      Text.Append ("=0,");
      Down := Engine.Text.Get_Property (Names (1), Engines.Code);
      Text.Append (Down);

      return Text;
   end Initialize;

end Properties.Declarations.Element_Iterator_Specification;
