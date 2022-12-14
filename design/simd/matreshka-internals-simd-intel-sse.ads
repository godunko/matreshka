------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--         Localization, Internationalization, Globalization for Ada        --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2010 Vadim Godunko <vgodunko@gmail.com>                      --
--                                                                          --
-- Matreshka is free software;  you can  redistribute it  and/or modify  it --
-- under terms of the  GNU General Public License as published  by the Free --
-- Software  Foundation;  either version 2,  or (at your option)  any later --
-- version.  Matreshka  is distributed in the hope that it will be  useful, --
-- but   WITHOUT  ANY  WARRANTY;  without  even  the  implied  warranty  of --
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General --
-- Public License for more details.  You should have received a copy of the --
-- GNU General Public License distributed with Matreshka; see file COPYING. --
-- If not, write  to  the  Free Software Foundation,  51  Franklin  Street, --
-- Fifth Floor, Boston, MA 02110-1301, USA.                                 --
--                                                                          --
-- As a special exception,  if other files  instantiate  generics from this --
-- unit, or you link  this unit with other files  to produce an executable, --
-- this  unit  does not  by itself cause  the resulting  executable  to  be --
-- covered  by the  GNU  General  Public  License.  This exception does not --
-- however invalidate  any other reasons why  the executable file  might be --
-- covered by the  GNU Public License.                                      --
--                                                                          --
------------------------------------------------------------------------------
--  $Revision$ $Date$
------------------------------------------------------------------------------
--  This package provides access to SSE instruction set.
------------------------------------------------------------------------------
with Interfaces;

package Matreshka.Internals.SIMD.Intel.SSE is

   pragma Preelaborate;

   function mm_extract
     (A : Unsigned_16_Vector_4;
      N : Interfaces.Unsigned_32) return Interfaces.Unsigned_16;

--   function mm_extract_pi16
--     (A : Integer_16_Vector_4;
--      N : Unsigned_32) return Integer_16;

private

--    _mm_setzero_ps
--    _mm_add_ss
--    _mm_sub_ss
--    _mm_mul_ss
--    _mm_div_ss
--    _mm_sqrt_ss
--    _mm_rcp_ss
--    _mm_rsqrt_ss
--    _mm_min_ss
--    _mm_max_ss
--    _mm_add_ps
--    _mm_sub_ps
--    _mm_mul_ps
--    _mm_div_ps
--    _mm_sqrt_ps
--    _mm_rcp_ps
--    _mm_rsqrt_ps
--    _mm_min_ps
--    _mm_max_ps
--    _mm_and_ps
--    _mm_andnot_ps
--    _mm_or_ps
--    _mm_xor_ps
--    _mm_cmpeq_ss
--    _mm_cmplt_ss
--    _mm_cmple_ss
--    _mm_cmpgt_ss
--    _mm_cmpge_ss
--    _mm_cmpneq_ss
--    _mm_cmpnlt_ss
--    _mm_cmpnle_ss
--    _mm_cmpngt_ss
--    _mm_cmpnge_ss
--    _mm_cmpord_ss
--    _mm_cmpunord_ss
--    _mm_cmpeq_ps
--    _mm_cmplt_ps
--    _mm_cmple_ps
--    _mm_cmpgt_ps
--    _mm_cmpge_ps
--    _mm_cmpneq_ps
--    _mm_cmpnlt_ps
--    _mm_cmpnle_ps
--    _mm_cmpngt_ps
--    _mm_cmpnge_ps
--    _mm_cmpord_ps
--    _mm_cmpunord_ps
--    _mm_comieq_ss
--    _mm_comilt_ss
--    _mm_comile_ss
--    _mm_comigt_ss
--    _mm_comige_ss
--    _mm_comineq_ss
--    _mm_ucomieq_ss
--    _mm_ucomilt_ss
--    _mm_ucomile_ss
--    _mm_ucomigt_ss
--    _mm_ucomige_ss
--    _mm_ucomineq_ss
--    _mm_cvtss_si32
--    _mm_cvt_ss2si
--    _mm_cvtss_si64    x86_64, Intel
--    _mm_cvtss_si64x   x86_64, Microsoft
--    _mm_cvtps_pi32
--    _mm_cvt_ps2pi
--    _mm_cvttss_si32
--    _mm_cvtt_ss2si
--    _mm_cvttss_si64   x86_64, Intel
--    _mm_cvttss_si64x  x86_64, Microsoft
--    _mm_cvttps_pi32
--    _mm_cvtt_ps2pi
--    _mm_cvtsi32_ss
--    _mm_cvt_si2ss
--    _mm_cvtsi64_ss    x86_64, Intel
--    _mm_cvtsi64x_ss   x86_64, Microsoft
--    _mm_cvtpi32_ps
--    _mm_cvt_pi2ps
--    _mm_cvtpi16_ps
--    _mm_cvtpu16_ps
--    _mm_cvtpi8_ps
--    _mm_cvtpu8_ps
--    _mm_cvtpi32x2_ps
--    _mm_cvtps_pi16
--    _mm_cvtps_pi8
--    _mm_shuffle_ps
--    _mm_unpackhi_ps
--    _mm_unpacklo_ps
--    _mm_loadh_pi
--    _mm_storeh_pi
--    _mm_movehl_ps
--    _mm_movelh_ps
--    _mm_loadl_pi
--    _mm_storel_pi
--    _mm_movemask_ps
--    _mm_getcsr
--    _MM_GET_EXCEPTION_STATE
--    _MM_GET_EXCEPTION_MASK
--    _MM_GET_ROUNDING_MODE
--    _MM_GET_FLUSH_ZERO_MODE
--    _mm_setcsr
--    _MM_SET_EXCEPTION_STATE
--    _MM_SET_EXCEPTION_MASK
--    _MM_SET_ROUNDING_MODE
--    _MM_SET_FLUSH_ZERO_MODE
--    _mm_set_ss
--    _mm_set1_ps
--    _mm_set_ps1
--    _mm_load_ss
--    _mm_load1_ps
--    _mm_load_ps1
--    _mm_load_ps
--    _mm_loadu_ps
--    _mm_loadr_ps
--    _mm_set_ps
--    _mm_setr_ps
--    _mm_store_ss
--    _mm_cvtss_f32
--    _mm_store_ps
--    _mm_storeu_ps
--    _mm_store1_ps
--    _mm_store_ps1
--    _mm_storer_ps
--    _mm_move_ss
--  + _mm_extract_pi16
--    _mm_insert_pi16
--    _mm_max_pi16
--    _mm_max_pu8
--    _mm_min_pi16
--    _mm_min_pu8
--    _mm_movemask_pi8
--    _mm_mulhi_pu16
--    _mm_shuffle_pi16
--    _mm_maskmove_si64
--    _mm_avg_pu8
--    _mm_avg_pu16
--    _mm_sad_pu8
--    _mm_prefetch
--    _mm_stream_pi
--    _mm_stream_ps
--    _mm_sfence
--    _mm_pause
--    _MM_TRANSPOSE4_PS

   pragma Inline (mm_extract);
   pragma Inline_Always (mm_extract);
end Matreshka.Internals.SIMD.Intel.SSE;
