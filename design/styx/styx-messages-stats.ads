with Ada.Streams;

with League.Strings;

package Styx.Messages.Stats is

   type Stat_Request is new Request with record
      FID : Styx.Messages.FID;
   end record;

   procedure Visit
     (Visiter : in out Styx.Request_Visiters.Request_Visiter'Class;
      Value   : Stat_Request);

   type Stat_Request_Access is access all Stat_Request;

   type Stat_Reply is new Reply with record
      Value : Styx.Messages.Directory_Entry;
   end record;

   procedure Visit
     (Visiter : in out Styx.Reply_Visiters.Reply_Visiter'Class;
      Value   : Stat_Reply);

end Styx.Messages.Stats;
