with WebAPI.DOM.Documents;

package WebAPI.HTML.Documents is

   type Document is limited interface
     and WebAPI.DOM.Documents.Document;

   type Document_Access is access all Document'Class
     with Storage_Size => 0;

end WebAPI.HTML.Documents;
