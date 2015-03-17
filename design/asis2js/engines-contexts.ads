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

   type Context is tagged limited record
      Text            : aliased Text_Engines.Engine (Context'Unchecked_Access);
      Boolean         : aliased Boolean_Engines.Engine
        (Context'Unchecked_Access);
      Call_Convention : aliased Call_Convention_Engines.Engine
        (Context'Unchecked_Access);
   end record;

end Engines.Contexts;
