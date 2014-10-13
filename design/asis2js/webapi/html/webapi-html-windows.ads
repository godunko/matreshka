with WebAPI.HTML.Documents;

package WebAPI.HTML.Windows is

   type Window is limited interface;

   type Window_Access is access all Window'Class;

   not overriding function Get_Document
    (Self : not null access Window)
      return WebAPI.HTML.Documents.Document_Access is abstract;

end WebAPI.HTML.Windows;
