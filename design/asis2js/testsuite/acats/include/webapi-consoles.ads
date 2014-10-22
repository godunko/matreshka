package WebAPI.Consoles is

   type Console_Type is limited interface;

   type Console_Access is access all Console_Type'Class
     with Storage_Size => 0;

   not overriding procedure Log
     (Self : not null access Console_Type;
      Text : String) is abstract
        with Import     => True,
             Convention => JavaScript_Function,
             Link_Name  => "log";

   Console : constant WebAPI.Consoles.Console_Access
     with Import     => True,
          Convention => JavaScript;

end WebAPI.Consoles;
