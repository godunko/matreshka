with Styx.Request_Visiters;
with Styx.Reply_Visiters;

package body Styx.Messages.Walks is

   -----------
   -- Visit --
   -----------

   procedure Visit
     (Visiter : in out Styx.Request_Visiters.Request_Visiter'Class;
      Value   : Walk_Request) is
   begin
      Visiter.Walk (Value);
   end Visit;

   -----------
   -- Visit --
   -----------

   procedure Visit
     (Visiter : in out Styx.Reply_Visiters.Reply_Visiter'Class;
      Value   : Walk_Reply) is
   begin
      Visiter.Walk (Value);
   end Visit;

end Styx.Messages.Walks;
