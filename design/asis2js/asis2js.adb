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
with Engines.Registry_All_Actions;

procedure Asis2JS is
   procedure Compile_Unit (Unit : Asis.Compilation_Unit);
   procedure Compile_File (File : League.Strings.Universal_String);

   Engine      : aliased Engines.Engine;
   Context     : Asis.Context;

   ASIS_Params : constant League.Strings.Universal_String :=
     League.Application.Arguments.Element (1);

   ------------------
   -- Compile_File --
   ------------------

   procedure Compile_File (File : League.Strings.Universal_String) is
      File_Name   : constant Wide_String := File.To_UTF_16_Wide_String;
   begin
      declare
         Units : constant Asis.Compilation_Unit_List :=
           Asis.Compilation_Units.Compilation_Units (Context);
      begin
         for J in Units'Range loop
            if Asis.Compilation_Units.Text_Name (Units (J)) = File_Name then
               Compile_Unit (Units (J));
            end if;
         end loop;
      end;
   end Compile_File;

   ------------------
   -- Compile_Unit --
   ------------------

   procedure Compile_Unit (Unit : Asis.Compilation_Unit) is
      List   : constant Asis.Context_Clause_List :=
        Asis.Elements.Context_Clause_Elements (Unit);
      Result : League.Holders.Holder;
      Code   : League.Strings.Universal_String;
   begin
      for J in List'Range loop
         Result := Engine.Get_Property
           (List (J), Engines.Property_Names.Code);
         Code.Append (League.Holders.Element (Result));
      end loop;

      Result := Engine.Get_Property
        (Element => Asis.Elements.Unit_Declaration (Unit),
         Name    => Engines.Property_Names.Code);

      Code.Append ("{");
      Code.Append (League.Holders.Element (Result));
      Code.Append ("};");
      Ada.Wide_Wide_Text_IO.Put_Line (Code.To_Wide_Wide_String);
   end Compile_Unit;

begin
   Asis.Implementation.Initialize ("-ws");

   Asis.Ada_Environments.Associate
     (The_Context => Context,
      Name        => Asis.Ada_Environments.Default_Name,
      Parameters  => ASIS_Params.To_UTF_16_Wide_String);

   Asis.Ada_Environments.Open (Context);

   Engines.Registry_All_Actions (Engine);

   Ada.Wide_Wide_Text_IO.Put_Line ("var standard = standard || {};");

   for J in 2 .. League.Application.Arguments.Length loop
      Compile_File (League.Application.Arguments.Element (J));
   end loop;

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