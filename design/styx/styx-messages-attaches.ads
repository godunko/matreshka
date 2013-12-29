with Ada.Streams;

with League.Strings;

package Styx.Messages.Attaches is

   type Attach_Request is new Request with record
      FID      : Styx.Messages.FID;
      Auth_FID : Styx.Messages.FID;
      User     : League.Strings.Universal_String;
      Tree     : League.Strings.Universal_String;
   end record;

   procedure Visit
     (Visiter : in out Styx.Request_Visiters.Request_Visiter'Class;
      Value   : Attach_Request);

   type Attach_Request_Access is access all Attach_Request;

   type Attach_Reply is new Reply with record
      QID  : Styx.Messages.QID;
   end record;

   procedure Visit
     (Visiter : in out Styx.Reply_Visiters.Reply_Visiter'Class;
      Value   : Attach_Reply);

end Styx.Messages.Attaches;
