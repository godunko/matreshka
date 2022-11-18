with Ada.Streams;

with League.Strings;

package Styx.Messages.Opens is

   type Open_Mode is (Read, Write, Read_Write, Execute);

   type Open_Request is new Request with record
      FID             : Styx.Messages.FID;
      Remove_On_Close : Boolean;
      Trunc           : Boolean;
      Mode            : Open_Mode;
   end record;

   procedure Visit
     (Visiter : in out Styx.Request_Visiters.Request_Visiter'Class;
      Value   : Open_Request);

   type Open_Request_Access is access all Open_Request;

   type Open_Reply is new Reply with record
      QID  : Styx.Messages.QID;
      Unit : Styx.Messages.Size;
   end record;

   procedure Visit
     (Visiter : in out Styx.Reply_Visiters.Reply_Visiter'Class;
      Value   : Open_Reply);

end Styx.Messages.Opens;
