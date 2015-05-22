with League.Strings;
with Ada.Containers.Vectors;
with Ada.Containers.Hashed_Maps;

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
      Result : out Document;
      Force  : Boolean := False);
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
      Nest_Output,
      Concat_Output,
      Union_Output);

   type Output_Item (Kind : Output_Kinds := Empty_Output) is record
      case Kind is
         when Empty_Output =>
            null;
         when New_Line_Output =>
            Force : Boolean;
         when Text_Output =>
            Text : League.Strings.Universal_String;
         when Nest_Output =>
            Indent : Natural := 0;
            Down   : Document;
         when Union_Output | Concat_Output =>
            Left, Right : Document;
            --  For union there is next invariant:
            --  Length (First_Line (left)) >= Max (Length (First_Line (right)))
      end case;
   end record;

   function Hash (Item : Output_Item) return Ada.Containers.Hash_Type;

   package Maps is new Ada.Containers.Hashed_Maps
     (Key_Type        => Output_Item,
      Element_Type    => Document,
      Hash            => Hash,
      Equivalent_Keys => "=",
      "="             => "=");

   package Output_Item_Vectors is new Ada.Containers.Vectors
     (Index_Type   => Document,
      Element_Type => Output_Item,
      "="          => "=");

   type Printer is tagged limited record
      Store : Output_Item_Vectors.Vector;
      Back  : Maps.Map;
   end record;

   procedure Append
     (Self  : in out Printer;
      Item  : Output_Item;
      Index : out Document);

   procedure Flatten
     (Self   : in out Printer;
      Input  : Document;
      Result : out Document);

end Outputs;
