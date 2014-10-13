with Ada.Containers.Hashed_Maps;

with Asis;
with Asis.Extensions.Flat_Kinds;

with League.Holders;
with League.Strings;

package Engines is

   type Engine is tagged limited private;

   function Get_Property
     (Self    : in out Engine;
      Element : Asis.Element;
      Name    : League.Strings.Universal_String)
     return League.Holders.Holder;

   procedure Set_Property
     (Self    : in out Engine;
      Element : Asis.Element;
      Name    : League.Strings.Universal_String;
      Value   : League.Holders.Holder);

   type Action_Callback is access procedure
     (Engine  : in out Engines.Engine;
      Element : Asis.Element;
      Name    : League.Strings.Universal_String);

   procedure Register_Calculator
     (Self : in out Engine;
      Kind : Asis.Extensions.Flat_Kinds.Flat_Element_Kinds;
      Name : League.Strings.Universal_String;
      Action : Action_Callback);

private

   type Property_Key is record
      Element : Asis.Element;
      Name    : League.Strings.Universal_String;
   end record;

   function Hash (Value : Property_Key) return Ada.Containers.Hash_Type;

   package Property_Maps is new Ada.Containers.Hashed_Maps
     (Key_Type        => Property_Key,
      Element_Type    => League.Holders.Holder,
      Hash            => Hash,
      Equivalent_Keys => "=",
      "="             => League.Holders."=");

   type Action_Key is record
      Kind : Asis.Extensions.Flat_Kinds.Flat_Element_Kinds;
      Name : League.Strings.Universal_String;
   end record;

   function Hash (Value : Action_Key) return Ada.Containers.Hash_Type;

   package Action_Maps is new Ada.Containers.Hashed_Maps
     (Key_Type        => Action_Key,
      Element_Type    => Action_Callback,
      Hash            => Hash,
      Equivalent_Keys => "=",
      "="             => "=");

   type Engine is tagged limited record
      Property_Cache : Property_Maps.Map;
      Actions        : Action_Maps.Map;
   end record;

end Engines;
