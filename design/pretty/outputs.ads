with League.Strings;
with Ada.Containers.Vectors;

package Outputs is

   type Document is private;

   type Printer is tagged limited private;

   procedure Initialize (Self : in out Printer);

   procedure Nil
     (Self   : in out Printer;
      Result : out Document);
   --  Create empty document

   procedure Text
     (Self   : in out Printer;
      Line   : League.Strings.Universal_String;
      Result : out Document);
   --  Create document with single line of given Text

   procedure New_Line
     (Self   : in out Printer;
      Result : out Document);
   --  Create document with single new line character

   procedure Nest
     (Self   : in out Printer;
      Indent : Natural;
      Input  : Document;
      Result : out Document);
   --  Create document where each new line char appended with Indent spaces

   procedure Concat
     (Self   : in out Printer;
      Left   : Document;
      Right  : Document;
      Result : out Document);
   --  Create document as join text from two documents

   procedure Group
     (Self   : in out Printer;
      Input  : Document;
      Result : out Document);
   --  Group all new lines in Input documend to fold together

   function Pretty
     (Self   : in out Printer;
      Width  : Positive;
      Input  : Document) return League.Strings.Universal_String;
   --  Convert Input document to string with given prefered line Width

private

   type Document is new Positive;

   type Output_Kinds is
     (Empty_Output,
      Text_Output,
      New_Line_Output,
      Union_Output);

   type Output_Item (Kind : Output_Kinds := Empty_Output) is record
      case Kind is
         when Empty_Output =>
            null;
         when Text_Output =>
            Text       : League.Strings.Universal_String;
            Text_Right : Document;
         when New_Line_Output =>
            Indent         : Natural := 0;
            New_Line_Right : Document;
         when Union_Output =>
            Left, Right : Document;
            --  Length (First_Line (left)) >= Max (Length (First_Line (right)))
      end case;
   end record;

   package Output_Item_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Document,
      Element_Type => Output_Item,
      "="          => "=");

   type Printer is tagged limited record
      Store : Output_Item_Vectors.Vector;
   end record;

   procedure Flatten
     (Self   : in out Printer;
      Input  : Document;
      Result : out Document);

   procedure Best
     (Self   : in out Printer;
      Width  : Positive;
      Placed : Natural;
      Input  : Document;
      Result : out Document);

   function Layout
     (Self   : Printer;
      Input  : Document) return League.Strings.Universal_String;

end Outputs;
