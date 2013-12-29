with Styx.Request_Visiters;
with Styx.Reply_Visiters;

package body Styx.Messages.Attaches is

   -----------
   -- Visit --
   -----------

   procedure Visit
     (Visiter : in out Styx.Request_Visiters.Request_Visiter'Class;
      Value   : Attach_Request) is
   begin
      Visiter.Attach (Value);
   end Visit;

   -----------
   -- Visit --
   -----------

   procedure Visit
     (Visiter : in out Styx.Reply_Visiters.Reply_Visiter'Class;
      Value   : Attach_Reply) is
   begin
      Visiter.Attach (Value);
   end Visit;

end Styx.Messages.Attaches;
