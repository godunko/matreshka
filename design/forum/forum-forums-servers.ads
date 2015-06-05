with Spikedog.HTTP_Session_Managers;

package Forum.Forums.Servers is

   type Server_Forum is new Forum with null record;

   procedure Initialize
    (Self    : in out Server_Forum'Class;
     Driver  : League.Strings.Universal_String;
     Options : SQL.Options.SQL_Options);

   function Get_HTTP_Session_Manager
    (Self : Server_Forum'Class)
       return
         not null Spikedog.HTTP_Session_Managers.HTTP_Session_Manager_Access;

end Forum.Forums.Servers;
