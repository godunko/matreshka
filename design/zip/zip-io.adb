
package body Zip.IO is

   use type Stream_Element_IO.Count;

   -----------
   -- Close --
   -----------

   procedure Close (File : in out File_Type) is
   begin
      Stream_Element_IO.Close (Stream_Element_IO.File_Type (File));
   end Close;

   ------------------
   -- Get_Position --
   ------------------

   function Get_Position (File : File_Type) return Zip_File_Offset is
   begin
      return
        Zip_File_Offset
         (Stream_Element_IO.Index (Stream_Element_IO.File_Type (File)) - 1);
   end Get_Position;

   --------------
   -- Get_Size --
   --------------

   function Get_Size (File : File_Type) return Zip_File_Offset is
   begin
      return
        Zip_File_Offset
         (Stream_Element_IO.Size (Stream_Element_IO.File_Type (File)));
   end Get_Size;

   ----------
   -- Open --
   ----------

   procedure Open (File : out File_Type; Name : String) is
   begin
      Stream_Element_IO.Open
       (Stream_Element_IO.File_Type (File),
        Stream_Element_IO.In_File,
        Name);
   end Open;

   ----------
   -- Read --
   ----------

   procedure Read (File : File_Type; Data : out Ada.Streams.Stream_Element_Array) is
   begin
      for J in Data'Range loop
         Stream_Element_IO.Read (Stream_Element_IO.File_Type (File), Data (J));
      end loop;
   end Read;

   ------------------
   -- Set_Position --
   ------------------

   procedure Set_Position (File : File_Type; Position : Zip_File_Offset) is
   begin
      Stream_Element_IO.Set_Index
       (Stream_Element_IO.File_Type (File),
        Stream_Element_IO.Count (Position) + 1);
   end Set_Position;

end Zip.IO;
