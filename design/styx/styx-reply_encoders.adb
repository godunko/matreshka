with League.Strings;

package body Styx.Reply_Encoders is

   subtype Stream_Element_Array_4 is Ada.Streams.Stream_Element_Array (0 .. 3);

   procedure Write_32
     (Value : Interfaces.Unsigned_32;
      Data  : out Stream_Element_Array_4);

   ------------
   -- Attach --
   ------------

   overriding procedure Attach
     (Self    : in out Encoder;
      Message : Styx.Messages.Attaches.Attach_Reply) is
   begin
      Self.Write_32 (0);
      Self.Write_8 (Interfaces.Unsigned_8'(105));
      Self.Write_16 (Interfaces.Unsigned_16 (Message.Tag));
      Self.Write (Message.QID);
   end Attach;

   ----------
   -- Auth --
   ----------

   overriding procedure Auth
     (Self    : in out Encoder;
      Message : Styx.Messages.Authes.Auth_Reply)
   is
   begin
      Self.Write_32 (0);
      Self.Write_8 (Interfaces.Unsigned_8'(103));
      Self.Write_16 (Interfaces.Unsigned_16 (Message.Tag));
      Self.Write (Message.Auth_QID);
   end Auth;

   -----------
   -- Clunk --
   -----------

   overriding procedure Clunk
     (Self    : in out Encoder;
      Message : Styx.Messages.Clunks.Clunk_Reply) is
   begin
      Self.Write_32 (0);
      Self.Write_8 (Interfaces.Unsigned_8'(121));
      Self.Write_16 (Interfaces.Unsigned_16 (Message.Tag));
   end Clunk;

   ------------
   -- Encode --
   ------------

   procedure Encode
     (Self    : in out Encoder;
      Stream  : access Ada.Streams.Root_Stream_Type'Class;
      Command : Styx.Messages.Reply'Class)
   is
   begin
      Styx.Messages.Visit (Self, Command);

      declare
         Data : Ada.Streams.Stream_Element_Array :=
           Self.Output.To_Stream_Element_Array;
      begin
         Write_32 (Data'Length, Data (0 .. 3));
         Ada.Streams.Write (Stream.all, Data);
         Self.Output.Clear;
      end;
   end Encode;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Self : in out Encoder) is
   begin
      Self.UTF_8 := new League.Text_Codecs.Text_Codec'
        (League.Text_Codecs.Codec
           (League.Strings.To_Universal_String ("utf-8")));
   end Initialize;

   ----------
   -- Open --
   ----------

   overriding procedure Open
     (Self    : in out Encoder;
      Message : Styx.Messages.Opens.Open_Reply) is
   begin
      Self.Write_32 (0);
      Self.Write_8 (Interfaces.Unsigned_8'(113));
      Self.Write_16 (Interfaces.Unsigned_16 (Message.Tag));
      Self.Write (Message.QID);
      Self.Write_32 (Interfaces.Unsigned_32 (Message.Unit));
   end Open;

   ----------
   -- Read --
   ----------

   overriding procedure Read
     (Self    : in out Encoder;
      Message : Styx.Messages.Reads.Read_Reply) is
   begin
      Self.Write_32 (0);
      Self.Write_8 (Interfaces.Unsigned_8'(117));
      Self.Write_16 (Interfaces.Unsigned_16 (Message.Tag));
      Self.Write_32 (Interfaces.Unsigned_32 (Message.Data.Length));
      Self.Output.Append (Message.Data);
   end Read;

   overriding procedure Read_Directory
     (Self    : in out Encoder;
      Message : Styx.Messages.Reads.Read_Directory_Reply)
   is
      Temp : League.Stream_Element_Vectors.Stream_Element_Vector;
   begin
      for J in 1 .. Message.Count loop
         Self.Write (Message.Data (J));
      end loop;

      Temp := Self.Output;
      Self.Output.Clear;

      Self.Write_32 (0);
      Self.Write_8 (Interfaces.Unsigned_8'(117));
      Self.Write_16 (Interfaces.Unsigned_16 (Message.Tag));
      Self.Write_32 (Interfaces.Unsigned_32 (Temp.Length));
      Self.Output.Append (Temp);
   end Read_Directory;


   ----------
   -- Stat --
   ----------

   overriding procedure Stat
     (Self    : in out Encoder;
      Message : Styx.Messages.Stats.Stat_Reply)
   is
      Temp : League.Stream_Element_Vectors.Stream_Element_Vector;
   begin
      Self.Write (Message.Value);

      Temp := Self.Output;
      Self.Output.Clear;

      Self.Write_32 (0);
      Self.Write_8 (Interfaces.Unsigned_8'(125));
      Self.Write_16 (Interfaces.Unsigned_16 (Message.Tag));
      Self.Write_16 (Interfaces.Unsigned_16 (Temp.Length));
      Self.Output.Append (Temp);
   end Stat;

   -------------
   -- Version --
   -------------

   overriding procedure Version
     (Self    : in out Encoder;
      Message : Styx.Messages.Versions.Version_Reply)
   is
   begin
      Self.Write_32 (0);
      Self.Write_8 (Interfaces.Unsigned_8'(101));
      Self.Write_16 (Interfaces.Unsigned_16 (Message.Tag));
      Self.Write_32 (Interfaces.Unsigned_32 (Message.MSize));
      Self.Write (Message.Version);
   end Version;

   ----------
   -- Walk --
   ----------

   overriding procedure Walk
     (Self    : in out Encoder;
      Message : Styx.Messages.Walks.Walk_Reply) is
   begin
      Self.Write_32 (0);
      Self.Write_8 (Interfaces.Unsigned_8'(111));
      Self.Write_16 (Interfaces.Unsigned_16 (Message.Tag));
      Self.Write_16 (Interfaces.Unsigned_16 (Message.Count));

      for J in Message.List'Range loop
         Self.Write (Message.List (J));
      end loop;
   end Walk;

   -----------
   -- Write --
   -----------

   not overriding procedure Write_8
     (Self  : in out Encoder;
      Value : Interfaces.Unsigned_8) is
   begin
      Self.Output.Append (Ada.Streams.Stream_Element (Value));
   end Write_8;

   --------------
   -- Write_16 --
   --------------

   not overriding procedure Write_16
     (Self  : in out Encoder;
      Value : Interfaces.Unsigned_16)
   is
      use type Interfaces.Unsigned_16;
      Data : Ada.Streams.Stream_Element_Array (1 .. 2);
      X : Interfaces.Unsigned_16 := Value;
   begin
      for J in Data'Range loop
         Data (J) := Ada.Streams.Stream_Element (X and 16#FF#);
         X := Interfaces.Shift_Right (X, Ada.Streams.Stream_Element'Size);
      end loop;

      Self.Output.Append (Data);
   end Write_16;

   -----------
   -- Write --
   -----------

   not overriding procedure Write_32
     (Self  : in out Encoder;
      Value : Interfaces.Unsigned_32)
   is
      Data : Stream_Element_Array_4;
   begin
      Write_32 (Value, Data);
      Self.Output.Append (Data);
   end Write_32;

   --------------
   -- Write_32 --
   --------------

   procedure Write_32
     (Value : Interfaces.Unsigned_32;
      Data  : out Stream_Element_Array_4)
   is
      use type Interfaces.Unsigned_32;
      X : Interfaces.Unsigned_32 := Value;
   begin
      for J in Data'Range loop
         Data (J) := Ada.Streams.Stream_Element (X and 16#FF#);
         X := Interfaces.Shift_Right (X, Ada.Streams.Stream_Element'Size);
      end loop;
   end Write_32;

   -----------
   -- Write --
   -----------

   not overriding procedure Write_64
     (Self  : in out Encoder;
      Value : Interfaces.Unsigned_64)
   is
      use type Interfaces.Unsigned_64;
      Data : Ada.Streams.Stream_Element_Array (1 .. 8);
      X : Interfaces.Unsigned_64 := Value;
   begin
      for J in Data'Range loop
         Data (J) := Ada.Streams.Stream_Element (X and 16#FF#);
         X := Interfaces.Shift_Right (X, Ada.Streams.Stream_Element'Size);
      end loop;

      Self.Output.Append (Data);
   end Write_64;

   -----------
   -- Write --
   -----------

   not overriding procedure Write
     (Self  : in out Encoder;
      QID   : Styx.Messages.QID) is
   begin
      Self.Write_8 (QID.Kind);
      Self.Write_32 (QID.Version);
      Self.Write_64 (QID.Path);
   end Write;

   -----------
   -- Write --
   -----------

   not overriding procedure Write
     (Self  : in out Encoder;
      Value : League.Strings.Universal_String)
   is
      Data : League.Stream_Element_Vectors.Stream_Element_Vector :=
        Self.UTF_8.Encode (Value);
   begin
      Self.Write_16 (Interfaces.Unsigned_16 (Data.Length));

      for J in 1 .. Data.Length loop
         Self.Write_8 (Interfaces.Unsigned_8 (Data.Element (J)));
      end loop;
   end Write;

   -----------
   -- Write --
   -----------

   not overriding procedure Write
     (Self  : in out Encoder;
      Value : Styx.Messages.Directory_Entry)
   is
      use type Ada.Streams.Stream_Element_Count;

      Temp : League.Stream_Element_Vectors.Stream_Element_Vector;
      Save : League.Stream_Element_Vectors.Stream_Element_Vector :=
        Self.Output;
   begin
      Self.Output.Clear;
      Self.Write_16 (Value.Dir_Type);
      Self.Write_32 (Value.Dev);
      Self.Write (Value.QID);
      Self.Write_32 (Value.Mode);
      Self.Write_32 (0);
      Self.Write_32 (0);
      Self.Write_64 (Value.Length);
      Self.Write (Value.Name);
      Self.Write (Value.Owner);
      Self.Write (Value.Group);
      Self.Write (Value.Changed);

      Temp := Self.Output;
      Self.Output := Save;
      Self.Write_16 (Interfaces.Unsigned_16 (Temp.Length));
      Self.Output.Append (Temp);
   end Write;

end Styx.Reply_Encoders;
