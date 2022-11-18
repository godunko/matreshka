with Spikedog.HTTP_Session_Managers;

with AWFC.Accounts.Password_Managers;

package Forum.Forums.Servers is

   type Password_Manager_Access is
     access all AWFC.Accounts.Password_Managers.Password_Manager'Class;

   type Server_Forum is new Forum with record
      Password_Manager : Password_Manager_Access;
   end record;

   procedure Initialize
    (Self    : in out Server_Forum'Class;
     Driver  : League.Strings.Universal_String;
     Options : SQL.Options.SQL_Options);

   function Get_HTTP_Session_Manager
    (Self : Server_Forum'Class)
       return
         not null Spikedog.HTTP_Session_Managers.HTTP_Session_Manager_Access;

end Forum.Forums.Servers;
