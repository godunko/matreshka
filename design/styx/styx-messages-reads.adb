with Styx.Request_Visiters;
with Styx.Reply_Visiters;

package body Styx.Messages.Reads is

   -----------
   -- Visit --
   -----------

   procedure Visit
     (Visiter : in out Styx.Request_Visiters.Request_Visiter'Class;
      Value   : Read_Request) is
   begin
      Visiter.Read (Value);
   end Visit;

   -----------
   -- Visit --
   -----------

   procedure Visit
     (Visiter : in out Styx.Reply_Visiters.Reply_Visiter'Class;
      Value   : Read_Reply) is
   begin
      Visiter.Read (Value);
   end Visit;

   -----------
   -- Visit --
   -----------

   procedure Visit
     (Visiter : in out Styx.Reply_Visiters.Reply_Visiter'Class;
      Value   : Read_Directory_Reply) is
   begin
      Visiter.Read_Directory (Value);
   end Visit;

end Styx.Messages.Reads;
