with WebAPI.HTML.Documents;

package WebAPI.HTML.Windows is

   type Window is limited interface;

   type Window_Access is access all Window'Class
     with Storage_Size => 0;

   not overriding function Get_Document
    (Self : not null access Window)
      return WebAPI.HTML.Documents.Document_Access is abstract
        with Import     => True,
             Convention => JavaScript_Getter,
             Link_Name  => "document";

end WebAPI.HTML.Windows;
