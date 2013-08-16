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

package body XML.Schema.Objects.Type_Definitions.Complex_Type_Definitions is

   ------------------
   -- Get_Abstract --
   ------------------

   function Get_Abstract
     (Self : XS_Complex_Type_Definition'Class)
      return Boolean
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Abstract unimplemented");
      raise Program_Error with "Unimplemented function Get_Abstract";
      return Get_Abstract (Self);
   end Get_Abstract;

   --------------------
   -- Get_Annotation --
   --------------------

   function Get_Annotation
     (Self : XS_Complex_Type_Definition'Class)
      return XML.Schema.Annotations.XS_Annotation
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Annotation unimplemented");
      raise Program_Error with "Unimplemented function Get_Annotation";
      return Get_Annotation (Self);
   end Get_Annotation;

   ----------------------
   -- Get_Content_Type --
   ----------------------

   function Get_Content_Type
     (Self : XS_Complex_Type_Definition'Class)
      return Content_Types
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Content_Type unimplemented");
      raise Program_Error with "Unimplemented function Get_Content_Type";
      return Get_Content_Type (Self);
   end Get_Content_Type;

   ------------------
   -- Get_Particle --
   ------------------

   function Get_Particle
     (Self : XS_Complex_Type_Definition'Class)
      return Natural
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Particle unimplemented");
      raise Program_Error with "Unimplemented function Get_Particle";
      return Get_Particle (Self);
   end Get_Particle;

end XML.Schema.Objects.Type_Definitions.Complex_Type_Definitions;
