with Asis.Elements;

with League.Strings.Hash;

package body Engines is

   ---------
   -- "=" --
   ---------

   overriding function "=" (Left, Right : Property_Key) return Boolean is
      use type League.Strings.Universal_String;
   begin
      return Asis.Elements.Is_Identical (Left.Element, Right.Element) and then
        Left.Name = Right.Name;
   end "=";

   ------------------
   -- Get_Property --
   ------------------

   function Get_Property
     (Self    : in out Engine;
      Element : Asis.Element;
      Name    : League.Strings.Universal_String)
      return League.Holders.Holder
   is
      Key : constant Property_Key := (Element, Name);
      Pos : Property_Maps.Cursor := Self.Property_Cache.Find (Key);
   begin
      if not Property_Maps.Has_Element (Pos) then
         declare
            Kind : constant Asis.Extensions.Flat_Kinds.Flat_Element_Kinds :=
              Asis.Extensions.Flat_Kinds.Flat_Element_Kind (Element);
         begin
            Self.Actions.Element ((Kind, Name)) (Self, Element, Name);
            Pos := Self.Property_Cache.Find (Key);
         end;
      end if;

      return Property_Maps.Element (Pos);
   end Get_Property;

   ----------
   -- Hash --
   ----------

   function Hash (Value : Property_Key) return Ada.Containers.Hash_Type is
      use type Ada.Containers.Hash_Type;

      Element_Hash : constant Asis.ASIS_Integer :=
        Asis.Elements.Hash (Value.Element);
      Name_Hash : constant Ada.Containers.Hash_Type :=
        League.Strings.Hash (Value.Name);
   begin
      return Name_Hash + Ada.Containers.Hash_Type (abs Element_Hash);
   end Hash;

   ----------
   -- Hash --
   ----------

   function Hash (Value : Action_Key) return Ada.Containers.Hash_Type is
      use type Ada.Containers.Hash_Type;

      Kind_Hash : constant Ada.Containers.Hash_Type :=
        Asis.Extensions.Flat_Kinds.Flat_Element_Kinds'Pos (Value.Kind);
      Name_Hash : constant Ada.Containers.Hash_Type :=
        League.Strings.Hash (Value.Name);
   begin
      return Name_Hash + Kind_Hash;
   end Hash;

   -------------------------
   -- Register_Calculator --
   -------------------------

   procedure Register_Calculator
     (Self : in out Engine;
      Kind : Asis.Extensions.Flat_Kinds.Flat_Element_Kinds;
      Name : League.Strings.Universal_String;
      Action : Action_Callback)
   is
   begin
      Self.Actions.Insert ((Kind, Name), Action);
   end Register_Calculator;

   ------------------
   -- Set_Property --
   ------------------

   procedure Set_Property
     (Self    : in out Engine;
      Element : Asis.Element;
      Name    : League.Strings.Universal_String;
      Value   : League.Holders.Holder)
   is
      Key : constant Property_Key := (Element, Name);
   begin
      Self.Property_Cache.Insert (Key, Value);
   end Set_Property;

end Engines;
