with Ada.Wide_Wide_Text_IO;

with League.Application;
with League.String_Vectors;
with League.Strings;

with XML.Schema.Complex_Type_Definitions;
with XML.Schema.Element_Declarations;
with XML.Schema.Models;
with XML.Schema.Utilities;
with XML.Schema.Type_Definitions;
with XML.Schema.Objects.Particles;

with Matreshka.XML_Schema.URI_Rewriter;

with Ada.Text_IO;
with XML.Schema.Named_Maps;
with XML.Schema.Objects;
with XML.Schema.Objects.Type_Definitions;
with XML.Schema.Objects.Terms;
with XML.Schema.Model_Groups;
with XML.Schema.Object_Lists;

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
      use all type XML.Schema.Objects.Type_Definitions
        .Complex_Type_Definitions.Content_Types;

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

      Complex_Types : Xml.Schema.Named_Maps.XS_Named_Map :=
        Model.Get_Components_By_Namespace
          (Object_Type => Xml.Schema.Complex_Type,
           Namespace   => Namespace);

      XS_Object   : XML.Schema.Objects.XS_Object;
      XS_Particle : XML.Schema.Objects.Particles.XS_Particle;
      XS_Term     : XML.Schema.Objects.Terms.XS_Term;
      XS_Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
      XS_List     : XML.Schema.Object_Lists.XS_Object_List;
   begin
      if Type_D.Get_Type_Category = XML.Schema.Complex_Type then
         CTD := Type_D.To_Complex_Type_Definition;

         if CTD.Is_Null then
            raise Program_Error;
         end if;
      end if;

      for J in 1 .. Complex_Types.Length loop
         XS_Object := Complex_Types.Item (J);

         Ada.Text_IO.Put_Line (XS_Object.Get_Name.To_UTF_8_String);

         CTD := XS_Object.To_Complex_Type_Definition;

         if CTD.Get_Content_Type in Element_Only | Mixed then
            XS_Particle := CTD.Get_Particle;
            XS_Term := XS_Particle.Get_Term;
            XS_Model_Group := XS_Term.To_Model_Group;
            XS_List := XS_Model_Group.Get_Particles;

            for J in 1 .. XS_List.Get_Length loop
               XS_Particle := XS_List.Item (J).To_Particle;
               XS_Term := XS_Particle.Get_Term;
               Ada.Text_IO.Put ((J'Img));
               Ada.Text_IO.Put (' ');
               Ada.Text_IO.Put_Line (XS_Term.Get_Type'Img);
            end loop;
         end if;
      end loop;

   end;
end Driver;
