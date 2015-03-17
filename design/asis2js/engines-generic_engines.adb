with Asis.Elements;
with Ada.Wide_Text_IO;

package body Engines.Generic_Engines is

   ---------
   -- "=" --
   ---------

   overriding function "=" (Left, Right : Property_Key) return Boolean is
   begin
      return Asis.Elements.Is_Identical (Left.Element, Right.Element) and then
        Left.Name = Right.Name;
   end "=";

   ------------------
   -- Get_Property --
   ------------------

   function Get_Property
     (Self    : access Engine;
      Element : Asis.Element;
      Name    : Propert_Name)
      return Property_Type
   is
      Key    : constant Property_Key := (Element, Name);
      Pos    : constant Property_Maps.Cursor := Self.Property_Cache.Find (Key);
      Value  : Property_Type;
      Action : Action_Callback;
   begin
      if Property_Maps.Has_Element (Pos) then
         Value := Property_Maps.Element (Pos);
      else
         declare
            Kind : constant Asis.Extensions.Flat_Kinds.Flat_Element_Kinds :=
              Asis.Extensions.Flat_Kinds.Flat_Element_Kind (Element);
         begin
            Action := Self.Actions.Element ((Kind, Name));
         exception
            when Constraint_Error =>
               Ada.Wide_Text_IO.Put
                 (Asis.Extensions.Flat_Kinds.Flat_Element_Kinds'Wide_Image
                    (Kind));
               Ada.Wide_Text_IO.Put (" ");
               Ada.Wide_Text_IO.Put_Line (Propert_Name'Wide_Image (Name));
               Ada.Wide_Text_IO.Put_Line (Asis.Elements.Debug_Image (Element));
               raise;
         end;

         Value := Action (Self.Context, Element, Name);
         Self.Property_Cache.Insert (Key, Value);
      end if;

      return Value;
   end Get_Property;

   ----------
   -- Hash --
   ----------

   function Hash (Value : Property_Key) return Ada.Containers.Hash_Type is
      use type Ada.Containers.Hash_Type;

      Element_Hash : constant Asis.ASIS_Integer :=
        Asis.Elements.Hash (Value.Element);
      Name_Hash : constant Ada.Containers.Hash_Type :=
        Propert_Name'Pos (Value.Name);
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
        Propert_Name'Pos (Value.Name);
   begin
      return Name_Hash + Kind_Hash;
   end Hash;

   -------------------------
   -- Register_Calculator --
   -------------------------

   procedure Register_Calculator
     (Self   : in out Engine;
      Kind   : Asis.Extensions.Flat_Kinds.Flat_Element_Kinds;
      Name   : Propert_Name;
      Action : access function
        (Engine  : access Abstract_Context;
         Element : Asis.Element;
         Name    : Propert_Name) return Property_Type) is
   begin
      Self.Actions.Insert ((Kind, Name), Action);
   end Register_Calculator;

end Engines.Generic_Engines;
