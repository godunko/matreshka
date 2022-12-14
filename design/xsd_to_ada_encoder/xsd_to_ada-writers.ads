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
--  $Revision: 3559 $ $Date: 2012-12-07 13:08:31 +0200 (Пт., 07 дек. 2012) $
------------------------------------------------------------------------------

with League.Strings;

package XSD_To_Ada.Writers is

   pragma Preelaborate;

   type Writer is tagged record
      Text : League.Strings.Universal_String;
   end record;

   procedure P
     (Self   : in out Writer;
      Text   : Wide_Wide_String := "");

   procedure N
     (Self : in out Writer;
      Text : Wide_Wide_String);

   procedure P
     (Self   : in out Writer;
      Text   : League.Strings.Universal_String);

   procedure N
     (Self : in out Writer;
      Text : League.Strings.Universal_String);

   procedure P
     (Self : in out Writer;
      Text : Wide_Wide_String := "";
      Copy : in out Writer'Class);

   procedure N
     (Self : in out Writer;
      Text : Wide_Wide_String;
      Copy : in out Writer'Class);

   procedure P
     (Self   : in out Writer;
      Text   : League.Strings.Universal_String;
      Copy : in out Writer'Class);

   procedure N
     (Self : in out Writer;
      Text : League.Strings.Universal_String;
      Copy : in out Writer'Class);

   procedure N
     (Self  : in out Writer;
      Value : Natural);

end XSD_To_Ada.Writers;
