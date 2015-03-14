with Asis.Declarations;
with Asis.Elements;
with Asis.Expressions;

with Engines.Property_Types;

package body Properties.Expressions.Identifiers is

   ---------------------
   -- Call_Convention --
   ---------------------

   function Call_Convention
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String) return League.Holders.Holder
   is
      use type Asis.Expression_Kinds;

      Def : constant Asis.Declaration :=
        Asis.Expressions.Corresponding_Name_Definition (Element);
   begin
      if Asis.Elements.Is_Nil (Def) then
         if Asis.Elements.Expression_Kind (Element) =
           Asis.An_Operator_Symbol
         then
            return Engines.Property_Types.Call_Convention_Holders.To_Holder
              (Engines.Property_Types.Intrinsic);
         end if;

         return Engines.Property_Types.Call_Convention_Holders.To_Holder
           (Engines.Property_Types.Unspecified);
      end if;

      return Engine.Get_Property
        (Asis.Elements.Enclosing_Element (Def), Name);
   end Call_Convention;

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String) return League.Holders.Holder
   is
      Decl : constant Asis.Declaration :=
        Asis.Expressions.Corresponding_Name_Declaration (Element);
      Image : constant Wide_String :=
        Asis.Expressions.Name_Image (Element);
      Text : constant League.Strings.Universal_String :=
        League.Strings.From_UTF_16_Wide_String (Image);
      Value : constant League.Holders.Holder :=
        League.Holders.To_Holder (Text.To_Lowercase);
   begin
      if Asis.Elements.Is_Nil (Decl) then
         return Value;
      else
         return Engine.Get_Property
           (Asis.Declarations.Names (Decl) (1), Name);
      end if;
   end Code;

   ----------------
   -- Initialize --
   ----------------

   function Initialize
     (Engine  : access Engines.Engine;
      Element : Asis.Expression;
      Name    : League.Strings.Universal_String) return League.Holders.Holder
   is
      Decl : constant Asis.Declaration :=
        Asis.Expressions.Corresponding_Name_Declaration (Element);
   begin
      if Asis.Elements.Is_Nil (Decl) then
         return League.Holders.To_Holder
           (League.Strings.To_Universal_String ("undefined"));
      else
         return Engine.Get_Property (Decl, Name);
      end if;
   end Initialize;

   --------------------
   -- Intrinsic_Name --
   --------------------

   function Intrinsic_Name
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String) return League.Holders.Holder
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
               return League.Holders.To_Holder (Text);
            end;
         end if;

         return League.Holders.To_Holder
           (League.Strings.Empty_Universal_String);
      end if;

      return Engine.Get_Property
        (Asis.Elements.Enclosing_Element (Def), Name);
   end Intrinsic_Name;

end Properties.Expressions.Identifiers;
