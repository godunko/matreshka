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

package XML.Schema.Type_Definitions is

   pragma Preelaborate;

   type XS_Type_Definition is limited interface;

   not overriding function Get_Final
    (Self : not null access constant XS_Type_Definition)
       return XML.Schema.Derivation_Flags is abstract;
   --  For complex types the returned value is a bit combination of the subset
   --  of {DERIVATION_EXTENSION, DERIVATION_RESTRICTION} corresponding to final
   --  set of this type or DERIVATION_NONE. For simple types the returned value
   --  is a bit combination of the subset of { DERIVATION_RESTRICTION,
   --  DERIVATION_EXTENSION, DERIVATION_UNION, DERIVATION_LIST} corresponding
   --  to final set of this type or DERIVATION_NONE.

   not overriding function Is_Final
    (Self        : not null access constant XS_Type_Definition;
     Restriction : XML.Schema.Derivation_Kinds)
       return Boolean is abstract;
   --  {final}. For a complex type definition it is a subset of {extension,
   --  restriction}. For a simple type definition it is a subset of {extension,
   --  list, restriction, union}.
   --
   --  Parameters
   --
   --    restriction of type unsigned short
   --      Extension, restriction, list, union constants (defined in
   --      XSConstants).
   --
   --  Return Value
   --
   --    True if restriction is in the final set, otherwise false.

end XML.Schema.Type_Definitions;
