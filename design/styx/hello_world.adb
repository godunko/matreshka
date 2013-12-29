with Interfaces;

with League.Strings;

package body Hello_World is

   function To_QID (Node : Inode) return Styx.Messages.QID;
   function To_Dir_Entry (Node : Inode) return Styx.Messages.Directory_Entry;

   ------------
   -- Attach --
   ------------

   overriding procedure Attach
     (Self    : in out Request_Handler;
      Message : Styx.Messages.Attaches.Attach_Request)
   is
      Reply : aliased Styx.Messages.Attaches.Attach_Reply;
   begin
      Reply.Tag := Message.Tag;
      Reply.QID := To_QID (Root);
      Self.FIDs.Insert (Message.FID, Root);

      Self.Encoder.Encode (Self.Output, Reply);
   end Attach;

   ----------
   -- Auth --
   ----------

   overriding procedure Auth
     (Self    : in out Request_Handler;
      Message : Styx.Messages.Authes.Auth_Request)
   is
      Reply : aliased Styx.Messages.Authes.Auth_Reply;
   begin
      Reply.Tag := Message.Tag;

      Self.Encoder.Encode (Self.Output, Reply);
   end Auth;

   -----------
   -- Clunk --
   -----------

   overriding procedure Clunk
     (Self    : in out Request_Handler;
      Message : Styx.Messages.Clunks.Clunk_Request)
   is
      Reply : aliased Styx.Messages.Clunks.Clunk_Reply;
   begin
      Reply.Tag := Message.Tag;
      Self.FIDs.Delete (Message.FID);

      Self.Encoder.Encode (Self.Output, Reply);
   end Clunk;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Self : in out Request_Handler) is
   begin
      Self.Encoder.Initialize;

      Self.UTF_8 := new League.Text_Codecs.Text_Codec'
        (League.Text_Codecs.Codec
           (League.Strings.To_Universal_String ("utf-8")));
   end Initialize;

   ----------
   -- Open --
   ----------

   overriding procedure Open
     (Self    : in out Request_Handler;
      Message : Styx.Messages.Opens.Open_Request)
   is
      Reply : aliased Styx.Messages.Opens.Open_Reply;
      Node  : constant Inode := Self.FIDs (Message.FID);
   begin
      Reply.Tag := Message.Tag;
      Reply.QID := To_QID (Node);
      Reply.Unit := 0;

      Self.Encoder.Encode (Self.Output, Reply);
   end Open;

   ----------
   -- Read --
   ----------

   overriding procedure Read
     (Self    : in out Request_Handler;
      Message : Styx.Messages.Reads.Read_Request)
   is
      use type Interfaces.Unsigned_64;
      Node  : constant Inode := Self.FIDs (Message.FID);
   begin
      if Message.Offset /= 0 then
         declare
            Reply : aliased Styx.Messages.Reads.Read_Reply;
         begin
            Reply.Tag := Message.Tag;

            Self.Encoder.Encode (Self.Output, Reply);
            return;
         end;
      end if;

      case Node is
         when Root =>
            declare
               Reply : aliased Styx.Messages.Reads.Read_Directory_Reply (1);
            begin
               Reply.Tag := Message.Tag;

--                 Reply.Data (1) := To_Dir_Entry (Root);
               Reply.Data (1) := To_Dir_Entry (Hello);

               Self.Encoder.Encode (Self.Output, Reply);
            end;

         when Hello =>
            declare
               Reply : aliased Styx.Messages.Reads.Read_Directory_Reply (2);
            begin
               Reply.Tag := Message.Tag;

               Reply.Data (1) := To_Dir_Entry (Root);
               Reply.Data (2) := To_Dir_Entry (World);

               Self.Encoder.Encode (Self.Output, Reply);
            end;

         when World =>
            declare
               Text : constant League.Strings.Universal_String :=
                 League.Strings.To_Universal_String ("Hello World!");
               Reply : aliased Styx.Messages.Reads.Read_Reply;
            begin
               Reply.Tag := Message.Tag;
               Reply.Data.Append (Self.UTF_8.Encode (Text));

               Self.Encoder.Encode (Self.Output, Reply);
            end;
      end case;
   end Read;

   ----------
   -- Stat --
   ----------

   overriding procedure Stat
     (Self    : in out Request_Handler;
      Message : Styx.Messages.Stats.Stat_Request)
   is
      Node  : constant Inode := Self.FIDs (Message.FID);
      Reply : aliased Styx.Messages.Stats.Stat_Reply;
   begin
      Reply.Tag := Message.Tag;

      Reply.Value := To_Dir_Entry (Node);

      Self.Encoder.Encode (Self.Output, Reply);
   end Stat;

   ------------------
   -- To_Dir_Entry --
   ------------------

   function To_Dir_Entry (Node : Inode) return Styx.Messages.Directory_Entry is
   begin
      case Node is
         when Root =>
            return
              (Dir_Type    => 0,
               Dev         => 0,
               QID         => To_QID (Root),
               Mode        => 16#80_00_43_FF#,
               Access_Time => <>,
               Change_Time => <>,
               Length      => 16#36#,
               Name        => League.Strings.To_Universal_String (".."),
               Owner       => League.Strings.To_Universal_String ("max"),
               Group       => League.Strings.To_Universal_String ("users"),
               Changed     => League.Strings.To_Universal_String ("max"));
         when Hello =>
            return
              (Dir_Type    => 0,
               Dev         => 0,
               QID         => To_QID (Hello),
               Mode        => 16#80_00_43_FF#,
               Access_Time => <>,
               Change_Time => <>,
               Length      => 16#3c#,
               Name        => League.Strings.To_Universal_String ("hello"),
               Owner       => League.Strings.To_Universal_String ("max"),
               Group       => League.Strings.To_Universal_String ("users"),
               Changed     => League.Strings.To_Universal_String ("max"));

         when World =>
            return
              (Dir_Type    => 0,
               Dev         => 0,
               QID         => To_QID (World),
               Mode        => 8#00_04_17_77#,
               Access_Time => <>,
               Change_Time => <>,
               Length      => 12,
               Name        => League.Strings.To_Universal_String ("world"),
               Owner       => League.Strings.To_Universal_String ("max"),
               Group       => League.Strings.To_Universal_String ("users"),
               Changed     => League.Strings.To_Universal_String ("max"));

      end case;
   end To_Dir_Entry;

   ------------
   -- To_QID --
   ------------

   function To_QID (Node : Inode) return Styx.Messages.QID is
   begin
      case Node is
         when Root =>
            return (Styx.Messages.Directory, 0, 1);
         when Hello =>
            return (Styx.Messages.Directory, 0, 2);
         when World =>
            return (Styx.Messages.Normal, 0, 3);
      end case;
   end To_QID;

   -------------
   -- Version --
   -------------

   overriding procedure Version
     (Self    : in out Request_Handler;
      Message : Styx.Messages.Versions.Version_Request)
   is
      Reply : aliased Styx.Messages.Versions.Version_Reply;
   begin
      --   Self.MSize := Message.MSize;

      Reply := (Tag => Message.Tag,
                MSize => Message.MSize,
                Version => League.Strings.To_Universal_String ("9P2000"));

      Self.Encoder.Encode (Self.Output, Reply);
   end Version;

   ----------
   -- Walk --
   ----------

   overriding procedure Walk
     (Self    : in out Request_Handler;
      Message : Styx.Messages.WalkS.Walk_Request)
   is
      use type League.Strings.Universal_String;

      Reply    : aliased Styx.Messages.Walks.Walk_Reply (Message.Names.Length);
      Node     : Inode := Self.FIDs (Message.FID);
      New_Node : Inode := Node;
   begin
      Reply.Tag := Message.Tag;

      for J in 1 .. Message.Names.Length loop
         case Node is
            when Root =>
               if Message.Names.Element (J) =
                 League.Strings.To_Universal_String ("hello")
               then
                  New_Node := Hello;
               elsif Message.Names.Element (J) =
                 League.Strings.To_Universal_String ("..")
               then
                  New_Node := Root;
               else
                  raise Constraint_Error;
               end if;
            when Hello =>
               if Message.Names.Element (J) =
                 League.Strings.To_Universal_String ("world")
               then
                  New_Node := World;
               elsif Message.Names.Element (J) =
                 League.Strings.To_Universal_String ("..")
               then
                  New_Node := Root;
               else
                  raise Constraint_Error;
               end if;
            when World =>
               raise Constraint_Error;
         end case;

         Reply.List (J) := To_QID (New_Node);
      end loop;

      Self.FIDs.Insert (Message.New_FID, New_Node);

      Self.Encoder.Encode (Self.Output, Reply);
   end Walk;

end Hello_World;

