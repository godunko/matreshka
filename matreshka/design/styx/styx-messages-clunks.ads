with Ada.Streams;

with League.Strings;

package Styx.Messages.Clunks is

   type Clunk_Request is new Request with record
      FID : Styx.Messages.FID;
   end record;

   procedure Visit
     (Visiter : in out Styx.Request_Visiters.Request_Visiter'Class;
      Value   : Clunk_Request);

   type Clunk_Request_Access is access all Clunk_Request;

   type Clunk_Reply is new Reply with record
      null;
   end record;

   procedure Visit
     (Visiter : in out Styx.Reply_Visiters.Reply_Visiter'Class;
      Value   : Clunk_Reply);

end Styx.Messages.Clunks;
