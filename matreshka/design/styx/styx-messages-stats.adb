with Styx.Request_Visiters;
with Styx.Reply_Visiters;

package body Styx.Messages.Stats is

   -----------
   -- Visit --
   -----------

   procedure Visit
     (Visiter : in out Styx.Request_Visiters.Request_Visiter'Class;
      Value   : Stat_Request) is
   begin
      Visiter.Stat (Value);
   end Visit;

   -----------
   -- Visit --
   -----------

   procedure Visit
     (Visiter : in out Styx.Reply_Visiters.Reply_Visiter'Class;
      Value   : Stat_Reply) is
   begin
      Visiter.Stat (Value);
   end Visit;

end Styx.Messages.Stats;
