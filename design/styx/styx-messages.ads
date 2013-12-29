--  Root type for 9P messages

with Ada.Streams;
with Interfaces;

with League.Strings;
with League.Calendars;

limited with Styx.Request_Visiters;
limited with Styx.Reply_Visiters;

package Styx.Messages is

   type Size is mod 2 ** 32;

   type Message_Tag is mod 2 ** 16;

   type Byte_Count is mod 2 ** 16;

   type FID is mod 2 ** 32;

   type QID is record
      Kind    : Interfaces.Unsigned_8;
      Version : Interfaces.Unsigned_32;
      Path    : Interfaces.Unsigned_64;
   end record;

   Directory      : constant Interfaces.Unsigned_8 := 16#80#;
   --  type bit for directories
   Append_Only    : constant Interfaces.Unsigned_8 := 16#40#;
   --  type bit for append only files
   Exclusive      : constant Interfaces.Unsigned_8 := 16#20#;
   --  type bit for exclusive use files
   Mount          : constant Interfaces.Unsigned_8 := 16#10#;
   --  type bit for mounted channel
   Authentication : constant Interfaces.Unsigned_8 := 16#08#;
   --  type bit for authentication file
   Temporary      : constant Interfaces.Unsigned_8 := 16#04#;
   --  type bit for non-backed-up file
   Symbolic_Link  : constant Interfaces.Unsigned_8 := 16#02#;
   --  type bit for symbolic link
   Link           : constant Interfaces.Unsigned_8 := 16#01#;
   --  type bit for hard link
   Normal         : constant Interfaces.Unsigned_8 := 16#00#;
   --  type bits for plain file

   type Directory_Entry is record
      Dir_Type    : Interfaces.Unsigned_16;
      Dev         : Interfaces.Unsigned_32;
      QID         : Styx.Messages.QID;
      Mode        : Interfaces.Unsigned_32;
      Access_Time : League.Calendars.Date_Time;
      Change_Time : League.Calendars.Date_Time;
      Length      : Interfaces.Unsigned_64;
      Name        : League.Strings.Universal_String;
      Owner       : League.Strings.Universal_String;
      Group       : League.Strings.Universal_String;
      Changed     : League.Strings.Universal_String;
   end record;

   type Request is abstract tagged record
      Tag  : Message_Tag;
   end record;

   procedure Visit
     (Visiter : in out Styx.Request_Visiters.Request_Visiter'Class;
      Value   : Request) is abstract;

   type Request_Access is access all Request'Class;

   type Reply is abstract tagged record
      Tag  : Message_Tag;
   end record;

   procedure Visit
     (Visiter : in out Styx.Reply_Visiters.Reply_Visiter'Class;
      Value   : Reply) is abstract;

end Styx.Messages;
