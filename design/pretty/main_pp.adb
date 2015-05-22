with Outputs; use Outputs;

with Ada.Wide_Wide_Text_IO;

with League.Strings;

procedure Main_PP is
   X : Printer;

   function "+"
     (Left : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   package Trees is
      type Node;

      type Node_Array is array (Positive range <>) of access Node;

      type Node (Length : Natural) is record
         S : League.Strings.Universal_String;
         TS : Node_Array (1 .. Length);
      end record;

      C : aliased Node := (0, +"ccc", (others => null));
      D : aliased Node := (0, +"dd", (others => null));
      E : aliased Node := (0, +"eee", (others => null));
      G : aliased Node := (0, +"gg", (others => null));
      H : aliased Node := (0, +"hhh", (others => null));
      I : aliased Node := (0, +"ii", (others => null));
      B : aliased Node := (2, +"bbbbb", (C'Access, D'Access));
      F : aliased Node := (3, +"ffff", (G'Access, H'Access, I'Access));
      A : aliased Node := (3, +"aaa", (B'Access, E'Access, F'Access));

      function Show_Tree (T : access Node) return Document;
      function Show_Bracket (List : Node_Array) return Document;
      function Show_Trees (List : Node_Array) return Document;
   end Trees;

   package body Trees is

      function Show_Bracket (List : Node_Array) return Document is
         Down : Document;
         Temp : Document;
      begin
         if List'Length = 0 then
            X.Nil (Down);
            return Down;
         end if;

         Down := Show_Trees (List);

         X.Nest (1, Down, Down);
         X.Text (+"[", Temp);
         X.Concat (Temp, Down, Down);
         X.Text (+"]", Temp);
         X.Concat (Down, Temp, Down);

         return Down;
      end Show_Bracket;

      function Show_Tree (T : access Node) return Document is
         Down : Document := Show_Bracket (T.TS);
         Temp : Document;
      begin
         X.Nest (T.S.Length, Down, Down);
         X.Text (T.S, Temp);
         X.Concat (Temp, Down, Temp);
         X.Group (Temp, Temp);

         return Temp;
      end Show_Tree;

      function Show_Trees (List : Node_Array) return Document is
         Down : Document := Show_Tree (List (List'First));
         Temp : Document;
      begin
         if List'Length > 1 then
            X.Text (+",", Temp);
            X.Concat (Down, Temp, Down);
            X.New_Line (Temp);
            X.Concat (Down, Temp, Down);
            Temp := Show_Trees (List (List'First + 1 .. List'Last));
            X.Concat (Down, Temp, Down);

         end if;

         return Down;
      end Show_Trees;
   end Trees;

   W : Document;
begin
   X.Initialize;
   W := Trees.Show_Tree (Trees.A'Access);

   Ada.Wide_Wide_Text_IO.Put_Line
     (X.Pretty (30, W).To_Wide_Wide_String);
end Main_PP;
