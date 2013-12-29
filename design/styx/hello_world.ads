with Ada.Containers.Ordered_Maps;
with Ada.Streams;

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

with League.Text_Codecs;

package Hello_World is

   --  This demo fils system containts two directory and one file:
   --  <root>/hello/world

   type Request_Handler (Output : access Ada.Streams.Root_Stream_Type'Class)
     is new Styx.Request_Visiters.Request_Visiter with private;

   procedure Initialize (Self : in out Request_Handler);

private

   type Text_Codec_Access is access League.Text_Codecs.Text_Codec;

   type Inode is (Root, Hello, World);
   --  Internal "Inode" representation

   package FID_Maps is new Ada.Containers.Ordered_Maps
     (Key_Type     => Styx.Messages.FID,
      Element_Type => Inode,
      "<"          => Styx.Messages."<");

   type Request_Handler (Output : access Ada.Streams.Root_Stream_Type'Class)
     is new Styx.Request_Visiters.Request_Visiter with
      record
         UTF_8   : Text_Codec_Access;
         Encoder : Styx.Reply_Encoders.Encoder;
         FIDs    : FID_Maps.Map;  --  list of open files/inodes
      end record;

   overriding procedure Attach
     (Self    : in out Request_Handler;
      Message : Styx.Messages.Attaches.Attach_Request);

   overriding procedure Auth
     (Self    : in out Request_Handler;
      Message : Styx.Messages.Authes.Auth_Request);

   overriding procedure Clunk
     (Self    : in out Request_Handler;
      Message : Styx.Messages.Clunks.Clunk_Request);

   overriding procedure Open
     (Self    : in out Request_Handler;
      Message : Styx.Messages.Opens.Open_Request);

   overriding procedure Read
     (Self    : in out Request_Handler;
      Message : Styx.Messages.Reads.Read_Request);

   overriding procedure Stat
     (Self    : in out Request_Handler;
      Message : Styx.Messages.Stats.Stat_Request);

   overriding procedure Version
     (Self    : in out Request_Handler;
      Message : Styx.Messages.Versions.Version_Request);

   overriding procedure Walk
     (Self    : in out Request_Handler;
      Message : Styx.Messages.WalkS.Walk_Request);

end Hello_World;
