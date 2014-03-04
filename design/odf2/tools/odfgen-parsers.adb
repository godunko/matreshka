------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Open Document Toolkit                           --
--                                                                          --
--                              Tools Component                             --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2014, Vadim Godunko <vgodunko@gmail.com>                     --
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
with League.Characters.Latin;

package body ODFGen.Parsers is

   use type League.Strings.Universal_String;

   function To_Ada
    (Name : League.Strings.Universal_String)
       return League.Strings.Universal_String;

   ------------------
   -- Error_String --
   ------------------

   overriding function Error_String
    (Self : Parser) return League.Strings.Universal_String is
   begin
      return League.Strings.Empty_Universal_String;
   end Error_String;

   -------------------
   -- Start_Element --
   -------------------

   overriding procedure Start_Element
    (Self           : in out Parser;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes;
     Success        : in out Boolean)
   is
      Delimiter : Natural;
      Value     : League.Strings.Universal_String;
      Module    : League.Strings.Universal_String;
      Name      : League.Strings.Universal_String;

   begin
      if Qualified_Name.To_Wide_Wide_String = "ODF" then
         null;

      elsif Qualified_Name.To_Wide_Wide_String = "element" then
         Value :=
           Attributes.Value (League.Strings.To_Universal_String ("name"));
         Delimiter := Value.Index (':');
         Module := Value.Head (Delimiter - 1);
         Name := Value.Tail_From (Delimiter + 1);
         Elements.Insert
          ((Module, Name, To_Ada (Module), To_Ada (Name)));
         Strings.Include (To_Ada (Name) & "_Element", Name);

      elsif Qualified_Name.To_Wide_Wide_String = "attribute" then
         null;

      else
         raise Program_Error;
      end if;
   end Start_Element;

   --------------------------
   -- Start_Prefix_Mapping --
   --------------------------

   overriding procedure Start_Prefix_Mapping
    (Self          : in out Parser;
     Prefix        : League.Strings.Universal_String;
     Namespace_URI : League.Strings.Universal_String;
     Success       : in out Boolean) is
   begin
      Namespaces.Insert
       ((Prefix          => Prefix,
         Namespace_URI   => Namespace_URI,
         Prefix_Ada_Name => To_Ada (Prefix) & "_Prefix",
         URI_Ada_Name    => To_Ada (Prefix) & "_URI"));
   end Start_Prefix_Mapping;

   ------------
   -- To_Ada --
   ------------

   function To_Ada
    (Name : League.Strings.Universal_String)
       return League.Strings.Universal_String
   is
      use type League.Characters.Universal_Character;

      Ada_Name : League.Strings.Universal_String;
      Upper    : Boolean := True;

   begin
      for J in 1 .. Name.Length loop
         if Name (J) = League.Characters.Latin.Hyphen_Minus then
            Upper := True;
            Ada_Name.Append (League.Characters.Latin.Low_Line);

         elsif Upper then
            Ada_Name.Append (Name.Slice (J, J).To_Simple_Uppercase);
            Upper := False;

         else
            Ada_Name.Append (Name (J));
         end if;
      end loop;

      return Ada_Name;
   end To_Ada;

end ODFGen.Parsers;
