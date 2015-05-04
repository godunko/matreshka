with Asis.Declarations;
with Asis.Elements;
with Asis.Expressions;

package body Properties.Declarations.Package_Instantiation is

   function Is_Predefined (Name : Asis.Expression) return Boolean;

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Declaration;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      Generic_Name : constant Asis.Expression :=
        Asis.Declarations.Generic_Unit_Name (Element);
      Spec : constant Asis.Declaration :=
        Asis.Declarations.Corresponding_Declaration (Element);
   begin
      case Asis.Elements.Expression_Kind (Generic_Name) is
         when Asis.A_Selected_Component =>
            if Is_Predefined (Generic_Name) then
               declare
                  Text     : League.Strings.Universal_String;
                  Named    : League.Strings.Universal_String;
                  Selector : constant Asis.Identifier :=
                    Asis.Expressions.Selector (Generic_Name);
                  Image : constant Asis.Program_Text :=
                    Asis.Expressions.Name_Image (Selector);
                  Inside_Package : constant Boolean :=
                    Engine.Boolean.Get_Property
                      (Element, Engines.Inside_Package);
               begin
                  if Inside_Package then
                     Text.Append ("_ec.");
                  else
                     Text.Append ("var ");
                  end if;

                  Named := Engine.Text.Get_Property
                    (Asis.Declarations.Names (Element) (1), Name);

                  Text.Append (Named);
                  Text.Append ("= _ec._");

                  Named := League.Strings.From_UTF_16_Wide_String (Image);
                  Named := Named.To_Lowercase;
                  Text.Append (Named);
                  Text.Append (";");
                  return Text;
               end;
            end if;
         when others =>
            null;
      end case;

      return Engine.Text.Get_Property (Spec, Name);
   end Code;

   -------------------
   -- Is_Predefined --
   -------------------

   function Is_Predefined (Name : Asis.Expression) return Boolean is
      Selector : constant Asis.Identifier :=
        Asis.Expressions.Selector (Name);
      Image : constant Asis.Program_Text :=
        Asis.Expressions.Name_Image (Selector);
   begin
      return Image = "Generic_Elementary_Functions" or else
        Image = "Address_To_Access_Conversions";
   end Is_Predefined;

end Properties.Declarations.Package_Instantiation;