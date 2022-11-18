------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--         Localization, Internationalization, Globalization for Ada        --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2012-2017, Vadim Godunko <vgodunko@gmail.com>                --
-- All rights reserved.                                                     --
--                                                                          --
-- Redistribution and use in source and binary forms, with or without       --
-- modification, are permitted provided that the following conditions       --
-- are met:                                                                 --
--                                                                          --
--  * Redistributions of source code must retain the above copyright        --
--    notice, this list of conditions and the following disclaimer.         --
--                                                                          --
--  * Redistributions in binary form must reproduce the above copyright     --
--    notice, this list of conditions and the following disclaimer in the   --
--    documentation and/or other materials provided with the distribution.  --
--                                                                          --
--  * Neither the name of the Vadim Godunko, IE nor the names of its        --
--    contributors may be used to endorse or promote products derived from  --
--    this software without specific prior written permission.              --
--                                                                          --
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS      --
-- "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT        --
-- LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR    --
-- A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT     --
-- HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,   --
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED --
-- TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR   --
-- PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF   --
-- LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING     --
-- NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS       --
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.             --
--                                                                          --
------------------------------------------------------------------------------
--  $Revision$ $Date$
------------------------------------------------------------------------------
with Matreshka.Internals.Unicode;

package body UAFLEX.Scanners is

   package Tables is
      function To_Class (Value : Matreshka.Internals.Unicode.Code_Point)
        return Character_Class;
      pragma Inline (To_Class);

      function Switch (S : State; Class : Character_Class) return State;
      pragma Inline (Switch);

      function Rule (S : State) return Rule_Index;
      pragma Inline (Rule);
   end Tables;

   procedure On_Accept
     (Self    : not null access UAFLEX.Handlers.Handler'Class;
      Scanner : not null access UAFLEX.Scanners.Scanner'Class;
      Rule    : Rule_Index;
      Token   : out Parser_Tokens.Token;
      Skip    : in out Boolean);

   package body Tables is separate;

   use Tables;

   procedure On_Accept
     (Self    : not null access UAFLEX.Handlers.Handler'Class;
      Scanner : not null access UAFLEX.Scanners.Scanner'Class;
      Rule    : Rule_Index;
      Token   : out Parser_Tokens.Token;
      Skip    : in out Boolean) is separate;

   End_Of_Buffer : constant Wide_Wide_Character :=
     Wide_Wide_Character'Val (Abstract_Sources.End_Of_Buffer);

   -------------------------
   -- Get_Start_Condition --
   -------------------------

   function Get_Start_Condition
     (Self : Scanner'Class)
      return Start_Condition
   is
   begin
      return Self.Start;
   end Get_Start_Condition;

   --------------
   -- Get_Text --
   --------------

   function Get_Text
     (Self : Scanner'Class)
      return League.Strings.Universal_String
   is
   begin
      if Self.From <= Self.To then
         return League.Strings.To_Universal_String
           (Self.Buffer (Self.From .. Self.To));
      elsif Self.From = Self.To + 1 then
         return League.Strings.Empty_Universal_String;
      else
         return League.Strings.To_Universal_String
           (Self.Buffer (Self.From .. Self.Buffer'Last)
              & Self.Buffer (1 .. Self.To));
      end if;
   end Get_Text;

   ---------------
   -- Get_Token --
   ---------------

   procedure Get_Token (Self : access Scanner'Class; Result : out Token) is
      procedure Next;

      procedure Next is
      begin
         if Self.Next = Self.Buffer'Last then
            Self.Next := 1;
         else
            Self.Next := Self.Next + 1;
         end if;
      end Next;

      EOF : constant Wide_Wide_Character :=
        Wide_Wide_Character'Val (Abstract_Sources.End_Of_Input);
      --  EOD : constant Wide_Wide_Character :=
      --    Wide_Wide_Character'Val (Abstract_Sources.End_Of_Data);

      Current_State : State := Self.Start;
      Char : Character_Class;
      Next_Rule : Rule_Index;
      Skip      : Boolean := True;
   begin
      loop
         if Self.Buffer (Self.Next) = EOF then
            Result := Parser_Tokens.End_Of_Input;
            return;
         end if;

         Current_State := Self.Start;
         Self.Rule := 0;
         Self.From := Self.Next;
         Self.To   := Self.Next - 1;

         loop
            Char := Self.Classes (Self.Next);

            if Char /= Error_Character then
               Current_State := Switch (Current_State, Char);

               if Current_State not in Looping_State then
                  if Current_State in Final_State then
                     Self.Rule := Rule (Current_State);
                     Self.To := Self.Next;
                  end if;

                  exit;
               elsif Current_State in Final_State then
                  Next_Rule := Rule (Current_State);
                  Self.Rule := Next_Rule;
                  Self.To := Self.Next;
               end if;

               Next;
            elsif Self.Buffer (Self.Next) = End_Of_Buffer then
               Self.Read_Buffer;
            else
               exit;
            end if;
         end loop;

         Self.Next := Self.To;
         Next;

         if Self.Rule = 0 then
            Result := Parser_Tokens.Error;
            return;
         else
            On_Accept (Self.Handler, Self, Self.Rule, Result, Skip);

            if not Skip then
               return;
            end if;
         end if;
      end loop;
   end Get_Token;

   ----------------------
   -- Get_Token_Length --
   ----------------------

   function Get_Token_Length (Self : Scanner'Class) return Positive is
   begin
      if Self.From <= Self.To then
         return Self.To - Self.From + 1;
      else
         return Buffer_Index'Last - Self.From + 1 + Self.To;
      end if;
   end Get_Token_Length;

   ------------------------
   -- Get_Token_Position --
   ------------------------

   function Get_Token_Position (Self : Scanner'Class) return Positive is
      Half : constant Buffer_Half :=
        Buffer_Half'Val (Boolean'Pos (Self.From >= Buffer_Half_Size));
   begin
      return Self.Offset (Half) + Self.From;
   end Get_Token_Position;

   -----------------
   -- Read_Buffer --
   -----------------

   procedure Read_Buffer (Self : in out Scanner'Class) is
      use Abstract_Sources;
      use type Code_Unit_32;

      Next : Code_Unit_32;
      Pos  : Buffer_Index := Self.Next;
   begin
      if Self.From <= Buffer_Half_Size xor Self.Next <= Buffer_Half_Size then
         raise Constraint_Error with "Token too large";
      end if;

      if Pos = Buffer_Half_Size then
         Self.Offset (High) := Self.Offset (High) + Self.Buffer'Length;
      elsif Pos = Self.Buffer'Last then
         Self.Offset (Low) := Self.Offset (Low) + Self.Buffer'Length;
      end if;

      loop
         Next := Self.Source.Get_Next;
         Self.Buffer (Pos) := Wide_Wide_Character'Val (Next);

         if Next = End_Of_Input or Next = Error then
            Self.Classes (Pos) := Error_Character;
            return;
         else
            Self.Classes (Pos) := To_Class (Next);

            if Pos = Self.Buffer'Last then
               Pos := 1;
            else
               Pos := Pos + 1;
            end if;

            if Pos = Buffer_Half_Size or Pos = Self.Buffer'Last then
               Self.Classes (Pos) := Error_Character;
               Self.Buffer (Pos) := End_Of_Buffer;
               return;
            end if;
         end if;
      end loop;
   end Read_Buffer;

   -----------------
   -- Set_Handler --
   -----------------

   procedure Set_Handler
     (Self    : in out Scanner'Class;
      Handler : not null UAFLEX.Handlers.Handler_Access) is
   begin
      Self.Handler := Handler;
   end Set_Handler;

   ----------------
   -- Set_Source --
   ----------------

   procedure Set_Source
     (Self : in out Scanner'Class;
      Source : not null Abstract_Sources.Source_Access)
   is
   begin
      Self.Source := Source;
   end Set_Source;

   -------------------------
   -- Set_Start_Condition --
   -------------------------

   procedure Set_Start_Condition
     (Self : in out Scanner'Class;
      Condition : Start_Condition)
   is
   begin
      Self.Start := Condition;
   end Set_Start_Condition;

end UAFLEX.Scanners;
