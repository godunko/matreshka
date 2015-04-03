with Asis.Declarations;

package body Properties.Declarations.Loop_Parameter_Specification is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      Var    : League.Strings.Universal_String;
      Text   : League.Strings.Universal_String;
      Names  : constant Asis.Defining_Name_List :=
        Asis.Declarations.Names (Element);
      Cond   : constant League.Strings.Universal_String :=
        Engine.Text.Get_Property (Element, Engines.Condition);
      Last : constant League.Strings.Universal_String :=
        Engine.Unique.Get (Element, "_last");
   begin
      Text.Append ("(");
      Text.Append (Cond);
      Text.Append ("=");
      Var := Engine.Text.Get_Property (Names (1), Name);
      Text.Append (Var);
      Text.Append ("!=");
      Text.Append (Last);
      Text.Append (") && (");
      Text.Append (Var);
      Text.Append ("=_ec._succ(");
      Text.Append (Var);
      Text.Append ("))");

      return Text;
   end Code;

   ---------------
   -- Condition --
   ---------------

   function Condition
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      pragma Unreferenced (Name);
      Result : constant League.Strings.Universal_String :=
        Engine.Unique.Get (Element, "_cond");
   begin
      return Result;
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
      Var    : League.Strings.Universal_String;
      Text   : League.Strings.Universal_String;
      Down   : League.Strings.Universal_String;
      Names  : constant Asis.Defining_Name_List :=
        Asis.Declarations.Names (Element);
      Bounds : constant Asis.Discrete_Subtype_Definition :=
        Asis.Declarations.Specification_Subtype_Definition (Element);
      Last : constant League.Strings.Universal_String :=
        Engine.Unique.Get (Element, "_last");
      Cond   : constant League.Strings.Universal_String :=
        Engine.Text.Get_Property (Element, Engines.Condition);
   begin
      Text.Append ("var ");
      Text.Append (Last);
      Text.Append ("=");
      Down := Engine.Text.Get_Property (Bounds, Engines.Upper);
      Text.Append (Down);
      Text.Append (",");
      Var := Engine.Text.Get_Property (Names (1), Engines.Code);
      Text.Append (Var);
      Text.Append ("=");
      Down := Engine.Text.Get_Property (Bounds, Engines.Lower);
      Text.Append (Down);
      Text.Append (",");
      Text.Append (Cond);
      Text.Append ("=");
      Text.Append (Var);
      Text.Append ("<=");
      Text.Append (Last);

      return Text;
   end Initialize;

end Properties.Declarations.Loop_Parameter_Specification;
