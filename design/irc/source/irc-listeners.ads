with League.Strings;

limited with IRC.Sessions;

package IRC.Listeners is

   type Listener is limited interface;
   --  This type gets notification about events received by Session

   not overriding procedure On_Message
     (Self    : access Listener;
      Session : access IRC.Sessions.Session'Class;
      Target  : League.Strings.Universal_String;
      Source  : League.Strings.Universal_String;
      Text    : League.Strings.Universal_String) is null;
   --  Notification on new message

   not overriding procedure On_Notice
     (Self    : access Listener;
      Session : access IRC.Sessions.Session'Class;
      Target  : League.Strings.Universal_String;
      Source  : League.Strings.Universal_String;
      Text    : League.Strings.Universal_String) is null;
   --  Notification on new message

   not overriding procedure On_Ping
     (Self    : access Listener;
      Session : access IRC.Sessions.Session'Class;
      Source  : League.Strings.Universal_String) is null;
   --  Notification on ping request

end IRC.Listeners;
