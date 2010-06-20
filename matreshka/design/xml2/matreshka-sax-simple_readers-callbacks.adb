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
-- Copyright © 2010, Vadim Godunko <vgodunko@gmail.com>                     --
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
with Ada.Exceptions;

package body Matreshka.SAX.Simple_Readers.Callbacks is

   ------------------
   -- Call_Comment --
   ------------------

   procedure Call_Comment
    (Self    : not null access SAX_Simple_Reader'Class;
     Comment : League.Strings.Universal_String) is
   begin
      Self.Continue :=
        Self.Lexical_Handler.Comment (Comment);

      if not Self.Continue then
         Self.Error_Message := Self.Lexical_Handler.Error_String;
      end if;

   exception
      when E : others =>
         Self.Continue      := False;
         Self.Error_Message :=
           League.Strings.To_Universal_String ("exception come from handler");
         Ada.Exceptions.Save_Occurrence (Self.User_Exception, E);
   end Call_Comment;

   -------------------------------
   -- Call_External_Entity_Decl --
   -------------------------------

   procedure Call_External_Entity_Decl
    (Self      : not null access SAX_Simple_Reader'Class;
     Name      : League.Strings.Universal_String;
     Public_Id : League.Strings.Universal_String;
     System_Id : League.Strings.Universal_String) is
   begin
      Self.Continue :=
        Self.Decl_Handler.External_Entity_Decl (Name, Public_Id, System_Id);

      if not Self.Continue then
         Self.Error_Message := Self.Decl_Handler.Error_String;
      end if;

   exception
      when E : others =>
         Self.Continue      := False;
         Self.Error_Message :=
           League.Strings.To_Universal_String ("exception come from handler");
         Ada.Exceptions.Save_Occurrence (Self.User_Exception, E);
   end Call_External_Entity_Decl;

   -------------------------------
   -- Call_Internal_Entity_Decl --
   -------------------------------

   procedure Call_Internal_Entity_Decl
    (Self  : not null access SAX_Simple_Reader'Class;
     Name  : League.Strings.Universal_String;
     Value : League.Strings.Universal_String) is
   begin
      Self.Continue := Self.Decl_Handler.Internal_Entity_Decl (Name, Value);

      if not Self.Continue then
         Self.Error_Message := Self.Decl_Handler.Error_String;
      end if;

   exception
      when E : others =>
         Self.Continue      := False;
         Self.Error_Message :=
           League.Strings.To_Universal_String ("exception come from handler");
         Ada.Exceptions.Save_Occurrence (Self.User_Exception, E);
   end Call_Internal_Entity_Decl;

   -------------------------------
   -- Call_Unparsed_Entity_Decl --
   -------------------------------

   procedure Call_Unparsed_Entity_Decl
    (Self          : not null access SAX_Simple_Reader'Class;
     Name          : League.Strings.Universal_String;
     Public_Id     : League.Strings.Universal_String;
     System_Id     : League.Strings.Universal_String;
     Notation_Name : League.Strings.Universal_String) is
   begin
      Self.Continue :=
        Self.DTD_Handler.Unparsed_Entity_Decl
         (Name, Public_Id, System_Id, Notation_Name);

      if not Self.Continue then
         Self.Error_Message := Self.DTD_Handler.Error_String;
      end if;

   exception
      when E : others =>
         Self.Continue      := False;
         Self.Error_Message :=
           League.Strings.To_Universal_String ("exception come from handler");
         Ada.Exceptions.Save_Occurrence (Self.User_Exception, E);
   end Call_Unparsed_Entity_Decl;

end Matreshka.SAX.Simple_Readers.Callbacks;
