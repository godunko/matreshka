with League.Holders.Generic_Enumerations;

package Engines.Property_Types is

   type Call_Convention is
     (Intrinsic,
      JavaScript_Getter,
      JavaScript_Setter,
      JavaScript_Function,
      Unspecified);

   package Call_Convention_Holders is new
     League.Holders.Generic_Enumerations (Call_Convention);

end Engines.Property_Types;
