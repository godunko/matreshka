package body Outputs is

   ----------
   -- Best --
   ----------

   ------------
   -- Concat --
   ------------

   procedure Concat
     (Self   : in out Printer;
      Left   : Document;
      Right  : Document;
      Result : out Document) is
   begin
      Self.Store.Append ((Concat_Output, Left, Right));
      Result := Self.Store.Last_Index;
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
            Self.Store.Append ((Concat_Output, Down, Temp));
            Result := Self.Store.Last_Index;

         when Nest_Output =>
            Self.Flatten (Item.Nest_Right, Result);

         when New_Line_Output =>
            Result := 3;  --  Text ' '

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
      Self.Store.Append ((Union_Output, Down, Input));
      Result := Self.Store.Last_Index;
   end Group;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Self : in out Printer) is
   begin
      Self.Store.Append ((Kind => Empty_Output));   --  1
      Self.Store.Append ((Kind => New_Line_Output));  --  2
      Self.Store.Append  --  3
        ((Text_Output, League.Strings.To_Universal_String (" ")));
   end Initialize;

   ------------
   -- Layout --
   ------------

   ----------
   -- Nest --
   ----------

   procedure Nest
     (Self   : in out Printer;
      Indent : Natural;
      Input  : Document;
      Result : out Document)
   is
   begin
      Self.Store.Append ((Nest_Output, Indent, Input));
      Result := Self.Store.Last_Index;
   end Nest;

   --------------
   -- New_Line --
   --------------

   procedure New_Line
     (Self   : in out Printer;
      Result : out Document)
   is
      pragma Unreferenced (Self);
   begin
      Result := 2;
   end New_Line;

   ---------
   -- Nil --
   ---------

   procedure Nil
     (Self   : in out Printer;
      Result : out Document) is
      pragma Unreferenced (Self);
   begin
      Result := 1;
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

         type Pair is record
            Indent : Natural;
            Doc    : Outputs.Document;
         end record;

         type Pair_Array is array (Positive range <>) of Pair;

         procedure Best
           (Placed : Natural;
            List   : Pair_Array;
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
            List   : Pair_Array;
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

            Input  : constant Outputs.Document := List (List'First).Doc;
            Indent : constant Natural := List (List'First).Indent;
            Item   : constant Outputs.Output_Item := Self.Store.Element (Input);
            Down   : Document;
            Tail   : Pair_Array renames List (List'First + 1 .. List'Last);
         begin
            case Item.Kind is
               when Empty_Output =>
                  if Tail'Length = 0 then
                     Result := 1;  --  Nil
                  else
                     Best
                       (Placed => Placed,
                        List   => Tail,
                        Result => Result);
                  end if;

               when Concat_Output =>
                  Best
                    (Placed => Placed,
                     List   => Pair'(Indent, Item.Left) &
                               Pair'(Indent, Item.Right) &
                               Tail,
                     Result => Result);

               when Nest_Output =>
                  Best
                    (Placed => Placed,
                     List   => Pair'(Indent + Item.Indent, Item.Nest_Right) &
                               Tail,
                     Result => Result);

               when Text_Output =>
                  if Tail'Length = 0 then
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
                  if Tail'Length = 0 then
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
                  if Width >= Placed then
                     Best
                       (Placed => Placed,
                        List   => Pair'(Indent, Item.Left) & Tail,
                        Result => Down);

                     if not Fits (Down, Width - Placed) then
                        Best
                          (Placed => Placed,
                           List   => Pair'(Indent, Item.Right) & Tail,
                           Result => Down);
                     end if;
                  else
                     Best
                       (Placed => Placed,
                        List   => Pair'(Indent, Item.Right) & Tail,
                        Result => Down);
                  end if;

                  Result := Down;
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
   begin
      Formatted_Documents.Best
        (Placed => 0,
         List   => (1 => (0, Input)),
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
      Self.Store.Append ((Text_Output, Line));
      Result := Self.Store.Last_Index;
   end Text;

end Outputs;
