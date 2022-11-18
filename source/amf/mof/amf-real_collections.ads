------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Ada Modeling Framework                          --
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
--private with Ada.Finalization;

--private with AMF.Internals.Collections.Strings;

package AMF.Real_Collections is

   pragma Preelaborate;

--   type Collection_Of_Real is tagged private;
--
--   type Set_Of_Real is new Collection_Of_Real with private;
--   type Ordered_Set_Of_Real is new Collection_Of_Real with private;
--   type Bag_Of_Real is new Collection_Of_Real with private;
   type Sequence_Of_Real is new Integer;

--   type Collection_Of_Real is tagged private;
--
--   type Set_Of_Real is new Collection_Of_Real with private;
--   type Ordered_Set_Of_Real is new Collection_Of_Real with private;
--   type Bag_Of_Real is new Collection_Of_Real with private;
--   type Sequence_Of_Real is new Collection_Of_Real with private;

private

--   type Collection_Of_Real is
--     new Ada.Finalization.Controlled with null record;
----   type Collection_Of_Real is new Ada.Finalization.Controlled with record
----      Collection :
----        AMF.Internals.Collections.Reals.Shared_Real_Collection_Access;
----   end record;
--
--   type Set_Of_Real is new Collection_Of_Real with null record;
--   type Ordered_Set_Of_Real is new Collection_Of_Real with null record;
--   type Bag_Of_Real is new Collection_Of_Real with null record;
--   type Sequence_Of_Real is new Collection_Of_Real with null record;

end AMF.Real_Collections;
