------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               XML Processor                              --
--                                                                          --
--                        Runtime Library Component                         --
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

package body XSD_To_Ada.Writers is

   New_Line : constant Wide_Wide_Character := Wide_Wide_Character'Val (10);

   procedure N (Self : in out Writer; Text : Wide_Wide_String) is
   begin
      Self.Text.Append (Text);
   end N;

   procedure N
     (Self : in out Writer;
      Text : League.Strings.Universal_String) is
   begin
      Self.N (Text.To_Wide_Wide_String);
   end N;

   procedure N
     (Self : in out Writer;
      Text : Wide_Wide_String;
      Copy : in out Writer'Class) is
   begin
      Self.N (Text);
      Copy.N (Text);
   end N;

   procedure N
     (Self : in out Writer;
      Text : League.Strings.Universal_String;
      Copy : in out Writer'Class) is
   begin
      Self.N (Text);
      Copy.N (Text);
   end N;

   -------
   -- N --
   -------

   procedure N
     (Self  : in out Writer;
      Value : Natural)
   is
      Image : constant Wide_Wide_String := Natural'Wide_Wide_Image (Value);
   begin
      Self.N (Image (2 .. Image'Last));
   end N;

   procedure P
     (Self : in out Writer;
      Text : Wide_Wide_String := "";
      Copy : in out Writer'Class) is
   begin
      Self.P (Text);
      Copy.P (Text);
   end P;

   procedure P
     (Self   : in out Writer;
      Text   : League.Strings.Universal_String;
      Copy : in out Writer'Class) is
   begin
      Self.P (Text);
      Copy.P (Text);
   end P;

   procedure P
     (Self   : in out Writer;
      Text   : League.Strings.Universal_String) is
   begin
      Self.P (Text.To_Wide_Wide_String);
   end P;

   procedure P
     (Self   : in out Writer;
      Text   : Wide_Wide_String := "") is
   begin
      Self.Text.Append (Text);
      Self.Text.Append (New_Line);
   end P;

end XSD_To_Ada.Writers;
