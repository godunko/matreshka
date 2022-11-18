with Styx.Messages.Attaches;
with Styx.Messages.Authes;
with Styx.Messages.Clunks;
with Styx.Messages.Opens;
with Styx.Messages.Reads;
with Styx.Messages.Stats;
with Styx.Messages.Versions;
with Styx.Messages.Walks;

package Styx.Request_Visiters is

   type Request_Visiter is limited interface;

   procedure Attach
     (Self    : in out Request_Visiter;
      Message : Styx.Messages.Attaches.Attach_Request) is abstract;

   procedure Auth
     (Self    : in out Request_Visiter;
      Message : Styx.Messages.Authes.Auth_Request) is abstract;

   procedure Clunk
     (Self    : in out Request_Visiter;
      Message : Styx.Messages.Clunks.Clunk_Request) is abstract;

   procedure Open
     (Self    : in out Request_Visiter;
      Message : Styx.Messages.Opens.Open_Request) is abstract;

   procedure Read
     (Self    : in out Request_Visiter;
      Message : Styx.Messages.Reads.Read_Request) is abstract;

   procedure Stat
     (Self    : in out Request_Visiter;
      Message : Styx.Messages.Stats.Stat_Request) is abstract;

   procedure Version
     (Self    : in out Request_Visiter;
      Message : Styx.Messages.Versions.Version_Request) is abstract;

   procedure Walk
     (Self    : in out Request_Visiter;
      Message : Styx.Messages.WalkS.Walk_Request) is abstract;

end Styx.Request_Visiters;
