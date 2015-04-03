with Ada.Containers.Hashed_Maps;

with Asis.Elements;

with League.Strings;

with Engines.Generic_Engines;

package Engines.Contexts is

   type Context;

   package Text_Engines is new Generic_Engines
     (Propert_Name     => Text_Property,
      Property_Type    => League.Strings.Universal_String,
      Abstract_Context => Context);

   package Boolean_Engines is new Generic_Engines
     (Propert_Name     => Boolean_Property,
      Property_Type    => Boolean,
      Abstract_Context => Context);

   package Call_Convention_Engines is new Generic_Engines
     (Propert_Name     => Call_Convention_Property,
      Property_Type    => Call_Convention_Kind,
      Abstract_Context => Context);

   package Uniques is

      type Unique_Map is tagged private;

      function Get
        (Self : access Unique_Map;
         Element : Asis.Element;
         Prefix  : Wide_Wide_String := "")
         return League.Strings.Universal_String;

   private
      function Hash (Item : Asis.Element) return Ada.Containers.Hash_Type;

      package Maps is new Ada.Containers.Hashed_Maps
        (Key_Type        => Asis.Element,
         Element_Type    => Positive,
         Hash            => Hash,
         Equivalent_Keys => Asis.Elements.Is_Equal,
         "="             => "=");

      type Unique_Map is new Maps.Map with null record;

   end Uniques;

   type Context is tagged limited record
      Text            : aliased Text_Engines.Engine (Context'Unchecked_Access);
      Boolean         : aliased Boolean_Engines.Engine
        (Context'Unchecked_Access);
      Call_Convention : aliased Call_Convention_Engines.Engine
        (Context'Unchecked_Access);
      Unique          : aliased Uniques.Unique_Map;
   end record;

end Engines.Contexts;
