with Ada.Streams;

with League.Text_Codecs;

with Styx.Messages;

package Styx.Request_Decoders is

   type Text_Codec_Access is access League.Text_Codecs.Text_Codec;

   type Decoder is tagged record
      UTF_8 : Text_Codec_Access;
   end record;

   procedure Initialize (Self : in out Decoder);

   procedure Decode
     (Self    : Decoder;
      Stream  : access Ada.Streams.Root_Stream_Type'Class;
      Command : out Styx.Messages.Request_Access;
      Success : out Boolean);

end Styx.Request_Decoders;
