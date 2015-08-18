------------------------------------------------------------------------------
--                                                                          --
--                      House Designer's Smart Studio                       --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2015, Vadim Godunko <vgodunko@gmail.com>                     --
-- All rights reserved.                                                     --
--                                                                          --
------------------------------------------------------------------------------
--  $Revision$ $Date$
------------------------------------------------------------------------------

package body OpenGL is

   ---------
   -- "+" --
   ---------

   function "+"
    (Left  : Clear_Buffer_Mask_Bits;
     Right : Clear_Buffer_Mask_Bits) return Clear_Buffer_Mask is
   begin
      return Clear_Buffer_Mask (Left or Right);
   end "+";

end OpenGL;
