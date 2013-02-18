with League.Strings;
with XML.DOM.Documents;
with XML.DOM.Elements;
with XML.DOM.Implementations;

procedure Demo is
   Implementation : XML.DOM.Implementations.DOM_Implementation;
   Document       : XML.DOM.Documents.DOM_Document
     := Implementation.Create_Document;
   Element_1      : XML.DOM.Elements.DOM_Element
     := Document.Create_Element_NS
         (League.Strings.Empty_Universal_String,
          League.Strings.To_Universal_String ("demo"));
   Element_2      : XML.DOM.Elements.DOM_Element
     := Document.Create_Element_NS
         (League.Strings.Empty_Universal_String,
          League.Strings.To_Universal_String ("demo"));

begin
--   Element := XML.DOM.Elements.Null_DOM_Element;
   null;
   Document := XML.DOM.Documents.Null_DOM_Document;
end Demo;
