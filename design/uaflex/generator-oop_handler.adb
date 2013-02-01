with Matreshka.Internals.Finite_Automatons;
with Ada.Wide_Wide_Text_IO;
with Nodes;

package body Generator.OOP_Handler is

   --------
   -- Go --
   --------

   procedure Go
     (Actions : League.String_Vectors.Universal_String_Vector;
      File    : String;
      Types   : League.Strings.Universal_String;
      Unit    : League.Strings.Universal_String;
      Scanner : League.Strings.Universal_String;
      Tokens  : League.Strings.Universal_String)
   is
      procedure P (Text : Wide_Wide_String);
      procedure N (Text : Wide_Wide_String);

      Output  : Ada.Wide_Wide_Text_IO.File_Type;

      procedure N (Text : Wide_Wide_String) is
      begin
         Ada.Wide_Wide_Text_IO.Put (Output, Text);
      end N;

      procedure P (Text : Wide_Wide_String) is
      begin
         Ada.Wide_Wide_Text_IO.Put_Line (Output, Text);
      end P;

   begin
      Ada.Wide_Wide_Text_IO.Create (Output, Name => File);

      P ("limited with " & Scanner.To_Wide_Wide_String & ";");
      P ("with " & Tokens.To_Wide_Wide_String & ";");
      P ("");
      P ("package " & Unit.To_Wide_Wide_String & " is");
      P ("");
      P ("   type Handler is abstract tagged limited null record;");
      P ("");

      for J in 1 .. Actions.Length loop
         P ("   procedure " & Actions.Element (J).To_Wide_Wide_String);
         P ("     (Self    : not null access Handler;");
         P ("      Scanner : not null access " &
              Scanner.To_Wide_Wide_String & ".Scanner'Class;");
         P ("      Rule    : " & Types.To_Wide_Wide_String & ".Rule_Index;");
         P ("      Token   : out " & Tokens.To_Wide_Wide_String & ".Token;");
         P ("      Skip    : in out Boolean) is abstract;");
         P ("");
      end loop;

      P ("   type Handler_Access is access all Handler'Class;");
      P ("");
      P ("end " & Unit.To_Wide_Wide_String & ";");

      Ada.Wide_Wide_Text_IO.Close (Output);
   end Go;

   ---------------
   -- On_Accept --
   ---------------

   procedure On_Accept
     (Actions : League.String_Vectors.Universal_String_Vector;
      File    : String;
      Types   : League.Strings.Universal_String;
      Handler : League.Strings.Universal_String;
      Scanner : League.Strings.Universal_String;
      Tokens  : League.Strings.Universal_String)
   is
      procedure P (Text : Wide_Wide_String);
      procedure N (Text : Wide_Wide_String);

      Output  : Ada.Wide_Wide_Text_IO.File_Type;
      First   : Boolean;

      procedure N (Text : Wide_Wide_String) is
      begin
         Ada.Wide_Wide_Text_IO.Put (Output, Text);
      end N;

      procedure P (Text : Wide_Wide_String) is
      begin
         Ada.Wide_Wide_Text_IO.Put_Line (Output, Text);
      end P;

   begin
      Ada.Wide_Wide_Text_IO.Create (Output, Name => File);

      P ("separate (" & Scanner.To_Wide_Wide_String & ")");
      P ("procedure On_Accept");
      P ("  (Self    : not null access " &
           Handler.To_Wide_Wide_String & ".Handler'Class;");
      P ("   Scanner : not null access " &
           Scanner.To_Wide_Wide_String & ".Scanner'Class;");
      P ("   Rule    : " & Types.To_Wide_Wide_String & ".Rule_Index;");
      P ("   Token   : out " & Tokens.To_Wide_Wide_String & ".Token;");
      P ("   Skip    : in out Boolean) is");
      P ("begin");
      P ("   case Rule is");

      for J in 1 .. Actions.Length loop
         First := True;

         for R in Nodes.Indexes.First_Index .. Nodes.Indexes.Last_Index loop
            if Nodes.Indexes (R) /= J then
               null;
            elsif First then
               N ("      when " & Image (R));
               First := False;
            else
               N (" | " & Image (R));
            end if;
         end loop;

         P (" =>");
         P ("         Self." & Actions.Element (J).To_Wide_Wide_String &
              " (Scanner, Rule, Token, Skip);");
         P ("");
      end loop;

      P ("      when others =>");
      P ("         raise Constraint_Error;");
      P ("   end case;");
      P ("end On_Accept;");

      Ada.Wide_Wide_Text_IO.Close (Output);
   end On_Accept;
end Generator.OOP_Handler;
