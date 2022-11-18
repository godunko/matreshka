with Styx.Request_Visiters;
with Styx.Reply_Visiters;

package body Styx.Messages.Opens is

   -----------
   -- Visit --
   -----------

   procedure Visit
     (Visiter : in out Styx.Request_Visiters.Request_Visiter'Class;
      Value   : Open_Request) is
   begin
      Visiter.Open (Value);
   end Visit;

   -----------
   -- Visit --
   -----------

   procedure Visit
     (Visiter : in out Styx.Reply_Visiters.Reply_Visiter'Class;
      Value   : Open_Reply) is
   begin
      Visiter.Open (Value);
   end Visit;

end Styx.Messages.Opens;
