with Ada.Streams;

with League.Strings;

package Styx.Messages.Versions is

   type Version_Request is new Request with record
      MSize   : Size;
      Version : League.Strings.Universal_String;
   end record;

   procedure Visit
     (Visiter : in out Styx.Request_Visiters.Request_Visiter'Class;
      Value   : Version_Request);

   type Version_Request_Access is access all Version_Request;

   type Version_Reply is new Reply with record
      MSize   : Size;
      Version : League.Strings.Universal_String;
   end record;

   procedure Visit
     (Visiter : in out Styx.Reply_Visiters.Reply_Visiter'Class;
      Value   : Version_Reply);

end Styx.Messages.Versions;
