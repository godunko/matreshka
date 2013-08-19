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

with XML.Schema.Objects.Internals;

package body XML.Schema.Object_Lists is

   use type Matreshka.XML_Schema.Object_Lists.Object_List_Access;

   ------------
   -- Adjust --
   ------------

   overriding procedure Adjust (Self : in out XS_Object_List) is
   begin
      if Self.Node /= null then
         Matreshka.XML_Schema.Object_Lists.Reference (Self.Node);
      end if;
   end Adjust;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Self : in out XS_Object_List) is
   begin
      if Self.Node /= null then
         Matreshka.XML_Schema.Object_Lists.Dereference (Self.Node);
      end if;
   end Finalize;

   ----------------
   -- Get_Length --
   ----------------

   function Get_Length (Self : XS_Object_List'Class) return Natural is
   begin
      if Self.Node /= null then
         return Self.Node.Length;
      else
         return 0;
      end if;
   end Get_Length;

   ----------
   -- Item --
   ----------

   function Item
     (Self  : XS_Object_List'Class;
      Index : Positive)
      return XML.Schema.Objects.XS_Object
   is
   begin
      if Self.Node /= null then
         return XML.Schema.Objects.Internals.Create (Self.Node.Item (Index));
      else
         return XML.Schema.Objects.Null_XS_Object;
      end if;
   end Item;

 end XML.Schema.Object_Lists;
