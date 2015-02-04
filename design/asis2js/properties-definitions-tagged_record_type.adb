with Asis.Declarations;
with Asis.Elements;

with Properties.Tools;

package body Properties.Definitions.Tagged_Record_Type is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Engine;
      Element : Asis.Definition;
      Name    : League.Strings.Universal_String)
      return League.Holders.Holder
   is
      Decl : constant Asis.Declaration :=
        Asis.Elements.Enclosing_Element (Element);
      Result : League.Strings.Universal_String;
      Name_Image : League.Strings.Universal_String;
   begin
      Result.Append ("_ec.");

      Name_Image := League.Holders.Element
        (Engine.Get_Property (Asis.Declarations.Names (Decl) (1), Name));

      Result.Append (Name_Image);
      Result.Append (" =  function (){};");
      Result.Append ("_ec.");
      Result.Append (Name_Image);
      Result.Append (".prototype = new _ec._tag('");
      Result.Append (Name_Image);
      Result.Append ("', '');");

      declare
         List : constant Asis.Declaration_List :=
           Properties.Tools.Corresponding_Type_Subprograms (Element);
      begin
         for J in List'Range loop
            if Asis.Declarations.Is_Dispatching_Operation (List (J))
              and then Asis.Elements.Has_Abstract (List (J))
            then
               Result.Append ("_ec.");
               Result.Append (Name_Image);
               Result.Append (".prototype.");
               Result.Append
                 (League.Holders.Element
                    (Engine.Get_Property
                         (Asis.Declarations.Names (List (J)) (1), Name)));
               Result.Append (" = _ec._abstract;");
            end if;
         end loop;
      end;

      return League.Holders.To_Holder (Result);
   end Code;

end Properties.Definitions.Tagged_Record_Type;
