with Styx.Request_Visiters;
with Styx.Reply_Visiters;

package body Styx.Messages.Authes is

   -----------
   -- Visit --
   -----------

   procedure Visit
     (Visiter : in out Styx.Request_Visiters.Request_Visiter'Class;
      Value   : Auth_Request) is
   begin
      Visiter.Auth (Value);
   end Visit;

   -----------
   -- Visit --
   -----------

   procedure Visit
     (Visiter : in out Styx.Reply_Visiters.Reply_Visiter'Class;
      Value   : Auth_Reply) is
   begin
      Visiter.Auth (Value);
   end Visit;

end Styx.Messages.Authes;
