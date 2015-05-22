package body Outputs is

   ----------
   -- Best --
   ----------

   procedure Best
     (Self   : in out Printer;
      Width  : Positive;
      Placed : Natural;
      Input  : Document;
      Result : out Document)
   is
      function Fits
        (Index : Document;
         Width : Natural) return Boolean;

      function Fits
        (Index : Document;
         Width : Natural) return Boolean
      is
         Item : constant Output_Item := Self.Store.Element (Index);
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

            when others =>
               raise Constraint_Error;
         end case;
      end Fits;

      Item : constant Output_Item := Self.Store.Element (Input);
      Down : Document;
   begin
      case Item.Kind is
         when Empty_Output =>
            Result := Input;

         when Text_Output =>
            Self.Best
              (Width,
               Placed + Item.Text.Length,
               Item.Text_Right,
               Down);

            if Down = Item.Text_Right then
               Result := Input;
            else
               Self.Store.Append ((Text_Output, Item.Text, Down));
               Result := Self.Store.Last_Index;
            end if;

         when New_Line_Output =>
            Self.Best (Width, Item.Indent, Item.New_Line_Right, Down);

            if Down = Item.New_Line_Right then
               Result := Input;
            else
               Self.Store.Append ((New_Line_Output, Item.Indent, Down));
               Result := Self.Store.Last_Index;
            end if;

         when Union_Output =>
            if Width >= Placed then
               Self.Best (Width, Placed, Item.Left, Down);

               if not Fits (Down, Width - Placed) then
                  Self.Best (Width, Placed, Item.Right, Down);
               end if;
            else
               Self.Best (Width, Placed, Item.Right, Down);
            end if;

            Result := Down;
      end case;
   end Best;

   ------------
   -- Concat --
   ------------

   procedure Concat
     (Self   : in out Printer;
      Left   : Document;
      Right  : Document;
      Result : out Document)
   is
      Item : constant Output_Item := Self.Store.Element (Left);
      Down : Document;
      Temp : Document;
   begin
      case Item.Kind is
         when Empty_Output =>
            Result := Right;

         when Text_Output =>
            Self.Concat (Item.Text_Right, Right, Down);

            if Down = Item.Text_Right then
               Result := Left;
            else
               Self.Store.Append ((Text_Output, Item.Text, Down));
               Result := Self.Store.Last_Index;
            end if;

         when New_Line_Output =>
            Self.Concat (Item.New_Line_Right, Right, Down);

            if Down = Item.New_Line_Right then
               Result := Left;
            else
               Self.Store.Append ((New_Line_Output, Item.Indent, Down));
               Result := Self.Store.Last_Index;
            end if;

         when Union_Output =>
            Self.Concat (Item.Left, Right, Down);
            Self.Concat (Item.Right, Right, Temp);

            if Item.Left = Down and Item.Right = Temp then
               Result := Left;
            else
               Self.Store.Append ((Union_Output, Down, Temp));
               Result := Self.Store.Last_Index;
            end if;

      end case;
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
      Down : Document;
   begin
      case Item.Kind is
         when Empty_Output =>
            Result := Input;

         when Text_Output =>
            Self.Flatten (Item.Text_Right, Down);

            if Down = Item.Text_Right then
               Result := Input;
            else
               Self.Store.Append ((Text_Output, Item.Text, Down));
               Result := Self.Store.Last_Index;
            end if;

         when New_Line_Output =>
            Self.Flatten (Item.New_Line_Right, Down);
            Self.Store.Append
              ((Text_Output, League.Strings.To_Universal_String (" "), Down));
            Result := Self.Store.Last_Index;

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
      Item : constant Output_Item := Self.Store.Element (Input);
      Down : Document;
   begin
      case Item.Kind is
         when Empty_Output =>
            Result := Input;

         when Text_Output =>
            Self.Group (Item.Text_Right, Down);

            if Down = Item.Text_Right then
               Result := Input;
            else
               Self.Store.Append ((Text_Output, Item.Text, Down));
               Result := Self.Store.Last_Index;
            end if;

         when New_Line_Output =>
            Self.Flatten (Input, Down);
            Self.Store.Append ((Union_Output, Down, Input));
            Result := Self.Store.Last_Index;

         when Union_Output =>
            Self.Group (Item.Left, Down);

            if Down = Item.Left then
               Result := Input;
            else
               Self.Store.Append ((Union_Output, Down, Item.Right));
               Result := Self.Store.Last_Index;
            end if;

      end case;

   end Group;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Self : in out Printer) is
   begin
      Self.Store.Append ((Kind => Empty_Output));   --  1
      Self.Store.Append ((New_Line_Output, 0, 1));  --  2
   end Initialize;

   ------------
   -- Layout --
   ------------

   function Layout
     (Self   : Printer;
      Input  : Document) return League.Strings.Universal_String
   is
      use type League.Strings.Universal_String;

      Item : constant Output_Item := Self.Store.Element (Input);
      Temp : League.Strings.Universal_String;
   begin
      case Item.Kind is
         when Empty_Output =>
            return League.Strings.Empty_Universal_String;

         when Text_Output =>
            Temp := Self.Layout (Item.Text_Right);

            return Item.Text & Temp;

         when New_Line_Output =>
            declare
               NL    : constant Wide_Wide_Character :=
                 Wide_Wide_Character'Val (10);
               Space : constant Wide_Wide_String := (1 .. Item.Indent => ' ');
            begin
               Temp := Self.Layout (Item.New_Line_Right);

               return NL & Space & Temp;
            end;

         when Union_Output =>
            raise Constraint_Error;
      end case;
   end Layout;

   ----------
   -- Nest --
   ----------

   procedure Nest
     (Self   : in out Printer;
      Indent : Natural;
      Input  : Document;
      Result : out Document)
   is
      Item : constant Output_Item := Self.Store.Element (Input);
      Temp : Document;
      Down : Document;
   begin
      case Item.Kind is
         when Empty_Output =>
            Result := Input;

         when Text_Output =>
            Self.Nest (Indent, Item.Text_Right, Down);

            if Down = Item.Text_Right then
               Result := Input;
            else
               Self.Store.Append ((Text_Output, Item.Text, Down));
               Result := Self.Store.Last_Index;
            end if;

         when New_Line_Output =>
            Self.Nest (Indent, Item.New_Line_Right, Temp);

            Self.Store.Append
              ((New_Line_Output, Indent + Item.Indent, Temp));
            Result := Self.Store.Last_Index;

         when Union_Output =>
            Self.Nest (Indent, Item.Left, Down);
            Self.Nest (Indent, Item.Right, Temp);
            Self.Store.Append ((Union_Output, Down, Temp));
            Result := Self.Store.Last_Index;

      end case;
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
      Temp : Document;
   begin
      Self.Best
        (Width  => Width,
         Placed => 0,
         Input  => Input,
         Result => Temp);

      return Self.Layout (Temp);
   end Pretty;

   ----------
   -- Text --
   ----------

   procedure Text
     (Self   : in out Printer;
      Line   : League.Strings.Universal_String;
      Result : out Document) is
   begin
      Self.Store.Append ((Text_Output, Line, 1));
      Result := Self.Store.Last_Index;
   end Text;

end Outputs;
