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
      Index : out Document)
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
   -- Concat --
   ------------

   procedure Concat
     (Self   : in out Printer;
      Left   : Document;
      Right  : Document;
      Result : out Document) is
   begin
      Self.Append ((Concat_Output, Left, Right), Result);
   end Concat;

   -------------
   -- Flatten --
   -------------

   procedure Flatten
     (Self   : in out Printer;
      Input  : Document;
      Result : out Document)
   is
      Item : constant Output_Item := Self.Store.Element (Input);
      Temp : Document;
      Down : Document;
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
      Input  : Document;
      Result : out Document)
   is
      Down : Document;
   begin
      Self.Flatten (Input, Down);

      if Input = Down  then
         Result := Input;
      else
         Self.Append ((Union_Output, Down, Input), Result);
      end if;
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

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Self : in out Printer) is
   begin
      null;
   end Initialize;

   ----------
   -- Nest --
   ----------

   procedure Nest
     (Self   : in out Printer;
      Indent : Natural;
      Input  : Document;
      Result : out Document) is
   begin
      Self.Append ((Nest_Output, Indent, Input), Result);
   end Nest;

   --------------
   -- New_Line --
   --------------

   procedure New_Line
     (Self   : in out Printer;
      Result : out Document;
      Force  : Boolean := False) is
   begin
      Self.Append ((New_Line_Output, Force), Result);
   end New_Line;

   ---------
   -- Nil --
   ---------

   procedure Nil
     (Self   : in out Printer;
      Result : out Document) is
   begin
      Self.Append ((Kind => Empty_Output), Result);
   end Nil;

   ------------
   -- Pretty --
   ------------

   function Pretty
     (Self   : in out Printer;
      Width  : Positive;
      Input  : Document) return League.Strings.Universal_String
   is
      package Formatted_Documents is

         type Document is new Positive;

         type Output_Kinds is
           (Empty_Output,
            Text_Output,
            New_Line_Output);

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
            end case;
         end record;

         package Output_Item_Vectors is new Ada.Containers.Vectors
           (Index_Type   => Document,
            Element_Type => Output_Item,
            "="          => "=");

         Store : Output_Item_Vectors.Vector;

         type Pair;
         type Pair_Access is access all Pair;
         type Pair is record
            Indent : Natural;
            Doc    : Outputs.Document;
            Next   : Pair_Access;
         end record;

         procedure Best
           (Placed : Natural;
            List   : Pair_Access;
            Result : out Document);

         function Layout
           (Input  : Document) return League.Strings.Universal_String;

      end Formatted_Documents;

      package body Formatted_Documents is

         ----------
         -- Best --
         ----------

         procedure Best
           (Placed : Natural;
            List   : Pair_Access;
            Result : out Document)
         is
            function Fits
              (Index : Document;
               Width : Natural) return Boolean;

            ----------
            -- Fits --
            ----------

            function Fits
              (Index : Document;
               Width : Natural) return Boolean
            is
               Item : constant Output_Item := Store.Element (Index);
            begin
               case Item.Kind is
                  when Empty_Output =>
                     return True;

                  when Text_Output =>
                     if Width >= Item.Text.Length then
                        return Fits (Item.Text_Right, Width - Item.Text.Length);
                     else
                        return False;
                     end if;

                  when New_Line_Output =>
                     return True;

               end case;
            end Fits;

            Input  : constant Outputs.Document := List.Doc;
            Indent : constant Natural := List.Indent;
            Tail   : constant Pair_Access := List.Next;
            Item   : constant Outputs.Output_Item := Self.Store.Element (Input);
            Down   : Document;
         begin
            case Item.Kind is
               when Empty_Output =>
                  if Tail = null then
                     Result := 1;  --  Nil
                  else
                     Best
                       (Placed => Placed,
                        List   => Tail,
                        Result => Result);
                  end if;

               when Concat_Output =>
                  declare
                     Right : aliased Pair := (Indent, Item.Right, Tail);
                     Left  : aliased Pair :=
                       (Indent, Item.Left, Right'Unchecked_Access);
                  begin
                     Best
                       (Placed => Placed,
                        List   => Left'Unchecked_Access,
                        Result => Result);
                  end;

               when Nest_Output =>
                  declare
                     Down : aliased Pair :=
                       (Indent + Item.Indent, Item.Down, Tail);
                  begin
                     Best
                       (Placed => Placed,
                        List   => Down'Unchecked_Access,
                        Result => Result);
                  end;

               when Text_Output =>
                  if Tail = null then
                     Down := 1;  --  Nil
                  else
                     Best
                       (Placed => Placed + Item.Text.Length,
                        List   => Tail,
                        Result => Down);
                  end if;

                  Store.Append ((Text_Output, Item.Text, Down));
                  Result := Store.Last_Index;

               when New_Line_Output =>
                  if Tail = null then
                     Down := 1;  --  Nil
                  else
                     Best
                       (Placed => Indent,
                        List   => Tail,
                        Result => Down);
                  end if;

                  Store.Append ((New_Line_Output, Indent, Down));
                  Result := Store.Last_Index;

               when Union_Output =>
                  declare
                     Left  : aliased Pair := (Indent, Item.Left, Tail);
                     Right : aliased Pair := (Indent, Item.Right, Tail);
                  begin
                     if Width >= Placed then
                        Best
                          (Placed => Placed,
                           List   => Left'Unchecked_Access,
                           Result => Down);

                        if not Fits (Down, Width - Placed) then
                           Best
                             (Placed => Placed,
                              List   => Right'Unchecked_Access,
                              Result => Down);
                        end if;
                     else
                        Best
                          (Placed => Placed,
                           List   => Right'Unchecked_Access,
                           Result => Down);
                     end if;

                     Result := Down;
                  end;
            end case;
         end Best;

         ------------
         -- Layout --
         ------------

         function Layout
           (Input  : Document) return League.Strings.Universal_String
         is
            use type League.Strings.Universal_String;

            Item : constant Output_Item := Store.Element (Input);
            Temp : League.Strings.Universal_String;
         begin
            case Item.Kind is
               when Empty_Output =>
                  return League.Strings.Empty_Universal_String;

               when Text_Output =>
                  Temp := Layout (Item.Text_Right);

                  return Item.Text & Temp;

               when New_Line_Output =>
                  declare
                     NL    : constant Wide_Wide_Character :=
                       Wide_Wide_Character'Val (10);
                     Space : constant Wide_Wide_String := (1 .. Item.Indent => ' ');
                  begin
                     Temp := Layout (Item.New_Line_Right);

                     return NL & Space & Temp;
                  end;

            end case;
         end Layout;

      begin
         Store.Append ((Kind => Empty_Output));   --  1
      end Formatted_Documents;

      Temp : Formatted_Documents.Document;
      Head : aliased Formatted_Documents.Pair := (0, Input, null);
   begin
      Formatted_Documents.Best
        (Placed => 0,
         List   => Head'Access,
         Result => Temp);

      return Formatted_Documents.Layout (Temp);
   end Pretty;

   ----------
   -- Text --
   ----------

   procedure Text
     (Self   : in out Printer;
      Line   : League.Strings.Universal_String;
      Result : out Document) is
   begin
      Self.Append ((Text_Output, Line), Result);
   end Text;

end Outputs;
