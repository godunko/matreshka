with Ada.Containers.Hashed_Maps;

with Asis.Extensions.Flat_Kinds;

generic
   type Propert_Name is (<>);
   type Property_Type is private;
   type Abstract_Context;
package Engines.Generic_Engines is

   type Engine (Context : access Abstract_Context) is
     tagged limited private;

   function Get_Property
     (Self    : access Engine;
      Element : Asis.Element;
      Name    : Propert_Name) return Property_Type;

   procedure Register_Calculator
     (Self   : in out Engine;
      Kind   : Asis.Extensions.Flat_Kinds.Flat_Element_Kinds;
      Name   : Propert_Name;
      Action : access function
        (Engine  : access Abstract_Context;
         Element : Asis.Element;
         Name    : Propert_Name) return Property_Type);

private

   type Property_Key is record
      Element : Asis.Element;
      Name    : Propert_Name;
   end record;

   function Hash (Value : Property_Key) return Ada.Containers.Hash_Type;
   overriding function "=" (Left, Right : Property_Key) return Boolean;

   package Property_Maps is new Ada.Containers.Hashed_Maps
     (Key_Type        => Property_Key,
      Element_Type    => Property_Type,
      Hash            => Hash,
      Equivalent_Keys => "=",
      "="             => "=");

   type Action_Key is record
      Kind : Asis.Extensions.Flat_Kinds.Flat_Element_Kinds;
      Name : Propert_Name;
   end record;

   function Hash (Value : Action_Key) return Ada.Containers.Hash_Type;

   type Action_Callback is access function
     (Engine  : access Abstract_Context;
      Element : Asis.Element;
      Name    : Propert_Name) return Property_Type;

   package Action_Maps is new Ada.Containers.Hashed_Maps
     (Key_Type        => Action_Key,
      Element_Type    => Action_Callback,
      Hash            => Hash,
      Equivalent_Keys => "=",
      "="             => "=");

   type Engine (Context : access Abstract_Context) is tagged limited
   record
      Property_Cache : Property_Maps.Map;
      Actions        : Action_Maps.Map;
   end record;

end Engines.Generic_Engines;
