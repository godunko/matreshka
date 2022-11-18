package body My_Handlers is
   overriding procedure Handle_Event
    (Self  : not null access Handler;
     Event : access WebAPI.DOM.Events.Event'Class) is
   begin
      Self.P.Append_Child (Self.T);
   end Handle_Event;
end My_Handlers;
