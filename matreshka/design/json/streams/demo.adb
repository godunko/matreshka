with League.JSON.Streams.Boolean_Stream_Operations;
with League.JSON.Streams.Float_Stream_Operations;
with League.JSON.Streams.Integer_Stream_Operations;
with League.JSON.Streams.Generic_Float_Stream_Operations;
with League.JSON.Streams.Generic_Integer_Stream_Operations;
with League.JSON.Streams.Long_Float_Stream_Operations;
with League.JSON.Streams.Long_Integer_Stream_Operations;
with League.Strings;

package body Demo is

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
            JS.Key (League.Strings.To_Universal_String ("f"));
            League.JSON.Streams.Boolean_Stream_Operations.Read (JS, V.F);
            JS.Key (League.Strings.To_Universal_String ("x"));
            League.JSON.Streams.Integer_Stream_Operations.Read (JS, V.X);
            JS.Key (League.Strings.To_Universal_String ("y"));
            League.JSON.Streams.Integer_Stream_Operations.Read (JS, V.Y);
            JS.Key (League.Strings.To_Universal_String ("n"));
            League.Strings.Universal_String'Read (JS'Access, V.N);
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
            JS.Key (League.Strings.To_Universal_String ("f"));
            League.JSON.Streams.Boolean_Stream_Operations.Write (JS, V.F);
            JS.Key (League.Strings.To_Universal_String ("x"));
            League.JSON.Streams.Integer_Stream_Operations.Write (JS, V.X);
            JS.Key (League.Strings.To_Universal_String ("y"));
            League.JSON.Streams.Integer_Stream_Operations.Write (JS, V.Y);
            JS.Key (League.Strings.To_Universal_String ("n"));
            League.Strings.Universal_String'Write (JS'Access, V.N);
            JS.End_Object;
         end;

      else
         Integer'Write (S, V.X);
         Integer'Write (S, V.Y);
      end if;
   end Write;

end Demo;
