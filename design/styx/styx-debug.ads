with Styx.Messages.Attaches;
with Styx.Messages.Authes;
with Styx.Messages.Clunks;
with Styx.Messages.Opens;
with Styx.Messages.Reads;
with Styx.Messages.Stats;
with Styx.Messages.Versions;
with Styx.Messages.Walks;
with Styx.Request_Visiters;

package Styx.Debug is

   type Request_Debuger is
     new Styx.Request_Visiters.Request_Visiter with private;

private

   type Request_Debuger is
     new Styx.Request_Visiters.Request_Visiter with null record;

   overriding procedure Attach
     (Self    : in out Request_Debuger;
      Message : Styx.Messages.Attaches.Attach_Request);

   overriding procedure Auth
     (Self    : in out Request_Debuger;
      Message : Styx.Messages.Authes.Auth_Request);

   overriding procedure Clunk
     (Self    : in out Request_Debuger;
      Message : Styx.Messages.Clunks.Clunk_Request);

   overriding procedure Open
     (Self    : in out Request_Debuger;
      Message : Styx.Messages.Opens.Open_Request);

   overriding procedure Read
     (Self    : in out Request_Debuger;
      Message : Styx.Messages.Reads.Read_Request);

   overriding procedure Stat
     (Self    : in out Request_Debuger;
      Message : Styx.Messages.Stats.Stat_Request);

   overriding procedure Version
     (Self    : in out Request_Debuger;
      Message : Styx.Messages.Versions.Version_Request);

   overriding procedure Walk
     (Self    : in out Request_Debuger;
      Message : Styx.Messages.WalkS.Walk_Request);
end Styx.Debug;
