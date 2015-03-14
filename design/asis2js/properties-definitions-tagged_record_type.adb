with Asis.Declarations;
with Asis.Elements;

with Properties.Tools;
with Engines.Property_Names;

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
      Result.Append (" =  function (){");

      declare
         List : constant Asis.Declaration_List :=
           Properties.Tools.Corresponding_Type_Components (Element);
      begin
         for J in List'Range loop
            declare
               Names : constant Asis.Defining_Name_List :=
                 Asis.Declarations.Names (List (J));
            begin
               for N in Names'Range loop
                  Result.Append ("this.");
                  Result.Append
                    (League.Holders.Element
                       (Engine.Get_Property
                            (Names (N), Name)));
                  Result.Append (" = ");
               end loop;

               Result.Append
                 (League.Holders.Element
                    (Engine.Get_Property
                         (List (J), Engines.Property_Names.Initialize)));

               Result.Append (";");
            end;
         end loop;
      end;

      Result.Append ("};");
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
