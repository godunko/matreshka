with Asis.Declarations;
with Asis.Elements;

with Engines.Property_Names;

package body Properties.Declarations.Constant_Declarations is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String) return League.Holders.Holder
   is
      List : constant Asis.Defining_Name_List :=
        Asis.Declarations.Names (Element);

      Init : constant Asis.Expression :=
        Asis.Declarations.Initialization_Expression (Element);

      Init_Code : League.Strings.Universal_String;
      Prefix    : League.Strings.Universal_String;

      Constant_Name : League.Strings.Universal_String;
      Text  : League.Strings.Universal_String;
      Value : League.Holders.Holder;
   begin
      if not Asis.Elements.Is_Nil (Init) then
         Init_Code := League.Holders.Element
           (Engine.Get_Property (Init, Name));
      end if;

      for J in List'Range loop
         Prefix := League.Holders.Element
           (Engine.Get_Property
              (Asis.Elements.Enclosing_Element (Element),
               Engines.Property_Names.Declaration_Prefix));

         Text.Append (Prefix);

         Constant_Name := League.Holders.Element
             (Engine.Get_Property (List (J), Name));
         Text.Append (Constant_Name);

         if not Asis.Elements.Is_Nil (Init) then
            Text.Append (" = ");
            Text.Append (Init_Code);
         end if;

         Text.Append (";");
      end loop;

      Value := League.Holders.To_Holder (Text);
      return Value;
   end Code;

end Properties.Declarations.Constant_Declarations;
