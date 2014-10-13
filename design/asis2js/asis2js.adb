with Ada.Wide_Text_IO;
with Ada.Wide_Wide_Text_IO;

with Asis;
with Asis.Ada_Environments;
with Asis.Compilation_Units;
with Asis.Elements;
with Asis.Errors;
with Asis.Exceptions;
with Asis.Implementation;

with League.Application;
with League.Holders;
with League.Strings;

with Engines;
with Engines.Property_Names;

with Properties.Declarations.Procedure_Body_Declarations;
with Asis.Extensions.Flat_Kinds;

procedure Asis2JS is
   procedure Register_Actions (Engine : in out Engines.Engine);
   procedure Compile (Unit : Asis.Compilation_Unit);

   Engine      : Engines.Engine;
   Context     : Asis.Context;

   ASIS_Params : constant League.Strings.Universal_String :=
     League.Application.Arguments.Element (1);

   File        : constant League.Strings.Universal_String :=
     League.Application.Arguments.Element (2);

   File_Name   : constant Wide_String := File.To_UTF_16_Wide_String;

   -------------
   -- Compile --
   -------------

   procedure Compile (Unit : Asis.Compilation_Unit) is
      Result : League.Holders.Holder;
      Code   : League.Strings.Universal_String;
   begin
      Result := Engine.Get_Property
        (Element => Asis.Elements.Unit_Declaration (Unit),
         Name    => Engines.Property_Names.Code);

      Code := League.Holders.Element (Result);
      Ada.Wide_Wide_Text_IO.Put_Line (Code.To_Wide_Wide_String);
   end Compile;

   ----------------------
   -- Register_Actions --
   ----------------------

   procedure Register_Actions (Engine : in out Engines.Engine) is
   begin
      Engine.Register_Calculator
        (Asis.Extensions.Flat_Kinds.A_Procedure_Body_Declaration,
         Engines.Property_Names.Code,
         Properties.Declarations.Procedure_Body_Declarations.Code'Access);
   end Register_Actions;

begin
   Asis.Implementation.Initialize ("");

   Asis.Ada_Environments.Associate
     (The_Context => Context,
      Name        => Asis.Ada_Environments.Default_Name,
      Parameters  => ASIS_Params.To_UTF_16_Wide_String);

   Asis.Ada_Environments.Open (Context);

   Register_Actions (Engine);

   declare
      Units : constant Asis.Compilation_Unit_List :=
        Asis.Compilation_Units.Compilation_Units (Context);
   begin
      for J in Units'Range loop
         if Asis.Compilation_Units.Text_Name (Units (J)) = File_Name then
            Compile (Units (J));
         end if;
      end loop;
   end;

   Asis.Ada_Environments.Close (Context);
   Asis.Ada_Environments.Dissociate (Context);
   Asis.Implementation.Finalize ("");

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
