with League.Strings;

with UI.Widgets.Grid_Views;
with UI.Grid_Models;

package Grid is

   type My_Row is new UI.Grid_Models.Abstract_Row with record
      Index : Positive;
   end record;

   type My_Row_Access is access all My_Row;

   type Rows is array (1 .. 30) of My_Row_Access;

   type Grid_Model is new UI.Grid_Models.Grid_Model with record
      My_Row : Rows;
   end record;

   procedure Initialize (Self : in out Grid_Model);

   overriding function Column_Count
     (Self   : not null access Grid_Model) return Natural;

   overriding function Row_Count
     (Self   : not null access Grid_Model;
      Parent : UI.Grid_Models.Row_Access := null) return Natural;

   overriding function Row
     (Self   : not null access Grid_Model;
      Index  : Positive;
      Parent : UI.Grid_Models.Row_Access := null)
      return not null UI.Grid_Models.Row_Access;

   overriding function Row_Index
     (Self   : not null access Grid_Model;
      Index  : UI.Grid_Models.Row_Access)
      return Positive;

   overriding function Parent
     (Self  : not null access Grid_Model;
      Index : not null UI.Grid_Models.Row_Access)
      return UI.Grid_Models.Row_Access;

   overriding procedure Visit_Cell
     (Self    : not null access Grid_Model;
      Index   : not null UI.Grid_Models.Row_Access;
      Column  : Positive;
      Visiter : not null access UI.Grid_Models.Cell_Visiter'Class);

   type Grid_Header is new UI.Widgets.Grid_Views.Grid_Header with null record;

   overriding function Text
     (Self   : not null access Grid_Header;
      Column : Positive) return League.Strings.Universal_String;

   overriding function Width
     (Self   : not null access Grid_Header;
      Column : Positive) return Natural;

   overriding function Text_Align
     (Self   : not null access Grid_Header;
      Column : Positive) return UI.Widgets.Grid_Views.Align;

   Header : aliased Grid_Header;
   Model  : aliased Grid_Model;
end Grid;
