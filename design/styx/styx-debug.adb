with Ada.Text_IO;

package body Styx.Debug is

   ------------
   -- Attach --
   ------------

   overriding procedure Attach
     (Self    : in out Request_Debuger;
      Message : Styx.Messages.Attaches.Attach_Request) is
   begin
      Ada.Text_IO.Put_Line ("<<Attach>>");
      Ada.Text_IO.Put_Line ("FID: " & Message.FID'Img);
      Ada.Text_IO.Put_Line ("User: "& Message.User.To_UTF_8_String);
      Ada.Text_IO.Put_Line ("Tree: "& Message.Tree.To_UTF_8_String);
   end Attach;

   ----------
   -- Auth --
   ----------

   overriding procedure Auth
     (Self    : in out Request_Debuger;
      Message : Styx.Messages.Authes.Auth_Request) is
   begin
      Ada.Text_IO.Put_Line ("<<Auth>>");
      Ada.Text_IO.Put_Line ("FID: " & Message.Auth_FID'Img);
      Ada.Text_IO.Put_Line ("User: "& Message.User.To_UTF_8_String);
      Ada.Text_IO.Put_Line ("Tree: "& Message.Tree.To_UTF_8_String);
   end Auth;

   -----------
   -- Clunk --
   -----------

   overriding procedure Clunk
     (Self    : in out Request_Debuger;
      Message : Styx.Messages.Clunks.Clunk_Request) is
   begin
      Ada.Text_IO.Put_Line ("<<Clunk>>");
      Ada.Text_IO.Put_Line ("FID: " & Message.FID'Img);
   end Clunk;

   ----------
   -- Open --
   ----------

   overriding procedure Open
     (Self    : in out Request_Debuger;
      Message : Styx.Messages.Opens.Open_Request) is
   begin
      Ada.Text_IO.Put_Line ("<<Open>>");
      Ada.Text_IO.Put_Line ("FID: " & Message.FID'Img);
   end Open;

   ----------
   -- Read --
   ----------

   overriding procedure Read
     (Self    : in out Request_Debuger;
      Message : Styx.Messages.Reads.Read_Request) is
   begin
      Ada.Text_IO.Put_Line ("<<Read>>");
      Ada.Text_IO.Put_Line ("FID: " & Message.FID'Img);
      Ada.Text_IO.Put_Line ("Offset: " & Message.Offset'Img);
      Ada.Text_IO.Put_Line ("Count: " & Message.Count'Img);
   end Read;

   ----------
   -- Stat --
   ----------

   overriding procedure Stat
     (Self    : in out Request_Debuger;
      Message : Styx.Messages.Stats.Stat_Request) is
   begin
      Ada.Text_IO.Put_Line ("<<Stat>>");
      Ada.Text_IO.Put_Line ("FID: " & Message.FID'Img);
   end Stat;

   -------------
   -- Version --
   -------------

   overriding procedure Version
     (Self    : in out Request_Debuger;
      Message : Styx.Messages.Versions.Version_Request)
   is
   begin
      Ada.Text_IO.Put_Line ("<<Version>>");
      Ada.Text_IO.Put_Line ("Tag: " & Message.Tag'Img);
      Ada.Text_IO.Put_Line ("MSize: " & Message.MSize'Img);
      Ada.Text_IO.Put_Line ("Version: "& Message.Version.To_UTF_8_String);
   end Version;

   ----------
   -- Walk --
   ----------

   overriding procedure Walk
     (Self    : in out Request_Debuger;
      Message : Styx.Messages.WalkS.Walk_Request)
   is
   begin
      Ada.Text_IO.Put_Line ("<<Walk>>");
      Ada.Text_IO.Put_Line ("Tag: " & Message.Tag'Img);
      Ada.Text_IO.Put_Line ("FID: " & Message.FID'Img);
      Ada.Text_IO.Put_Line ("New_FID: " & Message.New_FID'Img);

      for J in 1 .. Message.Names.Length loop
         Ada.Text_IO.Put_Line
           ("Name: " & Message.Names.Element (J).To_UTF_8_String);
      end loop;
   end Walk;

end Styx.Debug;
