with Ada.Wide_Wide_Text_IO;

with League.Application;
with League.String_Vectors;
with League.Strings;

with XML.Schema.Complex_Type_Definitions;
with XML.Schema.Element_Declarations;
with XML.Schema.Models;
with XML.Schema.Utilities;
with XML.Schema.Type_Definitions;

with Matreshka.XML_Schema.URI_Rewriter;

procedure Driver is
   Model      : XML.Schema.Models.XS_Model;
   Namespaces : League.String_Vectors.Universal_String_Vector;

begin
   Matreshka.XML_Schema.URI_Rewriter.Initialize;

   Model :=
     XML.Schema.Utilities.Load (League.Application.Arguments.Element (1));

   if Model.Is_Null then
      raise Program_Error;
   end if;

   Ada.Wide_Wide_Text_IO.Put_Line ("Namespaces:");
   Namespaces := Model.Get_Namespaces;

   for J in 1 .. Namespaces.Length loop
      Ada.Wide_Wide_Text_IO.Put_Line
       ("   '"
          & Namespaces (J).To_Wide_Wide_String
          & ''');
   end loop;

   --  Lookup for element declaration.

   declare
      use type XML.Schema.Type_Category;

      Namespace : League.Strings.Universal_String
        := League.Strings.To_Universal_String ("http://www.actforex.com/iats");
      Name      : League.Strings.Universal_String
        := League.Strings.To_Universal_String ("OpenSessionResponse");
      Decl      : XML.Schema.Element_Declarations.XS_Element_Declaration
        := Model.Get_Element_Declaration (Name, Namespace);
      Type_D    : XML.Schema.Type_Definitions.XS_Type_Definition
        := Decl.Get_Type_Definition;
      CTD       :
        XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;

   begin
      if Type_D.Get_Type_Category /= XML.Schema.Complex_Type then
         CTD := Type_D.To_Complex_Type_Definition;

         if CTD.Is_Null then
            raise Program_Error;
         end if;
      end if;
   end;
end Driver;
