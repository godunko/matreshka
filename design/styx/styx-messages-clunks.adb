with Styx.Request_Visiters;
with Styx.Reply_Visiters;

package body Styx.Messages.Clunks is

   -----------
   -- Visit --
   -----------

   procedure Visit
     (Visiter : in out Styx.Request_Visiters.Request_Visiter'Class;
      Value   : Clunk_Request) is
   begin
      Visiter.Clunk (Value);
   end Visit;

   -----------
   -- Visit --
   -----------

   procedure Visit
     (Visiter : in out Styx.Reply_Visiters.Reply_Visiter'Class;
      Value   : Clunk_Reply) is
   begin
      Visiter.Clunk (Value);
   end Visit;

end Styx.Messages.Clunks;
