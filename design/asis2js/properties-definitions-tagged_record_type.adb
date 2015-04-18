with Asis.Declarations;
with Asis.Definitions;
with Asis.Elements;

with Properties.Tools;

package body Properties.Definitions.Tagged_Record_Type is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Definition;
      Name    : Engines.Text_Property) return League.Strings.Universal_String
   is
      use type Asis.Type_Kinds;

      Decl : constant Asis.Declaration :=
        Asis.Elements.Enclosing_Element (Element);
      Parent : Asis.Subtype_Indication := Asis.Nil_Element;
      Result : League.Strings.Universal_String;
      Name_Image : League.Strings.Universal_String;
   begin
      if Asis.Elements.Type_Kind (Element) =
        Asis.A_Derived_Record_Extension_Definition
      then
         Parent := Asis.Definitions.Parent_Subtype_Indication (Element);
      end if;

      Name_Image := Engine.Text.Get_Property
        (Asis.Declarations.Names (Decl) (1), Name);

      Result.Append ("_ec.");
      Result.Append (Name_Image);
      Result.Append (" =  function (");

      declare
         List : constant Asis.Discriminant_Association_List :=
           Properties.Tools.Corresponding_Type_Discriminants (Element);
      begin
         for J in List'Range loop
            declare
               Id    : League.Strings.Universal_String;
               Names : constant Asis.Defining_Name_List :=
                 Asis.Declarations.Names (List (J));
            begin
               for N in Names'Range loop
                  Id := Engine.Text.Get_Property (Names (N), Name);
                  Result.Append (Id);

                  if J /= List'Last and N /= Names'Last then
                     Result.Append (",");
                  end if;
               end loop;
            end;
         end loop;

         Result.Append ("){");

         for J in List'Range loop
            declare
               Id    : League.Strings.Universal_String;
               Names : constant Asis.Defining_Name_List :=
                 Asis.Declarations.Names (List (J));
               Init  : constant Asis.Expression :=
                 Asis.Declarations.Initialization_Expression (List (J));
            begin
               for N in Names'Range loop
                  Id := Engine.Text.Get_Property (Names (N), Name);

                  if not Asis.Elements.Is_Nil (Init) then
                     Result.Append ("if (typeof ");
                     Result.Append (Id);
                     Result.Append ("=== 'undefined')");
                     Result.Append (Id);
                     Result.Append ("=");
                     Result.Append (Engine.Text.Get_Property (Init, Name));
                     Result.Append (";");
                  end if;

                  Result.Append ("this.");
                  Result.Append (Id);
                  Result.Append (" = ");
                  Result.Append (Id);
                  Result.Append (";");
               end loop;
            end;
         end loop;

         if not Asis.Elements.Is_Nil (Parent) then
            Result.Append
              (Engine.Text.Get_Property (Parent, Name));
            Result.Append (".call (this");

            for J in List'Range loop
               declare
                  Id    : League.Strings.Universal_String;
                  Names : constant Asis.Defining_Name_List :=
                    Asis.Declarations.Names (List (J));
               begin
                  for N in Names'Range loop
                     Result.Append (",");
                     Id := Engine.Text.Get_Property (Names (N), Name);
                     Result.Append (Id);
                  end loop;
               end;
            end loop;

            Result.Append (");");
         end if;
      end;

      declare
         List : constant Asis.Declaration_List :=
           Properties.Tools.Corresponding_Type_Components (Element);
      begin
         for J in List'Range loop
            declare
               Id    : League.Strings.Universal_String;
               Init  : constant Asis.Expression :=
                 Asis.Declarations.Initialization_Expression (List (J));
               Names : constant Asis.Defining_Name_List :=
                 Asis.Declarations.Names (List (J));
               Value : League.Strings.Universal_String;
            begin
               if not Asis.Elements.Is_Nil (Init) then
                  Value := Engine.Text.Get_Property (Init, Name);
               end if;

               for N in Names'Range loop
                  Id := Engine.Text.Get_Property (Names (N), Name);
                  Result.Append ("this.");
                  Result.Append (Id);
                  Result.Append (" = ");

                  if Asis.Elements.Is_Nil (Init) then
                     Result.Append
                       (Engine.Text.Get_Property
                          (List (J), Engines.Initialize));
                  else
                     Result.Append (Value);
                  end if;

                  Result.Append (";");
               end loop;
            end;
         end loop;
      end;

      Result.Append ("};");
      Result.Append ("_ec.");
      Result.Append (Name_Image);
      Result.Append (".prototype = _ec._tag('");
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
                 (Engine.Text.Get_Property
                         (Asis.Declarations.Names (List (J)) (1), Name));
               Result.Append (" = _ec._abstract;");
            end if;
         end loop;
      end;

      return Result;
   end Code;

end Properties.Definitions.Tagged_Record_Type;
