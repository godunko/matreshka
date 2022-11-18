------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--         Localization, Internationalization, Globalization for Ada        --
--                                                                          --
--                              Tools Component                             --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2013, Vadim Godunko <vgodunko@gmail.com>                     --
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
--
--  This is simple minimal perfect hash function generator for small set of
--  universal string. Driver accept JSON file with list of strings.
--  Example:
--    [ "OpenSession", "CloseSession", "GetBalance", "Deposit" ]
--  or
--  {
--    "package" : "Test",
--    "strings" :
--      [
--        {"name" : "S1", "text" : "OpenSession"},
--        {"name" : "S2", "text" : "CloseSession"},
--        {"name" : "S3", "text" : "GetBalance"},
--        {"name" : "S4", "text" : "Deposit"}
--      ]
--  }


with Ada.Directories;
with Ada.Numerics.Discrete_Random;
with Ada.Streams.Stream_IO;
with Ada.Wide_Wide_Text_IO;

with League.Application;
with League.JSON.Documents;
with League.Strings;
with League.String_Vectors;
with League.Text_Codecs;
with League.JSON.Objects;
with League.JSON.Arrays;
with League.JSON.Values;

procedure Perf_Driver is

   Min_Length : Natural := Natural'Last;

   subtype Position is Natural;

   type Position_Array is array (Positive range <>) of Position;

   type Index_Array is array (Positive range <>) of Natural;

   function "+" (Item : Wide_Wide_String)
     return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   function Read_File
     (Name : League.Strings.Universal_String)
         return League.Strings.Universal_String;
   --  Read content of gigen file into universal string

   procedure Read_JSON_Object
     (X    : League.JSON.Objects.JSON_Object;
      Name : in out League.Strings.Universal_String;
      Enum : in out League.String_Vectors.Universal_String_Vector;
      List : in out League.String_Vectors.Universal_String_Vector);
   --  Read target package name (if any), list of strings to make perfect hash
   --  Collect sting names into Enum if any.

   procedure Read_JSON_Array
     (X    : League.JSON.Arrays.JSON_Array;
      Enum : in out League.String_Vectors.Universal_String_Vector;
      List : in out League.String_Vectors.Universal_String_Vector);
   --  Read list of strings to make perfect hash

   function Find_Distinct
     (V          : League.String_Vectors.Universal_String_Vector;
      Max        : Position;
      Pos        : in out Position_Array;
      Use_Length : Boolean;
      From       : Positive := 1) return Boolean;
   --  Find indexes Pos where all strings in V has distinct characters
   --  Dont go over Max characters in string.
   --  From is index in Pos to start working from.

   function Try_Hash
     (List : League.String_Vectors.Universal_String_Vector;
      A, B : Positive;
      Pos  : Position_Array;
      Map  : in out Index_Array) return Boolean;
   --  For each item in List fill Map (Index (item) := Hash (Item)
   --  Return True if no conflicts in Map found.
   --  Let Hash function be
   --    (A * Item (Pos(1)) + B * Item (Pos(2)) + Item.Length) mod Map'Length

   package Randoms is new Ada.Numerics.Discrete_Random (Positive);

   -------------------
   -- Find_Distinct --
   -------------------

   function Find_Distinct
     (V          : League.String_Vectors.Universal_String_Vector;
      Max        : Position;
      Pos        : in out Position_Array;
      Use_Length : Boolean;
      From       : Positive := 1) return Boolean
   is
      use League.Strings;
      use League.String_Vectors;
   begin
      if From = Pos'First then
         Pos (From) := 1;
      else
         Pos (From) := Pos (From - 1) + 1;
      end if;

      if From /= Pos'Last then
         while Pos (From) <= Max + From - Pos'Last loop
            if Find_Distinct (V, Max, Pos, Use_Length, From + 1) then
               return True;
            end if;

            Pos (From) := Pos (From) + 1;
         end loop;

         return False;
      else
         declare
            T   : Universal_String_Vector;
            E   : Universal_String;
            S   : Wide_Wide_String (Pos'Range);
            Len : Natural;
         begin
            for J in 1 .. V.Length loop
               E := V.Element (J);

               for K in Pos'Range loop
                  S (K) := E.Element (Pos (K)).To_Wide_Wide_Character;
               end loop;

               Len := E.Length;

               E := To_Universal_String (S);

               if Use_Length then
                  for X in 1 .. J - 1 loop
                     if T.Element (X) = E and then
                       V.Element (X).Length = Len
                     then
                        return False;
                     end if;
                  end loop;
               elsif T.Index (E) > 0 then
                  return False;
               end if;

               T.Append (E);
            end loop;

            return True;
         end;
      end if;
   end Find_Distinct;

   ---------------
   -- Read_File --
   ---------------

   function Read_File
     (Name : League.Strings.Universal_String)
         return League.Strings.Universal_String
   is
      File_Name : constant String :=
        League.Text_Codecs.To_Exception_Message (Name);
   begin
      if Ada.Directories.Exists (File_Name) then
         declare
            Decoder : League.Text_Codecs.Text_Codec :=
              League.Text_Codecs.Codec (+"utf-8");

            Size : constant Ada.Directories.File_Size :=
              Ada.Directories.Size (File_Name);

            Length : constant Ada.Streams.Stream_Element_Offset :=
              Ada.Streams.Stream_Element_Count (Size);

            File   : Ada.Streams.Stream_IO.File_Type;
            Data   : Ada.Streams.Stream_Element_Array (1 .. Length);
            Last   : Ada.Streams.Stream_Element_Offset;
         begin
            Ada.Streams.Stream_IO.Open
              (File, Ada.Streams.Stream_IO.In_File, File_Name);
            Ada.Streams.Stream_IO.Read (File, Data, Last);
            Ada.Streams.Stream_IO.Close (File);

            return Decoder.Decode (Data (1 .. Last));

         end;
      else
         return League.Strings.Empty_Universal_String;
      end if;
   end Read_File;

   ----------------------
   -- Read_JSON_Object --
   ----------------------

   procedure Read_JSON_Object
     (X    : League.JSON.Objects.JSON_Object;
      Name : in out League.Strings.Universal_String;
      Enum : in out League.String_Vectors.Universal_String_Vector;
      List : in out League.String_Vectors.Universal_String_Vector) is
   begin
      Name := X.Value (+"package").To_String (Default => Name);

      Read_JSON_Array (X.Value (+"strings").To_Array, Enum, List);
   end Read_JSON_Object;

   ---------------------
   -- Read_JSON_Array --
   ---------------------

   procedure Read_JSON_Array
     (X    : League.JSON.Arrays.JSON_Array;
      Enum : in out League.String_Vectors.Universal_String_Vector;
      List : in out League.String_Vectors.Universal_String_Vector)
   is
      Item   : League.JSON.Values.JSON_Value;
      Object : League.JSON.Objects.JSON_Object;
   begin
      for J in 1 .. X.Length loop
         Item := X.Element (J);

         if Item.Is_Object then
            Object := Item.To_Object;
            List.Append (Object.Value (+"text").To_String);

            if Object.Contains (+"name") then
               Enum.Append (Object.Value (+"name").To_String);
            end if;
         elsif Item.Is_String then
            List.Append (Item.To_String);
         else
            raise Constraint_Error;
         end if;
      end loop;
   end Read_JSON_Array;

   --------------
   -- Try_Hash --
   --------------

   function Try_Hash
     (List : League.String_Vectors.Universal_String_Vector;
      A, B : Positive;
      Pos  : Position_Array;
      Map  : in out Index_Array) return Boolean
   is

      use League.Strings;
      use League.String_Vectors;

      type Unsigned is mod 2 ** 32;

      function Hash (S : Universal_String) return Positive;

      function Hash (S : Universal_String) return Positive is
         Result : Unsigned := Unsigned (S.Length);
         Char   : Unsigned;
      begin
         for K in Pos'Range loop
            Char := Unsigned (Wide_Wide_Character'Pos
                              (S.Element (Pos (K)).To_Wide_Wide_Character));
            if K = 1 then
               Result := Result + Unsigned (A) * Char;
            else
               Result := Result + Unsigned (B) * Char;
            end if;
         end loop;

         return Natural (Result mod Map'Length) + 1;
      end Hash;

      H : Positive;
   begin
      for J in 1 .. List.Length loop
         H := Hash (List.Element (J));

         if Map (H) = 0 then
            Map (H) := J;
         else
            return False;
         end if;
      end loop;

      return True;
   end Try_Hash;

   ------------------
   -- Print_Source --
   ------------------

   procedure Print_Source
     (Name : League.Strings.Universal_String;
      Enum : League.String_Vectors.Universal_String_Vector;
      A, B : Positive;
      Pos  : Position_Array;
      Map  : Index_Array)
   is
      use League.Strings;
      use League.String_Vectors;

      procedure P (X : Wide_Wide_String);
      procedure P (X : Universal_String);
      procedure P (X : Integer);
      procedure N (X : Wide_Wide_String := "");
      procedure N (X : Universal_String);

      Output : Universal_String;

      New_Line : Wide_Wide_String := (1 => Wide_Wide_Character'Val (10));

      procedure P (X : Wide_Wide_String) is
      begin
         Output.Append (X);
      end P;

      procedure P (X : Universal_String) is
      begin
         Output.Append (X);
      end P;

      procedure P (X : Integer) is
         Image : Wide_Wide_String := Integer'Wide_Wide_Image (X);
      begin
         P (Image (2 .. Image'Last));
      end P;

      procedure N (X : Wide_Wide_String := "") is
      begin
         P (X); P (New_Line);
      end N;

      procedure N (X : Universal_String) is
      begin
         P (X); P (New_Line);
      end N;
   begin
      N ("with League.Strings;");
      N;
      P ("package "); P (Name); N (" is");
      N ("   function Hash (X : League.Strings.Universal_String)" &
           " return Natural;");
      P ("end "); P (Name); N (";");

      P ("package body "); P (Name); N (" is");
      N ("   type Unsigned is mod 2 ** 32;");
      N;
      P ("   M : array (Unsigned range 1 .. "); P (Map'Last);
      N (") of Natural :=");
      P ("     (");
      for J in Map'Range loop
         if Map (J) /= 0 then
            P (J); P (" => "); P (Natural (Map (J))); N (",");
            P ("      ");
         end if;
      end loop;

      N ("others => 0);");
      N;
      N ("   function Hash (X : League.Strings.Universal_String)" &
           " return Natural is");
      N ("      Result : Unsigned := Unsigned (X.Length);");
      N ("      Char   : Unsigned;");
      N ("   begin");

      for K in Pos'Range loop
         N ("      Char := Unsigned (Wide_Wide_Character'Pos");
         P ("                (X.Element ("); P (Pos (K));
         N (").To_Wide_Wide_Character));");
         P ("      Result := Result + Unsigned (");

         if K = 1 then
            P (A);
         else
            P (B);
         end if;

         N (") * Char;");
      end loop;
      P ("      return M ((Result mod "); P (Map'Length);
      N (") + 1);");
      N ("   end Hash;");
      N;
      P ("end "); P (Name); N (";");

      Ada.Wide_Wide_Text_IO.Put_Line (Output.To_Wide_Wide_String);
   end Print_Source;

   Arg  : constant League.String_Vectors.Universal_String_Vector :=
     League.Application.Arguments;
   Text : League.Strings.Universal_String;
   Doc  : League.JSON.Documents.JSON_Document;
   Name : League.Strings.Universal_String := +"Perfect_Hash";
   Enum : League.String_Vectors.Universal_String_Vector;
   List : League.String_Vectors.Universal_String_Vector;
begin
   if Arg.Length /= 1 then
      Ada.Wide_Wide_Text_IO.Put_Line ("File name expected as argument");
      return;
   end if;

   Text := Read_File (Arg.Element (1));

   Doc := League.JSON.Documents.From_JSON (Text);

   if Doc.Is_Object then
      Read_JSON_Object (Doc.To_Object, Name, Enum, List);
   elsif Doc.Is_Array then
      Read_JSON_Array (Doc.To_Array, Enum, List);
   else
      Ada.Wide_Wide_Text_IO.Put_Line ("bad json in input file");
      return;
   end if;

   --  Get min length of any string in List

   for J in 1 .. List.Length loop
      declare
         Item : constant League.Strings.Universal_String := List.Element (J);
      begin
         Min_Length := Natural'Min (Min_Length, Item.Length);
      end;
   end loop;

   --  Try to find shortest sequence of positions in string with unique chars
   for K in 1 .. Min_Length loop
      declare
         Random : Randoms.Generator;
         Pos    : Position_Array (1 .. K);
      begin
         Randoms.Reset (Random);

         if Find_Distinct (List, Min_Length, Pos, Use_Length => True) then
            --  Here we found positions in string with unique chars
            declare
               A, B   : Positive := Randoms.Random (Random);
               Map    : Index_Array (1 .. List.Length * 2) := (others => 0);
            begin
               --  Try to find hash
               while not Try_Hash
                 (List => List,
                  A    => A,
                  B    => B,
                  Pos  => Pos,
                  Map  => Map)
               loop
                  A := Randoms.Random (Random);
                  B := Randoms.Random (Random);
                  Map := (others => 0);
               end loop;

               --  We found suitable A, B for out Hash and fill Map with
               --  corresponding indexes. Print package now

               Print_Source (Name, Enum, A, B, Pos, Map);
               exit;
            end;
         end if;
      end;
   end loop;

end Perf_Driver;
