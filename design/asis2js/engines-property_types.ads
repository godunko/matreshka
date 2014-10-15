with League.Holders.Generic_Enumerations;

package Engines.Property_Types is

   type Call_Convention is
     (Intrinsic,
      JavaScript_Property_Getter,
      JavaScript_Property_Setter,
      JavaScript_Function,
      JavaScript_Getter,
      Unspecified);

   package Call_Convention_Holders is new
     League.Holders.Generic_Enumerations (Call_Convention);

end Engines.Property_Types;
