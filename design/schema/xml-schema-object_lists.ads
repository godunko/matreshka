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
-- Copyright © 2012, Vadim Godunko <vgodunko@gmail.com>                     --
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

private with Ada.Finalization;

with XML.Schema.Objects;

private with Matreshka.XML_Schema.Object_Lists;

package XML.Schema.Object_Lists is

   pragma Preelaborate;

   type XS_Object_List is tagged private;

   function Get_Length (Self : XS_Object_List'Class) return Natural;
   --  The number of XSObjects in the XSObjectList.
   --  The range of valid child object indices is 1 to Get_Length inclusive.

   function Item
     (Self  : XS_Object_List'Class;
      Index : Positive) return XML.Schema.Objects.XS_Object;
   --  Returns the Index-th item in the collection or null if index is greater
   --  than the number of objects in the list. The index starts at 1.
   --
   --  Parameters
   --
   --    index of type Positive -  index into the collection.
   --
   --  Return Value
   --
   --  The XSObject at the indexth position in the XSObjectList, or null if the
   --  index specified is not valid.

   Empty_XS_Object_List : constant XS_Object_List;

private

   type XS_Object_List is new Ada.Finalization.Controlled with record
      Node : Matreshka.XML_Schema.Object_Lists.Object_List_Access;
   end record;

   overriding procedure Adjust (Self : in out XS_Object_List)
     with Inline => True;

   overriding procedure Finalize (Self : in out XS_Object_List);

   Empty_XS_Object_List : constant XS_Object_List
     := (Ada.Finalization.Controlled with Node => null);

end XML.Schema.Object_Lists;
