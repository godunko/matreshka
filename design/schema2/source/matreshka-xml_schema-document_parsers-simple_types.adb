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

separate (Matreshka.XML_Schema.Document_Parsers)
package body Simple_Types is

   -------------------------------
   -- Start_Simple_Type_Element --
   -------------------------------

   procedure Start_Simple_Type_Element
    (Self       : in out Document_Parser'Class;
     Attributes : XML.SAX.Attributes.SAX_Attributes;
     Success    : in out Boolean)
   is
      use all type Matreshka.XML_Schema.AST.Final_Kinds;

      Image : League.Strings.Universal_String;
      Items : League.String_Vectors.Universal_String_Vector;

   begin
      Self.Push_Simple_Type;
      Self.Current.Simple_Type_Definition :=
        Matreshka.XML_Schema.AST.Simple.Constructors.Create (Self.Locator);

      --  Process 'final' attribute.

      if Attributes.Is_Specified (Final_Attribute) then
         Self.Current.Simple_Type_Definition.Final :=
           Matreshka.XML_Schema.Convertors.To_Final_Flags
            (Attributes.Value (Final_Attribute),
             (Extension   => False,
              Restriction => True,
              List        => True,
              Union       => True));
      end if;

      --  Process 'name' attribute.

      if Attributes.Is_Specified (Name_Attribute) then
         Self.Current.Simple_Type_Definition.Name :=
           Attributes.Value (Name_Attribute);
      end if;
   end Start_Simple_Type_Element;

end Simple_Types;
