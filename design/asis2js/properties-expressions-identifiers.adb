with Asis.Declarations;
with Asis.Elements;
with Asis.Expressions;

package body Properties.Expressions.Identifiers is

   ---------------------
   -- Call_Convention --
   ---------------------

   function Call_Convention
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Call_Convention_Property)
      return Engines.Call_Convention_Kind
   is
      use type Asis.Expression_Kinds;

      Def : constant Asis.Declaration :=
        Asis.Expressions.Corresponding_Name_Definition (Element);
   begin
      if Asis.Elements.Is_Nil (Def) then
         if Asis.Elements.Expression_Kind (Element) =
           Asis.An_Operator_Symbol
         then
            return Engines.Intrinsic;
         end if;

         return Engines.Unspecified;
      end if;

      return Engine.Call_Convention.Get_Property
        (Asis.Elements.Enclosing_Element (Def), Name);
   end Call_Convention;

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      Decl : constant Asis.Declaration :=
        Asis.Expressions.Corresponding_Name_Declaration (Element);
      Image : constant Wide_String :=
        Asis.Expressions.Name_Image (Element);
      Text : constant League.Strings.Universal_String :=
        League.Strings.From_UTF_16_Wide_String (Image);
   begin
      if Asis.Elements.Is_Nil (Decl) then
         return Text.To_Lowercase;
      else
         return Engine.Text.Get_Property
           (Asis.Declarations.Names (Decl) (1), Name);
      end if;
   end Code;

   ----------------
   -- Initialize --
   ----------------

   function Initialize
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      Decl : constant Asis.Declaration :=
        Asis.Expressions.Corresponding_Name_Declaration (Element);
   begin
      if Asis.Elements.Is_Nil (Decl) then
         return League.Strings.To_Universal_String ("undefined");
      else
         return Engine.Text.Get_Property (Decl, Name);
      end if;
   end Initialize;

   --------------------
   -- Intrinsic_Name --
   --------------------

   function Intrinsic_Name
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      use type Asis.Expression_Kinds;

      Def : constant Asis.Declaration :=
        Asis.Expressions.Corresponding_Name_Definition (Element);
   begin
      if Asis.Elements.Is_Nil (Def) then
         if Asis.Elements.Expression_Kind (Element) =
           Asis.An_Operator_Symbol
         then
            declare
               Text : constant League.Strings.Universal_String :=
                 League.Strings.From_UTF_16_Wide_String
                   (Asis.Expressions.Name_Image (Element));
            begin
               return Text;
            end;
         end if;

         return League.Strings.Empty_Universal_String;
      end if;

      return Engine.Text.Get_Property
        (Asis.Elements.Enclosing_Element (Def), Name);
   end Intrinsic_Name;

end Properties.Expressions.Identifiers;
