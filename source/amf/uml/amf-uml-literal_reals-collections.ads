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
-- Copyright © 2011-2012, Vadim Godunko <vgodunko@gmail.com>                --
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
--  This file is generated, don't edit it.
------------------------------------------------------------------------------
with AMF.Generic_Collections;

package AMF.UML.Literal_Reals.Collections is

   pragma Preelaborate;

   package UML_Literal_Real_Collections is
     new AMF.Generic_Collections
          (UML_Literal_Real,
           UML_Literal_Real_Access);

   type Set_Of_UML_Literal_Real is
     new UML_Literal_Real_Collections.Set with null record;

   Empty_Set_Of_UML_Literal_Real : constant Set_Of_UML_Literal_Real;

   type Ordered_Set_Of_UML_Literal_Real is
     new UML_Literal_Real_Collections.Ordered_Set with null record;

   Empty_Ordered_Set_Of_UML_Literal_Real : constant Ordered_Set_Of_UML_Literal_Real;

   type Bag_Of_UML_Literal_Real is
     new UML_Literal_Real_Collections.Bag with null record;

   Empty_Bag_Of_UML_Literal_Real : constant Bag_Of_UML_Literal_Real;

   type Sequence_Of_UML_Literal_Real is
     new UML_Literal_Real_Collections.Sequence with null record;

   Empty_Sequence_Of_UML_Literal_Real : constant Sequence_Of_UML_Literal_Real;

private

   Empty_Set_Of_UML_Literal_Real : constant Set_Of_UML_Literal_Real
     := (UML_Literal_Real_Collections.Set with null record);

   Empty_Ordered_Set_Of_UML_Literal_Real : constant Ordered_Set_Of_UML_Literal_Real
     := (UML_Literal_Real_Collections.Ordered_Set with null record);

   Empty_Bag_Of_UML_Literal_Real : constant Bag_Of_UML_Literal_Real
     := (UML_Literal_Real_Collections.Bag with null record);

   Empty_Sequence_Of_UML_Literal_Real : constant Sequence_Of_UML_Literal_Real
     := (UML_Literal_Real_Collections.Sequence with null record);

end AMF.UML.Literal_Reals.Collections;
