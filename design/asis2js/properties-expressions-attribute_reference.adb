with Asis.Elements;
with Asis.Expressions;

package body Properties.Expressions.Attribute_Reference is

   function Call_Convention
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Call_Convention_Property)
      return Engines.Call_Convention_Kind
   is
      pragma Unreferenced (Engine, Name);
      Kind   : constant Asis.Attribute_Kinds :=
        Asis.Elements.Attribute_Kind (Element);
   begin
      case Kind is
         when Asis.An_Image_Attribute =>
            return Engines.Intrinsic;
         when others =>
            raise Program_Error with
              "Unimplemented Call_Convention attribute: " &
              Asis.Attribute_Kinds'Image (Kind);
      end case;
   end Call_Convention;

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      Prefix : constant Asis.Expression :=
        Asis.Expressions.Prefix (Element);
      Kind   : constant Asis.Attribute_Kinds :=
        Asis.Elements.Attribute_Kind (Element);
   begin
      case Kind is
         when Asis.An_Access_Attribute |
              Asis.An_Address_Attribute |
            Asis.An_Unchecked_Access_Attribute =>
            return Engine.Text.Get_Property (Prefix, Name);

         when Asis.A_Position_Attribute =>
            declare
               Text     : League.Strings.Universal_String;
               Selector : constant Asis.Identifier :=
                 Asis.Expressions.Selector (Prefix);
               Def : constant Asis.Defining_Name :=
                 Asis.Expressions.Corresponding_Name_Definition (Selector);
            begin
               Text := Engine.Text.Get_Property (Def, Name);
               Text.Prepend ("'");
               Text.Append ("'");

               return Text;
            end;
         when others =>
            raise Program_Error with "Unimplemented attribute: " &
              Asis.Attribute_Kinds'Image (Kind);
      end case;
   end Code;

   --------------------
   -- Intrinsic_Name --
   --------------------

   function Intrinsic_Name
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      pragma Unreferenced (Engine, Name);
      Kind   : constant Asis.Attribute_Kinds :=
        Asis.Elements.Attribute_Kind (Element);
   begin
      return League.Strings.To_Universal_String
        (Asis.Attribute_Kinds'Wide_Wide_Image (Kind));
   end Intrinsic_Name;

end Properties.Expressions.Attribute_Reference;
