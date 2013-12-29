with Styx.Messages.Attaches;
with Styx.Messages.Authes;
with Styx.Messages.Clunks;
with Styx.Messages.Opens;
with Styx.Messages.Reads;
with Styx.Messages.Stats;
with Styx.Messages.Versions;
with Styx.Messages.Walks;

package Styx.Reply_Visiters is

   type Reply_Visiter is limited interface;

   procedure Attach
     (Self    : in out Reply_Visiter;
      Message : Styx.Messages.Attaches.Attach_Reply) is abstract;

   procedure Auth
     (Self    : in out Reply_Visiter;
      Message : Styx.Messages.Authes.Auth_Reply) is abstract;

   procedure Clunk
     (Self    : in out Reply_Visiter;
      Message : Styx.Messages.Clunks.Clunk_Reply) is abstract;

   procedure Open
     (Self    : in out Reply_Visiter;
      Message : Styx.Messages.Opens.Open_Reply) is abstract;

   procedure Read
     (Self    : in out Reply_Visiter;
      Message : Styx.Messages.Reads.Read_Reply) is abstract;

   procedure Read_Directory
     (Self    : in out Reply_Visiter;
      Message : Styx.Messages.Reads.Read_Directory_Reply) is abstract;

   procedure Stat
     (Self    : in out Reply_Visiter;
      Message : Styx.Messages.Stats.Stat_Reply) is abstract;

   procedure Version
     (Self    : in out Reply_Visiter;
      Message : Styx.Messages.Versions.Version_Reply) is abstract;

   procedure Walk
     (Self    : in out Reply_Visiter;
      Message : Styx.Messages.Walks.Walk_Reply) is abstract;

end Styx.Reply_Visiters;
