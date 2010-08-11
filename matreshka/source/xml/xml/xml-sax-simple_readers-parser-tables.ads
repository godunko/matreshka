------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                              XML Processor                               --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2010, Vadim Godunko <vgodunko@gmail.com>                     --
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

private package XML.SAX.Simple_Readers.Parser.Tables is

   pragma Preelaborate;

   type Goto_Entry is record
      Nonterm  : Integer;
      Newstate : Integer;
   end record;

   type Shift_Reduce_Entry is record
      T   : Integer;
      Act : Integer;
   end record;

   YY_Default           : constant :=    -1;
   YY_First_Shift_Entry : constant :=     0;
   YY_Accept_Code       : constant := -3001;
   YY_Error_Code        : constant := -3000;

   YY_Goto_Matrix : constant array (-1 .. 135) of Goto_Entry :=
    ((   -1,    -1), (   -3,     1), (   -2,     2), (   -4,     4),
     (  -14,    11), (  -13,     9), (   -6,     7), (   -5,    13),
     (  -14,    11), (  -13,    17), (   -7,    16), (  -20,    23),
     (  -15,    22), (   -8,    25), (  -10,    27), (  -16,    30),
     (  -17,    32), (  -53,    33), (  -14,    11), (  -13,     9),
     (   -6,    34), (  -11,    37), (  -17,    39), (  -27,    45),
     (  -26,    44), (  -25,    43), (  -24,    42), (  -23,    41),
     (  -22,    40), (  -14,    47), (  -12,    48), (  -55,    55),
     (  -54,    57), (  -14,    11), (  -13,    17), (   -9,    62),
     (  -27,    45), (  -26,    44), (  -25,    43), (  -24,    42),
     (  -23,    41), (  -22,    66), (  -18,    67), (  -14,    47),
     (  -12,    48), (  -27,    45), (  -26,    44), (  -25,    43),
     (  -24,    42), (  -23,    69), (  -14,    47), (  -12,    48),
     (  -30,    72), (  -40,    73), (  -21,    78), (  -60,    82),
     (  -27,    45), (  -26,    44), (  -25,    43), (  -24,    42),
     (  -23,    69), (  -14,    47), (  -12,    48), (  -28,    86),
     (  -15,    87), (  -35,    95), (  -34,    94), (  -33,    92),
     (  -32,    91), (  -31,    96), (  -42,    98), (  -41,    97),
     (  -14,    11), (  -13,     9), (   -6,   104), (  -56,   105),
     (  -59,   106), (  -19,   108), (  -29,   109), (  -28,   114),
     (  -15,   115), (  -38,   119), (  -36,   120), (  -35,   118),
     (  -34,   117), (  -42,   131), (  -14,    11), (  -13,    17),
     (  -58,   148), (  -57,   147), (  -14,   152), (  -12,   153),
     (   -8,   149), (  -14,    11), (  -13,     9), (   -6,   156),
     (  -37,   173), (  -38,   119), (  -36,   120), (  -35,   118),
     (  -34,   117), (  -39,   175), (  -43,   177), (  -45,   178),
     (  -46,   179), (  -47,   180), (  -48,   181), (  -49,   182),
     (  -50,   183), (  -51,   184), (  -58,   191), (  -14,   152),
     (  -12,   153), (   -8,   149), (  -14,    11), (  -13,    17),
     (  -36,   194), (  -35,   118), (  -34,   117), (  -36,   197),
     (  -35,   118), (  -34,   117), (  -44,   205), (  -44,   206),
     (  -44,   207), (  -44,   208), (  -44,   209), (  -44,   210),
     (  -44,   211), (  -44,   212), (  -52,   214), (  -36,   218),
     (  -35,   118), (  -34,   117), (  -52,   222), (  -44,   228),
     (  -44,   231));

   YY_Goto_Offset : constant array (0 .. 231) of Integer :=
    (    0,    2,    3,    3,    3,    7,    7,    7,
        10,   10,   10,   10,   10,   10,   10,   10,
        12,   13,   13,   13,   14,   14,   14,   15,
        16,   17,   20,   20,   21,   21,   21,   22,
        30,   30,   32,   35,   35,   35,   35,   35,
        44,   51,   51,   51,   51,   51,   51,   51,
        51,   51,   51,   52,   53,   53,   53,   54,
        54,   55,   55,   55,   55,   55,   55,   55,
        55,   55,   55,   62,   62,   62,   62,   64,
        64,   69,   71,   71,   71,   71,   71,   74,
        75,   75,   76,   76,   76,   77,   78,   78,
        78,   80,   80,   80,   80,   80,   84,   84,
        84,   84,   85,   85,   85,   85,   85,   85,
        85,   87,   92,   92,   92,   95,   95,   95,
        95,   95,   95,   95,   95,   95,   95,   95,
        95,   96,  100,  101,  101,  101,  101,  101,
       101,  101,  101,  101,  101,  102,  103,  104,
       105,  106,  107,  108,  109,  109,  109,  109,
       109,  109,  109,  109,  113,  113,  113,  113,
       113,  113,  113,  113,  113,  115,  115,  115,
       115,  115,  115,  115,  115,  115,  115,  115,
       115,  115,  115,  115,  115,  118,  118,  121,
       121,  121,  122,  123,  124,  125,  126,  127,
       128,  129,  129,  130,  130,  130,  130,  130,
       130,  130,  130,  130,  130,  133,  133,  133,
       133,  133,  133,  133,  133,  133,  133,  133,
       133,  133,  133,  133,  133,  133,  134,  134,
       134,  134,  134,  134,  134,  134,  134,  134,
       135,  135,  135,  135,  136,  136,  136,  136);

   YY_Rule_Length : constant array (0 .. 142) of Integer :=
    (    2,    0,    3,    4,    5,    5,    1,    1,
         1,    1,    7,    0,    8,    5,    3,    0,
         3,    0,    2,    1,    0,    1,    1,    2,
         0,    0,    8,    0,    0,    6,    0,    2,
         3,    1,    3,    0,    2,    1,    0,    1,
         1,    1,    1,    1,    1,    1,    4,    4,
         5,    4,    4,    6,    5,    5,    3,    2,
         1,    0,    0,    4,    1,    1,    1,    1,
         2,    2,    2,    1,    2,    2,    2,    1,
         4,    3,    3,    2,    3,    1,    2,    2,
         2,    1,    2,    2,    2,    1,    2,    2,
         2,    1,    5,    4,    3,    2,    0,    0,
         4,    2,    1,    0,    0,    4,    0,    4,
         0,    4,    0,    4,    0,    4,    0,    4,
         0,    4,    0,    4,    7,    6,    3,    2,
         0,    1,    1,    2,    1,    0,    3,    0,
         6,    2,    2,    1,    0,    1,    1,    1,
         1,    1,    0,    5,    0,    4,    0);

   YY_Get_LHS_Rule : constant array (0 .. 142) of Integer :=
    (   -1,   -3,   -2,   -5,   -5,   -5,   -5,   -9,
        -9,   -9,   -4,   -4,  -12,  -12,  -10,  -10,
       -11,  -11,   -6,   -6,   -6,  -13,  -13,  -14,
       -16,  -19,   -7,  -20,  -21,   -7,   -7,  -15,
       -15,  -18,  -17,  -17,  -22,  -22,  -22,  -23,
       -23,  -23,  -23,  -23,  -23,  -23,  -27,  -27,
       -27,  -24,  -24,  -24,  -24,  -24,  -28,  -29,
       -29,  -29,  -30,  -25,  -31,  -31,  -31,  -31,
       -33,  -33,  -33,  -33,  -33,  -33,  -33,  -33,
       -34,  -35,  -37,  -37,  -38,  -38,  -36,  -36,
       -36,  -36,  -36,  -36,  -36,  -36,  -36,  -36,
       -36,  -36,  -32,  -32,  -39,  -39,  -39,  -40,
       -26,  -41,  -41,  -41,  -43,  -42,  -45,  -42,
       -46,  -42,  -47,  -42,  -48,  -42,  -49,  -42,
       -50,  -42,  -51,  -42,  -42,  -42,  -52,  -52,
       -52,  -44,  -44,  -44,  -44,  -53,   -8,  -56,
       -54,  -54,  -57,  -57,  -57,  -58,  -58,  -58,
       -58,  -58,  -59,  -55,  -60,  -55,  -55);

   YY_Shift_Reduce_Matrix : constant array (-1 .. 469) of Shift_Reduce_Entry :=
    ((   -1,    -1), (   -1,    -1), (    3,     3), (   -1,   -11),
     (    0, -3001), (   -1, -3000), (   29,     6), (   -1, -3000),
     (    1,     8), (    4,    12), (   24,    10), (   -1,   -20),
     (   -1, -3000), (   26,    14), (   -1, -3000), (    4,    12),
     (    7,    15), (   24,    10), (   -1,   -30), (   -1,    -6),
     (   -1,   -19), (   -1,   -21), (   -1,   -22), (    5,    18),
     (   -1, -3000), (   -1,    -2), (   22,    19), (   -1, -3000),
     (   13,    20), (   14,    21), (   -1,   -27), (   25,    24),
     (   -1, -3000), (   -1,   -18), (   -1,   -23), (   30,    26),
     (   -1,   -15), (   15,    28), (   -1, -3000), (   16,    29),
     (   -1, -3000), (   -1,   -24), (   17,    31), (   -1,   -35),
     (   -1,  -125), (    4,    12), (   24,    10), (   -1,   -20),
     (   26,    35), (   -1, -3000), (   31,    36), (   -1,   -17),
     (   -1,   -31), (   15,    38), (   -1, -3000), (   17,    31),
     (   -1,   -35), (    3,    53), (    4,    12), (    8,    49),
     (    9,    50), (   10,    52), (   24,    46), (   42,    51),
     (   -1,   -38), (   11,    54), (   -1, -3000), (   12,    56),
     (   -1,  -142), (    1,    61), (    4,    12), (   22,    58),
     (   24,    10), (   25,    60), (   27,    59), (   -1,    -3),
     (   22,    63), (   -1, -3000), (   26,    64), (   -1, -3000),
     (    5,    65), (   -1, -3000), (   -1,   -32), (    3,    53),
     (    4,    12), (    8,    49), (    9,    50), (   10,    52),
     (   24,    46), (   42,    51), (   -1,   -38), (    3,    53),
     (    4,    12), (    8,    49), (    9,    50), (   10,    52),
     (   18,    68), (   24,    46), (   42,    51), (   -1, -3000),
     (   -1,   -37), (   -1,   -39), (   -1,   -40), (   -1,   -41),
     (   -1,   -42), (   -1,   -43), (   -1,   -44), (   -1,   -45),
     (   12,    70), (   19,    71), (   -1, -3000), (   -1,   -58),
     (   -1,   -95), (   13,    74), (   14,    75), (   -1, -3000),
     (   29,    76), (   30,    77), (   -1, -3000), (   -1,   -28),
     (   11,    79), (   12,    81), (   28,    80), (   -1, -3000),
     (   -1,  -140), (   -1,  -126), (   -1,    -7), (   -1,    -8),
     (   -1,    -9), (   -1,    -4), (   -1,    -5), (   -1,   -14),
     (   22,    83), (   -1, -3000), (   -1,   -10), (    3,    53),
     (    4,    12), (    8,    49), (    9,    50), (   10,    52),
     (   24,    46), (   42,    51), (   -1,   -33), (   11,    84),
     (   -1, -3000), (   -1,   -34), (   -1,   -36), (   13,    20),
     (   14,    21), (   20,    85), (   -1, -3000), (   12,    88),
     (   -1, -3000), (   32,    89), (   33,    90), (   34,    93),
     (   -1, -3000), (   12,    99), (   -1,   -99), (   15,   100),
     (   -1, -3000), (   16,   101), (   -1, -3000), (   26,   102),
     (   -1, -3000), (   26,   103), (   -1, -3000), (    4,    12),
     (   24,    10), (   -1,   -20), (   -1,  -127), (   -1,  -129),
     (   -1,  -138), (   26,   107), (   -1, -3000), (   -1,   -16),
     (   -1,   -25), (   22,   110), (   -1,   -57), (   11,   111),
     (   -1, -3000), (   11,   112), (   23,   113), (   -1, -3000),
     (   13,    20), (   14,    21), (   20,    85), (   -1, -3000),
     (   -1,   -60), (   -1,   -61), (   -1,   -62), (   -1,   -63),
     (   12,   116), (   34,   121), (   41,   122), (   -1, -3000),
     (   38,   123), (   39,   124), (   40,   125), (   -1,   -67),
     (   38,   126), (   39,   127), (   40,   128), (   -1,   -71),
     (   11,   129), (   -1, -3000), (   11,   130), (   12,    99),
     (   -1, -3000), (   -1,   -98), (   34,   141), (   43,   132),
     (   44,   133), (   45,   134), (   46,   135), (   47,   136),
     (   48,   137), (   49,   138), (   50,   139), (   51,   140),
     (   -1, -3000), (   11,   142), (   -1, -3000), (   11,   143),
     (   15,   144), (   -1, -3000), (   22,   145), (   -1, -3000),
     (   22,   146), (   -1, -3000), (    4,    12), (   24,    10),
     (   -1,   -29), (    3,    53), (    4,    12), (   22,   150),
     (   24,   151), (   25,    24), (   -1,  -132), (   26,   154),
     (   -1, -3000), (   22,   155), (   -1, -3000), (    4,    12),
     (   24,    10), (   -1,   -20), (   21,   157), (   22,   158),
     (   -1, -3000), (   -1,   -56), (   -1,   -49), (   -1,   -50),
     (   12,   159), (   -1, -3000), (   11,   160), (   -1, -3000),
     (   11,   161), (   -1, -3000), (   38,   162), (   39,   163),
     (   40,   164), (   -1,   -81), (   38,   165), (   39,   166),
     (   40,   167), (   -1,   -85), (   38,   168), (   39,   169),
     (   40,   170), (   -1,   -89), (   35,   171), (   37,   172),
     (   -1, -3000), (   36,   174), (   -1,   -77), (   12,   116),
     (   34,   121), (   -1, -3000), (   36,   176), (   -1,   -94),
     (   -1,   -64), (   -1,   -65), (   -1,   -66), (   -1,   -68),
     (   -1,   -69), (   -1,   -70), (   -1,   -59), (   -1,   -96),
     (   -1,   -97), (   -1,  -100), (   -1,  -102), (   -1,  -104),
     (   -1,  -106), (   -1,  -108), (   -1,  -110), (   -1,  -112),
     (   -1,  -114), (   34,   185), (   -1, -3000), (   12,   186),
     (   -1, -3000), (   -1,   -46), (   -1,   -47), (   11,   187),
     (   -1, -3000), (   30,   188), (   -1, -3000), (    5,   189),
     (   -1, -3000), (    3,    53), (    4,    12), (   22,   150),
     (   24,   151), (   25,    24), (   27,   190), (   -1, -3000),
     (   -1,  -131), (   -1,  -133), (   -1,  -134), (   -1,  -135),
     (   -1,  -136), (   -1,  -137), (   22,   192), (   -1, -3000),
     (   -1,  -141), (    4,    12), (   24,    10), (   -1,   -26),
     (   -1,   -54), (   -1,   -55), (   11,   193), (   -1, -3000),
     (   -1,   -52), (   -1,   -53), (   -1,   -78), (   -1,   -79),
     (   -1,   -80), (   -1,   -82), (   -1,   -83), (   -1,   -84),
     (   -1,   -86), (   -1,   -87), (   -1,   -88), (   -1,   -73),
     (   12,   116), (   34,   121), (   -1, -3000), (   35,   195),
     (   36,   196), (   -1, -3000), (   12,   116), (   34,   121),
     (   -1, -3000), (   35,   198), (   36,   199), (   -1, -3000),
     (   12,   200), (   -1, -3000), (   22,   204), (   52,   201),
     (   53,   202), (   54,   203), (   -1, -3000), (   22,   204),
     (   52,   201), (   53,   202), (   54,   203), (   -1, -3000),
     (   22,   204), (   52,   201), (   53,   202), (   54,   203),
     (   -1, -3000), (   22,   204), (   52,   201), (   53,   202),
     (   54,   203), (   -1, -3000), (   22,   204), (   52,   201),
     (   53,   202), (   54,   203), (   -1, -3000), (   22,   204),
     (   52,   201), (   53,   202), (   54,   203), (   -1, -3000),
     (   22,   204), (   52,   201), (   53,   202), (   54,   203),
     (   -1, -3000), (   22,   204), (   52,   201), (   53,   202),
     (   54,   203), (   -1, -3000), (   12,   213), (   -1, -3000),
     (   36,   215), (   -1,  -120), (   -1,   -48), (   26,   216),
     (   -1, -3000), (   -1,   -13), (   11,   217), (   -1, -3000),
     (   -1,  -130), (   -1,  -139), (   -1,   -51), (   -1,   -76),
     (   -1,   -72), (   12,   116), (   34,   121), (   -1, -3000),
     (   -1,   -75), (   39,   219), (   -1,   -91), (   12,   220),
     (   -1, -3000), (   -1,   -93), (   -1,  -121), (   -1,  -122),
     (   22,   221), (   -1, -3000), (   -1,  -124), (   -1,  -101),
     (   -1,  -103), (   -1,  -105), (   -1,  -107), (   -1,  -109),
     (   -1,  -111), (   -1,  -113), (   -1,  -115), (   36,   215),
     (   -1,  -120), (   35,   223), (   36,   224), (   -1, -3000),
     (   12,   225), (   -1, -3000), (   22,   226), (   -1, -3000),
     (   -1,  -128), (   -1,   -74), (   -1,   -90), (   -1,   -92),
     (   -1,  -123), (   35,   227), (   36,   224), (   -1, -3000),
     (   22,   204), (   52,   201), (   53,   202), (   54,   203),
     (   -1, -3000), (   12,   229), (   -1, -3000), (   -1,  -119),
     (    5,   230), (   -1, -3000), (   22,   204), (   52,   201),
     (   53,   202), (   54,   203), (   -1, -3000), (   -1,  -117),
     (   -1,  -118), (   -1,   -12), (   -1,  -116));

   YY_Shift_Reduce_Offset : constant array (0 .. 231) of Integer :=
    (    0,    1,    3,    5,    7,   11,   12,   14,
        18,   19,   20,   21,   22,   24,   25,   27,
        30,   32,   33,   34,   36,   38,   40,   41,
        43,   44,   47,   49,   51,   52,   54,   56,
        64,   66,   68,   75,   77,   79,   81,   82,
        90,   99,  100,  101,  102,  103,  104,  105,
       106,  107,  110,  111,  112,  115,  118,  119,
       123,  124,  125,  126,  127,  128,  129,  130,
       131,  133,  134,  142,  144,  145,  146,  150,
       152,  156,  158,  160,  162,  164,  166,  169,
       170,  171,  172,  174,  175,  176,  178,  180,
       183,  187,  188,  189,  190,  191,  195,  199,
       203,  205,  208,  209,  220,  222,  225,  227,
       229,  232,  238,  240,  242,  245,  248,  249,
       250,  251,  253,  255,  257,  261,  265,  269,
       272,  274,  277,  279,  280,  281,  282,  283,
       284,  285,  286,  287,  288,  289,  290,  291,
       292,  293,  294,  295,  296,  298,  300,  301,
       302,  304,  306,  308,  315,  316,  317,  318,
       319,  320,  321,  323,  324,  327,  328,  329,
       331,  332,  333,  334,  335,  336,  337,  338,
       339,  340,  341,  342,  343,  346,  349,  352,
       355,  357,  362,  367,  372,  377,  382,  387,
       392,  397,  399,  401,  402,  404,  405,  407,
       408,  409,  410,  411,  412,  415,  416,  418,
       420,  421,  422,  423,  425,  426,  427,  428,
       429,  430,  431,  432,  433,  434,  436,  439,
       441,  443,  444,  445,  446,  447,  448,  451,
       456,  458,  459,  461,  466,  467,  468,  469);

end XML.SAX.Simple_Readers.Parser.Tables;
