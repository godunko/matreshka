with Ada.Streams;

with League.Strings;
with League.String_Vectors;

package Styx.Messages.Walks is

   type Walk_Request is new Request with record
      FID     : Styx.Messages.FID;
      New_FID : Styx.Messages.FID;
      Names   : League.String_Vectors.Universal_String_Vector;
   end record;

   procedure Visit
     (Visiter : in out Styx.Request_Visiters.Request_Visiter'Class;
      Value   : Walk_Request);

   type Walk_Request_Access is access all Walk_Request;

   type QID_Array is array (Positive range <>) of QID;

   type Walk_Reply (Count : Natural) is new Reply with record
      List : QID_Array (1 .. Count);
   end record;

   procedure Visit
     (Visiter : in out Styx.Reply_Visiters.Reply_Visiter'Class;
      Value   : Walk_Reply);

end Styx.Messages.Walks;
