with Ada.Wide_Wide_Text_IO;

with League.Strings;

with GNAT.Sockets;

with IRC.Sessions;
with IRC.Listeners;

procedure IRC_Test is
   function "+" (Text : Wide_Wide_String)
     return League.Strings.Universal_String
        renames League.Strings.To_Universal_String;

   type Listener is new IRC.Listeners.Listener with record
      Identified : Boolean := False;
   end record;

   overriding procedure On_Message
     (Self    : access Listener;
      Session : access IRC.Sessions.Session'Class;
      Target  : League.Strings.Universal_String;
      Source  : League.Strings.Universal_String;
      Text    : League.Strings.Universal_String);

   overriding procedure On_Notice
     (Self    : access Listener;
      Session : access IRC.Sessions.Session'Class;
      Target  : League.Strings.Universal_String;
      Source  : League.Strings.Universal_String;
      Text    : League.Strings.Universal_String);

   overriding procedure On_Ping
     (Self    : access Listener;
      Session : access IRC.Sessions.Session'Class;
      Source  : League.Strings.Universal_String);

   ----------------
   -- On_Message --
   ----------------

   overriding procedure On_Message
     (Self    : access Listener;
      Session : access IRC.Sessions.Session'Class;
      Target  : League.Strings.Universal_String;
      Source  : League.Strings.Universal_String;
      Text    : League.Strings.Universal_String) is
   begin
      Ada.Wide_Wide_Text_IO.Put (Source.To_Wide_Wide_String);
      Ada.Wide_Wide_Text_IO.Put (" : ");
      Ada.Wide_Wide_Text_IO.Put_Line (Text.To_Wide_Wide_String);
      Session.Send_Message (Source, Text);
   end On_Message;

   ---------------
   -- On_Notice --
   ---------------

   overriding procedure On_Notice
     (Self    : access Listener;
      Session : access IRC.Sessions.Session'Class;
      Target  : League.Strings.Universal_String;
      Source  : League.Strings.Universal_String;
      Text    : League.Strings.Universal_String) is
   begin
      if Source.Starts_With ("NickServ") and not Self.Identified then
         Ada.Wide_Wide_Text_IO.Put (Source.To_Wide_Wide_String);
         Ada.Wide_Wide_Text_IO.Put (" : ");
         Ada.Wide_Wide_Text_IO.Put_Line (Text.To_Wide_Wide_String);
         Session.Raw_Command (+"NickServ IDENTIFY password");
         Self.Identified := True;

         Session.Join (+"#ada");
      end if;
   end On_Notice;

   -------------
   -- On_Ping --
   -------------

   overriding procedure On_Ping
     (Self    : access Listener;
      Session : access IRC.Sessions.Session'Class;
      Source  : League.Strings.Universal_String) is
   begin
      Ada.Wide_Wide_Text_IO.Put_Line (Source.To_Wide_Wide_String);
      Session.Pong (Source);
   end On_Ping;

   Handler  : aliased Listener;
   Session  : IRC.Sessions.Session (Handler'Access);
   Socket   : GNAT.Sockets.Socket_Type;
   Selector : GNAT.Sockets.Selector_Type;
   Read     : GNAT.Sockets.Socket_Set_Type;
   Write    : GNAT.Sockets.Socket_Set_Type;
   Error    : GNAT.Sockets.Socket_Set_Type;
   Status   : GNAT.Sockets.Selector_Status;
begin
   Session.Connect
     (Socket    => Socket,
      Host      => +"irc.odessa.ua",
      Port      => 7777,
      Nick      => +"test",
      Password  => +"",
      User      => +"test",
      Real_Name => +"Test Name");

   GNAT.Sockets.Create_Selector (Selector);

   loop
      GNAT.Sockets.Set (Read, Socket);
      GNAT.Sockets.Set (Error, Socket);

      GNAT.Sockets.Check_Selector
        (Selector     => Selector,
         R_Socket_Set => Read,
         W_Socket_Set => Write,
         E_Socket_Set => Error,
         Status       => Status,
         Timeout      => 60.0);

      if Status in GNAT.Sockets.Completed then
         if not GNAT.Sockets.Is_Empty (Read) then
            Session.Check_Socket (Socket);
         end if;
      end if;
   end loop;
end IRC_Test;
