with League.Pretty_Printers; use League.Pretty_Printers;

with Ada.Wide_Wide_Text_IO;

with League.Strings;

procedure Main_PP is
   X : aliased Printer;

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
      begin
         if List'Length = 0 then
            return X.New_Document;
         end if;

         Down := Show_Trees (List).Nest (1);

         return X.New_Document.Put ("[").Append (Down).Put ("]");
      end Show_Bracket;

      function Show_Tree (T : access Node) return Document is
         Down : constant Document := Show_Bracket (T.TS).Nest (T.S.Length);
      begin
         return X.New_Document.Put (T.S).Append (Down).Group;
      end Show_Tree;

      function Show_Trees (List : Node_Array) return Document is
         Down : Document := Show_Tree (List (List'First));
         Temp : Document;
      begin
         if List'Length > 1 then
            Down.Put_Line (",");
            Temp := Show_Trees (List (List'First + 1 .. List'Last));
            Down.Append (Temp);

         end if;

         return Down;
      end Show_Trees;
   end Trees;

   W : Document;
begin
   W := Trees.Show_Tree (Trees.A'Access);

   Ada.Wide_Wide_Text_IO.Put_Line
     (X.Pretty (30, W).To_Wide_Wide_String);

   declare
      Aggr : Document;
   begin
      W := X.New_Document;
      Aggr := X.New_Document;

      for J in 1 .. 256 loop
         Aggr.Append
           (X.New_Document
            .New_Line
            .Put (Integer'Wide_Wide_Image (-J))
            .Put (",")
            .Group);
      end loop;

      W.Put
        ("S_1 : aliased constant Second_Stage_Array :=");

      W.Append
        (X.New_Document
         .New_Line
         .Put ("(")
         .Append (Aggr.Group.Nest (1))
         .Put (");")
         .Nest (2)
         .New_Line);

      W.New_Line;

      W.New_Line;
      W.Put_Line ("(Wery_Long_Line, Wery_Long_Line," &
                        " Wery_Long_Line, Wery_Long_Line);");
   end;

   Ada.Wide_Wide_Text_IO.Put_Line
        (X.Pretty (56, W).To_Wide_Wide_String);

end Main_PP;

