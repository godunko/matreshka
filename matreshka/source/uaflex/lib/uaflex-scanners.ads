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
-- Copyright © 2012-2015, Vadim Godunko <vgodunko@gmail.com>                --
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

with Abstract_Sources;
with League.Strings;
with UAFLEX.Handlers;
with UAFLEX.Lexer_Types;
with Parser_Tokens;

package UAFLEX.Scanners is
   use UAFLEX.Lexer_Types;

   subtype Token is Parser_Tokens.Token;
   type Scanner is tagged limited private;

   procedure Set_Source
     (Self : in out Scanner'Class;
      Source : not null Abstract_Sources.Source_Access);

   procedure Set_Handler
     (Self    : in out Scanner'Class;
      Handler : not null UAFLEX.Handlers.Handler_Access);

   subtype Start_Condition is State;

   procedure Set_Start_Condition
    (Self : in out Scanner'Class; Condition : Start_Condition);

   function Get_Start_Condition
     (Self : Scanner'Class) return Start_Condition;

   procedure Get_Token (Self : access Scanner'Class; Result : out Token);

   procedure Move_Back (Self : in out Scanner'Class; Count : Positive) is null;

   function Get_Text
     (Self : Scanner'Class) return League.Strings.Universal_String;

   function Get_Token_Length (Self : Scanner'Class) return Positive;
   function Get_Token_Position (Self : Scanner'Class) return Positive;
private

   Buffer_Half_Size : constant := 1024;

   subtype Buffer_Index is Positive range 1 .. 2 * Buffer_Half_Size;

   type Character_Class_Array is array (Buffer_Index) of Character_Class;

   Error_Character : constant Character_Class := 0;
   Error_State : constant State := State'Last;

   type Buffer_Half is (Low, High);

   type Buffer_Offset is array (Buffer_Half) of Natural;

   type Scanner is tagged limited record
      Handler : Handlers.Handler_Access;
      Source  : Abstract_Sources.Source_Access;
      Start   : State := INITIAL;
      Next    : Buffer_Index := 1;
      From    : Buffer_Index := 1;
      To      : Natural := 0;
      Rule    : Rule_Index;
      Offset  : Buffer_Offset := (0, 0);
      Buffer  : Wide_Wide_String (Buffer_Index) :=
        (1 => Wide_Wide_Character'Val (Abstract_Sources.End_Of_Buffer),
         others => <>);
      Classes : Character_Class_Array := (1 => Error_Character, others => <>);
   end record;

   procedure Read_Buffer (Self : in out Scanner'Class);

end UAFLEX.Scanners;
