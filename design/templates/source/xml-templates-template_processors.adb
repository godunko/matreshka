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

package body XML.Templates.Template_Processors is

   ----------------
   -- Characters --
   ----------------

   overriding procedure Characters
    (Self    : in out Template_Processor;
     Text    : League.Strings.Universal_String;
     Success : in out Boolean) is
   begin
      Self.Content_Handler.Characters (Text, Success);
   end Characters;

   -------------
   -- End_DTD --
   -------------

   overriding procedure End_DTD
    (Self    : in out Template_Processor;
     Success : in out Boolean) is
   begin
      Self.Lexical_Handler.End_DTD (Success);
   end End_DTD;

   -----------------
   -- End_Element --
   -----------------

   overriding procedure End_Element
    (Self           : in out Template_Processor;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Success        : in out Boolean) is
   begin
      Self.Content_Handler.End_Element
       (Namespace_URI, Local_Name, Qualified_Name, Success);
   end End_Element;

   ------------------
   -- Error_String --
   ------------------

   overriding function Error_String
    (Self : Template_Processor) return League.Strings.Universal_String is
   begin
      return League.Strings.Empty_Universal_String;
   end Error_String;

   -------------------------
   -- Set_Content_Handler --
   -------------------------

   procedure Set_Content_Handler
    (Self    : in out Template_Processor'Class;
     Handler : XML.SAX.Readers.SAX_Content_Handler_Access) is
   begin
      Self.Content_Handler := Handler;
   end Set_Content_Handler;

   -------------------------
   -- Set_Lexical_Handler --
   -------------------------

   procedure Set_Lexical_Handler
    (Self    : in out Template_Processor'Class;
     Handler : XML.SAX.Readers.SAX_Lexical_Handler_Access) is
   begin
      Self.Lexical_Handler := Handler;
   end Set_Lexical_Handler;

   ---------------
   -- Start_DTD --
   ---------------

   overriding procedure Start_DTD
    (Self      : in out Template_Processor;
     Name      : League.Strings.Universal_String;
     Public_Id : League.Strings.Universal_String;
     System_Id : League.Strings.Universal_String;
     Success   : in out Boolean) is
   begin
      Self.Lexical_Handler.Start_DTD (Name, Public_Id, System_Id, Success);
   end Start_DTD;

   -------------------
   -- Start_Element --
   -------------------

   overriding procedure Start_Element
    (Self           : in out Template_Processor;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean) is
   begin
      Self.Content_Handler.Start_Element
       (Namespace_URI, Local_Name, Qualified_Name, Attributes, Success);
   end Start_Element;

end XML.Templates.Template_Processors;
