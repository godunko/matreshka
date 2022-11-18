
package Hello_WebGL is

   procedure Run_Application
     with Export        => True,
          Convention    => JavaScript_Function,
          External_Name => "runApplication";

end Hello_WebGL;
