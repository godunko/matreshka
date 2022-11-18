with Ada.Streams;
with Matreshka.Filters.Deflate.Unpack;
with Matreshka.Filters.LZMA.XZ_Unpack;
with League.Stream_Element_Vectors;
with League.Strings;
with League.Text_Codecs;
with Ada.Wide_Wide_Text_IO;

procedure Main is
   package D renames Matreshka.Filters.Deflate.Unpack;

   Data_1 : constant Ada.Streams.Stream_Element_Array :=
     (16#73#, 16#49#, 16#4D#, 16#CB#, 16#49#, 16#2C#, 16#49#, 16#55#,
      16#00#, 16#11#);

   Data_2 : constant Ada.Streams.Stream_Element_Array :=
     (16#0D#, 16#C8#, 16#41#, 16#0A#, 16#80#, 16#20#, 16#10#, 16#05#,
      16#D0#, 16#7D#, 16#D0#, 16#1D#, 16#FE#, 16#09#, 16#BA#, 16#84#,
      16#EB#, 16#A0#, 16#2B#, 16#4C#, 16#FA#, 16#B5#, 16#01#, 16#1D#,
      16#21#, 16#27#, 16#A1#, 16#DB#, 16#D7#, 16#5B#, 16#BE#, 16#D0#,
      16#AD#, 16#DC#, 16#E2#, 16#4F#, 16#15#, 16#D7#, 16#6E#, 16#03#,
      16#DD#, 16#70#, 16#32#, 16#F6#, 16#A6#, 16#56#, 16#20#, 16#86#,
      16#3D#, 16#1C#, 16#1B#, 16#8E#, 16#4A#, 16#19#, 16#FC#, 16#1F#,
      16#92#, 16#A6#, 16#0E#, 16#26#, 16#F8#, 16#25#, 16#0E#, 16#E6#,
      16#CC#, 16#E8#, 16#3A#, 16#09#, 16#6D#, 16#8D#, 16#49#, 16#C5#,
      16#59#, 16#DF#, 16#75#, 16#F9#, 16#00#);

   Text_1 : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String ("Deflate late");

   Text_2 : constant League.Strings.Universal_String :=
     League.Strings.To_Universal_String
       ("Congratulations on becoming an MCP. Please be advised that "
        & "effective immediately"
        & Wide_Wide_Character'Val (13)
        & Wide_Wide_Character'Val (10));

   procedure Check
     (Data : League.Stream_Element_Vectors.Stream_Element_Vector;
      Text : League.Strings.Universal_String);

   -----------
   -- Check --
   -----------

   procedure Check
     (Data : League.Stream_Element_Vectors.Stream_Element_Vector;
      Text : League.Strings.Universal_String)
   is
      use type League.Strings.Universal_String;

      Result : constant League.Strings.Universal_String :=
        League.Text_Codecs.Codec_For_Application_Locale.Decode (Data);
   begin
      if Result /= Text then
         Ada.Wide_Wide_Text_IO.Put_Line (Result.To_Wide_Wide_String);
         raise Program_Error;
      end if;
   end Check;

   Input  : League.Stream_Element_Vectors.Stream_Element_Vector;
   Output : League.Stream_Element_Vectors.Stream_Element_Vector;

begin
   D.Initialize;
   declare
      Filter : Matreshka.Filters.LZMA.XZ_Unpack.Filter;
      Data : constant Ada.Streams.Stream_Element_Array :=
        (16#FD#, 16#37#, 16#7A#, 16#58#, 16#5A#, 16#00#, 16#00#, 16#04#,
         16#E6#, 16#D6#, 16#B4#, 16#46#, 16#02#, 16#00#, 16#21#, 16#01#,
         16#16#, 16#00#, 16#00#, 16#00#, 16#74#, 16#2F#, 16#E5#, 16#A3#,
         16#E0#, 16#02#, 16#E5#, 16#01#, 16#B5#, 16#5D#, 16#00#, 16#10#,
         16#11#, 16#C8#, 16#A6#, 16#C3#, 16#29#, 16#15#, 16#28#, 16#39#,
         16#2F#, 16#4D#, 16#65#, 16#2E#, 16#89#, 16#FB#, 16#E2#, 16#73#,
         16#4B#, 16#43#, 16#9F#, 16#80#, 16#F9#, 16#A3#, 16#EA#, 16#DA#,
         16#40#, 16#12#, 16#04#, 16#96#, 16#45#, 16#00#, 16#1A#, 16#09#,
         16#1A#, 16#F0#, 16#8E#, 16#8F#, 16#22#, 16#78#, 16#A8#, 16#80#,
         16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
         16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
         16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#);
   begin
      Input.Append (Data);
      Filter.Read (Input, Output);
   end;

   declare
      Filter : D.Filter;
   begin
      Input.Append (Data_1);

      Filter.Read (Input, Output);
      Filter.Flush (Output);
      Check (Output, Text_1);
      Input.Clear;
      Output.Clear;
   end;

   declare
      Filter : D.Filter;
   begin
      Input.Append (Data_2);

      Filter.Read (Input, Output);
      Filter.Flush (Output);
      Check (Output, Text_2);
      Input.Clear;
      Output.Clear;
   end;

   declare
      Filter : D.Filter;
   begin
      for J in Data_1'Range loop
         Input.Clear;
         Input.Append (Data_1 (J));

         Filter.Read (Input, Output);
      end loop;

      Filter.Flush (Output);
      Check (Output, Text_1);
      Input.Clear;
      Output.Clear;
   end;

   declare
      Filter : D.Filter;
   begin
      for J in Data_2'Range loop
         Input.Clear;
         Input.Append (Data_2 (J));

         Filter.Read (Input, Output);
      end loop;

      Filter.Flush (Output);
      Check (Output, Text_2);
      Input.Clear;
      Output.Clear;
   end;

end Main;
