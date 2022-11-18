with Ada.Streams;

with League.Strings;

package Styx.Messages.Authes is

   type Auth_Request is new Request with record
      Auth_FID : Styx.Messages.FID;
      User     : League.Strings.Universal_String;
      Tree     : League.Strings.Universal_String;
   end record;

   procedure Visit
     (Visiter : in out Styx.Request_Visiters.Request_Visiter'Class;
      Value   : Auth_Request);

   type Auth_Request_Access is access all Auth_Request;

   type Auth_Reply is new Reply with record
      Auth_QID  : Styx.Messages.QID;
   end record;

   procedure Visit
     (Visiter : in out Styx.Reply_Visiters.Reply_Visiter'Class;
      Value   : Auth_Reply);

end Styx.Messages.Authes;
