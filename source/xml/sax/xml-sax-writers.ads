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
-- Copyright © 2012-2013, Vadim Godunko <vgodunko@gmail.com>                --
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
--  This package declare base interface for SAX writers and set of convenience
--  subprograms.
------------------------------------------------------------------------------
with League.Strings;
with XML.SAX.Attributes;
with XML.SAX.Content_Handlers;
with XML.SAX.Lexical_Handlers;

package XML.SAX.Writers is

   pragma Preelaborate;

   type SAX_Writer is limited interface
     and XML.SAX.Content_Handlers.SAX_Content_Handler
       and XML.SAX.Lexical_Handlers.SAX_Lexical_Handler;

   procedure Characters
    (Self : in out SAX_Writer'Class;
     Text : League.Strings.Universal_String);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when Characters sets Success to False.

   procedure Characters
    (Self : in out SAX_Writer'Class;
     Text : Wide_Wide_String);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when Characters sets Success to False.

   procedure Characters
    (Self    : in out SAX_Writer'Class;
     Text    : Wide_Wide_String;
     Success : in out  Boolean);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when Characters sets Success to False.

   procedure Characters
    (Self : in out SAX_Writer'Class;
     Text : Wide_Wide_Character);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when Characters sets Success to False.

   procedure Characters
    (Self    : in out SAX_Writer'Class;
     Text    : Wide_Wide_Character;
     Success : in out  Boolean);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when Characters sets Success to False.

   procedure Comment
    (Self : in out SAX_Writer'Class;
     Text : League.Strings.Universal_String);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when Comment sets Success to False.

   procedure End_CDATA (Self : in out SAX_Writer'Class);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when End_CDATA sets Success to False.

   procedure End_Document (Self : in out SAX_Writer'Class);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when End_Document sets Success to False.

   procedure End_DTD (Self : in out SAX_Writer'Class);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when End_DTD sets Success to False.

   procedure End_Element
    (Self           : in out SAX_Writer'Class;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when End_Element sets Success to False.

   procedure End_Element
    (Self           : in out SAX_Writer'Class;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when End_Element sets Success to False.

   procedure End_Element
    (Self           : in out SAX_Writer'Class;
     Qualified_Name : League.Strings.Universal_String);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when End_Element sets Success to False.

   procedure End_Element
    (Self           : in out SAX_Writer'Class;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Success        : in out Boolean);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when End_Element sets Success to False.

   procedure End_Element
    (Self           : in out SAX_Writer'Class;
     Qualified_Name : League.Strings.Universal_String;
     Success        : in out Boolean);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when End_Element sets Success to False.

   procedure End_Entity
    (Self : in out SAX_Writer'Class;
     Name : League.Strings.Universal_String);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when End_Entity sets Success to False.

   procedure End_Prefix_Mapping
    (Self   : in out SAX_Writer'Class;
     Prefix : League.Strings.Universal_String
       := League.Strings.Empty_Universal_String);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when End_Prefix_Mapping sets Success to False.

   procedure Ignorable_Whitespace
    (Self : in out SAX_Writer'Class;
     Text : League.Strings.Universal_String);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when Ignorable_Whitespace sets Success to False.

   procedure Processing_Instruction
    (Self   : in out SAX_Writer'Class;
     Target : League.Strings.Universal_String;
     Data   : League.Strings.Universal_String
       := League.Strings.Empty_Universal_String);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when Processing_Instruction sets Success to False.

   procedure Skipped_Entity
    (Self : in out SAX_Writer'Class;
     Name : League.Strings.Universal_String);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when Skipped_Entity sets Success to False.

   procedure Start_CDATA (Self : in out SAX_Writer'Class);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when Start_CDATA sets Success to False.

   procedure Start_Document (Self : in out SAX_Writer'Class);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when Start_Document sets Success to False.

   procedure Start_DTD
    (Self      : in out SAX_Writer'Class;
     Name      : League.Strings.Universal_String;
     Public_Id : League.Strings.Universal_String
       := League.Strings.Empty_Universal_String;
     System_Id : League.Strings.Universal_String
       := League.Strings.Empty_Universal_String);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when Start_DTD sets Success to False.

   procedure Start_Element
    (Self           : in out SAX_Writer'Class;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes
       := XML.SAX.Attributes.Empty_SAX_Attributes);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when Start_Element sets Success to False.

   procedure Start_Element
    (Self           : in out SAX_Writer'Class;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes
       := XML.SAX.Attributes.Empty_SAX_Attributes);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when Start_Element sets Success to False.

   procedure Start_Element
    (Self           : in out SAX_Writer'Class;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes
       := XML.SAX.Attributes.Empty_SAX_Attributes);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when Start_Element sets Success to False.

   procedure Start_Element
    (Self           : in out SAX_Writer'Class;
     Namespace_URI  : League.Strings.Universal_String;
     Local_Name     : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes
       := XML.SAX.Attributes.Empty_SAX_Attributes;
     Success : in out Boolean);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when Start_Element sets Success to False.

   procedure Start_Element
    (Self           : in out SAX_Writer'Class;
     Qualified_Name : League.Strings.Universal_String;
     Attributes     : XML.SAX.Attributes.SAX_Attributes
       := XML.SAX.Attributes.Empty_SAX_Attributes;
     Success : in out Boolean);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when Start_Element sets Success to False.

   procedure Start_Entity
    (Self : in out SAX_Writer'Class;
     Name : League.Strings.Universal_String);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when Start_Entity sets Success to False.

   procedure Start_Prefix_Mapping
    (Self          : in out SAX_Writer'Class;
     Prefix        : League.Strings.Universal_String
       := League.Strings.Empty_Universal_String;
     Namespace_URI : League.Strings.Universal_String);
   --  Overloaded subprogram for convenience. Raises Constraint_Error with
   --  Error_String when Start_Prefix_Mapping sets Success to False.

end XML.SAX.Writers;
