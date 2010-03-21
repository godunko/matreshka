%token Token_Code_Point
%token Token_Any_Code_Point
%token Token_Alternation
%token Token_Optional_Greedy
%token Token_Optional_Lazy
%token Token_Zero_Or_More_Greedy
%token Token_Zero_Or_More_Lazy
%token Token_One_Or_More_Greedy
%token Token_One_Or_More_Lazy
%token Token_Character_Class_Begin
%token Token_Character_Class_End
%token Token_Negate_Character_Class
%token Token_Character_Class_Range
--  %token Token_Character_Class_Union

{
   type Kinds is (None, Code_Point, AST_Node);

   type YYSType (Kind : Kinds := None) is record
      case Kind is
         when None =>
            null;

         when Code_Point =>
            Code : Wide_Wide_Character;

         when AST_Node =>
            Node : Positive;
      end case;
   end record;
}

%%

re : re Token_Alternation series
{
   --  Alternation

   AST_Last := AST_Last + 1;
   AST (AST_Last) := (Alternation, 0, $1.Node, $3.Node);

   AST_Start := AST_Last;
   $$ := (AST_Node, AST_Last);

   Put_Line ("[re | series]" & Integer'Image ($1.Node) & Integer'Image ($3.Node));
}
  | series
{
   AST_Start := $1.Node;
   $$ := $1;

   Put_Line ("[series]");
}
  ;

series : series singleton
{
   Attach ($1.Node, $2.Node);
   $$ := $1;

   Put_Line ("[series singleton]" & Integer'Image ($1.Node) & Integer'Image ($2.Node));
}
  | singleton
{
   $$ := $1;
   Put_Line ("[singleton]" & Integer'Image ($$.Node));
}
  ;

singleton : singleton Token_Optional_Greedy
{
--   AST ($1.Node).Mult := (Optional, Greedy);
   raise Program_Error;
}
  | singleton Token_Optional_Lazy
{
   --  Optional, lazy

   AST_Last := AST_Last + 1;
   AST (AST_Last) := (Multiplicity, 0, $1.Node, False, 0, 1);

   $$ := (AST_Node, AST_Last);

   Put_Line ("[singleton Token_Optional_Lazy]" & Integer'Image ($1.Node));
}
  | singleton Token_Zero_Or_More_Greedy
{
--   AST ($1.Node).Mult := (Zero_Or_More, Greedy);
   raise Program_Error;
}
  | singleton Token_Zero_Or_More_Lazy
{
--   AST ($1.Node).Mult := (Zero_Or_More, Lazy);
   raise Program_Error;
}
  | singleton Token_One_Or_More_Greedy
{
   --  One or more, greedy

   AST_Last := AST_Last + 1;
   AST (AST_Last) := (Multiplicity, 0, $1.Node, True, 1, Natural'Last);

   $$ := (AST_Node, AST_Last);

   Put_Line ("[singleton Token_One_Or_More_Greedy]" & Integer'Image ($1.Node));
}
  | singleton Token_One_Or_More_Lazy
{
--   AST ($1.Node).Mult := (One_Or_More, Lazy);
   raise Program_Error;
}
  | Token_Code_Point
{
   AST_Last := AST_Last + 1;
   AST (AST_Last) := (Code_Point, 0, $1.Code);

   $$ := (AST_Node, AST_Last);

   Put_Line ("[Token_Code_Point] " & Wide_Wide_Character'Image ($1.Code) & Integer'Image ($$.Node));
}
  | character_class
{
   $$ := $1;
}
  ;

character_class : Token_Character_Class_Begin character_class_content Token_Character_Class_End
{
   $$ := $2;
}
  | Token_Character_Class_Begin Token_Negate_Character_Class character_class_content Token_Character_Class_End
{
   AST ($3.Node).Negated := True;
   $$ := $3;
}
  ;

character_class_content : character_class_content Token_Code_Point Token_Character_Class_Range Token_Code_Point
{
   --  Add range of code points to character class

   AST_Last := AST_Last + 1;
   AST (AST_Last) := (Code_Point_Range, 0, $2.Code, $4.Code);

   Add ($1.Node, AST_Last);
   $$ := $1;
}
  | character_class_content Token_Code_Point
{
   --  Add code point to character class

   AST_Last := AST_Last + 1;
   AST (AST_Last) := (Code_Point, 0, $2.Code);

   Add ($1.Node, AST_Last);
   $$ := $1;
}
  |
{
   --  Initialize new character class node

   AST_Last := AST_Last + 1;
   AST (AST_Last) := (Character_Class, 0, False, 0);
   $$ := (AST_Node, AST_Last);
}
  ;

%%
##
   procedure Parse (File_Name : String);
##
with Ada.Text_IO; 
with Scanner.IO;
with Syntax;
##
   use Ada.Text_IO;
   use Scanner;
   use Syntax;

   procedure Parse (File_Name : String) is

      procedure YYError (S : String) is
      begin
         Put_Line (S);

         raise Program_Error;
      end YYError;

##
   begin
      Scanner.IO.Open_Input (File_Name);
      YYParse;
   end Parse;
