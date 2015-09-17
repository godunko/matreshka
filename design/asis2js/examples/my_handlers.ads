with WebAPI.DOM.Events;
with WebAPI.DOM.Event_Listeners;
with WebAPI.DOM.Elements;
with WebAPI.DOM.Texts;

package My_Handlers is
   type Handler is new WebAPI.DOM.Event_Listeners.Event_Listener with record
      P : WebAPI.DOM.Elements.Element_Access;
      T : WebAPI.DOM.Texts.Text_Access;
   end record;

   overriding procedure Handle_Event
    (Self  : not null access Handler;
     Event : access WebAPI.DOM.Events.Event'Class);

   type Handler_Access is access all Handler;

end My_Handlers;
