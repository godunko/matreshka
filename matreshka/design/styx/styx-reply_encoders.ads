with Ada.Streams;

with League.Text_Codecs;
with League.Strings;
with League.Stream_Element_Vectors;

with Styx.Messages;
with Styx.Messages.Attaches;
with Styx.Messages.Authes;
with Styx.Messages.Clunks;
with Styx.Messages.Opens;
with Styx.Messages.Reads;
with Styx.Messages.Stats;
with Styx.Messages.Versions;
with Styx.Messages.Walks;
with Styx.Reply_Visiters;
with Interfaces;

package Styx.Reply_Encoders is

   type Encoder is new Styx.Reply_Visiters.Reply_Visiter with private;

   procedure Initialize (Self : in out Encoder);

   procedure Encode
     (Self    : in out Encoder;
      Stream  : access Ada.Streams.Root_Stream_Type'Class;
      Command : Styx.Messages.Reply'Class);

private

   type Text_Codec_Access is access League.Text_Codecs.Text_Codec;

   type Encoder is new Styx.Reply_Visiters.Reply_Visiter with record
      UTF_8  : Text_Codec_Access;
      Output : League.Stream_Element_Vectors.Stream_Element_Vector;
   end record;

   not overriding procedure Write_8
     (Self  : in out Encoder;
      Value : Interfaces.Unsigned_8);

   not overriding procedure Write_16
     (Self  : in out Encoder;
      Value : Interfaces.Unsigned_16);

   not overriding procedure Write_32
     (Self  : in out Encoder;
      Value : Interfaces.Unsigned_32);

   not overriding procedure Write_64
     (Self  : in out Encoder;
      Value : Interfaces.Unsigned_64);

   not overriding procedure Write
     (Self  : in out Encoder;
      QID   : Styx.Messages.QID);

   not overriding procedure Write
     (Self  : in out Encoder;
      Value : League.Strings.Universal_String);

   not overriding procedure Write
     (Self  : in out Encoder;
      Value : Styx.Messages.Directory_Entry);

   overriding procedure Attach
     (Self    : in out Encoder;
      Message : Styx.Messages.Attaches.Attach_Reply);

   overriding procedure Auth
     (Self    : in out Encoder;
      Message : Styx.Messages.Authes.Auth_Reply);

   overriding procedure Clunk
     (Self    : in out Encoder;
      Message : Styx.Messages.Clunks.Clunk_Reply);

   overriding procedure Open
     (Self    : in out Encoder;
      Message : Styx.Messages.Opens.Open_Reply);

   overriding procedure Read
     (Self    : in out Encoder;
      Message : Styx.Messages.Reads.Read_Reply);

   overriding procedure Read_Directory
     (Self    : in out Encoder;
      Message : Styx.Messages.Reads.Read_Directory_Reply);

   overriding procedure Stat
     (Self    : in out Encoder;
      Message : Styx.Messages.Stats.Stat_Reply);

   overriding procedure Version
     (Self    : in out Encoder;
      Message : Styx.Messages.Versions.Version_Reply);

   overriding procedure Walk
     (Self    : in out Encoder;
      Message : Styx.Messages.Walks.Walk_Reply);

end Styx.Reply_Encoders;
