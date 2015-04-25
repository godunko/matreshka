with Asis.Definitions;
with Asis.Elements;

package body Properties.Definitions.Subtype_Indication is

   ------------
   -- Bounds --
   ------------

   function Bounds
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      Mark : constant Asis.Definition :=
        Asis.Definitions.Subtype_Mark (Element);
      Constr : constant Asis.Definition :=
        Asis.Definitions.Subtype_Constraint (Element);
   begin
      if Asis.Elements.Is_Nil (Constr) then
         return Engine.Text.Get_Property (Mark, Name);
      else
         return Engine.Text.Get_Property (Constr, Name);
      end if;
   end Bounds;

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      Mark : constant Asis.Definition :=
        Asis.Definitions.Subtype_Mark (Element);
   begin
      return Engine.Text.Get_Property (Mark, Name);
   end Code;

   ----------------
   -- Initialize --
   ----------------

   function Initialize
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      use type League.Strings.Universal_String;

      Text : League.Strings.Universal_String;
      Mark : constant Asis.Definition :=
        Asis.Definitions.Subtype_Mark (Element);
      Is_Simple : constant Boolean :=
        Engine.Boolean.Get_Property (Element, Engines.Is_Simple_Type);
      Constr : constant Asis.Definition :=
        Asis.Definitions.Subtype_Constraint (Element);
   begin
      if Is_Simple then
         Text := Engine.Text.Get_Property (Mark, Name);
      else
         Text.Append (" new ");
         Text.Append (Engine.Text.Get_Property (Mark, Engines.Code));
         Text.Append ("(");

         if not Asis.Elements.Is_Nil (Constr) then
            Text.Append (Engine.Text.Get_Property (Constr, Engines.Code));
         end if;

         Text.Append (")");
      end if;

      return Text;
   end Initialize;

   function Is_Simple_Type
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Boolean_Property) return Boolean
   is
      Mark : constant Asis.Definition :=
        Asis.Definitions.Subtype_Mark (Element);
   begin
      return Engine.Boolean.Get_Property (Mark, Name);
   end Is_Simple_Type;

end Properties.Definitions.Subtype_Indication;
