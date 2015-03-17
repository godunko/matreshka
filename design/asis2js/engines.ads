package Engines is

   type Text_Property is
     (Code,
      Intrinsic_Name,
      Declaration_Prefix,
      Initialize
      --  Code to initialize an object of given type
     );

   type Boolean_Property is
     (Export);

   type Call_Convention_Property is
     (Call_Convention);

   type Call_Convention_Kind is
     (Intrinsic,
      JavaScript_Property_Getter,
      JavaScript_Property_Setter,
      JavaScript_Function,
      JavaScript_Getter,
      Unspecified);

end Engines;
