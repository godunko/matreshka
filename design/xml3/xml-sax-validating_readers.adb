with Ada.Wide_Wide_Text_IO;
with Ada.Unchecked_Deallocation;

with League.Strings.Internals;
with Matreshka.Internals.Strings.Operations;
with Matreshka.Internals.Unicode.Characters.General_Punctuation;
with Matreshka.Internals.Unicode.Characters.Latin;
with XML.SAX.Readers;

package body XML.SAX.Validating_Readers is

   use type Matreshka.Internals.Unicode.Code_Point;
   use type Sources.Read_Status;
   use Matreshka.Internals.Unicode.Characters.General_Punctuation;
   use Matreshka.Internals.Unicode.Characters.Latin;

   procedure Next (Self : in out SAX_Validating_Reader'Class);
   --  Reads next character from input source. When Status is Successful it
   --  means that character is read from source. End_Of_Data means that there
   --  is no character available to read now, but can be available later.
   --  End_Of_Input signals that the end of document is reached.

   function Is_End_Of_Document
    (Self : SAX_Validating_Reader'Class) return Boolean;
   --  Returns True when current status of input source is End_Of_Input, or,
   --  in incremental mode, is End_Of_Data.

   procedure Unexpected_End_Of_Document
    (Self       : in out SAX_Validating_Reader'Class;
     Subprogram : Parse_Subprogram);
   --  Reports unexpected end of document. In incremental mode when end of data
   --  is reached it saves current state to restore parsing from it.

   procedure Report_Parse_Error (Self : in out SAX_Validating_Reader'Class);
   --  Reports parse error;

   procedure Parse_Failed
    (Self       : in out SAX_Validating_Reader'Class;
     Subprogram : Parse_Subprogram);
   --  Reports parse error in document. In incremental mode when end of data is
   --  reached it saves current state to restore parsing from it.

   package Character_Classification is

      type Character_Classes is
       (Invalid_Character,
        Name_Start_Character,
        Name_Continue_Character,
        Other_Character);

      function Is_Name_Start_Character
       (Code : Matreshka.Internals.Unicode.Code_Point) return Boolean;
      --  Returns True when specified code is NameStartChar.

      function Character_Class
       (Code : Matreshka.Internals.Unicode.Code_Point)
          return Character_Classes;
      --  Returns character class of the specified code.

      function Is_Whitespace
       (Code : Matreshka.Internals.Unicode.Code_Point) return Boolean;
      --  Returns True when specified code is whitespace.

      function Is_Character
       (Code : Matreshka.Internals.Unicode.Code_Point) return Boolean;
      --  Returns True when specified code is valid XML character.

   end Character_Classification;

   package Parser is

      procedure Parse_Document (Self : in out SAX_Validating_Reader'Class);
      --  Parses [1] 'document' production.

      procedure Parse_Name (Self : in out SAX_Validating_Reader'Class);
      --  Parses [5] 'Name' production, and fills parsed name into Name_Buffer.
      --
      --  Current character is the first character of the name. After parsing
      --  current character is the first character immediately after last
      --  character of the name.

      procedure Parse_Attribute_Value
       (Self : in out SAX_Validating_Reader'Class);
      --  Parses [10] 'AttValue' production.
      --
      --  Current character must be the attribute value delimiter character
      --  (" or '). After parsing current character points to next character
      --  closing delimiter.

      procedure Parse_Character_Data
       (Self : in out SAX_Validating_Reader'Class);
      --  Parses [14] 'CharData' production.

      procedure Parse_Processing_Instruction
       (Self : in out SAX_Validating_Reader'Class);
      --  Parses [16] 'PI' production.
      --
      --  Implementation assumes that the beginning '<' of the PI is already
      --  read and the current character is '?' of '<?'. When parse is
      --  completed successfully current character is the first character
      --  after the PI.

      procedure Parse_Prolog (Self : in out SAX_Validating_Reader'Class);
      --  Parses XMLDecl and Misc* subexpressions in [22] 'prolog' production.
      --
      --  When parsing is successful current character is first character after
      --  '<' character.

      procedure Parse_Element (Self : in out SAX_Validating_Reader'Class);
      --  Parses [39] 'element' production.
      --
      --  Current character must be next character after '<'.

      procedure Parse_Attribute (Self : in out SAX_Validating_Reader'Class);
      --  Parses [41] 'attribute' production.

      procedure Parse_Content (Self : in out SAX_Validating_Reader'Class);
      --  Parses [43] 'content' production.
      --
      --  When end tag is found < is already parsed and current character
      --  points to /.

      procedure Parse_Reference (Self : in out SAX_Validating_Reader'Class);
      --  Parses [67] 'Reference' production.

   end Parser;

   ------------------------------
   -- Character_Classification --
   ------------------------------

   package body Character_Classification is

      type Character_Class_Secondary_Array is
        array (Matreshka.Internals.Unicode.Code_Point range 16#00# .. 16#FF#)
          of Character_Classes;

      Character_Class_0000 : aliased constant Character_Class_Secondary_Array
        := (Colon
              | Latin_Capital_Letter_A .. Latin_Capital_Letter_Z
              | Low_Line
              | Latin_Small_Letter_A .. Latin_Small_Letter_Z
              | 16#C0# .. 16#D6#
              | 16#D8# .. 16#F6#
              | 16#F8# .. 16#FF#
                => Name_Start_Character,
            Hyphen_Minus
              | Full_Stop
              | Digit_Zero .. Digit_Nine
              | 16#B7#
                => Name_Continue_Character,
            16#00# => Invalid_Character,
            others => Other_Character);
      --  NameStartChar ::= ":" | [A-Z] | "_" | [a-z] | [#xC0-#xD6]
      --                      | [#xD8-#xF6] | [#xF8-#x2FF]
      --
      --  NameChar ::= "-" | "." | [0-9] | #xB7

      Character_Class_0001 : aliased constant Character_Class_Secondary_Array
        := (others => Name_Start_Character);
      --  NameStartChar ::= [#xF8-#x2FF]
      --
      --  This is "shared" set for groups 0002, 0004 .. 001F.

      Character_Class_0003 : aliased constant Character_Class_Secondary_Array
        := (16#70# .. 16#7D# | 16#7F# .. 16#FF# => Name_Start_Character,
            16#00# .. 16#6F# => Name_Continue_Character,
            others => Other_Character);
      --  NameStartChar ::= [#x370-#x37D] | [#x37F-#x1FFF]
      --  NameChar ::= [#x0300-#x036F]

      Character_Class_0020 : aliased constant Character_Class_Secondary_Array
        := (16#0C# .. 16#0D# | 16#70# .. 16#FF# => Name_Start_Character,
            16#3F# .. 16#40# => Name_Continue_Character,
            others => Other_Character);
      --  NameStartChar ::= [#x200C-#x200D] | [#x2070-#x218F]
      --  NameChar ::= [#x203F-#x2040]

--  [#x2070-#x218F] | [#x2C00-#x2FEF] | [#x3001-#xD7FF] | [#xF900-#xFDCF] | [#xFDF0-#xFFFD] | [#x10000-#xEFFFF]

      ---------------------
      -- Character_Class --
      ---------------------

      function Character_Class
       (Code : Matreshka.Internals.Unicode.Code_Point)
          return Character_Classes is
      begin
         return Character_Class_0000 (Code);
      end Character_Class;

      ------------------
      -- Is_Character --
      ------------------

      function Is_Character
       (Code : Matreshka.Internals.Unicode.Code_Point) return Boolean is
      begin
         return
           Code in 16#0001# .. 16#D7FF#
             or else Code in 16#E000# .. 16#FFFD#
             or else Code in 16#1_0000# .. 16#10_FFFF#;
      end Is_Character;

      -----------------------------
      -- Is_Name_Start_Character --
      -----------------------------

      function Is_Name_Start_Character
       (Code : Matreshka.Internals.Unicode.Code_Point) return Boolean is
      begin
         return Character_Class_0000 (Code) = Name_Start_Character;
      end Is_Name_Start_Character;

      -------------------
      -- Is_Whitespace --
      -------------------

      function Is_Whitespace
       (Code : Matreshka.Internals.Unicode.Code_Point) return Boolean is
      begin
         return
           Code = Space                      --  0x20
             or Code = Character_Tabulation  --  0x09
             or Code = Carriage_Return       --  0x0D
             or Code = Line_Feed;            --  0x0A
      end Is_Whitespace;

   end Character_Classification;

   ---------------------
   -- Content_Handler --
   ---------------------

   overriding function Content_Handler
    (Self : not null access constant SAX_Validating_Reader)
       return XML.SAX.Readers.SAX_Content_Handler_Access is
   begin
      return Self.Content_Handler;
   end Content_Handler;

   -------------------------
   -- Declaration_Handler --
   -------------------------

   overriding function Declaration_Handler
    (Self : not null access constant SAX_Validating_Reader)
       return XML.SAX.Readers.SAX_Declaration_Handler_Access is
   begin
      return Self.Declaration_Handler;
   end Declaration_Handler;

   -----------------
   -- DTD_Handler --
   -----------------

   overriding function DTD_Handler
    (Self : not null access constant SAX_Validating_Reader)
       return XML.SAX.Readers.SAX_DTD_Handler_Access is
   begin
      return Self.DTD_Handler;
   end DTD_Handler;

   ---------------------
   -- Entity_Resolver --
   ---------------------

   overriding function Entity_Resolver
    (Self : not null access constant SAX_Validating_Reader)
       return XML.SAX.Readers.SAX_Entity_Resolver_Access is
   begin
      return Self.Entity_Resolver;
   end Entity_Resolver;

   -------------------
   -- Error_Handler --
   -------------------

   overriding function Error_Handler
    (Self : not null access constant SAX_Validating_Reader)
       return XML.SAX.Readers.SAX_Error_Handler_Access is
   begin
      return Self.Error_Handler;
   end Error_Handler;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out SAX_Validating_Reader) is
   begin
      Matreshka.Internals.Strings.Dereference (Self.Character_Buffer);
      Matreshka.Internals.Strings.Dereference (Self.Name_Buffer);
   end Finalize;

   ----------------
   -- Initialize --
   ----------------

   overriding procedure Initialize (Self : in out SAX_Validating_Reader) is
   begin
      null;
   end Initialize;

   ------------------------
   -- Is_End_Of_Document --
   ------------------------

   function Is_End_Of_Document
    (Self : SAX_Validating_Reader'Class) return Boolean is
   begin
      return Self.Source_Status /= Sources.Successful;
   end Is_End_Of_Document;

   ---------------------
   -- Lexical_Handler --
   ---------------------

   overriding function Lexical_Handler
    (Self : not null access constant SAX_Validating_Reader)
       return XML.SAX.Readers.SAX_Lexical_Handler_Access is
   begin
      return Self.Lexical_Handler;
   end Lexical_Handler;

   ----------
   -- Next --
   ----------

   procedure Next (Self : in out SAX_Validating_Reader'Class) is
      use type Sources.Source_Access;
      use type Matreshka.Internals.Utf16.Utf16_String_Index;

      procedure Free is
        new Ada.Unchecked_Deallocation
             (Sources.Source'Class, Sources.Source_Access);

   begin
      if Self.Current_Entity_Reference.Source /= null then
         Normalize_Line_Break : loop
            Self.Current_Entity_Reference.Source.Next
             (Self.Code, Self.Source_Status);

            exit Normalize_Line_Break
              when Self.Source_Status /= Sources.Successful;

            if Self.Code = Carriage_Return then
               Self.Current_Entity_Reference.Skip_LF := True;
               Self.Current_Entity_Reference.Line :=
                 Self.Current_Entity_Reference.Line + 1;
               Self.Current_Entity_Reference.Column := 1;
               Self.Code := Line_Feed;

               exit Normalize_Line_Break;

            elsif Self.Code = Line_Feed or Self.Code = Next_Line then
               if not Self.Current_Entity_Reference.Skip_LF then
                  Self.Current_Entity_Reference.Line :=
                    Self.Current_Entity_Reference.Line + 1;
                  Self.Current_Entity_Reference.Column := 1;
                  Self.Code := Line_Feed;

                  exit Normalize_Line_Break;
               end if;

               Self.Current_Entity_Reference.Skip_LF := False;

            elsif Self.Code = Line_Separator then
               Self.Current_Entity_Reference.Skip_LF := False;
               Self.Current_Entity_Reference.Line :=
                 Self.Current_Entity_Reference.Line + 1;
               Self.Current_Entity_Reference.Column := 1;
               Self.Code := Line_Feed;

               exit Normalize_Line_Break;

            else
               Self.Current_Entity_Reference.Column :=
                 Self.Current_Entity_Reference.Column + 1;
               Self.Current_Entity_Reference.Skip_LF := False;

               exit Normalize_Line_Break;
            end if;
         end loop Normalize_Line_Break;

         case Self.Source_Status is
            when Sources.Successful =>
               if not Self.Current_Entity_Reference.Is_Document then
--                  Matreshka.Internals.Utf16.Unchecked_Store
--                   (Self.Current_Entity_Reference.Text.Value,
--                    Self.Current_Entity_Reference.Text.Unused,
--                    Code);
--                  Self.Current_Entity_Reference.Text.Length :=
--                    Self.Current_Entity_Reference.Text.Length + 1;
                  Matreshka.Internals.Strings.Operations.Unterminated_Append
                   (Self.Current_Entity_Reference.Text, Self.Code);
                  --  It is slow operation, would be nice to use the fact that
                  --  filled shared string is not used anywhere, so several
                  --  checks can be avoided. Look to Detached_* API of string
                  --  (if it is implemented).
               end if;
--Ada.Wide_Wide_Text_IO.Put_Line
-- (Wide_Wide_Character'Wide_Wide_Image (Wide_Wide_Character'Val (Self.Code)));

            when Sources.Mailformed =>
               null;

            when Sources.End_Of_Data =>
               null;

            when Sources.End_Of_Input =>
               --  End of current entity, update entities table and pop entity
               --  reference stack.

               if not Self.Current_Entity_Reference.Is_Document then
                  --  Save entity's replacement text and position/index of
                  --  first character after text declaration for future use.

                  --  XXX Not implemented.

                  null;

                  --  Deallocate input source.

                  Free (Self.Current_Entity_Reference.Source);

                  --  Pop entity reference stack.

                  Self.Current_Entity_Reference :=
                    Self.Entity_Reference_Stack.Last_Element;
                  Self.Entity_Reference_Stack.Delete_Last;

                  Self.Next;
               end if;
         end case;

      else
         if Self.Current_Entity_Reference.Position
              < Self.Current_Entity_Reference.Text.Unused
         then
            Matreshka.Internals.Utf16.Unchecked_Next
             (Self.Current_Entity_Reference.Text.Value,
              Self.Current_Entity_Reference.Position,
              Self.Code);
            Self.Source_Status := Sources.Successful;

            --  Update location

            if Self.Code = Line_Feed then
               Self.Current_Entity_Reference.Line :=
                 Self.Current_Entity_Reference.Line + 1;
               Self.Current_Entity_Reference.Column := 1;

            else
               Self.Current_Entity_Reference.Column :=
                 Self.Current_Entity_Reference.Column + 1;
            end if;

         else
            --  Pop entity reference stack.

            Self.Current_Entity_Reference :=
              Self.Entity_Reference_Stack.Last_Element;
            Self.Entity_Reference_Stack.Delete_Last;

            Self.Next;
         end if;
      end if;
   end Next;

   -----------
   -- Parse --
   -----------

   procedure Parse
    (Self   : in out SAX_Validating_Reader'Class;
     Source : not null Sources.Source_Access) is
   begin
      Self.Current_Entity_Reference :=
       (Entity      => 0,
        Is_Document => True,
        Source      => Source,
        Text        => null,
        Position    => 0,
        Line        => 1,
        Column      => 0,
        Skip_LF     => False);
      Self.Parser_Status := Continue;

      Self.Next;
      Parser.Parse_Document (Self);
   end Parse;

   ------------------
   -- Parse_Failed --
   ------------------

   procedure Parse_Failed
    (Self       : in out SAX_Validating_Reader'Class;
     Subprogram : Parse_Subprogram) is
   begin
      null;
   end Parse_Failed;

   -----------------------
   -- Parse_Incremental --
   -----------------------

   procedure Parse_Incremental
    (Self   : in out SAX_Validating_Reader'Class;
     Source : not null Sources.Source_Access) is
   begin
      null;
   end Parse_Incremental;

   ----------------
   -- Parse_Next --
   ----------------

   procedure Parse_Next (Self : in out SAX_Validating_Reader'Class) is
   begin
      null;
   end Parse_Next;

   ------------
   -- Parser --
   ------------

   package body Parser is

      --  All parsing subprograms has the same structure, it allows to do
      --  incremental parsing.
      --
      --  procedure Parse_... (Self : in out SAX_Validating_Reader'Class) is
      --
      --     type States is
      --      (State_Init,
      --       ...
      --       State_Done,
      --       State_Invalid);
      --     --  States
      --
      --     type Inputs is (Input_..., ...);
      --     --  Inputs
      --
      --     Transition : constant array (States, Inputs) of States
      --       := ...;
      --     --  State transition table.
      --
      --     State : States;
      --     Input : Inputs;
      --
      --  begin
      --     if Self.Parse_State_Stack.Is_Empty then
      --        --  Initialize
      --        ...
      --     else
      --        --  Restore state, call parse function recursively
      --        ...
      --     end if;
      --
      --     loop
      --        case State is
      --           --  Do actions
      --        end case;
      --
      --        if Self.Is_End_Of_Document then
      --           Self.Unexpected_End_Of_Document (Parse_...'Access, State);
      --           return;
      --        end if;
      --
      --        State := Transition (State, Input);
      --
      --        case State is
      --           --  Do actions. Last statement in each handler must be
      --           --  exit/return statement or call of Self.Next procedure.
      --        end case;
      --     end loop;
      --  end Parse_...;

      use Character_Classification;

      ---------------------
      -- Parse_Attribute --
      ---------------------

      procedure Parse_Attribute (Self : in out SAX_Validating_Reader'Class) is

         type States is
          (State_Initial,
           State_Name,
           State_Whitespace_Before,
           State_Equals_Sign,
           State_Whitespace_After,
           State_Value,
           State_Invalid);

         type Inputs is
          (Input_Name_Start_Character,
           Input_Whitespace,
           Input_Equals_Sign,
           Input_Value_Open_Delimiter,
           Input_Unknown);

         Transition : constant array (States, Inputs) of States
           := (State_Initial =>
                (Input_Name_Start_Character => State_Name,
                 Input_Whitespace           => State_Invalid,
                 Input_Equals_Sign          => State_Invalid,
                 Input_Value_Open_Delimiter => State_Invalid,
                 Input_Unknown              => State_Invalid),
               State_Name =>
                (Input_Name_Start_Character => State_Invalid,
                 Input_Whitespace           => State_Whitespace_Before,
                 Input_Equals_Sign          => State_Equals_Sign,
                 Input_Value_Open_Delimiter => State_Invalid,
                 Input_Unknown              => State_Invalid),
               State_Whitespace_Before =>
                (Input_Name_Start_Character => State_Invalid,
                 Input_Whitespace           => State_Whitespace_Before,
                 Input_Equals_Sign          => State_Equals_Sign,
                 Input_Value_Open_Delimiter => State_Invalid,
                 Input_Unknown              => State_Invalid),
               State_Equals_Sign =>
                (Input_Name_Start_Character => State_Invalid,
                 Input_Whitespace           => State_Whitespace_After,
                 Input_Equals_Sign          => State_Invalid,
                 Input_Value_Open_Delimiter => State_Value,
                 Input_Unknown              => State_Invalid),
               State_Whitespace_After =>
                (Input_Name_Start_Character => State_Invalid,
                 Input_Whitespace           => State_Whitespace_After,
                 Input_Equals_Sign          => State_Invalid,
                 Input_Value_Open_Delimiter => State_Value,
                 Input_Unknown              => State_Invalid),
               State_Value => (others => State_Invalid),
               State_Invalid => (others => State_Invalid));

         State : States;
         Input : Inputs;

      begin
         if Self.Parse_State_Stack.Is_Empty then
            State := State_Initial;

         else
            raise Program_Error;
         end if;

         loop
            --  Check for end of data/document

            if Self.Is_End_Of_Document then
               Self.Unexpected_End_Of_Document (Parse_Attribute'Access);

               return;
            end if;

            --  Classify current character

            if Self.Code = Equals_Sign then
               Input := Input_Equals_Sign;

            elsif Self.Code = Quotation_Mark then
               Input := Input_Value_Open_Delimiter;

            elsif Self.Code = Apostrophe then
               Input := Input_Value_Open_Delimiter;

            elsif Is_Whitespace (Self.Code) then
               Input := Input_Whitespace;

            elsif Is_Name_Start_Character (Self.Code) then
               Input := Input_Name_Start_Character;

            else
               Input := Input_Unknown;
            end if;

            State := Transition (State, Input);

            case State is
               when State_Initial =>
                  raise Program_Error;

               when State_Name =>
                  Parse_Name (Self);

                  if Self.Parser_Status /= Continue then
                     Self.Parse_Failed (Parse_Attribute'Access);

                     return;
                  end if;

               when State_Whitespace_Before =>
                  Self.Next;

               when State_Equals_Sign =>
                  Self.Next;

               when State_Whitespace_After =>
                  Self.Next;

               when State_Value =>
                  Parse_Attribute_Value (Self);

                  if Self.Parser_Status /= Continue then
                     Self.Parse_Failed (Parse_Attribute'Access);

                     return;
                  end if;

                  return;

               when State_Invalid =>
                  Self.Report_Parse_Error;

                  return;
            end case;
         end loop;
      end Parse_Attribute;

      ---------------------------
      -- Parse_Attribute_Value --
      ---------------------------

      type Attribute_Value_States is
       (State_Initial,
        State_Quotation_Mark_Open,
        State_Quotation_Mark_Character,
        State_Apostrophe_Open,
        State_Apostrophe_Character,
        State_Done,
        State_Invalid);

      type Attribute_Value_Inputs is
       (Input_Quotation_Mark,
        Input_Apostrophe,
        Input_Ampersand,
        Input_Less_Than_Sign,
        Input_Character,
        Input_Unknown);

      Attribute_Value_Transition :
        constant array (Attribute_Value_States, Attribute_Value_Inputs)
          of Attribute_Value_States
            := (State_Initial =>
                 (Input_Quotation_Mark => State_Quotation_Mark_Open,
                  Input_Apostrophe     => State_Apostrophe_Open,
                  Input_Ampersand      => State_Invalid,
                  Input_Less_Than_Sign => State_Invalid,
                  Input_Character      => State_Invalid,
                  Input_Unknown        => State_Invalid),
                State_Quotation_Mark_Open =>
                 (Input_Quotation_Mark => State_Done,
                  Input_Apostrophe     => State_Quotation_Mark_Character,
                  Input_Ampersand      => State_Invalid,
                  Input_Less_Than_Sign => State_Invalid,
                  Input_Character      => State_Quotation_Mark_Character,
                  Input_Unknown        => State_Invalid),
                State_Apostrophe_Open =>
                 (Input_Quotation_Mark => State_Apostrophe_Character,
                  Input_Apostrophe     => State_Done,
                  Input_Ampersand      => State_Invalid,
                  Input_Less_Than_Sign => State_Invalid,
                  Input_Character      => State_Apostrophe_Character,
                  Input_Unknown        => State_Invalid),
                State_Quotation_Mark_Character =>
                 (Input_Quotation_Mark => State_Done,
                  Input_Apostrophe     => State_Quotation_Mark_Character,
                  Input_Ampersand      => State_Invalid,
                  Input_Less_Than_Sign => State_Invalid,
                  Input_Character      => State_Quotation_Mark_Character,
                  Input_Unknown        => State_Invalid),
                State_Apostrophe_Character =>
                 (Input_Quotation_Mark => State_Apostrophe_Character,
                  Input_Apostrophe     => State_Done,
                  Input_Ampersand      => State_Invalid,
                  Input_Less_Than_Sign => State_Invalid,
                  Input_Character      => State_Apostrophe_Character,
                  Input_Unknown        => State_Invalid),
                State_Done => (others => State_Invalid),
                State_Invalid => (others => State_Invalid));

      procedure Parse_Attribute_Value
       (Self : in out SAX_Validating_Reader'Class)
      is
         subtype States is Attribute_Value_States;
         subtype Inputs is Attribute_Value_Inputs;

         State : States;
         Input : Inputs;

      begin
         if Self.Parse_State_Stack.Is_Empty then
            State := State_Initial;

         else
            raise Program_Error;
         end if;

         loop
            --  Check for end of data/document

            if Self.Is_End_Of_Document then
               Self.Unexpected_End_Of_Document (Parse_Attribute_Value'Access);

               return;
            end if;

            --  Classify current character

            if Self.Code = Quotation_Mark then
               Input := Input_Quotation_Mark;

            elsif Self.Code = Apostrophe then
               Input := Input_Apostrophe;

            elsif Self.Code = Ampersand then
               Input := Input_Ampersand;

            elsif Self.Code = Less_Than_Sign then
               Input := Input_Less_Than_Sign;

            elsif Is_Character (Self.Code) then
               Input := Input_Character;

            else
               Input := Input_Unknown;
            end if;

            State := Attribute_Value_Transition (State, Input);

            case State is
               when State_Initial =>
                  raise Program_Error;

               when State_Quotation_Mark_Open =>
                  Matreshka.Internals.Strings.Operations.Reset
                   (Self.Character_Buffer);
                  Self.Next;

               when State_Apostrophe_Open =>
                  Matreshka.Internals.Strings.Operations.Reset
                   (Self.Character_Buffer);
                  Self.Next;

               when State_Quotation_Mark_Character =>
                  Matreshka.Internals.Strings.Operations.Unterminated_Append
                   (Self.Character_Buffer, Self.Code);
                  Self.Next;

               when State_Apostrophe_Character =>
                  Matreshka.Internals.Strings.Operations.Unterminated_Append
                   (Self.Character_Buffer, Self.Code);
                  Self.Next;

               when State_Done =>
                  Matreshka.Internals.Strings.Fill_Null_Terminator
                   (Self.Character_Buffer);
                  Self.Next;

                  return;

               when State_Invalid =>
                  Self.Report_Parse_Error;

                  return;
            end case;
         end loop;
      end Parse_Attribute_Value;

      --------------------------
      -- Parse_Character_Data --
      --------------------------

      type Character_Data_States is
       (State_Initial,
        State_Character_Data,
        State_Right_Square_Bracket_1,
        State_Right_Square_Bracket_2,
        State_Done,
        State_Invalid);

      type Character_Data_Inputs is
       (Input_Less_Than_Sign,
        Input_Ampersand,
        Input_Right_Square_Bracket,
        Input_Greater_Than_Sign,
        Input_Character,
        Input_Unknown);

      Character_Data_Transition :
        constant array (Character_Data_States, Character_Data_Inputs)
          of Character_Data_States
            := (State_Initial =>
                 (Input_Less_Than_Sign       => State_Invalid,
                  Input_Ampersand            => State_Invalid,
                  Input_Right_Square_Bracket => State_Right_Square_Bracket_1,
                  Input_Greater_Than_Sign    => State_Character_Data,
                  Input_Character            => State_Character_Data,
                  Input_Unknown              => State_Invalid),
                State_Character_Data =>
                 (Input_Less_Than_Sign       => State_Done,
                  Input_Ampersand            => State_Done,
                  Input_Right_Square_Bracket => State_Right_Square_Bracket_1,
                  Input_Greater_Than_Sign    => State_Character_Data,
                  Input_Character            => State_Character_Data,
                  Input_Unknown              => State_Invalid),
                State_Right_Square_Bracket_1 =>
                 (Input_Less_Than_Sign       => State_Done,
                  Input_Ampersand            => State_Done,
                  Input_Right_Square_Bracket => State_Right_Square_Bracket_2,
                  Input_Greater_Than_Sign    => State_Character_Data,
                  Input_Character            => State_Character_Data,
                  Input_Unknown              => State_Invalid),
                State_Right_Square_Bracket_2 =>
                 (Input_Less_Than_Sign       => State_Done,
                  Input_Ampersand            => State_Done,
                  Input_Right_Square_Bracket => State_Right_Square_Bracket_2,
                  Input_Greater_Than_Sign    => State_Invalid,
                  Input_Character            => State_Character_Data,
                  Input_Unknown              => State_Invalid),
                State_Done => (others => State_Invalid),
                State_Invalid => (others => State_Invalid));

      procedure Parse_Character_Data
       (Self : in out SAX_Validating_Reader'Class)
      is

         subtype States is Character_Data_States;
         subtype Inputs is Character_Data_Inputs;

         State : States;
         Input : Inputs;

      begin
         if Self.Parse_State_Stack.Is_Empty then
            Matreshka.Internals.Strings.Operations.Reset
             (Self.Character_Buffer);
            State := State_Initial;

         else
            raise Program_Error;
         end if;

         loop
            --  Check for end of data/document

            if Self.Is_End_Of_Document then
               Self.Unexpected_End_Of_Document (Parse_Character_Data'Access);

               return;
            end if;

            --  Classify current character

            if Self.Code = Ampersand then
               Input := Input_Ampersand;

            elsif Self.Code = Less_Than_Sign then
               Input := Input_Less_Than_Sign;

            elsif Self.Code = Right_Square_Bracket then
               Input := Input_Right_Square_Bracket;

            elsif Self.Code = Greater_Than_Sign then
               Input := Input_Greater_Than_Sign;

            elsif Is_Character (Self.Code) then
               Input := Input_Character;

            else
               Input := Input_Unknown;
            end if;

            State := Character_Data_Transition (State, Input);

            case State is
               when State_Initial =>
                  raise Program_Error;

               when State_Character_Data =>
                  Matreshka.Internals.Strings.Operations.Unterminated_Append
                   (Self.Character_Buffer, Self.Code);
                  Self.Next;

               when State_Right_Square_Bracket_1 =>
                  Matreshka.Internals.Strings.Operations.Unterminated_Append
                   (Self.Character_Buffer, Self.Code);
                  Self.Next;

               when State_Right_Square_Bracket_2 =>
                  Matreshka.Internals.Strings.Operations.Unterminated_Append
                   (Self.Character_Buffer, Self.Code);
                  Self.Next;

               when State_Done =>
                  Matreshka.Internals.Strings.Fill_Null_Terminator
                   (Self.Character_Buffer);
                  return;

               when State_Invalid =>
                  Self.Report_Parse_Error;

                  return;
            end case;
         end loop;
      end Parse_Character_Data;

      -------------------
      -- Parse_Content --
      -------------------

      procedure Parse_Content (Self : in out SAX_Validating_Reader'Class) is

         type States is
          (State_Initial,
           State_Character_Data,
           State_Less_Than_Sign,
           State_Element,
           State_Reference,
           State_Done,
           State_Invalid);

         type Inputs is
          (Input_Less_Than_Sign,
           Input_Ampersand,
           Input_Name_Start_Character,
           Input_Solidus,
           Input_Unknown);

         Transition : constant array (States, Inputs) of States
           := (State_Initial =>
                (Input_Less_Than_Sign       => State_Less_Than_Sign,
                 Input_Ampersand            => State_Reference,
                 Input_Name_Start_Character => State_Character_Data,
                 Input_Solidus              => State_Character_Data,
                 Input_Unknown              => State_Character_Data),
               State_Character_Data =>
                (Input_Less_Than_Sign       => State_Less_Than_Sign,
                 Input_Ampersand            => State_Reference,
                 Input_Name_Start_Character => State_Invalid,
                 Input_Solidus              => State_Invalid,
                 Input_Unknown              => State_Invalid),
               State_Less_Than_Sign =>
                (Input_Less_Than_Sign       => State_Invalid,
                 Input_Ampersand            => State_Invalid,
                 Input_Name_Start_Character => State_Element,
                 Input_Solidus              => State_Done,
                 Input_Unknown              => State_Invalid),
               State_Element =>
                (Input_Less_Than_Sign       => State_Less_Than_Sign,
                 Input_Ampersand            => State_Reference,
                 Input_Name_Start_Character => State_Character_Data,
                 Input_Solidus              => State_Character_Data,
                 Input_Unknown              => State_Character_Data),
               State_Reference =>
                (Input_Less_Than_Sign       => State_Less_Than_Sign,
                 Input_Ampersand            => State_Reference,
                 Input_Name_Start_Character => State_Character_Data,
                 Input_Solidus              => State_Character_Data,
                 Input_Unknown              => State_Character_Data),
               State_Done => (others => State_Invalid),
               State_Invalid => (others => State_Invalid));

         State : States;
         Input : Inputs;

      begin
         if Self.Parse_State_Stack.Is_Empty then
            State := State_Initial;

         else
            raise Program_Error;
         end if;

         loop
            --  Check for end of data/document

            if Self.Is_End_Of_Document then
               Self.Unexpected_End_Of_Document (Parse_Content'Access);

               return;
            end if;

            --  Classify current character

            if Self.Code = Ampersand then
               Input := Input_Ampersand;

            elsif Self.Code = Less_Than_Sign then
               Input := Input_Less_Than_Sign;

            elsif Self.Code = Solidus then
               Input := Input_Solidus;

            elsif Is_Name_Start_Character (Self.Code) then
               Input := Input_Name_Start_Character;

            else
               Input := Input_Unknown;
            end if;

            State := Transition (State, Input);

            case State is
               when State_Initial =>
                  raise Program_Error;

               when State_Character_Data =>
                  Parse_Character_Data (Self);

                  if Self.Parser_Status /= Continue then
                     Self.Parse_Failed (Parse_Content'Access);

                     return;
                  end if;

               when State_Less_Than_Sign =>
                  Self.Next;

               when State_Element =>
                  Parse_Element (Self);

                  if Self.Parser_Status /= Continue then
                     Self.Parse_Failed (Parse_Content'Access);

                     return;
                  end if;

               when State_Reference =>
                  Parse_Reference (Self);

                  if Self.Parser_Status /= Continue then
                     Self.Parse_Failed (Parse_Content'Access);

                     return;
                  end if;

               when State_Done =>
                  return;

               when State_Invalid =>
                  Self.Report_Parse_Error;

                  return;
            end case;
         end loop;
      end Parse_Content;

      --------------------
      -- Parse_Document --
      --------------------

      procedure Parse_Document (Self : in out SAX_Validating_Reader'Class) is
      begin
         if Self.Parse_State_Stack.Is_Empty then
            null;

         else
            raise Program_Error;
         end if;

         Parse_Prolog (Self);
         Parse_Element (Self);
--         loop
--            if Self.Is_End_Of_Document then
--               Self.Unexpected_End_Of_Document (Parse_Document'Access);
--
--               return;
--            end if;
--
--            Self.Next;
--         end loop;
      end Parse_Document;

      -------------------
      -- Parse_Element --
      -------------------

      procedure Parse_Element (Self : in out SAX_Validating_Reader'Class) is

         type States is
          (State_Initial,
           State_Name,
           State_Whitespace,
           State_Attribute,
           State_Start_Tag_Close,
           State_Content,
           State_Empty_Tag_Solidus,
           State_End_Tag_Open,
           State_End_Tag_Name,
           State_End_Tag_Whitespace,
           State_Done,
           State_Invalid);

         type Inputs is
          (Input_Name_Start_Character,
           Input_Whitespace,
           Input_Greater_Than_Sign,
           Input_Solidus,
           Input_Unknown);

         Transition : constant array (States, Inputs) of States
           := (State_Initial =>
                (Input_Name_Start_Character => State_Name,
                 Input_Whitespace           => State_Invalid,
                 Input_Greater_Than_Sign    => State_Invalid,
                 Input_Solidus              => State_Invalid,
                 Input_Unknown              => State_Invalid),
               State_Name =>
                (Input_Name_Start_Character => State_Invalid,
                 Input_Whitespace           => State_Whitespace,
                 Input_Greater_Than_Sign    => State_Start_Tag_Close,
                 Input_Solidus              => State_Empty_Tag_Solidus,
                 Input_Unknown              => State_Invalid),
               State_Whitespace =>
                (Input_Name_Start_Character => State_Attribute,
                 Input_Whitespace           => State_Whitespace,
                 Input_Greater_Than_Sign    => State_Start_Tag_Close,
                 Input_Solidus              => State_Empty_Tag_Solidus,
                 Input_Unknown              => State_Invalid),
               State_Attribute =>
                (Input_Name_Start_Character => State_Invalid,
                 Input_Whitespace           => State_Whitespace,
                 Input_Greater_Than_Sign    => State_Start_Tag_Close,
                 Input_Solidus              => State_Empty_Tag_Solidus,
                 Input_Unknown              => State_Invalid),
               State_Start_Tag_Close =>
                (Input_Name_Start_Character => State_Content,
                 Input_Whitespace           => State_Content,
                 Input_Greater_Than_Sign    => State_Content,
                 Input_Solidus              => State_Content,
                 Input_Unknown              => State_Content),
               State_Content =>
                (Input_Name_Start_Character => State_Invalid,
                 Input_Whitespace           => State_Invalid,
                 Input_Greater_Than_Sign    => State_Invalid,
                 Input_Solidus              => State_End_Tag_Open,
                 Input_Unknown              => State_Invalid),
               State_Empty_Tag_Solidus =>
                (Input_Name_Start_Character => State_Invalid,
                 Input_Whitespace           => State_Invalid,
                 Input_Greater_Than_Sign    => State_Done,
                 Input_Solidus              => State_Invalid,
                 Input_Unknown              => State_Invalid),
               State_End_Tag_Open =>
                (Input_Name_Start_Character => State_End_Tag_Name,
                 Input_Whitespace           => State_Invalid,
                 Input_Greater_Than_Sign    => State_Invalid,
                 Input_Solidus              => State_Invalid,
                 Input_Unknown              => State_Invalid),
               State_End_Tag_Name =>
                (Input_Name_Start_Character => State_Invalid,
                 Input_Whitespace           => State_End_Tag_Whitespace,
                 Input_Greater_Than_Sign    => State_Done,
                 Input_Solidus              => State_Invalid,
                 Input_Unknown              => State_Invalid),
               State_End_Tag_Whitespace =>
                (Input_Name_Start_Character => State_Invalid,
                 Input_Whitespace           => State_End_Tag_Whitespace,
                 Input_Greater_Than_Sign    => State_Done,
                 Input_Solidus              => State_Invalid,
                 Input_Unknown              => State_Invalid),
               State_Done => (others => State_Invalid),
               State_Invalid => (others => State_Invalid));

         State : States;
         Input : Inputs;

      begin
         if Self.Parse_State_Stack.Is_Empty then
            State := State_Initial;

         else
            raise Program_Error;
         end if;

         loop
            --  Check for end of data/document

            if Self.Is_End_Of_Document then
               Self.Unexpected_End_Of_Document (Parse_Element'Access);

               return;
            end if;

            --  Classify current character

            if Is_Whitespace (Self.Code) then
               Input := Input_Whitespace;

            elsif Self.Code = Greater_Than_Sign then
               Input := Input_Greater_Than_Sign;

            elsif Self.Code = Solidus then
               Input := Input_Solidus;

            elsif Is_Name_Start_Character (Self.Code) then
               Input := Input_Name_Start_Character;

            else
               Input := Input_Unknown;
            end if;

            State := Transition (State, Input);

            case State is
               when State_Initial =>
                  raise Program_Error;

               when State_Name =>
                  Parse_Name (Self);

                  if Self.Parser_Status /= Continue then
                     Self.Parse_Failed (Parse_Element'Access);

                     return;
                  end if;

               when State_Whitespace =>
                  Self.Next;

               when State_Attribute =>
                  Parse_Attribute (Self);

                  if Self.Parser_Status /= Continue then
                     Self.Parse_Failed (Parse_Element'Access);

                     return;
                  end if;

               when State_Start_Tag_Close =>
                  Self.Next;

               when State_Content =>
                  Parse_Content (Self);

                  if Self.Parser_Status /= Continue then
                     Self.Parse_Failed (Parse_Element'Access);

                     return;
                  end if;

               when State_Empty_Tag_Solidus =>
                  Self.Next;

               when State_End_Tag_Open =>
                  Self.Next;

               when State_End_Tag_Name =>
                  Parse_Name (Self);

                  if Self.Parser_Status /= Continue then
                     Self.Parse_Failed (Parse_Element'Access);

                     return;
                  end if;

               when State_End_Tag_Whitespace =>
                  Self.Next;

               when State_Done =>
                  Self.Next;

                  return;

               when State_Invalid =>
                  Self.Report_Parse_Error;

                  return;
            end case;
         end loop;
      end Parse_Element;

      ----------------
      -- Parse_Name --
      ----------------

      procedure Parse_Name (Self : in out SAX_Validating_Reader'Class) is

         type States is
          (State_Initial,
           State_First,
           State_Continue,
           State_Done,
           State_Invalid);

         type Inputs is
          (Input_Name_Start,
           Input_Name_Continue,
           Input_Unknown);

         Transition : constant array (States, Inputs) of States
           := (State_Initial =>
                (Input_Name_Start    => State_First,
                 Input_Name_Continue => State_Invalid,
                 Input_Unknown       => State_Invalid),
               State_First =>
                (Input_Name_Start    => State_Continue,
                 Input_Name_Continue => State_Continue,
                 Input_Unknown       => State_Done),
               State_Continue =>
                (Input_Name_Start    => State_Continue,
                 Input_Name_Continue => State_Continue,
                 Input_Unknown       => State_Done),
               State_Done => (others => State_Invalid),
	       State_Invalid => (others => State_Invalid));

         State : States;
         Input : Inputs;

      begin
         if Self.Parse_State_Stack.Is_Empty then
            State := State_Initial;

         else
            raise Program_Error;
         end if;

         loop
            --  Check for end of data/document

            if Self.Is_End_Of_Document then
               Self.Unexpected_End_Of_Document (Parse_Name'Access);

               return;
            end if;

            --  Classify current character

            case Character_Class (Self.Code) is
               when Name_Start_Character =>
                  Input := Input_Name_Start;

               when Name_Continue_Character =>
                  Input := Input_Name_Continue;

               when Invalid_Character | Other_Character =>
                  Input := Input_Unknown;
            end case;

            State := Transition (State, Input);

            case State is
               when State_Initial =>
                  raise Program_Error;

               when State_First =>
                  Matreshka.Internals.Strings.Operations.Reset
                   (Self.Name_Buffer);
                  Matreshka.Internals.Strings.Operations.Unterminated_Append
                   (Self.Name_Buffer, Self.Code);
                  Self.Next;

               when State_Continue =>
                  Matreshka.Internals.Strings.Operations.Unterminated_Append
                   (Self.Name_Buffer, Self.Code);
                  Self.Next;

               when State_Done =>
                  Matreshka.Internals.Strings.Fill_Null_Terminator
                   (Self.Name_Buffer);

                  return;

               when State_Invalid =>
                  Self.Report_Parse_Error;

                  return;
            end case;
         end loop;
      end Parse_Name;

      ----------------------------------
      -- Parse_Processing_Instruction --
      ----------------------------------

      procedure Parse_Processing_Instruction
       (Self : in out SAX_Validating_Reader'Class)
      is

         type States is
          (State_Initial,
           State_Initial_Question_Mark,
           State_Name,
           State_Whitespace,
           State_Data,
           State_Question_Mark,
           State_Done,
           State_Invalid);

         type Inputs is
          (Input_Question_Mark,
           Input_Name_Start_Character,
           Input_Whitespace,
           Input_Character,
           Input_Greater_Than_Sign,
           Input_Unknown);

         --  GNAT constructs transition table every time when subprogram is
         --  called, so it is resonable to move its declaration outside.

         Transition : constant array (States, Inputs) of States
           := (State_Initial =>
                (Input_Question_Mark        => State_Initial_Question_Mark,
                 Input_Name_Start_Character => State_Invalid,
                 Input_Whitespace           => State_Invalid,
                 Input_Character            => State_Invalid,
                 Input_Greater_Than_Sign    => State_Invalid,
                 Input_Unknown              => State_Invalid),
               State_Initial_Question_Mark =>
                (Input_Question_Mark        => State_Invalid,
                 Input_Name_Start_Character => State_Name,
                 Input_Whitespace           => State_Invalid,
                 Input_Character            => State_Invalid,
                 Input_Greater_Than_Sign    => State_Invalid,
                 Input_Unknown              => State_Invalid),
               State_Name =>
                (Input_Question_Mark        => State_Question_Mark,
                 Input_Name_Start_Character => State_Invalid,
                 Input_Whitespace           => State_Whitespace,
                 Input_Character            => State_Invalid,
                 Input_Greater_Than_Sign    => State_Invalid,
                 Input_Unknown              => State_Invalid),
               State_Whitespace =>
                (Input_Question_Mark        => State_Question_Mark,
                 Input_Name_Start_Character => State_Data,
                 Input_Whitespace           => State_Whitespace,
                 Input_Character            => State_Data,
                 Input_Greater_Than_Sign    => State_Data,
                 Input_Unknown              => State_Invalid),
               State_Data =>
                (Input_Question_Mark        => State_Question_Mark,
                 Input_Name_Start_Character => State_Data,
                 Input_Whitespace           => State_Data,
                 Input_Character            => State_Data,
                 Input_Greater_Than_Sign    => State_Data,
                 Input_Unknown              => State_Invalid),
               State_Question_Mark =>
                (Input_Question_Mark        => State_Question_Mark,
                 Input_Name_Start_Character => State_Data,
                 Input_Whitespace           => State_Data,
                 Input_Character            => State_Data,
                 Input_Greater_Than_Sign    => State_Done,
                 Input_Unknown              => State_Invalid),
               State_Done => (others => State_Invalid),
               State_Invalid => (others => State_Invalid));

         State : States;
         Input : Inputs;

      begin
         if Self.Parse_State_Stack.Is_Empty then
            State := State_Initial;
            Matreshka.Internals.Strings.Operations.Reset
             (Self.Character_Buffer);

         else
            raise Program_Error;
         end if;

         loop
            case State is
               when State_Initial =>
                  null;

               when State_Initial_Question_Mark =>
                  null;

               when State_Name =>
                  null;

               when State_Whitespace =>
                  null;

               when State_Data =>
                  null;

               when State_Question_Mark =>
                  if Self.Source_Status = Sources.Successful
                    and Self.Code /= Greater_Than_Sign
                  then
                     Matreshka.Internals.Strings.Operations.Unterminated_Append
                      (Self.Character_Buffer, Question_Mark);
                  end if;

               when State_Done =>
                  null;

               when State_Invalid =>
                  null;
            end case;

            --  Checks end of document

            if Self.Is_End_Of_Document then
               Self.Unexpected_End_Of_Document
                (Parse_Processing_Instruction'Access);

               return;
            end if;

            --  Classify current character

            if Self.Code = Question_Mark then
               Input := Input_Question_Mark;

            elsif Self.Code = Greater_Than_Sign then
               Input := Input_Greater_Than_Sign;

            elsif Is_Whitespace (Self.Code) then
               Input := Input_Whitespace;

            else
               case Character_Class (Self.Code) is
                  when Name_Start_Character =>
                     Input := Input_Name_Start_Character;

                  when Name_Continue_Character =>
                     Input := Input_Character;

                  when Other_Character =>
                     Input := Input_Character;

                  when Invalid_Character =>
                     Input := Input_Unknown;
               end case;
            end if;

            State := Transition (State, Input);

            case State is
               when State_Initial =>
                  raise Program_Error;

               when State_Initial_Question_Mark =>
                  Self.Next;

               when State_Name =>
                  Parse_Name (Self);

                  if Self.Parser_Status /= Continue then
                     Self.Parse_Failed (Parse_Processing_Instruction'Access);

                     return;
                  end if;

               when State_Whitespace =>
                  Self.Next;

               when State_Data =>
                  Matreshka.Internals.Strings.Operations.Unterminated_Append
                   (Self.Character_Buffer, Self.Code);
                  Self.Next;

               when State_Question_Mark =>
                  Self.Next;

               when State_Done =>
                  Matreshka.Internals.Strings.Fill_Null_Terminator
                   (Self.Character_Buffer);
                  Self.Next;

                  return;

               when State_Invalid =>
                  Self.Report_Parse_Error;

                  return;
            end case;
         end loop;
      end Parse_Processing_Instruction;

      ------------------
      -- Parse_Prolog --
      ------------------

      procedure Parse_Prolog (Self : in out SAX_Validating_Reader'Class) is

         type States is
          (State_Initial,
           State_Less_Than_Sign,
           State_Processing_Instruction,
           State_Whitespace,
           State_Done,
           State_Invalid);

         type Inputs is
          (Input_Less_Than_Sign,
           Input_Question_Mark,
           Input_Whitespace,
           Input_Unknown);

         Transition : constant array (States, Inputs) of States
           := (State_Initial =>
                (Input_Less_Than_Sign => State_Less_Than_Sign,
                 Input_Question_Mark  => State_Invalid,
                 Input_Whitespace     => State_Whitespace,
                 Input_Unknown        => State_Invalid),
               State_Less_Than_Sign =>
                (Input_Less_Than_Sign => State_Invalid,
                 Input_Question_Mark  => State_Processing_Instruction,
                 Input_Whitespace     => State_Invalid,
                 Input_Unknown        => State_Done),
               State_Processing_Instruction =>
                (Input_Less_Than_Sign => State_Less_Than_Sign,
                 Input_Question_Mark  => State_Invalid,
                 Input_Whitespace     => State_Whitespace,
                 Input_Unknown        => State_Invalid),
               State_Whitespace =>
                (Input_Less_Than_Sign => State_Less_Than_Sign,
                 Input_Question_Mark  => State_Invalid,
                 Input_Whitespace     => State_Whitespace,
                 Input_Unknown        => State_Invalid),
               State_Done => (others => State_Invalid),
               State_Invalid => (others => State_Invalid));

         State : States;
         Input : Inputs;

      begin
         if Self.Parse_State_Stack.Is_Empty then
            State := State_Initial;

         else
            raise Program_Error;
         end if;

         loop
            --  Checks end of document

            if Self.Is_End_Of_Document then
               Self.Unexpected_End_Of_Document (Parse_Prolog'Access);

               return;
            end if;

            --  Classify current character

            if Self.Code = Less_Than_Sign then
               Input := Input_Less_Than_Sign;

            elsif Self.Code = Question_Mark then
               Input := Input_Question_Mark;

            elsif Is_Whitespace (Self.Code) then
               Input := Input_Whitespace;

            else
               Input := Input_Unknown;
            end if;

            State := Transition (State, Input);

            case State is
               when State_Initial =>
                  raise Program_Error;

               when State_Less_Than_Sign =>
                  Self.Next;

               when State_Processing_Instruction =>
                  Parse_Processing_Instruction (Self);

                  if Self.Parser_Status /= Continue then
                     Self.Parse_Failed (Parse_Prolog'Access);

                     return;
                  end if;

               when State_Whitespace =>
                  Self.Next;

               when State_Done =>
                  return;

               when State_Invalid =>
                  Self.Report_Parse_Error;

                  return;
            end case;
         end loop;
      end Parse_Prolog;

      ---------------------
      -- Parse_Reference --
      ---------------------

      type Reference_States is
       (State_Initial,
        State_Ampersand,
        State_Name,
        State_Entity_Reference_Done,
        State_Number_Sign,
        State_Decimal_Character_Reference,
        State_Hex_Character_Reference,
        State_Character_Reference_Done,
        State_Invalid);

      type Reference_Inputs is
       (Input_Ampersand,
        Input_Name_Start_Character,
        Input_Number_Sign,
        Input_Latin_Small_Letter_X,
        Input_Decimal_Digit,
        Input_Capital_Hex_Digit,
        Input_Small_Hex_Digit,
        Input_Semicolon,
        Input_Unknown);

      Reference_Transition :
        constant array (Reference_States, Reference_Inputs) of Reference_States
          := (State_Initial =>
               (Input_Ampersand            => State_Ampersand,
                Input_Name_Start_Character => State_Invalid,
                Input_Number_Sign          => State_Invalid,
                Input_Latin_Small_Letter_X => State_Invalid,
                Input_Decimal_Digit        => State_Invalid,
                Input_Capital_Hex_Digit    => State_Invalid,
                Input_Small_Hex_Digit      => State_Invalid,
                Input_Semicolon            => State_Invalid,
                Input_Unknown              => State_Invalid),
              State_Ampersand =>
               (Input_Ampersand            => State_Invalid,
                Input_Name_Start_Character => State_Name,
                Input_Number_Sign          => State_Number_Sign,
                Input_Latin_Small_Letter_X => State_Invalid,
                Input_Decimal_Digit        => State_Invalid,
                Input_Capital_Hex_Digit    => State_Name,
                Input_Small_Hex_Digit      => State_Name,
                Input_Semicolon            => State_Invalid,
                Input_Unknown              => State_Invalid),
              State_Name =>
               (Input_Ampersand            => State_Invalid,
                Input_Name_Start_Character => State_Invalid,
                Input_Number_Sign          => State_Invalid,
                Input_Latin_Small_Letter_X => State_Invalid,
                Input_Decimal_Digit        => State_Invalid,
                Input_Capital_Hex_Digit    => State_Invalid,
                Input_Small_Hex_Digit      => State_Invalid,
                Input_Semicolon            => State_Entity_Reference_Done,
                Input_Unknown              => State_Invalid),
              State_Number_Sign =>
               (Input_Ampersand            => State_Invalid,
                Input_Name_Start_Character => State_Invalid,
                Input_Number_Sign          => State_Invalid,
                Input_Latin_Small_Letter_X => State_Hex_Character_Reference,
                Input_Decimal_Digit        =>
                  State_Decimal_Character_Reference,
                Input_Capital_Hex_Digit    => State_Invalid,
                Input_Small_Hex_Digit      => State_Invalid,
                Input_Semicolon            => State_Invalid,
                Input_Unknown              => State_Invalid),
              State_Decimal_Character_Reference =>
               (Input_Ampersand            => State_Invalid,
                Input_Name_Start_Character => State_Invalid,
                Input_Number_Sign          => State_Invalid,
                Input_Latin_Small_Letter_X => State_Invalid,
                Input_Decimal_Digit        =>
                  State_Decimal_Character_Reference,
                Input_Capital_Hex_Digit    => State_Invalid,
                Input_Small_Hex_Digit      => State_Invalid,
                Input_Semicolon            => State_Character_Reference_Done,
                Input_Unknown              => State_Invalid),
              State_Hex_Character_Reference =>
               (Input_Ampersand            => State_Invalid,
                Input_Name_Start_Character => State_Invalid,
                Input_Number_Sign          => State_Invalid,
                Input_Latin_Small_Letter_X => State_Invalid,
                Input_Decimal_Digit        => State_Hex_Character_Reference,
                Input_Capital_Hex_Digit    => State_Hex_Character_Reference,
                Input_Small_Hex_Digit      => State_Hex_Character_Reference,
                Input_Semicolon            => State_Character_Reference_Done,
                Input_Unknown              => State_Invalid),
              State_Entity_Reference_Done => (others => State_Invalid),
              State_Character_Reference_Done => (others => State_Invalid),
              State_Invalid => (others => State_Invalid));

      procedure Parse_Reference (Self : in out SAX_Validating_Reader'Class) is

         subtype States is Reference_States;
         subtype Inputs is Reference_Inputs;

         State : States;
         Input : Inputs;

      begin
         if Self.Parse_State_Stack.Is_Empty then
            State := State_Initial;

         else
            raise Program_Error;
         end if;

         loop
            --  Checks end of document

            if Self.Is_End_Of_Document then
               Self.Unexpected_End_Of_Document (Parse_Reference'Access);

               return;
            end if;

            --  Classify current character

            if Self.Code = Ampersand then
               Input := Input_Ampersand;

            elsif Self.Code = Semicolon then
               Input := Input_Semicolon;

            elsif Self.Code = Number_Sign then
               Input := Input_Number_Sign;

            elsif Self.Code = Latin_Small_Letter_X then
               Input := Input_Latin_Small_Letter_X;

            elsif Self.Code in Digit_Zero .. Digit_Nine then
               Input := Input_Decimal_Digit;

            elsif Self.Code
                    in Latin_Capital_Letter_A .. Latin_Capital_Letter_F
            then
               Input := Input_Capital_Hex_Digit;

            elsif Self.Code
                    in Latin_Small_Letter_A .. Latin_Small_Letter_F
            then
               Input := Input_Small_Hex_Digit;

            elsif Is_Name_Start_Character (Self.Code) then
               Input := Input_Name_Start_Character;

            else
               Input := Input_Unknown;
            end if;

            State := Reference_Transition (State, Input);

            case State is
               when State_Initial =>
                  raise Program_Error;

               when State_Ampersand =>
                  Self.Next;

               when State_Name =>
                  Parse_Name (Self);

                  if Self.Parser_Status /= Continue then
                     Self.Parse_Failed (Parse_Reference'Access);

                     return;
                  end if;

               when State_Entity_Reference_Done =>
                  Self.Next;

                  return;

               when State_Number_Sign =>
                  Self.Next;

               when State_Decimal_Character_Reference =>
                  Self.Next;

               when State_Hex_Character_Reference =>
                  Self.Next;

               when State_Character_Reference_Done =>
                  Self.Next;

                  return;

               when State_Invalid =>
                  Self.Report_Parse_Error;

                  return;
            end case;
         end loop;
      end Parse_Reference;

   end Parser;

   ------------------------
   -- Report_Parse_Error --
   ------------------------

   procedure Report_Parse_Error (Self : in out SAX_Validating_Reader'Class) is
   begin
      Ada.Wide_Wide_Text_IO.Put_Line ("Report_Parse_Error");
      Self.Parser_Status := Error;
   end Report_Parse_Error;

   -------------------------
   -- Set_Content_Handler --
   -------------------------

   overriding procedure Set_Content_Handler
    (Self    : not null access SAX_Validating_Reader;
     Handler : XML.SAX.Readers.SAX_Content_Handler_Access) is
   begin
     Self.Content_Handler := Handler;
   end Set_Content_Handler;

   -----------------------------
   -- Set_Declaration_Handler --
   -----------------------------

   overriding procedure Set_Declaration_Handler
    (Self    : not null access SAX_Validating_Reader;
     Handler : XML.SAX.Readers.SAX_Declaration_Handler_Access) is
   begin
      Self.Declaration_Handler := Handler;
   end Set_Declaration_Handler;

   ---------------------
   -- Set_DTD_Handler --
   ---------------------

   overriding procedure Set_DTD_Handler
    (Self    : not null access SAX_Validating_Reader;
     Handler : XML.SAX.Readers.SAX_DTD_Handler_Access) is
   begin
      Self.DTD_Handler := Handler;
   end Set_DTD_Handler;

   -------------------------
   -- Set_Entity_Resolver --
   -------------------------

   overriding procedure Set_Entity_Resolver
    (Self     : not null access SAX_Validating_Reader;
     Resolver : XML.SAX.Readers.SAX_Entity_Resolver_Access) is
   begin
      Self.Entity_Resolver := Resolver;
   end Set_Entity_Resolver;

   -----------------------
   -- Set_Error_Handler --
   -----------------------

   overriding procedure Set_Error_Handler
    (Self    : not null access SAX_Validating_Reader;
     Handler : XML.SAX.Readers.SAX_Error_Handler_Access) is
   begin
      Self.Error_Handler := Handler;
   end Set_Error_Handler;

   -------------------------
   -- Set_Lexical_Handler --
   -------------------------

   overriding procedure Set_Lexical_Handler
    (Self    : not null access SAX_Validating_Reader;
     Handler : XML.SAX.Readers.SAX_Lexical_Handler_Access) is
   begin
      Self.Lexical_Handler := Handler;
   end Set_Lexical_Handler;

   --------------------------------
   -- Unexpected_End_Of_Document --
   --------------------------------

   procedure Unexpected_End_Of_Document
    (Self       : in out SAX_Validating_Reader'Class;
     Subprogram : Parse_Subprogram) is
   begin
      Self.Parser_Status := Error;
   end Unexpected_End_Of_Document;

end XML.SAX.Validating_Readers;
