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
with Matreshka.XML_Schema.Visitors;

package body Matreshka.XML_Schema.AST.Simple is

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      ------------
      -- Create --
      ------------

      function Create
       (Locator : XML.SAX.Locators.SAX_Locator'Class)
          return not null Matreshka.XML_Schema.AST.Simple_Type_Access is
      begin
         return
           new Simple_Type_Node'
                (System_Id => Locator.System_Id,
                 Line      => Locator.Line,
                 Column    => Locator.Column,
                 Final     => (others => False),
                 Name      => League.Strings.Empty_Universal_String);
      end Create;

   end Constructors;

   ----------------
   -- Enter_Node --
   ----------------

   overriding procedure Enter_Node
    (Self    : not null access Simple_Type_Node;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is
   begin
      Visitor.Enter_Simple_Type
       (Matreshka.XML_Schema.AST.Simple_Type_Access (Self), Control);
   end Enter_Node;

   ---------------
   -- Get_Final --
   ---------------

   overriding function Get_Final
    (Self : not null access constant Simple_Type_Node)
       return XML.Schema.Derivation_Flags is
   begin
      return
       (XML.Schema.Derivation_Extension    => False,
        XML.Schema.Derivation_List         => Self.Final (List),
        XML.Schema.Derivation_Restriction  => Self.Final (Restriction),
        XML.Schema.Derivation_Substitution => False,
        XML.Schema.Derivation_Union        => Self.Final (Union));
   end Get_Final;

   --------------
   -- Is_Final --
   --------------

   overriding function Is_Final
    (Self        : not null access constant Simple_Type_Node;
     Restriction : XML.Schema.Derivation_Kinds)
       return Boolean is
   begin
      case Restriction is
         when XML.Schema.Derivation_Extension =>
            return False;

         when XML.Schema.Derivation_List =>
            return Self.Final (List);

         when XML.Schema.Derivation_Restriction =>
            return Self.Final (AST.Restriction);

         when XML.Schema.Derivation_Substitution =>
            return False;

         when XML.Schema.Derivation_Union =>
            return Self.Final (Union);
      end case;
   end Is_Final;

   ----------------
   -- Leave_Node --
   ----------------

   overriding procedure Leave_Node
    (Self    : not null access Simple_Type_Node;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is
   begin
      Visitor.Leave_Simple_Type
       (Matreshka.XML_Schema.AST.Simple_Type_Access (Self), Control);
   end Leave_Node;

   ----------------
   -- Visit_Node --
   ----------------

   overriding procedure Visit_Node
    (Self     : not null access Simple_Type_Node;
     Iterator : in out Matreshka.XML_Schema.Visitors.Abstract_Iterator'Class;
     Visitor  : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control  : in out Matreshka.XML_Schema.Visitors.Traverse_Control) is
   begin
      Iterator.Visit_Simple_Type
       (Visitor, Matreshka.XML_Schema.AST.Simple_Type_Access (Self), Control);
   end Visit_Node;

end Matreshka.XML_Schema.AST.Simple;
