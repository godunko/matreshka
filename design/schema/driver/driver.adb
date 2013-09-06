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
with XML.Schema.Simple_Type_Definitions;
with XML.Schema.Objects.Terms.Model_Groups;

procedure Driver is
   Model      : XML.Schema.Models.XS_Model;
   Namespaces : League.String_Vectors.Universal_String_Vector;

--   Choice      : Boolean := False;
--   Choice_Enum : League.Strings.Universal_String;
--   Condition   : League.Strings.Universal_String;
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

      procedure Print_Type_Definition
        (Type_D : XML.Schema.Type_Definitions.XS_Type_Definition;
         Indent : String := "";
         Name   : League.Strings.Universal_String);

      procedure Print_Term
        (XS_Term        : XML.Schema.Objects.Terms.XS_Term;
         Indent : String := "";
         Name   : League.Strings.Universal_String);

      procedure Print_X_Type_Definition
        (Type_D : XML.Schema.Type_Definitions.XS_Type_Definition;
         Indent : String := "";
         Name   : League.Strings.Universal_String);

      procedure Print_X_Term
        (XS_Term        : XML.Schema.Objects.Terms.XS_Term;
         Indent : String := "";
         Name   : League.Strings.Universal_String);

      ----------------
      -- Print_Term --
      ----------------

      procedure Print_Term
        (XS_Term : XML.Schema.Objects.Terms.XS_Term;
         Indent  : String := "";
         Name    : League.Strings.Universal_String)
      is
         use type XML.Schema.Objects.Terms.Model_Groups.Compositor_Kinds;

         XS_Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
         XS_List        : XML.Schema.Object_Lists.XS_Object_List;
         XS_Particle    : XML.Schema.Objects.Particles.XS_Particle;
         Decl : XML.Schema.Element_Declarations.XS_Element_Declaration;

         Type_D           : XML.Schema.Type_Definitions.XS_Type_Definition;
         CTD              : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;
         STD              : XML.Schema.Simple_Type_Definitions.XS_Simple_Type_Definition;
         XS_Term_2        : XML.Schema.Objects.Terms.XS_Term;
         XS_Model_Group_2 : XML.Schema.Model_Groups.XS_Model_Group;
         XS_List_2        : XML.Schema.Object_Lists.XS_Object_List;
         XS_Particle_2    : XML.Schema.Objects.Particles.XS_Particle;
         begin
         Ada.Text_IO.Put (Indent);
         Ada.Text_IO.Put_Line ("XS_Term.Get_Type =" & XS_Term.Get_Type'Img);
         Ada.Text_IO.Put_Line ("XS_Term.Get_Name =" & XS_Term.Get_Name.To_UTF_8_String);

--           if Choice then
--              Choice_Enum.Append (XS_Term.Get_Name.To_Wide_Wide_String & ", ");
--           end if;

         if XS_Term.Is_Model_Group then
            XS_Model_Group := XS_Term.To_Model_Group;
            XS_List := XS_Model_Group.Get_Particles;
            Ada.Text_IO.Put (Indent);
            Ada.Text_IO.Put_Line (XS_Model_Group.Get_Compositor'Img);

--              if XS_Model_Group.Get_Compositor =
--                XML.Schema.Objects.Terms.Model_Groups.Compositor_Choice
--              then
--                 Choice := True;
--                 Ada.Text_IO.Put_Line
--                   ("type " & Name.To_UTF_8_String & "_Kind is (");
--                 Choice_Enum.Append
--                   ("type " & Name.To_Wide_Wide_String &  "_Kind is (");
--
--                 for J in 1 .. XS_List.Get_Length loop
--                    Ada.Text_IO.Put (Indent);
--                    XS_Particle := XS_List.Item (J).To_Particle;
--                    Ada.Text_IO.Put_Line ((J'Img));
--                    Print_Term (XS_Particle.Get_Term, Indent & "   ", Name);
--                 end loop;
--
--                 Choice := False;
--                 Choice_Enum.Append (");");
--              else
               for J in 1 .. XS_List.Get_Length loop
                  Ada.Text_IO.Put (Indent);
                  XS_Particle := XS_List.Item (J).To_Particle;
                  Ada.Text_IO.Put_Line ((J'Img));
                  Print_Term (XS_Particle.Get_Term, Indent & "   ", Name);
               end loop;
--            end if;
         elsif XS_Term.Is_Element_Declaration then
            Decl   := XS_Term.To_Element_Declaration;

          Print_X_Type_Definition
            (Decl.Get_Type_Definition, Indent & "   ", Name);
         end if;
      end Print_Term;

      ---------------------------
      -- Print_Type_Definition --
      ---------------------------

      procedure Print_Type_Definition
        (Type_D : XML.Schema.Type_Definitions.XS_Type_Definition;
         Indent : String := "";
         Name   : League.Strings.Universal_String)
      is
         use type XML.Schema.Type_Definitions.XS_Type_Definition;

         XS_Particle    : XML.Schema.Objects.Particles.XS_Particle;
         XS_Term        : XML.Schema.Objects.Terms.XS_Term;
         XS_Base        : XML.Schema.Type_Definitions.XS_Type_Definition;

         CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;
         STD  : XML.Schema.Simple_Type_Definitions.XS_Simple_Type_Definition;
      begin
         XS_Base := Type_D.Get_Base_Type;

         Ada.Text_IO.Put_Line ("Type_D = " & Type_D.Get_Name.To_UTF_8_String);

         case Type_D.Get_Type_Category is
            when XML.Schema.Complex_Type =>
               CTD := Type_D.To_Complex_Type_Definition;

               if CTD.Get_Content_Type in Element_Only | Mixed then
                  Ada.Text_IO.Put_Line (Indent & "Complex_Type");
                  XS_Particle := CTD.Get_Particle;
                  XS_Term := XS_Particle.Get_Term;

                  Print_Term (XS_Term, Indent & "   ", Name);

                  Ada.Text_IO.Put_Line (Indent & "End Complex_Type");
               end if;
            when XML.Schema.Simple_Type =>
               Ada.Text_IO.Put (Indent & "Simple_Type : ");
               STD := Type_D.To_Simple_Type_Definition;
               Ada.Text_IO.Put_Line ("Type_D" & Type_D.Get_Name.To_UTF_8_String);
               Ada.Text_IO.Put_Line ("STD" & STD.Get_Name.To_UTF_8_String);

            when XML.Schema.None =>
               Ada.Text_IO.Put_Line (Indent & "NONE!!!");
         end case;

         if XS_Base.Get_Type_Category in
           XML.Schema.Complex_Type .. XML.Schema.Simple_Type
             and XS_Base /= Type_D  --  This is to filter predefined types
         then
            Ada.Text_IO.Put_Line (Indent & " is new");
            Print_Type_Definition (XS_Base, Indent & "   ", Name);
         end if;
      end Print_Type_Definition;

      ----------------
      -- Print_X_Term --
      ----------------

      procedure Print_X_Term
        (XS_Term : XML.Schema.Objects.Terms.XS_Term;
         Indent  : String := "";
         Name    : League.Strings.Universal_String)
      is
         use type XML.Schema.Objects.Terms.Model_Groups.Compositor_Kinds;

         XS_Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
         XS_List        : XML.Schema.Object_Lists.XS_Object_List;
         XS_Particle    : XML.Schema.Objects.Particles.XS_Particle;
         Decl : XML.Schema.Element_Declarations.XS_Element_Declaration;
         Type_D : XML.Schema.Type_Definitions.XS_Type_Definition;

         begin
         Ada.Text_IO.Put (Indent);
         Ada.Text_IO.Put_Line ("XS_Term.Get_Type =" & XS_Term.Get_Type'Img);
         Ada.Text_IO.Put (Indent);
         Ada.Text_IO.Put_Line ("XS_Term.Get_Name =" & XS_Term.Get_Name.To_UTF_8_String);

         if XS_Term.Is_Model_Group then
            XS_Model_Group := XS_Term.To_Model_Group;
            XS_List := XS_Model_Group.Get_Particles;
            Ada.Text_IO.Put (Indent);
            Ada.Text_IO.Put_Line (XS_Model_Group.Get_Compositor'Img);

               for J in 1 .. XS_List.Get_Length loop
                  Ada.Text_IO.Put (Indent);
                  XS_Particle := XS_List.Item (J).To_Particle;
                  Ada.Text_IO.Put_Line ((J'Img));
                  Print_X_Term (XS_Particle.Get_Term, Indent & "   ", Name);
               end loop;
         elsif XS_Term.Is_Element_Declaration then
            Decl   := XS_Term.To_Element_Declaration;
            Type_D := Decl.Get_Type_Definition;

            Ada.Text_IO.Put (Indent);
            Ada.Text_IO.Put_Line
              (XS_Term.Get_Name.To_UTF_8_String
               & " : "
               & Type_D.Get_Name.To_UTF_8_String & ";");
--          Print_Type_Definition
--            (Decl.Get_Type_Definition, Indent & "   ", Name);
         end if;
      end Print_X_Term;

      ---------------------------
      -- Print_X_Type_Definition --
      ---------------------------

      procedure Print_X_Type_Definition
        (Type_D : XML.Schema.Type_Definitions.XS_Type_Definition;
         Indent : String := "";
         Name   : League.Strings.Universal_String)
      is
         use type XML.Schema.Type_Definitions.XS_Type_Definition;

         XS_Particle    : XML.Schema.Objects.Particles.XS_Particle;
         XS_Term        : XML.Schema.Objects.Terms.XS_Term;
         XS_Base        : XML.Schema.Type_Definitions.XS_Type_Definition;

         CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;
         STD  : XML.Schema.Simple_Type_Definitions.XS_Simple_Type_Definition;
      begin
         XS_Base := Type_D.Get_Base_Type;
         Ada.Text_IO.Put_Line ("Type_D X = " & Type_D.Get_Name.To_UTF_8_String);
         case Type_D.Get_Type_Category is
            when XML.Schema.Complex_Type =>
               CTD := Type_D.To_Complex_Type_Definition;

               if CTD.Get_Content_Type in Element_Only | Mixed then
                  Ada.Text_IO.Put_Line (Indent & "Complex_Type");
                  XS_Particle := CTD.Get_Particle;
                  XS_Term := XS_Particle.Get_Term;

                  Print_X_Term (XS_Term, Indent & "   ", Name);

                  Ada.Text_IO.Put_Line (Indent & "End Complex_Type");
               end if;
            when XML.Schema.Simple_Type =>
               STD := Type_D.To_Simple_Type_Definition;
               Ada.Text_IO.Put (Indent & "Simple_Type : ");
               Ada.Text_IO.Put_Line
                 (Type_D.Get_Name.To_UTF_8_String
                  & " : " & XS_Base.Get_Name.To_UTF_8_String);

            when XML.Schema.None =>
               Ada.Text_IO.Put_Line (Indent & "NONE!!!");
         end case;
      end Print_X_Type_Definition;

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
         Print_Type_Definition
           (XS_Object.To_Type_Definition, "", League.Strings.Empty_Universal_String);
      end loop;

      Ada.Text_IO.Put_Line ("----------   BindOrders   ------------");

      for J in 1 .. Complex_Types.Length loop
         XS_Object := Complex_Types.Item (J);

         if XS_Object.Get_Name.To_UTF_8_String = "BindOrders"
           or XS_Object.Get_Name.To_UTF_8_String = "PositionInformationBase"
             or XS_Object.Get_Name.To_UTF_8_String = "AccountBalanceChangedInformation"
         then
            Ada.Text_IO.Put_Line (XS_Object.Get_Name.To_UTF_8_String);

--            Choice_Enum.Clear;

            Print_Type_Definition
              (XS_Object.To_Type_Definition,
               "",
               XS_Object.Get_Name);
         end if;
      end loop;

--      Ada.Text_IO.Put_Line (Choice_Enum.To_UTF_8_String);

   end;
end Driver;
