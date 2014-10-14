
package WebAPI.HTML.Documents is

   type Document is limited interface;

   type Document_Access is access all Document'Class
     with Storage_Size => 0;

end WebAPI.HTML.Documents;
