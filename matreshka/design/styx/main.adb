with Ada.Text_IO;
with Ada.Streams.Stream_IO.C_Streams;
with Interfaces.C_Streams;
with GNAT.Sockets;

with League.Strings;

with Styx.Debug;
with Styx.Request_Decoders;
with Styx.Reply_Encoders;
with Styx.Request_Visiters;
with Styx.Messages.Attaches;
with Styx.Messages.Authes;
with Styx.Messages.Clunks;
with Styx.Messages.Opens;
with Styx.Messages.Reads;
with Styx.Messages.Stats;
with Styx.Messages.Versions;
with Styx.Messages.Walks;

with Hello_World;

procedure Main is

   Address  : GNAT.Sockets.Sock_Addr_Type;
   Server   : GNAT.Sockets.Socket_Type;
   Socket   : GNAT.Sockets.Socket_Type;
   Input    : GNAT.Sockets.Stream_Access;
   Decoder  : Styx.Request_Decoders.Decoder;
   Debug    : Styx.Debug.Request_Debuger;
   Cmd      : Styx.Messages.Request_Access;
   Ok       : Boolean;
begin
   Ada.Text_IO.Put_Line (Ada.Text_IO.Standard_Error, "Started. Try:");
   Ada.Text_IO.Put_Line
     (Ada.Text_IO.Standard_Error,
      "mount -t 9p 127.0.0.1 /mnt/bt/ -oport=11111");

   Decoder.Initialize;

   GNAT.Sockets.Create_Socket (Server);
--     Address.Port := 564;
   Address.Port := 11111;
   GNAT.Sockets.Bind_Socket (Server, Address);
   GNAT.Sockets.Listen_Socket (Server);
   GNAT.Sockets.Accept_Socket (Server, Socket, Address);
   Ada.Text_IO.Put_Line (Ada.Text_IO.Standard_Error, "Accept_Socket");

   Input := GNAT.Sockets.Stream (Socket);

   declare
      Handler : Hello_World.Request_Handler (Input);
   begin
      Handler.Initialize;

      loop
         Decoder.Decode (Input, Cmd, Ok);
         exit when not Ok;
         Styx.Messages.Visit (Debug, Cmd.all);
         Styx.Messages.Visit (Handler, Cmd.all);
      end loop;
   end;
end Main;
