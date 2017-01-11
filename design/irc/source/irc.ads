with League.Text_Codecs;
with League.Strings;
with League.Stream_Element_Vectors;

with GNAT.Sockets;

package IRC is

   type Session is tagged;
   type Listener is limited interface;
   --  This type gets notification about events received by Session

   not overriding procedure On_Message
     (Self    : access Listener;
      Session : access IRC.Session'Class;
      Target  : League.Strings.Universal_String;
      Source  : League.Strings.Universal_String;
      Text    : League.Strings.Universal_String) is abstract;
   --  Notification on new message

   not overriding procedure On_Ping
     (Self    : access Listener;
      Session : access IRC.Session'Class;
      Source  : League.Strings.Universal_String) is abstract;
   --  Notification on ping request

   type Session (Listener : access IRC.Listener'Class) is
     tagged limited private;

   not overriding procedure Connect
     (Self      : in out Session;
      Socket    : out GNAT.Sockets.Socket_Type;
      Host      : League.Strings.Universal_String;
      Port      : GNAT.Sockets.Port_Type;
      Nick      : League.Strings.Universal_String;
      Password  : League.Strings.Universal_String;
      User      : League.Strings.Universal_String;
      Real_Name : League.Strings.Universal_String);
   --  Initialize new session with given IRC server:port. Return Socket
   --  to monitor input/output data.

   not overriding procedure Send_Message
     (Self   : in out Session;
      Target : League.Strings.Universal_String;
      Text   : League.Strings.Universal_String);
   --  Request sending new message

   not overriding procedure Pong
     (Self   : in out Session;
      Target : League.Strings.Universal_String);
   --  Send Pong reply

   not overriding procedure Join
     (Self    : in out Session;
      Channel : League.Strings.Universal_String);
   --  Request joining given channel

   not overriding procedure Check_Socket
     (Self   : in out Session;
      Socket : GNAT.Sockets.Socket_Type);
   --  This procedure called by driver when socket changes its state

private

   function "+" (Text : Wide_Wide_String)
     return League.Strings.Universal_String
        renames League.Strings.To_Universal_String;

   type Session (Listener : access IRC.Listener'Class) is tagged limited record
      Socket   : GNAT.Sockets.Socket_Type;
      Vector   : League.Stream_Element_Vectors.Stream_Element_Vector;
      Codec    : access League.Text_Codecs.Text_Codec :=
        new League.Text_Codecs.Text_Codec
          '(League.Text_Codecs.Codec (+"UTF-8"));
   end record;

end IRC;
