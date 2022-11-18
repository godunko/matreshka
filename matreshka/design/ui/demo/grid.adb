package body Grid is

   ------------------
   -- Column_Count --
   ------------------

   overriding function Column_Count
     (Self   : not null access Grid_Model) return Natural is
   begin
      return 2;
   end Column_Count;

   ---------------
   -- Row_Count --
   ---------------

   overriding function Row_Count
     (Self   : not null access Grid_Model;
      Parent : UI.Grid_Models.Row_Access := null) return Natural is
   begin
      return Self.My_Row'Length;
   end Row_Count;

   ---------
   -- Row --
   ---------

   overriding function Row
     (Self   : not null access Grid_Model;
      Index  : Positive;
      Parent : UI.Grid_Models.Row_Access := null)
      return not null UI.Grid_Models.Row_Access
   is
   begin
      return UI.Grid_Models.Row_Access (Self.My_Row (Index));
   end Row;

   ---------------
   -- Row_Index --
   ---------------

   overriding function Row_Index
     (Self   : not null access Grid_Model;
      Index  : UI.Grid_Models.Row_Access) return Positive is
   begin
      return My_Row (Index.all).Index;
   end Row_Index;

   ------------
   -- Parent --
   ------------

   overriding function Parent
     (Self  : not null access Grid_Model;
      Index : not null UI.Grid_Models.Row_Access)
      return UI.Grid_Models.Row_Access is
   begin
      return null;
   end Parent;

   ----------------
   -- Visit_Cell --
   ----------------

   overriding procedure Visit_Cell
     (Self    : not null access Grid_Model;
      Index   : not null UI.Grid_Models.Row_Access;
      Column  : Positive;
      Visiter : not null access UI.Grid_Models.Cell_Visiter'Class)
   is
      use type League.Strings.Universal_String;
   begin
      if Column = 1 then
         Visiter.Integer_Cell (Value => My_Row (Index.all).Index);
      else
         Visiter.String_Cell
           (Value => League.Strings.To_Universal_String ("value") &
             Integer'Wide_Wide_Image (My_Row (Index.all).Index));
      end if;
   end Visit_Cell;

   ----------
   -- Text --
   ----------

   overriding function Text
     (Self   : not null access Grid_Header;
      Column : Positive) return League.Strings.Universal_String is
   begin
      if Column = 1 then
         return League.Strings.To_Universal_String ("Id");
      else
         return League.Strings.To_Universal_String ("Value");
      end if;
   end Text;

   -----------
   -- Width --
   -----------

   overriding function Width
     (Self   : not null access Grid_Header;
      Column : Positive) return Natural is
   begin
      return 150;
   end Width;

   ----------------
   -- Text_Align --
   ----------------

   overriding function Text_Align
     (Self   : not null access Grid_Header;
      Column : Positive)
      return UI.Widgets.Grid_Views.Align
   is
   begin
      return UI.Widgets.Grid_Views.Right;
   end Text_Align;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Self : in out Grid_Model) is
   begin
      for J in Self.My_Row'Range loop
         Self.My_Row (J) := new My_Row;
         Self.My_Row (J).Index := J;
      end loop;
   end Initialize;

end Grid;
