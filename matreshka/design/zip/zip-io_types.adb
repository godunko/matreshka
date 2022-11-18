with Ada.Unchecked_Conversion;
with League.Calendars.ISO_8601;

package body Zip.IO_Types is

   generic
      type Element is (<>);
      Length : Ada.Streams.Stream_Element_Offset;

   package Generic_IO is
      procedure Read
        (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
         Item   : out Element);

      procedure Write
        (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
         Item   : Element);
   end Generic_IO;

   type Raw_Time is record
      Hours   : League.Calendars.ISO_8601.Hour_Number;
      Minutes : League.Calendars.ISO_8601.Minute_Number;
      Seconds : League.Calendars.ISO_8601.Second_Number range 0 .. 30;
   end record with Size => Unsigned_16'Size;
   for Raw_Time use record
      Seconds at 0 range 0 .. 4;
      Minutes at 0 range 5 .. 10;
      Hours   at 0 range 11 .. 15;
   end record;

   type Raw_Date is record
      Day     : League.Calendars.ISO_8601.Day_Number;
      Month   : League.Calendars.ISO_8601.Month_Number;
      Year    : League.Calendars.ISO_8601.Year_Number range 0 .. 127;
   end record with Size => Unsigned_16'Size;
   for Raw_Date use record
      Day   at 0 range 0 .. 4;
      Month at 0 range 5 .. 8;
      Year  at 0 range 9 .. 15;
   end record;

   ----------------
   -- Generic_IO --
   ----------------

   package body Generic_IO is

      type Unsigned_32 is mod 2 ** 32;

      ----------
      -- Read --
      ----------

      procedure Read
        (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
         Item   : out Element)
      is
         use type Ada.Streams.Stream_Element_Offset;
         Input : Ada.Streams.Stream_Element_Array (1 .. Length);
         Last  : Ada.Streams.Stream_Element_Offset;
         Value : Unsigned_32 := 0;
      begin
         Stream.Read (Input, Last);
         pragma Assert (Last = Input'Last);

         for J of reverse Input loop
            Value := Value * 2 ** 8 + Unsigned_32 (J);
         end loop;

         Item := Element'Val (Value);
      end Read;

      -----------
      -- Write --
      -----------

      procedure Write
        (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
         Item   : Element)
      is
         Value  : Unsigned_32 := Element'Pos (Item);
         Output : Ada.Streams.Stream_Element_Array (1 .. Length);
      begin
         for J of Output loop
            J := Ada.Streams.Stream_Element (Value mod 2 ** 8);
            Value := Value / 2 ** 8;
         end loop;
         Stream.Write (Output);
      end Write;

   end Generic_IO;

   package Unsigned_16_IO is new Generic_IO (Unsigned_16, 2);
   package Unsigned_32_IO is new Generic_IO (Unsigned_32, 4);

   procedure Read
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : out Unsigned_16) renames Unsigned_16_IO.Read;

   procedure Write
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : Unsigned_16) renames Unsigned_16_IO.Write;

   procedure Read
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : out Unsigned_32) renames Unsigned_32_IO.Read;

   procedure Write
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : Unsigned_32) renames Unsigned_32_IO.Write;

   ----------
   -- Read --
   ----------

   procedure Read
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : out Method)
   is
      function Cast is new Ada.Unchecked_Conversion (Unsigned_16, Method);

      Input : Unsigned_16;
   begin
      Unsigned_16'Read (Stream, Input);
      Item := Cast (Input);
   end Read;

   -----------
   -- Write --
   -----------

   procedure Write
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : Method)
   is
      function Cast is new Ada.Unchecked_Conversion (Method, Unsigned_16);

      Output : constant Unsigned_16 := Cast (Item);
   begin
      Unsigned_16'Write (Stream, Output);
   end Write;

   ----------
   -- Read --
   ----------

   procedure Read
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : out Date_Time)
   is
      function Cast_Time is
        new Ada.Unchecked_Conversion (Unsigned_16, Raw_Time);
      function Cast_Date is
        new Ada.Unchecked_Conversion (Unsigned_16, Raw_Date);

      Input_Time : Unsigned_16;
      Input_Date : Unsigned_16;
   begin
      Unsigned_16'Read (Stream, Input_Time);
      Unsigned_16'Read (Stream, Input_Date);

      declare
         use type League.Calendars.ISO_8601.Year_Number;
         use type League.Calendars.ISO_8601.Second_Number;

         Time   : constant Raw_Time := Cast_Time (Input_Time);
         Date   : constant Raw_Date := Cast_Date (Input_Date);
         Result : constant League.Calendars.Date_Time :=
           League.Calendars.ISO_8601.Create
             (Year           => 1980 + Date.Year,
              Month          => Date.Month,
              Day            => Date.Day,
              Hour           => Time.Hours,
              Minute         => Time.Minutes,
              Second         => Time.Seconds * 2,
              Nanosecond_100 => 0);
      begin
         Item := Date_Time (Result);
      end;
   end Read;

   -----------
   -- Write --
   -----------

   procedure Write
     (Stream : not null access Ada.Streams.Root_Stream_Type'Class;
      Item   : Date_Time)
   is
      function Cast_Time is
        new Ada.Unchecked_Conversion (Raw_Time, Unsigned_16);
      function Cast_Date is
        new Ada.Unchecked_Conversion (Raw_Date, Unsigned_16);

      Year           : League.Calendars.ISO_8601.Year_Number;
      Month          : League.Calendars.ISO_8601.Month_Number;
      Day            : League.Calendars.ISO_8601.Day_Number;
      Hour           : League.Calendars.ISO_8601.Hour_Number;
      Minute         : League.Calendars.ISO_8601.Minute_Number;
      Second         : League.Calendars.ISO_8601.Second_Number;
      Nanosecond_100 : League.Calendars.ISO_8601.Nanosecond_100_Number;
   begin
      League.Calendars.ISO_8601.Split
        (League.Calendars.Date_Time (Item),
         Year, Month, Day,
         Hour, Minute, Second, Nanosecond_100);

      declare
         use type League.Calendars.ISO_8601.Year_Number;
         use type League.Calendars.ISO_8601.Second_Number;

         Time   : constant Raw_Time :=
           (Hours   => Hour,
            Minutes => Minute,
            Seconds => Second / 2);
         Date   : constant Raw_Date :=
           (Year  => Year - 1980,
            Month => Month,
            Day   => Day);
         Output_Time : Unsigned_16 := Cast_Time (Time);
         Output_Date : Unsigned_16 := Cast_Date (Date);
      begin
         Unsigned_16'Write (Stream, Output_Time);
         Unsigned_16'Write (Stream, Output_Date);
      end;
   end Write;

end Zip.IO_Types;
