with OPM.Stores;

with Security.Users.Stores;
with Server.Sessions.Controller;

package body Forum.Forums.Servers is

   ------------------------------
   -- Get_HTTP_Session_Manager --
   ------------------------------

   function Get_HTTP_Session_Manager
    (Self : Server_Forum'Class)
       return
         not null Spikedog.HTTP_Session_Managers.HTTP_Session_Manager_Access is
   begin
      return
        Spikedog.HTTP_Session_Managers.HTTP_Session_Manager_Access
         (Self.Engine.Get_Store (Server.Sessions.Session'Tag));
   end Get_HTTP_Session_Manager;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
    (Self    : in out Server_Forum'Class;
     Driver  : League.Strings.Universal_String;
     Options : SQL.Options.SQL_Options)
   is
      Aux : OPM.Stores.Store_Access;

   begin
      Standard.Forum.Forums.Initialize (Self, Driver, Options);

      Aux :=
        new Server.Sessions.Controller.Session_Manager
             (Self.Engine'Unchecked_Access);
      Aux.Initialize;

      Aux :=
        new Security.Users.Stores.User_Store (Self.Engine'Unchecked_Access);
      Aux.Initialize;
   end Initialize;

end Forum.Forums.Servers;
