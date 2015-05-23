with League.Strings.Hash;

package body Outputs is

   Space : constant Output_Item :=
     (Kind => Text_Output, Text => League.Strings.To_Universal_String (" "));

   ------------
   -- Append --
   ------------

   procedure Append
     (Self  : in out Printer;
      Item  : Output_Item;
      Index : out Document_Index)
   is
      Cursor : constant Maps.Cursor := Self.Back.Find (Item);
   begin
      if Maps.Has_Element (Cursor) then
         Index := Maps.Element (Cursor);
      else
         Self.Store.Append (Item);
         Index := Self.Store.Last_Index;
         Self.Back.Insert (Item, Index);
      end if;
   end Append;

   ------------
   -- Append --
   ------------

   not overriding function Append
     (Self  : Document'Class;
      Right : Document'Class) return Document
   is
      Index : Document_Index;
   begin
      Self.Printer.Concat (Self.Index, Right.Index, Index);
      return (Self.Printer, Index);
   end Append;

   ------------
   -- Append --
   ------------

   not overriding function Put
     (Self  : Document'Class;
      Right : League.Strings.Universal_String) return Document
   is
      Index : Document_Index;
   begin
      Self.Printer.Text (Right, Index);
      Self.Printer.Concat (Self.Index, Index, Index);
      return (Self.Printer, Index);
   end Put;

   ------------
   -- Append --
   ------------

   not overriding function Put
     (Self  : Document'Class;
      Right : Wide_Wide_String) return Document is
   begin
      return Self.Put (League.Strings.To_Universal_String (Right));
   end Put;

   ------------
   -- Append --
   ------------

   not overriding procedure Append
     (Self   : in out Document;
      Right  : Document'Class) is
   begin
      Self.Printer.Concat (Self.Index, Right.Index, Self.Index);
   end Append;

   ------------
   -- Append --
   ------------

   not overriding procedure Put
     (Self   : in out Document;
      Right  : League.Strings.Universal_String)
   is
      Index : Document_Index;
   begin
      Self.Printer.Text (Right, Index);
      Self.Printer.Concat (Self.Index, Index, Self.Index);
   end Put;

   ------------
   -- Append --
   ------------

   not overriding procedure Put
     (Self   : in out Document;
      Right  : Wide_Wide_String) is
   begin
      Self.Put (League.Strings.To_Universal_String (Right));
   end Put;

   -----------------
   -- Append_Line --
   -----------------

   not overriding procedure Put_Line
     (Self   : in out Document;
      Right : Wide_Wide_String) is
   begin
      Self.Put (Right);
      Self.New_Line;
   end Put_Line;

   ------------
   -- Concat --
   ------------

   procedure Concat
     (Self   : in out Printer;
      Left   : Document_Index;
      Right  : Document_Index;
      Result : out Document_Index) is
   begin
      Self.Append ((Concat_Output, Left, Right), Result);
   end Concat;

   -----------
   -- Empty --
   -----------

   not overriding function Empty
     (Self : access Printer'Class) return Document
   is
      Index : Document_Index;
   begin
      Self.Nil (Index);
      return (Self.all'Unchecked_Access, Index);
   end Empty;

   -------------
   -- Flatten --
   -------------

   procedure Flatten
     (Self   : in out Printer;
      Input  : Document_Index;
      Result : out Document_Index)
   is
      Item : constant Output_Item := Self.Store.Element (Input);
      Temp : Document_Index;
      Down : Document_Index;
   begin
      case Item.Kind is
         when Empty_Output | Text_Output =>
            Result := Input;

         when Concat_Output =>
            Self.Flatten (Item.Left, Down);
            Self.Flatten (Item.Right, Temp);
            Self.Append ((Concat_Output, Down, Temp), Result);

         when Nest_Output =>
            Self.Flatten (Item.Down, Result);

         when New_Line_Output =>
            if Item.Force then
               Result := Input;
            else
               Self.Append (Space, Result);
            end if;

         when Union_Output =>
            Self.Flatten (Item.Left, Result);

      end case;
   end Flatten;

   -----------
   -- Group --
   -----------

   procedure Group
     (Self   : in out Printer;
      Input  : Document_Index;
      Result : out Document_Index)
   is
      Down : Document_Index;
   begin
      Self.Flatten (Input, Down);

      if Input = Down  then
         Result := Input;
      else
         Self.Append ((Union_Output, Down, Input), Result);
      end if;
   end Group;

   -----------
   -- Group --
   -----------

   not overriding function Group (Self : Document'Class) return Document is
      Index : Document_Index;
   begin
      Self.Printer.Group (Self.Index, Index);
      return (Self.Printer, Index);
   end Group;

   -----------
   -- Group --
   -----------

   not overriding procedure Group (Self : in out Document) is
   begin
      Self.Printer.Group (Self.Index, Self.Index);
   end Group;
   ----------
   -- Hash --
   ----------

   function Hash (Item : Output_Item) return Ada.Containers.Hash_Type is
      use type Ada.Containers.Hash_Type;

   begin
      case Item.Kind is
         when Empty_Output =>
            return 1;

         when New_Line_Output =>
            return 2 + Boolean'Pos (Item.Force);

         when Text_Output =>
            return League.Strings.Hash (Item.Text);

         when Nest_Output =>
            return Ada.Containers.Hash_Type (Item.Indent) * 1046527 +
              Ada.Containers.Hash_Type (Item.Down);

         when Union_Output =>
            return Ada.Containers.Hash_Type (Item.Left) * 1046527 +
              16127 * Ada.Containers.Hash_Type (Item.Right);

         when Concat_Output =>
            return Ada.Containers.Hash_Type (Item.Left) * 1046527 -
              16127 * Ada.Containers.Hash_Type (Item.Right);
      end case;
   end Hash;

   ----------
   -- Nest --
   ----------

   procedure Nest
     (Self   : in out Printer;
      Indent : Natural;
      Input  : Document_Index;
      Result : out Document_Index) is
   begin
      Self.Append ((Nest_Output, Indent, Input), Result);
   end Nest;

   ----------
   -- Nest --
   ----------

   not overriding function Nest
     (Self   : Document'Class;
      Indent : Natural) return Document
   is
      Index : Document_Index;
   begin
      Self.Printer.Nest (Indent, Self.Index, Index);
      return (Self.Printer, Index);
   end Nest;

   ----------
   -- Nest --
   ----------

   not overriding procedure Nest
     (Self   : in out Document;
      Indent : Natural) is
   begin
      Self.Printer.Nest (Indent, Self.Index, Self.Index);
   end Nest;

   --------------
   -- New_Line --
   --------------

   procedure New_Line
     (Self   : in out Printer;
      Result : out Document_Index;
      Force  : Boolean := False) is
   begin
      Self.Append ((New_Line_Output, Force), Result);
   end New_Line;

   --------------
   -- New_Line --
   --------------

   not overriding function New_Line
     (Self : access Printer'Class;
      Gap  : Wide_Wide_String := " ") return Document
   is
      pragma Unreferenced (Gap);
      Index : Document_Index;
   begin
      Self.New_Line (Index);
      return (Self.all'Unchecked_Access, Index);
   end New_Line;

   --------------
   -- New_Line --
   --------------

   not overriding function New_Line
     (Self : Document'Class;
      Gap  : Wide_Wide_String := " ") return Document is
   begin
      return Self.Append (Self.Printer.New_Line (Gap));
   end New_Line;

   --------------
   -- New_Line --
   --------------

   not overriding procedure New_Line
     (Self : in out Document;
      Gap  : Wide_Wide_String := " ") is
   begin
      Self.Append (Self.Printer.New_Line (Gap));
   end New_Line;

   ---------
   -- Nil --
   ---------

   procedure Nil
     (Self   : in out Printer;
      Result : out Document_Index) is
   begin
      Self.Append ((Kind => Empty_Output), Result);
   end Nil;

   ------------
   -- Pretty --
   ------------

   function Pretty
     (Self   : in out Printer;
      Width  : Positive;
      Input  : Document'Class) return League.Strings.Universal_String
   is
      package Formatted_Documents is

         --  Formatted document is represented as sequence of Items.
         --  Item is either text (without new line) or
         --  new line together with indent spaces.

         type Item;
         type Document is access all Item'Class;

         type Item is abstract tagged limited record
            Next : aliased Document;
         end record;

         not overriding function Fits
           (Self  : Item;
            Width : Natural) return Boolean is abstract;
         --  Check if line started from given item fits given Width

         not overriding procedure Append
           (Self   : Item;
            Result : in out League.Strings.Universal_String) is abstract;
         --  Append text representation of given item to Result

         type Text_Item is new Item with record
            Text : League.Strings.Universal_String;
         end record;

         overriding function Fits
           (Self  : Text_Item;
            Width : Natural) return Boolean;

         overriding procedure Append
           (Self   : Text_Item;
            Result : in out League.Strings.Universal_String);

         type Line_Item is new Item with record
            Indent : Natural;
         end record;

         overriding function Fits
           (Self  : Line_Item;
            Width : Natural) return Boolean;

         overriding procedure Append
           (Self   : Line_Item;
            Result : in out League.Strings.Universal_String);

         type Pair;
         type Pair_Access is access all Pair;

         type Pair is record
            Indent   : Natural;
            Document : Outputs.Document_Index;
            Next     : Pair_Access;
         end record;

         function New_Pair
           (Indent : Natural;
            Doc    : Outputs.Document_Index;
            Next   : Pair_Access) return not null Pair_Access;

         function Best
           (Offset : Natural;
            List   : not null Pair_Access) return Document;

         function Layout
           (Input : Document) return League.Strings.Universal_String;

      end Formatted_Documents;

      package body Formatted_Documents is

         Free_List : Pair_Access;

         procedure Free_Pair (Value : Pair_Access);

         ------------
         -- Append --
         ------------

         overriding procedure Append
           (Self   : Text_Item;
            Result : in out League.Strings.Universal_String) is
         begin
            Result.Append (Self.Text);
         end Append;

         ------------
         -- Append --
         ------------

         overriding procedure Append
           (Self   : Line_Item;
            Result : in out League.Strings.Universal_String)
         is
            NL    : constant Wide_Wide_Character :=
              Wide_Wide_Character'Val (10);
            Space : constant Wide_Wide_String := (1 .. Self.Indent => ' ');
         begin
            Result.Append (NL);
            Result.Append (Space);
         end Append;

         ----------
         -- Best --
         ----------

         function Best
           (Offset : Natural;
            List   : not null Pair_Access) return Document
         is
            Placed : Natural := Offset;
            Head   : not null Pair_Access := List;
            Tail   : Pair_Access;  --  Shortcut for Head.Next
            Result : aliased Document;
            Hook   : access Document := Result'Access;
            Indent : Natural;
            Item   : Outputs.Output_Item;
         begin
            loop
               Indent := Head.Indent;
               Tail := Head.Next;
               Item := Self.Store.Element (Head.Document);

               case Item.Kind is
                  when Empty_Output =>
                     exit when Tail = null;

                     Head := Tail;

                  when Concat_Output =>
                     Head := New_Pair
                       (Indent,
                        Item.Left,
                        New_Pair (Indent, Item.Right, Tail));

                  when Nest_Output =>
                     Head := New_Pair (Indent + Item.Indent, Item.Down, Tail);

                  when Text_Output =>
                     Hook.all := new Text_Item'(null, Item.Text);

                     exit when Tail = null;

                     Hook   := Hook.all.Next'Access;
                     Placed := Placed + Item.Text.Length;
                     Head   := Tail;

                  when New_Line_Output =>
                     Hook.all := new Line_Item'(null, Indent);

                     exit when Tail = null;

                     Hook   := Hook.all.Next'Access;
                     Placed := Indent;
                     Head   := Tail;

                  when Union_Output =>
                     if Width >= Placed then
                        Head := New_Pair (Indent, Item.Left, Tail);

                        Hook.all := Best (Placed, Head);
                        Free_Pair (Head);

                        exit when Hook.all = null  --  Empty always fits
                          or else Hook.all.Fits (Width - Placed);

                     end if;

                     Head := New_Pair (Indent, Item.Right, Tail);

                     Hook.all := Best (Placed, Head);
                     Free_Pair (Head);

                     exit;
               end case;
            end loop;

            --  XXX Here we can free any Pair allocated in this call
            return Result;
         end Best;

         ----------
         -- Fits --
         ----------

         overriding function Fits
           (Self  : Text_Item;
            Width : Natural) return Boolean is
         begin
            if Width < Self.Text.Length then
               return False;
            elsif Self.Next = null then
               return True;
            else
               return Self.Next.Fits (Width - Self.Text.Length);
            end if;
         end Fits;

         ----------
         -- Fits --
         ----------

         overriding function Fits
           (Self  : Line_Item;
            Width : Natural) return Boolean
         is
            pragma Unreferenced (Self, Width);
         begin
            return True;  --  New line fits any width
         end Fits;

         ---------------
         -- Free_Pair --
         ---------------

         procedure Free_Pair (Value : Pair_Access) is
         begin
            Value.Next := Free_List;
            Free_List := Value;
         end Free_Pair;

         ------------
         -- Layout --
         ------------

         function Layout
           (Input  : Document) return League.Strings.Universal_String
         is
            Next   : Document := Input;
            Result : League.Strings.Universal_String;
         begin
            while Next /= null loop
               Next.Append (Result);
               Next := Next.Next;
            end loop;

            return Result;
         end Layout;

         --------------
         -- New_Pair --
         --------------

         function New_Pair
           (Indent : Natural;
            Doc    : Outputs.Document_Index;
            Next   : Pair_Access) return not null Pair_Access is
         begin
            if Free_List = null then
               return new Pair'(Indent, Doc, Next);
            else
               return Value : constant not null Pair_Access := Free_List do
                  Free_List := Value.Next;
                  Value.all := (Indent, Doc, Next);
               end return;
            end if;
         end New_Pair;

      end Formatted_Documents;

      Temp : Formatted_Documents.Document;
   begin
      Temp := Formatted_Documents.Best
        (Offset => 0,
         List   => Formatted_Documents.New_Pair (0, Input.Index, null));

      return Formatted_Documents.Layout (Temp);
   end Pretty;

   ----------
   -- Text --
   ----------

   procedure Text
     (Self   : in out Printer;
      Line   : League.Strings.Universal_String;
      Result : out Document_Index) is
   begin
      Self.Append ((Text_Output, Line), Result);
   end Text;

   ----------
   -- Text --
   ----------

   not overriding function Text
     (Self  : access Printer'Class;
      Value : League.Strings.Universal_String) return Document
   is
      Index : Document_Index;
   begin
      Self.Text (Value, Index);
      return (Self.all'Unchecked_Access, Index);
   end Text;

   ----------
   -- Text --
   ----------

   not overriding function Text
     (Self  : access Printer'Class;
      Value : Wide_Wide_String) return Document is
   begin
      return Self.Text (League.Strings.To_Universal_String (Value));
   end Text;

end Outputs;
