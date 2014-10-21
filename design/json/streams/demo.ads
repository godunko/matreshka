with Ada.Streams;

package Demo is

   type Rect is record
      X : Integer;
      Y : Integer;
   end record;

   procedure Read
     (S : access Ada.Streams.Root_Stream_Type'Class;
      V : out Rect);

   procedure Write
     (S : access Ada.Streams.Root_Stream_Type'Class;
      V : Rect);

   for Rect'Read use Read;
   for Rect'Write use Write;

end Demo;
