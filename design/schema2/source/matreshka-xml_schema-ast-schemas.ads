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
--  Schema_Node represents single schema document.
------------------------------------------------------------------------------
with Ada.Containers.Vectors;

with XML.SAX.Locators;

package Matreshka.XML_Schema.AST.Schemas is

   pragma Preelaborate;

   type Form_Kinds is (Qualified, Unqualified);

   type Block_Kinds is (Extension, Restriction, Substitution);

   type Block_Flags is array (Block_Kinds) of Boolean;

   type Final_Kinds is (Extension, Restriction, List, Union);

   type Final_Flags is array (Final_Kinds) of Boolean;

   type Include_Information is record
      Location : League.Strings.Universal_String;
      Schema   : Schema_Access;
   end record;

   package Include_Vectors is
     new Ada.Containers.Vectors (Positive, Include_Information);

   type Schema_Node is new Abstract_Node with record
      Includes                 : Include_Vectors.Vector;
      Attribute_Form_Default   : Form_Kinds := Unqualified;
      Element_Form_Default     : Form_Kinds := Unqualified;
      Block_Default            : Block_Flags := (others => False);
      Final_Default            : Final_Flags := (others => False);
      Target_Namespace         : League.Strings.Universal_String;
      Target_Namespace_Defined : Boolean := False;
   end record;

   overriding procedure Enter_Node
    (Self    : not null access Schema_Node;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Leave_Node
    (Self    : not null access Schema_Node;
     Visitor : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control : in out Matreshka.XML_Schema.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of visitor interface.

   overriding procedure Visit_Node
    (Self     : not null access Schema_Node;
     Iterator : in out Matreshka.XML_Schema.Visitors.Abstract_Iterator'Class;
     Visitor  : in out Matreshka.XML_Schema.Visitors.Abstract_Visitor'Class;
     Control  : in out Matreshka.XML_Schema.Visitors.Traverse_Control);
   --  Dispatch call to corresponding subprogram of iterator interface.

   package Constructors is

      function Create
       (Locator : XML.SAX.Locators.SAX_Locator'Class)
          return not null Matreshka.XML_Schema.AST.Schema_Access;

   end Constructors;

end Matreshka.XML_Schema.AST.Schemas;
