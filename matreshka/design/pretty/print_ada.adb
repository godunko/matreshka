-- with League.Strings;

with Asis.Ada_Environments;
with Asis.Compilation_Units;
with Asis.Declarations;
with Asis.Elements;
with Asis.Errors;
with Asis.Exceptions;
with Asis.Extensions;
with Asis.Implementation;
with Asis.Iterator;

with Ada.Characters.Conversions;
with Ada.Command_Line;
with Ada.Wide_Text_IO;

with Gnat.Strings;

with League.Pretty_Printers;

procedure Print_Ada is

   procedure Print_Unit (Unit : Asis.Compilation_Unit);

   type State_Information is record
      Printer  : aliased League.Pretty_Printers.Printer;
      Document : League.Pretty_Printers.Document;
   end record;

   procedure Pre_Operation
     (Element :        Asis.Element;
      Control : in out Asis.Traverse_Control;
      State   : in out State_Information);

   procedure Post_Operation
     (Element :        Asis.Element;
      Control : in out Asis.Traverse_Control;
      State   : in out State_Information) is null;

   procedure Traverse_Element is new Asis.Iterator.Traverse_Element
     (State_Information, Pre_Operation, Post_Operation);

   procedure Traverse_Elements
     (List    : Asis.Element_List;
      Control : in out Asis.Traverse_Control;
      State   : in out State_Information);

   -----------------------
   -- Traverse_Elements --
   -----------------------

   procedure Traverse_Elements
     (List    : Asis.Element_List;
      Control : in out Asis.Traverse_Control;
      State   : in out State_Information) is
   begin
      for J in List'Range loop
         Traverse_Element (List (J), Control, State);
      end loop;
   end Traverse_Elements;

   -------------------
   -- Pre_Operation --
   -------------------

   procedure Pre_Operation
     (Element :        Asis.Element;
      Control : in out Asis.Traverse_Control;
      State   : in out State_Information) is
   begin
      case Asis.Elements.Element_Kind (Element) is
         when Asis.A_Declaration =>
            case Asis.Elements.Declaration_Kind (Element) is
               when Asis.A_Procedure_Body_Declaration =>
                  declare
                     Saved : League.Pretty_Printers.Document;
                  begin
                     State.Document.New_Line;
                     State.Document.Put ("procedure ");
                     Traverse_Elements
                       (Asis.Declarations.Names (Element), Control, State);
                     State.Document.Put_Line (" is");

                     Saved := State.Document.Put ("begin");

                     State.Document := State.Printer.New_Document;

                     Traverse_Elements
                       (Asis.Declarations.Body_Statements (Element),
                        Control,
                        State);
                     State.Document.Nest (3);

                     State.Document := Saved.Append (State.Document.New_Line);
                     State.Document.Put ("end;");

                     Control := Asis.Abandon_Children;
                  end;
               when others =>
                  null;
            end case;

         when Asis.A_Defining_Name =>
            State.Document.Put
              (Ada.Characters.Conversions.To_Wide_Wide_String
                 (Asis.Declarations.Defining_Name_Image (Element)));

         when Asis.A_Statement =>
            case Asis.Elements.Statement_Kind (Element) is
               when Asis.A_Null_Statement =>
                  State.Document.New_Line;
                  State.Document.Put ("null;");
               when others =>
                  null;
            end case;
         when others =>
            null;
      end case;
   end Pre_Operation;

   ----------------
   -- Print_Unit --
   ----------------

   procedure Print_Unit (Unit : Asis.Compilation_Unit) is
      Control : Asis.Traverse_Control := Asis.Continue;
      State   : State_Information;
   begin
      State.Document := State.Printer.New_Document;

      Traverse_Element
        (Asis.Elements.Unit_Declaration (Unit), Control, State);

      Ada.Wide_Text_IO.Put_Line
        (State.Printer.Pretty (80, State.Document).To_UTF_16_Wide_String);
   end Print_Unit;

   Count   : constant Natural := Ada.Command_Line.Argument_Count;
   Source  : Gnat.Strings.String_Access;
   Args    : GNAT.Strings.String_List (1 .. Count - 1);
   Last    : Natural := 0;
   Success : Boolean;
   Context : Asis.Context;

begin
   --  Collect options and source name from arguments
   for J in 1 .. Ada.Command_Line.Argument_Count loop
      declare
         Arg : constant String := Ada.Command_Line.Argument (J);
      begin
         if Arg'Length > 2 and then
           Arg (Arg'First .. Arg'First + 1) = "-I"
         then
            Last := Last + 1;
            Args (Last) := new String'(Arg);
         else
            Source := new String'(Arg);
         end if;
      end;
   end loop;

   --  Compile given source to ADT file
   Asis.Extensions.Compile
     (Source_File           => Source,
      Args                  => Args,
      Success               => Success);

   if not Success then
      raise Program_Error;
   end if;

   --  Start ASIS implementation
   Asis.Implementation.Initialize ("-ws");

   --  Put ADT file into context and open it
   Asis.Ada_Environments.Associate
     (The_Context => Context,
      Name        => Asis.Ada_Environments.Default_Name,
      Parameters  => "-C1 " & Ada.Characters.Conversions.To_Wide_String
        (Source (Source'First .. Source'Last - 1) & 't'));

   Asis.Ada_Environments.Open (Context);

   --  Lookup compilation unit corresponding to given source
   declare
      File_Name : constant Wide_String :=
        Ada.Characters.Conversions.To_Wide_String (Source.all);
      Units     : constant Asis.Compilation_Unit_List :=
        Asis.Compilation_Units.Compilation_Units (Context);
   begin
      for J in Units'Range loop
         if Asis.Compilation_Units.Text_Name (Units (J)) = File_Name then
            Print_Unit (Units (J));
         end if;
      end loop;
   end;

exception
   when Asis.Exceptions.ASIS_Inappropriate_Context          |
        Asis.Exceptions.ASIS_Inappropriate_Container        |
        Asis.Exceptions.ASIS_Inappropriate_Compilation_Unit |
        Asis.Exceptions.ASIS_Inappropriate_Element          |
        Asis.Exceptions.ASIS_Inappropriate_Line             |
        Asis.Exceptions.ASIS_Inappropriate_Line_Number      |
        Asis.Exceptions.ASIS_Failed                         =>

      Ada.Wide_Text_IO.Put ("ASIS Error Status is ");
      Ada.Wide_Text_IO.Put
        (Asis.Errors.Error_Kinds'Wide_Image (Asis.Implementation.Status));
      Ada.Wide_Text_IO.New_Line;

      Ada.Wide_Text_IO.Put ("ASIS Diagnosis is ");
      Ada.Wide_Text_IO.New_Line;
      Ada.Wide_Text_IO.Put (Asis.Implementation.Diagnosis);
      Ada.Wide_Text_IO.New_Line;

      Asis.Implementation.Set_Status;end Print_Ada;
