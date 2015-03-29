package Engines is

   type Text_Property is
     (Code,
      Intrinsic_Name,
      Initialize
      --  Code to initialize an object of given type
     );

   type Boolean_Property is
     (Export,
      Is_Simple_Type,   --  Is non-object type (Number, Boolean, etc)
      Is_Simple_Ref,    --  Wrapper for non-object type (Number, Boolean, etc)
      Inside_Package,   --  Enclosing Element is a package
      Is_Dispatching);  --  Declaration/call is a dispatching subprogram

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
