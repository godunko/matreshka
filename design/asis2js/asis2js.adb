with Ada.Directories;
with Ada.Wide_Text_IO;
with Ada.Wide_Wide_Text_IO;

with Asis;
with Asis.Ada_Environments;
with Asis.Compilation_Units;
with Asis.Elements;
with Asis.Errors;
with Asis.Exceptions;
with Asis.Extensions;
with Asis.Implementation;

with League.Application;
with League.Strings;

with Engines.Contexts;
with Engines.Registry_All_Actions;

procedure Asis2JS is

   use type League.Strings.Universal_String;

   procedure Compile_Unit (Unit : Asis.Compilation_Unit);
   procedure Compile_File (File : League.Strings.Universal_String);

   procedure Create_ADT_File (Source_File : League.Strings.Universal_String);

   Engine      : aliased Engines.Contexts.Context;
   Context     : Asis.Context;
   Source_File : League.Strings.Universal_String;
   ADT_File    : League.Strings.Universal_String;

   ------------------
   -- Compile_File --
   ------------------

   procedure Compile_File (File : League.Strings.Universal_String) is
      File_Name : constant Wide_String := File.To_UTF_16_Wide_String;
      Units     : constant Asis.Compilation_Unit_List :=
        Asis.Compilation_Units.Compilation_Units (Context);
      Success   : Boolean := False;

   begin
      for J in Units'Range loop
         if Asis.Compilation_Units.Text_Name (Units (J)) = File_Name then
            case Asis.Compilation_Units.Unit_Kind (Units (J)) is
               when Asis.A_Package_Body =>
                  Compile_Unit
                   (Asis.Compilation_Units.Corresponding_Declaration
                     (Units (J)));

               when others =>
                  Ada.Wide_Text_IO.Put
                   (Asis.Compilation_Units.Debug_Image (Units (J)));

                  raise Program_Error;
            end case;
         end if;
      end loop;
   end Compile_File;

   ------------------
   -- Compile_Unit --
   ------------------

   procedure Compile_Unit (Unit : Asis.Compilation_Unit) is
      List   : constant Asis.Context_Clause_List :=
        Asis.Elements.Context_Clause_Elements (Unit);
      Result : League.Strings.Universal_String;
      Code   : League.Strings.Universal_String;
   begin
      for J in List'Range loop
         Result := Engine.Text.Get_Property
           (List (J), Engines.Code);
         Code.Append (Result);
      end loop;

      Result := Engine.Text.Get_Property
        (Element => Asis.Elements.Unit_Declaration (Unit),
         Name    => Engines.Code);

      Code.Append (Result);

      Ada.Wide_Wide_Text_IO.Put_Line (Code.To_Wide_Wide_String);
   end Compile_Unit;

   ---------------------
   -- Create_ADT_File --
   ---------------------

   procedure Create_ADT_File (Source_File : League.Strings.Universal_String) is
      Success : Boolean;

   begin
      Asis.Extensions.Compile
       (new String'(Source_File.To_UTF_8_String),
        (1 .. 0 => null),
        Success,
        Display_Call => True);

      if not Success then
         raise Program_Error;
      end if;
   end Create_ADT_File;

begin
   --  Process command line parameters.

   Source_File := League.Application.Arguments.Element (1);
   ADT_File := Source_File.Head (Source_File.Length - 1) & 't';
   ADT_File :=
     League.Strings.From_UTF_8_String
      (Ada.Directories.Simple_Name (ADT_File.To_UTF_8_String));

   --  Execute GNAT to generate ADT files.

   Create_ADT_File (Source_File);

   --  Initialize ASIS-for-GNAT and load ADT file.

   Asis.Implementation.Initialize ("-ws");

   Asis.Ada_Environments.Associate
     (The_Context => Context,
      Name        => Asis.Ada_Environments.Default_Name,
      Parameters  => "-C1 " & ADT_File.To_UTF_16_Wide_String);

   Asis.Ada_Environments.Open (Context);

   --  Register processing actions.

   Engines.Registry_All_Actions (Engine);

   --  Process file.

   Compile_File (Source_File);

   --  Finalize ASIS.

   Asis.Ada_Environments.Close (Context);
   Asis.Ada_Environments.Dissociate (Context);
   Asis.Implementation.Finalize;

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

      Asis.Implementation.Set_Status;
end Asis2JS;
