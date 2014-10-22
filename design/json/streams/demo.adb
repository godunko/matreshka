with League.JSON.Streams;
with League.Strings;

package body Demo is

   package Integer_Stream_Operations is
     new League.JSON.Streams.Generic_Integer_Stream_Operations (Integer);

   ----------
   -- Read --
   ----------

   procedure Read
     (S : access Ada.Streams.Root_Stream_Type'Class;
      V : out Rect) is
   begin
      if S.all in League.JSON.Streams.JSON_Stream'Class then
         declare
            JS : League.JSON.Streams.JSON_Stream'Class
              renames League.JSON.Streams.JSON_Stream'Class (S.all);

         begin
            JS.Start_Object;
            JS.Key (League.Strings.To_Universal_String ("x"));
            JS.Start_Array;
            Integer_Stream_Operations.Read (JS, V.X);
            JS.End_Array;
            JS.Key (League.Strings.To_Universal_String ("y"));
            Integer_Stream_Operations.Read (JS, V.Y);
            JS.End_Object;
         end;

      else
         Integer'Read (S, V.X);
         Integer'Read (S, V.Y);
      end if;
   end Read;

   -----------
   -- Write --
   -----------

   procedure Write
     (S : access Ada.Streams.Root_Stream_Type'Class;
      V : Rect) is
   begin
      if S.all in League.JSON.Streams.JSON_Stream'Class then
         declare
            JS : League.JSON.Streams.JSON_Stream'Class
              renames League.JSON.Streams.JSON_Stream'Class (S.all);

         begin
            JS.Start_Object;
            JS.Key (League.Strings.To_Universal_String ("x"));
            JS.Start_Array;
            Integer_Stream_Operations.Write (JS, V.X);
            JS.End_Array;
            JS.Key (League.Strings.To_Universal_String ("y"));
            Integer_Stream_Operations.Write (JS, V.Y);
            JS.End_Object;
         end;

      else
         Integer'Write (S, V.X);
         Integer'Write (S, V.Y);
      end if;
   end Write;

end Demo;
