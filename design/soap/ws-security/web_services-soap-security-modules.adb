------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2012, Vadim Godunko <vgodunko@gmail.com>                     --
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
with Ada.Streams;
with GNAT.SHA1;

with League.Text_Codecs;

with Web_Services.SOAP.Payloads.Faults.Simple;
with Web_Services.SOAP.Security.Headers;

package body Web_Services.SOAP.Security.Modules is

   procedure Default_Provider
    (Username : League.Strings.Universal_String;
     Password : out League.Strings.Universal_String;
     Success  : out Boolean);

   UTF8_Codec : constant League.Text_Codecs.Text_Codec
     := League.Text_Codecs.Codec
         (League.Strings.To_Universal_String ("utf-8"));
   --  Text codec to convert strings into UTF8 representation.

   Get_Authentication_Data : Authentication_Data_Provider
     := Default_Provider'Access;

   function To_Base_64
    (Item : Ada.Streams.Stream_Element_Array)
       return Ada.Streams.Stream_Element_Array;

   function From_Base_64
    (Item : Ada.Streams.Stream_Element_Array)
       return Ada.Streams.Stream_Element_Array;

   function To_Binary_Message_Digest
    (Item : String) return Ada.Streams.Stream_Element_Array;
   --  Converts string into array of stream elements. Note: this subprogram is
   --  needed for GNAT GPL 2012 only, because it doesn't provide
   --  GNAT.SHA1.Digest subprogram which returns Binary_Message_Digest.

   ----------------------
   -- Default_Provider --
   ----------------------

   procedure Default_Provider
    (Username : League.Strings.Universal_String;
     Password : out League.Strings.Universal_String;
     Success  : out Boolean)
   is
      use type League.Strings.Universal_String;

   begin
      if Username /= League.Strings.To_Universal_String ("boris") then
         Success := False;

      else
         Success := True;
         Password := League.Strings.To_Universal_String ("123");
      end if;
   end Default_Provider;

   ------------------
   -- From_Base_64 --
   ------------------

   function From_Base_64
    (Item : Ada.Streams.Stream_Element_Array)
       return Ada.Streams.Stream_Element_Array
   is
      use type Ada.Streams.Stream_Element;
      use type Ada.Streams.Stream_Element_Offset;

      function Decode
       (Item : Ada.Streams.Stream_Element) return Ada.Streams.Stream_Element;

      ------------
      -- Decode --
      ------------

      function Decode
       (Item : Ada.Streams.Stream_Element) return Ada.Streams.Stream_Element is
      begin
         case Item is
            when Character'Pos ('A') .. Character'Pos ('Z') =>
               return Item - Character'Pos ('A');

            when Character'Pos ('a') .. Character'Pos ('z') =>
               return Item - Character'Pos ('a') + 26;

            when Character'Pos ('0') .. Character'Pos ('9') =>
               return Item - Character'Pos ('0') + 52;

            when Character'Pos ('+') =>
               return 62;

            when Character'Pos ('/') =>
               return 63;

            when Character'Pos ('=') =>
               return 0;

            when others =>
               raise Constraint_Error;
         end case;
      end Decode;

      Result : Ada.Streams.Stream_Element_Array (0 .. Item'Length);
      Unused : Ada.Streams.Stream_Element_Offset := Result'First;
      First  : Ada.Streams.Stream_Element_Offset := Item'First;

   begin
      while Item'Last > First loop
         declare
            S1 : constant Ada.Streams.Stream_Element := Item (First);
            S2 : constant Ada.Streams.Stream_Element := Item (First + 1);
            S3 : constant Ada.Streams.Stream_Element := Item (First + 2);
            S4 : constant Ada.Streams.Stream_Element := Item (First + 3);
            A1 : Ada.Streams.Stream_Element;
            A2 : Ada.Streams.Stream_Element;
            A3 : Ada.Streams.Stream_Element;
            A4 : Ada.Streams.Stream_Element;

         begin
            A1 := Decode (S1);
            A2 := Decode (S2);

            Result (Unused) := (A1 * 4) or ((A2 and 2#0011_0000#) / 16);
            Unused := Unused + 1;

            if S3 /= Character'Pos ('=') then
               A3 := Decode (S3);

               Result (Unused) :=
                ((A2 and 2#0000_1111#) * 16) or ((A3 and 2#0011_1100#) / 4);
               Unused := Unused + 1;

               if S4 /= Character'Pos ('=') then
                  A4 := Decode (S4);

                  Result (Unused) := ((A3 and 2#0000_0011#) * 64) or A4;
                  Unused := Unused + 1;
               end if;
            end if;

            First := First + 4;
         end;
      end loop;

      return Result (Result'First .. Unused - 1);
   end From_Base_64;

   ---------------------
   -- Receive_Request --
   ---------------------

   overriding procedure Receive_Request
    (Self    : in out Security_Module;
     Message : in out Web_Services.SOAP.Messages.SOAP_Message;
     Output  : in out Web_Services.SOAP.Messages.SOAP_Message_Access)
   is
      use type Ada.Streams.Stream_Element_Array;
      use type League.Strings.Universal_String;
      use type Web_Services.SOAP.Security.Headers.Username_Token_Header_Access;

      Token    :
        Web_Services.SOAP.Security.Headers.Username_Token_Header_Access;
      Password : League.Strings.Universal_String;
      Success  : Boolean;
      Digest   : League.Strings.Universal_String;

   begin
      --  There is no authentication data provider configured, security is
      --  disabled.

      if Get_Authentication_Data = null then
         return;
      end if;

      --  Obtain authentication token.

      for Header of Message.Headers loop
         if Header.all
           in Web_Services.SOAP.Security.Headers.Username_Token_Header'Class
         then
            Token :=
              Web_Services.SOAP.Security.Headers.Username_Token_Header_Access
               (Header);

            exit;
         end if;
      end loop;

      --  Authentication token is not provided, return fault.

      if Token = null then
         Output :=
           new Web_Services.SOAP.Messages.SOAP_Message'
            (Output  => null,
             Headers => <>,
             Payload =>
               Web_Services.SOAP.Payloads.Faults.Simple.Create_SOAP_Fault
                (League.Strings.To_Universal_String ("Sender"),
                 League.Strings.To_Universal_String ("en-US"),
                 League.Strings.To_Universal_String
                  ("An invalid security token was provided")));
--  XXX Fault/Code/Subcode/Value must be set to:
--                 WSSE_Namespace_URI,
--                 League.Strings.To_Universal_String ("wsse"),
--                 League.Strings.To_Universal_String ("InvalidSecurityToken")

         return;
      end if;

      --  Obtain authentication data.

      Get_Authentication_Data (Token.Username, Password, Success);

      if not Success then
         Output :=
           new Web_Services.SOAP.Messages.SOAP_Message'
            (Output  => null,
             Headers => <>,
             Payload =>
               Web_Services.SOAP.Payloads.Faults.Simple.Create_SOAP_Fault
                (League.Strings.To_Universal_String ("Sender"),
                 League.Strings.To_Universal_String ("en-US"),
                 League.Strings.To_Universal_String
                  ("The security token could not be authenticated"
                     & " or authorized")));
--  XXX Fault/Code/Subcode/Value must be set to:
--                 WSSE_Namespace_URI,
--                 League.Strings.To_Universal_String ("wsse"),
--                 League.Strings.To_Universal_String ("FailedAuthentication")

         return;
      end if;

      --  Check password.
      --
      --  Password digest is calculated as:
      --
      --    Password_Digest = Base64 ( SHA-1 ( nonce + created + password ) )

      Digest := Token.Nonce & Token.Created & Password;

      declare
         Full_Data : constant Ada.Streams.Stream_Element_Array
           := From_Base_64
               (UTF8_Codec.Encode (Token.Nonce).To_Stream_Element_Array)
                & UTF8_Codec.Encode
                   (Token.Created & Password).To_Stream_Element_Array;
         Digest    : constant League.Strings.Universal_String
           := UTF8_Codec.Decode
               (To_Base_64
                 (To_Binary_Message_Digest (GNAT.SHA1.Digest (Full_Data))));
         --  GNAT GPL 2012: Use of To_Binary_Message_Digest is not needed here,
         --  but GNAT GPL 2012 doesn't provide corresponding GNAT.SHA1.Digest
         --  subprogram.

      begin
         if Digest /= Token.Password then
            Output :=
              new Web_Services.SOAP.Messages.SOAP_Message'
               (Output  => null,
                Headers => <>,
                Payload =>
                  Web_Services.SOAP.Payloads.Faults.Simple.Create_SOAP_Fault
                   (League.Strings.To_Universal_String ("Sender"),
                    League.Strings.To_Universal_String ("en-US"),
                    League.Strings.To_Universal_String
                     ("The security token could not be authenticated"
                        & " or authorized")));
--  XXX Fault/Code/Subcode/Value must be set to:
--                 WSSE_Namespace_URI,
--                 League.Strings.To_Universal_String ("wsse"),
--                 League.Strings.To_Universal_String ("FailedAuthentication")

            return;
         end if;
      end;
   end Receive_Request;

   --------------------------------------
   -- Set_Authentication_Data_Provider --
   --------------------------------------

   procedure Set_Authentication_Data_Provider
    (Provider : Authentication_Data_Provider) is
   begin
      Get_Authentication_Data := Provider;
   end Set_Authentication_Data_Provider;

   ----------------
   -- To_Base_64 --
   ----------------

   function To_Base_64
    (Item : Ada.Streams.Stream_Element_Array)
       return Ada.Streams.Stream_Element_Array
   is
      use type Ada.Streams.Stream_Element;
      use type Ada.Streams.Stream_Element_Offset;

      Encode : constant
        array (Ada.Streams.Stream_Element range 0 .. 63)
          of Ada.Streams.Stream_Element
            := (Character'Pos ('A'), Character'Pos ('B'), Character'Pos ('C'),
                Character'Pos ('D'), Character'Pos ('E'), Character'Pos ('F'),
                Character'Pos ('G'), Character'Pos ('H'), Character'Pos ('I'),
                Character'Pos ('J'), Character'Pos ('K'), Character'Pos ('L'),
                Character'Pos ('M'), Character'Pos ('N'), Character'Pos ('O'),
                Character'Pos ('P'), Character'Pos ('Q'), Character'Pos ('R'),
                Character'Pos ('S'), Character'Pos ('T'), Character'Pos ('U'),
                Character'Pos ('V'), Character'Pos ('W'), Character'Pos ('X'),
                Character'Pos ('Y'), Character'Pos ('Z'), Character'Pos ('a'),
                Character'Pos ('b'), Character'Pos ('c'), Character'Pos ('d'),
                Character'Pos ('e'), Character'Pos ('f'), Character'Pos ('g'),
                Character'Pos ('h'), Character'Pos ('i'), Character'Pos ('j'),
                Character'Pos ('k'), Character'Pos ('l'), Character'Pos ('m'),
                Character'Pos ('n'), Character'Pos ('o'), Character'Pos ('p'),
                Character'Pos ('q'), Character'Pos ('r'), Character'Pos ('s'),
                Character'Pos ('t'), Character'Pos ('u'), Character'Pos ('v'),
                Character'Pos ('w'), Character'Pos ('x'), Character'Pos ('y'),
                Character'Pos ('z'), Character'Pos ('0'), Character'Pos ('1'),
                Character'Pos ('2'), Character'Pos ('3'), Character'Pos ('4'),
                Character'Pos ('5'), Character'Pos ('6'), Character'Pos ('7'),
                Character'Pos ('8'), Character'Pos ('9'), Character'Pos ('+'),
                Character'Pos ('/'));

      Result : Ada.Streams.Stream_Element_Array (0 .. Item'Length * 2);
      First  : Ada.Streams.Stream_Element_Offset := Item'First;
      Unused : Ada.Streams.Stream_Element_Offset := Result'First;
      Source : Ada.Streams.Stream_Element;

   begin
      while Item'Last - First >= 2 loop
         declare
            S1 : constant Ada.Streams.Stream_Element := Item (First);
            S2 : constant Ada.Streams.Stream_Element := Item (First + 1);
            S3 : constant Ada.Streams.Stream_Element := Item (First + 2);

         begin
            Source := (S1 and 2#1111_1100#) / 4;
            Result (Unused) := Encode (Source);
            Unused := Unused + 1;

            Source :=
             ((S1 and 2#0000_0011#) * 16) or ((S2 and 2#1111_0000#) / 16);
            Result (Unused) := Encode (Source);
            Unused := Unused + 1;

            Source :=
             ((S2 and 2#0000_1111#) * 4) or ((S3 and 2#1100_0000#) / 64);
            Result (Unused) := Encode (Source);
            Unused := Unused + 1;

            Source := S3 and 2#0011_1111#;
            Result (Unused) := Encode (Source);
            Unused := Unused + 1;
         end;

         First := First + 3;
      end loop;

      if Item'Last - First = 0 then
         declare
            S1 : constant Ada.Streams.Stream_Element := Item (First);

         begin
            Source := (S1 and 2#1111_1100#) / 4;
            Result (Unused) := Encode (Source);
            Unused := Unused + 1;

            Source := (S1 and 2#0000_0011#) * 16;
            Result (Unused) := Encode (Source);
            Unused := Unused + 1;

            Result (Unused) := Character'Pos ('=');
            Unused := Unused + 1;

            Result (Unused) := Character'Pos ('=');
            Unused := Unused + 1;
         end;

      elsif Item'Last - First = 1 then
         declare
            S1 : constant Ada.Streams.Stream_Element := Item (First);
            S2 : constant Ada.Streams.Stream_Element := Item (First + 1);

         begin
            Source := (S1 and 2#1111_1100#) / 4;
            Result (Unused) := Encode (Source);
            Unused := Unused + 1;

            Source :=
             ((S1 and 2#0000_0011#) * 16) or ((S2 and 2#1111_0000#) / 16);
            Result (Unused) := Encode (Source);
            Unused := Unused + 1;

            Source := (S2 and 2#0000_1111#) * 4;
            Result (Unused) := Encode (Source);
            Unused := Unused + 1;

            Result (Unused) := Character'Pos ('=');
            Unused := Unused + 1;
         end;
      end if;

      return Result (Result'First .. Unused - 1);
   end To_Base_64;

   ------------------------------
   -- To_Binary_Message_Digest --
   ------------------------------

   function To_Binary_Message_Digest
    (Item : String) return Ada.Streams.Stream_Element_Array
   is
      use type Ada.Streams.Stream_Element;
      use type Ada.Streams.Stream_Element_Offset;

      function Decode (Item : Character) return Ada.Streams.Stream_Element;

      ------------
      -- Decode --
      ------------

      function Decode (Item : Character) return Ada.Streams.Stream_Element is
      begin
         case Item is
            when '0' .. '9' =>
               return Character'Pos (Item) - Character'Pos ('0');

            when 'a' .. 'f' =>
               return Character'Pos (Item) - Character'Pos ('a') + 10;

            when 'A' .. 'F' =>
               return Character'Pos (Item) - Character'Pos ('A') + 10;

            when others =>
               raise Constraint_Error;
         end case;
      end Decode;

      Result : Ada.Streams.Stream_Element_Array (1 .. Item'Length / 2);
      First  : Natural := Item'First;
      Unused : Ada.Streams.Stream_Element_Offset := Result'First;

   begin
      while Item'Last - First > 0 loop
         Result (Unused) := (Decode (Item (First)) * 16) or Decode (Item (First + 1));
         Unused := Unused + 1;
         First := First + 2;
      end loop;

      return Result;
   end To_Binary_Message_Digest;

end Web_Services.SOAP.Security.Modules;
