package body Engines.Contexts is

   -------------
   -- Uniques --
   -------------

   package body Uniques is

      ---------
      -- Get --
      ---------

      function Get
        (Self : access Unique_Map;
         Element : Asis.Element;
         Prefix  : Wide_Wide_String := "")
         return League.Strings.Universal_String
      is
         Cursor : constant Maps.Cursor := Self.Find (Element);
         Value : Positive;
      begin
         if Maps.Has_Element (Cursor) then
            Value := Maps.Element (Cursor);
         else
            Value := Natural (Self.Length) + 1;
            Self.Insert (Element, Value);
         end if;

         declare
            use type League.Strings.Universal_String;

            Result : League.Strings.Universal_String :=
              League.Strings.To_Universal_String (Prefix);

            Image : constant Wide_Wide_String :=
              Positive'Wide_Wide_Image (Value);
         begin
            Result.Append (Image (2 .. Image'Last));

            return Result;
         end;
      end Get;

      ----------
      -- Hash --
      ----------

      function Hash (Item : Asis.Element) return Ada.Containers.Hash_Type is
         Result : constant Asis.ASIS_Integer := Asis.Elements.Hash (Item);
      begin
         return Ada.Containers.Hash_Type (abs Result);
      end Hash;

   end Uniques;

end Engines.Contexts;
