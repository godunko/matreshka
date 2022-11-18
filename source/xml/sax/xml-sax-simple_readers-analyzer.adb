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
-- Copyright © 2010-2017, Vadim Godunko <vgodunko@gmail.com>                --
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
with XML.SAX.Simple_Readers.Callbacks;

package body XML.SAX.Simple_Readers.Analyzer is

   use Matreshka.Internals.XML;
   use Matreshka.Internals.XML.Element_Tables;
   use Matreshka.Internals.XML.Entity_Tables;

   ---------------------------------------
   -- Analyze_Document_Type_Declaration --
   ---------------------------------------

   procedure Analyze_Document_Type_Declaration
    (Self : in out Simple_Reader'Class)
   is
      Current         : Entity_Identifier;
      Current_Element : Element_Identifier;

   begin
      if Self.Validation.Enabled then
         Current := First_Entity (Self.Entities);

         while Current /= No_Entity loop
            --  [XML 4.2.2 VC: Notation Declared]
            --
            --  "The Name MUST match the declared name of a notation."
            --
            --  Check whether entity is unparsed and its notation is declared.

            if Is_External_Unparsed_General_Entity (Self.Entities, Current)
              and then Symbol_Tables.Notation
                        (Self.Symbols,
                         Notation (Self.Entities, Current)) = No_Notation
            then
               Callbacks.Call_Error
                (Self,
                 League.Strings.To_Universal_String
                  ("[XML 4.2.2 VC: Notation Declared]"
                     & " notation name must match the declared name of a"
                     & " notation"));
            end if;

            Next_Entity (Self.Entities, Current);
         end loop;
      end if;

      --  [XML 3.3] Attribute List Declaration
      --
      --  "The Name in the AttlistDecl rule is the type of an element. At user
      --  option, an XML processor MAY issue a warning if attributes are
      --  declared for an element type not itself declared, but this is not an
      --  error. The Name in the AttDef rule is the name of the attribute."
      --
      --  Check whether element is not declared and has declared attributes.

      Current_Element := First_Element (Self.Elements);

      while Current_Element /= No_Element loop
         if not Is_Declared (Self.Elements, Current_Element)
           and Is_Attributes_Declared (Self.Elements, Current_Element)
         then
            Callbacks.Call_Warning
             (Self,
              League.Strings.To_Universal_String
               ("[XML 3.3]"
                  & " attribute list declaration for element type not itself"
                  & " declared"));
         end if;

         Next_Element (Self.Elements, Current_Element);
      end loop;
   end Analyze_Document_Type_Declaration;

end XML.SAX.Simple_Readers.Analyzer;
