------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                           SQL Database Access                            --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2011, Vadim Godunko <vgodunko@gmail.com>                     --
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
--  This package provides base implementation of SQL statement parameter
--  rewriter, which converts :name style parameter placeholders into database
--  specific representation.
--
--  It supports rewriting for PostgreSQL only for now: every :name parameter
--  placeholder is replaced by $N parameter placeholder. Duplicate names are
--  replaced by the same parameter placeholder.
------------------------------------------------------------------------------
with League.Strings;
with Matreshka.Internals.SQL_Parameter_Sets;

package Matreshka.Internals.SQL_Parameter_Rewriters is

   type Parameter_Rewriter is tagged limited private;

   procedure Rewrite
    (Self       : Parameter_Rewriter'Class;
     Source     : League.Strings.Universal_String;
     Rewritten  : out League.Strings.Universal_String;
     Parameters : out SQL_Parameter_Sets.Parameter_Set);

   not overriding procedure Database_Placeholder
    (Self        : Parameter_Rewriter;
     Name        : League.Strings.Universal_String;
     Number      : Positive;
     Placeholder : out League.Strings.Universal_String;
     Parameters  : in out SQL_Parameter_Sets.Parameter_Set);
   --  Sets Placeholder to database specific placeholder for parameter with
   --  Name and number Number. Implementation must modify Parameters
   --  accordingly.

private

   type Parameter_Rewriter is tagged limited null record;

end Matreshka.Internals.SQL_Parameter_Rewriters;
