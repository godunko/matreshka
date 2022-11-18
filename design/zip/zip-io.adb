
package body Zip.IO is

   use type Stream_Element_IO.Count;

   -----------
   -- Close --
   -----------

   procedure Close (File : in out File_Type) is
   begin
      Stream_Element_IO.Close (File.File);
   end Close;

   ------------------
   -- Get_Position --
   ------------------

   function Get_Position (File : File_Type) return Zip_File_Offset is
   begin
      return
        Zip_File_Offset
         (Stream_Element_IO.Index (File.File) - 1);
   end Get_Position;

   --------------
   -- Get_Size --
   --------------

   function Get_Size (File : File_Type) return Zip_File_Offset is
   begin
      return
        Zip_File_Offset
         (Stream_Element_IO.Size (File.File));
   end Get_Size;

   ----------
   -- Open --
   ----------

   procedure Open (File : out File_Type; Name : String) is
   begin
      Stream_Element_IO.Open
       (File.File,
        Stream_Element_IO.In_File,
        Name);
   end Open;

   ----------
   -- Read --
   ----------

   procedure Read (File : File_Type; Data : out Ada.Streams.Stream_Element_Array) is
   begin
      for J in Data'Range loop
         Stream_Element_IO.Read (File.File, Data (J));
      end loop;
   end Read;

   ----------
   -- Read --
   ----------

   overriding procedure Read
     (Self : in out File_Type;
      Item : out Ada.Streams.Stream_Element_Array;
      Last : out Ada.Streams.Stream_Element_Offset) is
   begin
      Self.Read (Item);
      Last := Item'Last;
   end Read;

   ------------------
   -- Set_Position --
   ------------------

   procedure Set_Position (File : File_Type; Position : Zip_File_Offset) is
   begin
      Stream_Element_IO.Set_Index
       (File.File,
        Stream_Element_IO.Count (Position) + 1);
   end Set_Position;

end Zip.IO;
