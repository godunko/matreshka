with Styx.Request_Visiters;
with Styx.Reply_Visiters;

package body Styx.Messages.Versions is

   -----------
   -- Visit --
   -----------

   procedure Visit
     (Visiter : in out Styx.Request_Visiters.Request_Visiter'Class;
      Value   : Version_Request) is
   begin
      Visiter.Version (Value);
   end Visit;

   -----------
   -- Visit --
   -----------

   procedure Visit
     (Visiter : in out Styx.Reply_Visiters.Reply_Visiter'Class;
      Value   : Version_Reply) is
   begin
      Visiter.Version (Value);
   end Visit;

end Styx.Messages.Versions;
