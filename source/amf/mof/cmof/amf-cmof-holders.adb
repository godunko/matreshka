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
with AMF.CMOF.Holders.Parameter_Direction_Kinds;
with AMF.CMOF.Holders.Visibility_Kinds;

package body AMF.CMOF.Holders is

   -------------
   -- Element --
   -------------

   function Element
    (Holder : League.Holders.Holder)
       return AMF.CMOF.Optional_CMOF_Parameter_Direction_Kind is
   begin
      if not League.Holders.Has_Tag
              (Holder, AMF.CMOF.Holders.Parameter_Direction_Kinds.Value_Tag)
      then
         raise Constraint_Error;
      end if;

      if League.Holders.Is_Empty (Holder) then
         return (Is_Empty => True);

      else
         return (False, AMF.CMOF.Holders.Parameter_Direction_Kinds.Element (Holder));
      end if;
   end Element;

   -------------
   -- Element --
   -------------

   function Element
    (Holder : League.Holders.Holder)
       return AMF.CMOF.Optional_CMOF_Visibility_Kind is
   begin
      if not League.Holders.Has_Tag
              (Holder, AMF.CMOF.Holders.Visibility_Kinds.Value_Tag)
      then
         raise Constraint_Error;
      end if;

      if League.Holders.Is_Empty (Holder) then
         return (Is_Empty => True);

      else
         return (False, AMF.CMOF.Holders.Visibility_Kinds.Element (Holder));
      end if;
   end Element;

   ---------------
   -- To_Holder --
   ---------------

   function To_Holder
    (Element : AMF.CMOF.Optional_CMOF_Parameter_Direction_Kind)
       return League.Holders.Holder is
   begin
      return Result : League.Holders.Holder do
         League.Holders.Set_Tag
          (Result, AMF.CMOF.Holders.Parameter_Direction_Kinds.Value_Tag);

         if not Element.Is_Empty then
            AMF.CMOF.Holders.Parameter_Direction_Kinds.Replace_Element
             (Result, Element.Value);
         end if;
      end return;
   end To_Holder;

   ---------------
   -- To_Holder --
   ---------------

   function To_Holder
    (Element : AMF.CMOF.Optional_CMOF_Visibility_Kind)
       return League.Holders.Holder is
   begin
      return Result : League.Holders.Holder do
         League.Holders.Set_Tag
          (Result, AMF.CMOF.Holders.Visibility_Kinds.Value_Tag);

         if not Element.Is_Empty then
            AMF.CMOF.Holders.Visibility_Kinds.Replace_Element
             (Result, Element.Value);
         end if;
      end return;
   end To_Holder;

end AMF.CMOF.Holders;
