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
--  This package provides access to SSE2 instructions set.
------------------------------------------------------------------------------
with Interfaces;

package Matreshka.Internals.SIMD.Intel.SSE2 is

   pragma Preelaborate;

   function To_Integer_16_Vector_8
    (Q7 : Interfaces.Integer_16;
     Q6 : Interfaces.Integer_16;
     Q5 : Interfaces.Integer_16;
     Q4 : Interfaces.Integer_16;
     Q3 : Interfaces.Integer_16;
     Q2 : Interfaces.Integer_16;
     Q1 : Interfaces.Integer_16;
     Q0 : Interfaces.Integer_16) return Integer_16_Vector_8;

   function To_Unsigned_16_Vector_8
    (Q7 : Interfaces.Unsigned_16;
     Q6 : Interfaces.Unsigned_16;
     Q5 : Interfaces.Unsigned_16;
     Q4 : Interfaces.Unsigned_16;
     Q3 : Interfaces.Unsigned_16;
     Q2 : Interfaces.Unsigned_16;
     Q1 : Interfaces.Unsigned_16;
     Q0 : Interfaces.Unsigned_16) return Unsigned_16_Vector_8;

--   function mm_set_epi16
--    (Q7 : Interfaces.Integer_16;
--     Q6 : Interfaces.Integer_16;
--     Q5 : Interfaces.Integer_16;
--     Q4 : Interfaces.Integer_16;
--     Q3 : Interfaces.Integer_16;
--     Q2 : Interfaces.Integer_16;
--     Q1 : Interfaces.Integer_16;
--     Q0 : Interfaces.Integer_16) return Integer_16_Vector_8;
--
--   function mm_set_epi16
--    (Q7 : Interfaces.Unsigned_16;
--     Q6 : Interfaces.Unsigned_16;
--     Q5 : Interfaces.Unsigned_16;
--     Q4 : Interfaces.Unsigned_16;
--     Q3 : Interfaces.Unsigned_16;
--     Q2 : Interfaces.Unsigned_16;
--     Q1 : Interfaces.Unsigned_16;
--     Q0 : Interfaces.Unsigned_16) return Unsigned_16_Vector_8;

   function mm_and
    (A : Integer_16_Vector_8;
     B : Integer_16_Vector_8) return Integer_16_Vector_8;

   function mm_and
    (A : Unsigned_16_Vector_8;
     B : Unsigned_16_Vector_8) return Unsigned_16_Vector_8;

   function mm_cmpeq
    (A : Integer_16_Vector_8;
     B : Integer_16_Vector_8) return Integer_16_Vector_8;

   function mm_cmpeq
    (A : Unsigned_16_Vector_8;
     B : Unsigned_16_Vector_8) return Unsigned_16_Vector_8;

   function mm_movemask
    (A : Integer_16_Vector_8) return Interfaces.Unsigned_32;

   function mm_movemask
    (A : Unsigned_16_Vector_8) return Interfaces.Unsigned_32;

private

   pragma Inline_Always (mm_and);
   pragma Inline_Always (mm_cmpeq);
   pragma Inline_Always (mm_movemask);
--   pragma Inline_Always (mm_set_epi16);
   pragma Inline_Always (To_Unsigned_16_Vector_8);

--    _mm_set_sd
--    _mm_set1_pd
--    _mm_set_pd1
--    _mm_set_pd
--    _mm_setr_pd
--    _mm_setzero_pd
--    _mm_move_sd
--    _mm_load_pd
--    _mm_loadu_pd
--    _mm_load1_pd
--    _mm_load_sd
--    _mm_load_pd1
--    _mm_loadr_pd
--    _mm_store_pd
--    _mm_storeu_pd
--    _mm_store_sd
--    _mm_cvtsd_f64
--    _mm_storel_pd
--    _mm_storeh_pd
--    _mm_store1_pd
--    _mm_store_pd1
--    _mm_storer_pd
--    _mm_cvtsi128_si32
--    _mm_cvtsi128_si64   x86_64, Intel
--    _mm_cvtsi128_si64x  x86_64, Microsoft
--    _mm_add_pd
--    _mm_add_sd
--    _mm_sub_pd
--    _mm_sub_sd
--    _mm_mul_pd
--    _mm_mul_sd
--    _mm_div_pd
--    _mm_div_sd
--    _mm_sqrt_pd
--    _mm_sqrt_sd
--    _mm_min_pd
--    _mm_min_sd
--    _mm_max_pd
--    _mm_max_sd
--    _mm_and_pd
--    _mm_andnot_pd
--    _mm_or_pd
--    _mm_xor_pd
--    _mm_cmpeq_pd
--    _mm_cmplt_pd
--    _mm_cmple_pd
--    _mm_cmpgt_pd
--    _mm_cmpge_pd
--    _mm_cmpneq_pd
--    _mm_cmpnlt_pd
--    _mm_cmpnle_pd
--    _mm_cmpngt_pd
--    _mm_cmpnge_pd
--    _mm_cmpord_pd
--    _mm_cmpunord_pd
--    _mm_cmpeq_sd
--    _mm_cmplt_sd
--    _mm_cmple_sd
--    _mm_cmpgt_sd
--    _mm_cmpge_sd
--    _mm_cmpneq_sd
--    _mm_cmpnlt_sd
--    _mm_cmpnle_sd
--    _mm_cmpngt_sd
--    _mm_cmpnge_sd
--    _mm_cmpord_sd
--    _mm_cmpunord_sd
--    _mm_comieq_sd
--    _mm_comilt_sd
--    _mm_comile_sd
--    _mm_comigt_sd
--    _mm_comige_sd
--    _mm_comineq_sd
--    _mm_ucomieq_sd
--    _mm_ucomilt_sd
--    _mm_ucomile_sd
--    _mm_ucomigt_sd
--    _mm_ucomige_sd
--    _mm_ucomineq_sd
--    _mm_set_epi64x
--    _mm_set_epi64
--    _mm_set_epi32
--  + _mm_set_epi16
--    _mm_set_epi8
--    _mm_set1_epi64x
--    _mm_set1_epi64
--    _mm_set1_epi32
--    _mm_set1_epi16
--    _mm_set1_epi8
--    _mm_setr_epi64
--    _mm_setr_epi32
--    _mm_setr_epi16
--    _mm_setr_epi8
--    _mm_load_si128
--    _mm_loadu_si128
--    _mm_loadl_epi64
--    _mm_store_si128
--    _mm_storeu_si128
--    _mm_storel_epi64
--    _mm_movepi64_pi64
--    _mm_movpi64_epi64
--    _mm_move_epi64
--    _mm_setzero_si128
--    _mm_cvtepi32_pd
--    _mm_cvtepi32_ps
--    _mm_cvtpd_epi32
--    _mm_cvtpd_pi32
--    _mm_cvtpd_ps
--    _mm_cvttpd_epi32
--    _mm_cvttpd_pi32
--    _mm_cvtpi32_pd
--    _mm_cvtps_epi32
--    _mm_cvttps_epi32
--    _mm_cvtps_pd
--    _mm_cvtsd_si32
--    _mm_cvtsd_si64    x86_64, Intel
--    _mm_cvtsd_si64x   x86_64, Microsoft
--    _mm_cvttsd_si32
--    _mm_cvttsd_si64   x86_64, Intel
--    _mm_cvttsd_si64x  x86_64, Microsoft
--    _mm_cvtsd_ss
--    _mm_cvtsi32_sd
--    _mm_cvtsi64_sd    x86_64, Intel
--    _mm_cvtsi64x_sd   x86_64, Microsoft
--    _mm_cvtss_sd
--    _mm_shuffle_pd
--    _mm_unpackhi_pd
--    _mm_unpacklo_pd
--    _mm_loadh_pd
--    _mm_loadl_pd
--    _mm_movemask_pd
--    _mm_packs_epi16
--    _mm_packs_epi32
--    _mm_packus_epi16
--    _mm_unpackhi_epi8
--    _mm_unpackhi_epi16
--    _mm_unpackhi_epi32
--    _mm_unpackhi_epi64
--    _mm_unpacklo_epi8
--    _mm_unpacklo_epi16
--    _mm_unpacklo_epi32
--    _mm_unpacklo_epi64
--    _mm_add_epi8
--    _mm_add_epi16
--    _mm_add_epi32
--    _mm_add_epi64
--    _mm_adds_epi8
--    _mm_adds_epi16
--    _mm_adds_epu8
--    _mm_adds_epu16
--    _mm_sub_epi8
--    _mm_sub_epi16
--    _mm_sub_epi32
--    _mm_sub_epi64
--    _mm_subs_epi8
--    _mm_subs_epi16
--    _mm_subs_epu8
--    _mm_subs_epu16
--    _mm_madd_epi16
--    _mm_mulhi_epi16
--    _mm_mullo_epi16
--    _mm_mul_su32
--    _mm_mul_epu32
--    _mm_slli_epi16
--    _mm_slli_epi32
--    _mm_slli_epi64
--    _mm_srai_epi16
--    _mm_srai_epi32
--    _mm_srli_si128
--    _mm_slli_si128
--    _mm_srli_epi16
--    _mm_srli_epi32
--    _mm_srli_epi64
--    _mm_sll_epi16
--    _mm_sll_epi32
--    _mm_sll_epi64
--    _mm_sra_epi16
--    _mm_sra_epi32
--    _mm_srl_epi16
--    _mm_srl_epi32
--    _mm_srl_epi64
--  + _mm_and_si128
--    _mm_andnot_si128
--    _mm_or_si128
--    _mm_xor_si128
--    _mm_cmpeq_epi8
--  + _mm_cmpeq_epi16
--    _mm_cmpeq_epi32
--    _mm_cmplt_epi8
--    _mm_cmplt_epi16
--    _mm_cmplt_epi32
--    _mm_cmpgt_epi8
--    _mm_cmpgt_epi16
--    _mm_cmpgt_epi32
--    _mm_extract_epi16
--    _mm_insert_epi16
--    _mm_max_epi16
--    _mm_max_epu8
--    _mm_min_epi16
--    _mm_min_epu8
--  + _mm_movemask_epi8
--    _mm_mulhi_epu16
--    _mm_shufflehi_epi16
--    _mm_shufflelo_epi16
--    _mm_shuffle_epi32
--    _mm_maskmoveu_si128
--    _mm_avg_epu8
--    _mm_avg_epu16
--    _mm_sad_epu8
--    _mm_stream_si32
--    _mm_stream_si128
--    _mm_stream_pd
--    _mm_clflush
--    _mm_lfence
--    _mm_mfence
--    _mm_cvtsi32_si128
--    _mm_cvtsi64_si128   x86_64, Intel
--    _mm_cvtsi64x_si128  x86_64, Microsoft
--    _mm_castpd_ps
--    _mm_castpd_si128
--    _mm_castps_pd
--    _mm_castps_si128
--    _mm_castsi128_ps
--    _mm_castsi128_pd

   function mm_and_si128 (A : v2di; B : v2di) return v2di;
   pragma Import (Intrinsic, mm_and_si128, "__builtin_ia32_pand128");

   function mm_movemask_epi8 (Item : v16qi) return Interfaces.Unsigned_32;
   pragma Import (Intrinsic, mm_movemask_epi8, "__builtin_ia32_pmovmskb128");

   function mm_cmpeq_epi16 (Left : v8hi; Right : v8hi) return v8hi;
   pragma Import (Intrinsic, mm_cmpeq_epi16, "__builtin_ia32_pcmpeqw128");

end Matreshka.Internals.SIMD.Intel.SSE2;
