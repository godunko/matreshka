with Servlet.Container_Initializers;
with Servlet.Contexts;

package Initializers is

   type Server_Initializer is limited
     new Servlet.Container_Initializers.Servlet_Container_Initializer
       with null record;

   overriding procedure On_Startup
    (Self    : in out Server_Initializer;
     Context : in out Servlet.Contexts.Servlet_Context'Class) is null;

end Initializers;
