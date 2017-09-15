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
-- Copyright © 2010-2013, Vadim Godunko <vgodunko@gmail.com>                --
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

with Matreshka.Internals.Strings;

private package Matreshka.Internals.Text_Codecs.IANA_Registry is

   pragma Preelaborate;

   type IANA_Record is record
      Name : not null Matreshka.Internals.Strings.Shared_String_Access;
      MIB  : Character_Set;
   end record;

   N1 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0075#, 16#0073#, 16#0061#, 16#0073#,
             16#0063#, 16#0069#, 16#0069#,
             others => 16#0000#),
           others => <>);
   --  usascii

   N2 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  isoir6

   N3 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0061#, 16#006E#, 16#0073#, 16#0069#,
             16#0078#, 16#0033#, 16#0034#, 16#0031#,
             16#0039#, 16#0036#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  ansix341968

   N4 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0061#, 16#006E#, 16#0073#, 16#0069#,
             16#0078#, 16#0033#, 16#0034#, 16#0031#,
             16#0039#, 16#0038#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  ansix341986

   N5 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#0069#, 16#0072#,
             16#0076#, 16#0031#, 16#0039#, 16#0039#,
             16#0031#,
             others => 16#0000#),
           others => <>);
   --  iso646irv1991

   N6 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#0075#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  iso646us

   N7 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 2,
         Length   => 2,
         Value    =>
            (16#0075#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  us

   N8 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0033#,
             16#0036#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  ibm367

   N9 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0033#, 16#0036#,
             16#0037#,
             others => 16#0000#),
           others => <>);
   --  cp367

   N10 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0063#, 16#0073#, 16#0061#, 16#0073#,
             16#0063#, 16#0069#, 16#0069#,
             others => 16#0000#),
           others => <>);
   --  csascii

   N11 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0031#,
             16#0031#, 16#0039#, 16#0038#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  iso885911987

   N12 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0030#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  isoir100

   N13 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  iso88591

   N14 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#006C#, 16#0061#, 16#0074#, 16#0069#,
             16#006E#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  latin1

   N15 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 2,
         Length   => 2,
         Value    =>
            (16#006C#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  l1

   N16 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0038#,
             16#0031#, 16#0039#,
             others => 16#0000#),
           others => <>);
   --  ibm819

   N17 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0038#, 16#0031#,
             16#0039#,
             others => 16#0000#),
           others => <>);
   --  cp819

   N18 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#006C#, 16#0061#, 16#0074#,
             16#0069#, 16#006E#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  csisolatin1

   N19 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0032#,
             16#0031#, 16#0039#, 16#0038#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  iso885921987

   N20 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0030#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  isoir101

   N21 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  iso88592

   N22 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#006C#, 16#0061#, 16#0074#, 16#0069#,
             16#006E#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  latin2

   N23 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 2,
         Length   => 2,
         Value    =>
            (16#006C#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  l2

   N24 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#006C#, 16#0061#, 16#0074#,
             16#0069#, 16#006E#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  csisolatin2

   N25 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0033#,
             16#0031#, 16#0039#, 16#0038#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  iso885931988

   N26 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0030#, 16#0039#,
             others => 16#0000#),
           others => <>);
   --  isoir109

   N27 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  iso88593

   N28 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#006C#, 16#0061#, 16#0074#, 16#0069#,
             16#006E#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  latin3

   N29 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 2,
         Length   => 2,
         Value    =>
            (16#006C#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  l3

   N30 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#006C#, 16#0061#, 16#0074#,
             16#0069#, 16#006E#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  csisolatin3

   N31 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0034#,
             16#0031#, 16#0039#, 16#0038#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  iso885941988

   N32 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0031#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  isoir110

   N33 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  iso88594

   N34 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#006C#, 16#0061#, 16#0074#, 16#0069#,
             16#006E#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  latin4

   N35 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 2,
         Length   => 2,
         Value    =>
            (16#006C#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  l4

   N36 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#006C#, 16#0061#, 16#0074#,
             16#0069#, 16#006E#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  csisolatin4

   N37 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0035#,
             16#0031#, 16#0039#, 16#0038#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  iso885951988

   N38 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0034#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  isoir144

   N39 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  iso88595

   N40 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0079#, 16#0072#, 16#0069#,
             16#006C#, 16#006C#, 16#0069#, 16#0063#,
             others => 16#0000#),
           others => <>);
   --  cyrillic

   N41 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 18,
         Length   => 18,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#006C#, 16#0061#, 16#0074#,
             16#0069#, 16#006E#, 16#0063#, 16#0079#,
             16#0072#, 16#0069#, 16#006C#, 16#006C#,
             16#0069#, 16#0063#,
             others => 16#0000#),
           others => <>);
   --  csisolatincyrillic

   N42 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0036#,
             16#0031#, 16#0039#, 16#0038#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  iso885961987

   N43 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0032#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  isoir127

   N44 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  iso88596

   N45 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0065#, 16#0063#, 16#006D#, 16#0061#,
             16#0031#, 16#0031#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  ecma114

   N46 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0061#, 16#0073#, 16#006D#, 16#006F#,
             16#0037#, 16#0030#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  asmo708

   N47 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0061#, 16#0072#, 16#0061#, 16#0062#,
             16#0069#, 16#0063#,
             others => 16#0000#),
           others => <>);
   --  arabic

   N48 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 16,
         Length   => 16,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#006C#, 16#0061#, 16#0074#,
             16#0069#, 16#006E#, 16#0061#, 16#0072#,
             16#0061#, 16#0062#, 16#0069#, 16#0063#,
             others => 16#0000#),
           others => <>);
   --  csisolatinarabic

   N49 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0037#,
             16#0031#, 16#0039#, 16#0038#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  iso885971987

   N50 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0032#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  isoir126

   N51 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  iso88597

   N52 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0065#, 16#006C#, 16#006F#, 16#0074#,
             16#0039#, 16#0032#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  elot928

   N53 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0065#, 16#0063#, 16#006D#, 16#0061#,
             16#0031#, 16#0031#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  ecma118

   N54 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0067#, 16#0072#, 16#0065#, 16#0065#,
             16#006B#,
             others => 16#0000#),
           others => <>);
   --  greek

   N55 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0067#, 16#0072#, 16#0065#, 16#0065#,
             16#006B#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  greek8

   N56 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 15,
         Length   => 15,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#006C#, 16#0061#, 16#0074#,
             16#0069#, 16#006E#, 16#0067#, 16#0072#,
             16#0065#, 16#0065#, 16#006B#,
             others => 16#0000#),
           others => <>);
   --  csisolatingreek

   N57 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0038#,
             16#0031#, 16#0039#, 16#0038#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  iso885981988

   N58 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0033#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  isoir138

   N59 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  iso88598

   N60 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0068#, 16#0065#, 16#0062#, 16#0072#,
             16#0065#, 16#0077#,
             others => 16#0000#),
           others => <>);
   --  hebrew

   N61 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 16,
         Length   => 16,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#006C#, 16#0061#, 16#0074#,
             16#0069#, 16#006E#, 16#0068#, 16#0065#,
             16#0062#, 16#0072#, 16#0065#, 16#0077#,
             others => 16#0000#),
           others => <>);
   --  csisolatinhebrew

   N62 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0039#,
             16#0031#, 16#0039#, 16#0038#, 16#0039#,
             others => 16#0000#),
           others => <>);
   --  iso885991989

   N63 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0034#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  isoir148

   N64 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0039#,
             others => 16#0000#),
           others => <>);
   --  iso88599

   N65 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#006C#, 16#0061#, 16#0074#, 16#0069#,
             16#006E#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  latin5

   N66 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 2,
         Length   => 2,
         Value    =>
            (16#006C#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  l5

   N67 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#006C#, 16#0061#, 16#0074#,
             16#0069#, 16#006E#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  csisolatin5

   N68 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0031#,
             16#0030#,
             others => 16#0000#),
           others => <>);
   --  iso885910

   N69 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0035#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  isoir157

   N70 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 2,
         Length   => 2,
         Value    =>
            (16#006C#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  l6

   N71 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0031#,
             16#0030#, 16#0031#, 16#0039#, 16#0039#,
             16#0032#,
             others => 16#0000#),
           others => <>);
   --  iso8859101992

   N72 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#006C#, 16#0061#, 16#0074#,
             16#0069#, 16#006E#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  csisolatin6

   N73 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#006C#, 16#0061#, 16#0074#, 16#0069#,
             16#006E#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  latin6

   N74 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0039#, 16#0033#, 16#0037#, 16#0032#,
             16#0061#, 16#0064#, 16#0064#,
             others => 16#0000#),
           others => <>);
   --  iso69372add

   N75 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0034#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  isoir142

   N76 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0074#, 16#0065#, 16#0078#,
             16#0074#, 16#0063#, 16#006F#, 16#006D#,
             16#006D#,
             others => 16#0000#),
           others => <>);
   --  csisotextcomm

   N77 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#006A#, 16#0069#, 16#0073#, 16#0078#,
             16#0032#, 16#0030#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  jisx201

   N78 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 4,
         Length   => 4,
         Value    =>
            (16#0078#, 16#0032#, 16#0030#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  x201

   N79 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 19,
         Length   => 19,
         Value    =>
            (16#0063#, 16#0073#, 16#0068#, 16#0061#,
             16#006C#, 16#0066#, 16#0077#, 16#0069#,
             16#0064#, 16#0074#, 16#0068#, 16#006B#,
             16#0061#, 16#0074#, 16#0061#, 16#006B#,
             16#0061#, 16#006E#, 16#0061#,
             others => 16#0000#),
           others => <>);
   --  cshalfwidthkatakana

   N80 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#006A#, 16#0069#, 16#0073#, 16#0065#,
             16#006E#, 16#0063#, 16#006F#, 16#0064#,
             16#0069#, 16#006E#, 16#0067#,
             others => 16#0000#),
           others => <>);
   --  jisencoding

   N81 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#006A#, 16#0069#,
             16#0073#, 16#0065#, 16#006E#, 16#0063#,
             16#006F#, 16#0064#, 16#0069#, 16#006E#,
             16#0067#,
             others => 16#0000#),
           others => <>);
   --  csjisencoding

   N82 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0073#, 16#0068#, 16#0069#, 16#0066#,
             16#0074#, 16#006A#, 16#0069#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  shiftjis

   N83 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#006D#, 16#0073#, 16#006B#, 16#0061#,
             16#006E#, 16#006A#, 16#0069#,
             others => 16#0000#),
           others => <>);
   --  mskanji

   N84 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0063#, 16#0073#, 16#0073#, 16#0068#,
             16#0069#, 16#0066#, 16#0074#, 16#006A#,
             16#0069#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  csshiftjis

   N85 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 47,
         Unused   => 39,
         Length   => 39,
         Value    =>
            (16#0065#, 16#0078#, 16#0074#, 16#0065#,
             16#006E#, 16#0064#, 16#0065#, 16#0064#,
             16#0075#, 16#006E#, 16#0069#, 16#0078#,
             16#0063#, 16#006F#, 16#0064#, 16#0065#,
             16#0070#, 16#0061#, 16#0063#, 16#006B#,
             16#0065#, 16#0064#, 16#0066#, 16#006F#,
             16#0072#, 16#006D#, 16#0061#, 16#0074#,
             16#0066#, 16#006F#, 16#0072#, 16#006A#,
             16#0061#, 16#0070#, 16#0061#, 16#006E#,
             16#0065#, 16#0073#, 16#0065#,
             others => 16#0000#),
           others => <>);
   --  extendedunixcodepackedformatforjapanese

   N86 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 19,
         Length   => 19,
         Value    =>
            (16#0063#, 16#0073#, 16#0065#, 16#0075#,
             16#0063#, 16#0070#, 16#006B#, 16#0064#,
             16#0066#, 16#006D#, 16#0074#, 16#006A#,
             16#0061#, 16#0070#, 16#0061#, 16#006E#,
             16#0065#, 16#0073#, 16#0065#,
             others => 16#0000#),
           others => <>);
   --  cseucpkdfmtjapanese

   N87 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0065#, 16#0075#, 16#0063#, 16#006A#,
             16#0070#,
             others => 16#0000#),
           others => <>);
   --  eucjp

   N88 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 39,
         Unused   => 37,
         Length   => 37,
         Value    =>
            (16#0065#, 16#0078#, 16#0074#, 16#0065#,
             16#006E#, 16#0064#, 16#0065#, 16#0064#,
             16#0075#, 16#006E#, 16#0069#, 16#0078#,
             16#0063#, 16#006F#, 16#0064#, 16#0065#,
             16#0066#, 16#0069#, 16#0078#, 16#0065#,
             16#0064#, 16#0077#, 16#0069#, 16#0064#,
             16#0074#, 16#0068#, 16#0066#, 16#006F#,
             16#0072#, 16#006A#, 16#0061#, 16#0070#,
             16#0061#, 16#006E#, 16#0065#, 16#0073#,
             16#0065#,
             others => 16#0000#),
           others => <>);
   --  extendedunixcodefixedwidthforjapanese

   N89 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 19,
         Length   => 19,
         Value    =>
            (16#0063#, 16#0073#, 16#0065#, 16#0075#,
             16#0063#, 16#0066#, 16#0069#, 16#0078#,
             16#0077#, 16#0069#, 16#0064#, 16#006A#,
             16#0061#, 16#0070#, 16#0061#, 16#006E#,
             16#0065#, 16#0073#, 16#0065#,
             others => 16#0000#),
           others => <>);
   --  cseucfixwidjapanese

   N90 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0062#, 16#0073#, 16#0034#, 16#0037#,
             16#0033#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  bs4730

   N91 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  isoir4

   N92 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#0067#, 16#0062#,
             others => 16#0000#),
           others => <>);
   --  iso646gb

   N93 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 2,
         Length   => 2,
         Value    =>
            (16#0067#, 16#0062#,
             others => 16#0000#),
           others => <>);
   --  gb

   N94 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 2,
         Length   => 2,
         Value    =>
            (16#0075#, 16#006B#,
             others => 16#0000#),
           others => <>);
   --  uk

   N95 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 19,
         Length   => 19,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0034#, 16#0075#, 16#006E#,
             16#0069#, 16#0074#, 16#0065#, 16#0064#,
             16#006B#, 16#0069#, 16#006E#, 16#0067#,
             16#0064#, 16#006F#, 16#006D#,
             others => 16#0000#),
           others => <>);
   --  csiso4unitedkingdom

   N96 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0073#, 16#0065#, 16#006E#, 16#0038#,
             16#0035#, 16#0030#, 16#0032#, 16#0030#,
             16#0030#, 16#0063#,
             others => 16#0000#),
           others => <>);
   --  sen850200c

   N97 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  isoir11

   N98 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#0073#, 16#0065#,
             16#0032#,
             others => 16#0000#),
           others => <>);
   --  iso646se2

   N99 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#0073#, 16#0065#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  se2

   N100 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 22,
         Length   => 22,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0031#, 16#0073#,
             16#0077#, 16#0065#, 16#0064#, 16#0069#,
             16#0073#, 16#0068#, 16#0066#, 16#006F#,
             16#0072#, 16#006E#, 16#0061#, 16#006D#,
             16#0065#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  csiso11swedishfornames

   N101 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 2,
         Length   => 2,
         Value    =>
            (16#0069#, 16#0074#,
             others => 16#0000#),
           others => <>);
   --  it

   N102 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  isoir15

   N103 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#0069#, 16#0074#,
             others => 16#0000#),
           others => <>);
   --  iso646it

   N104 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 14,
         Length   => 14,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0035#, 16#0069#,
             16#0074#, 16#0061#, 16#006C#, 16#0069#,
             16#0061#, 16#006E#,
             others => 16#0000#),
           others => <>);
   --  csiso15italian

   N105 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 2,
         Length   => 2,
         Value    =>
            (16#0065#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  es

   N106 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  isoir17

   N107 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#0065#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  iso646es

   N108 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 14,
         Length   => 14,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0037#, 16#0073#,
             16#0070#, 16#0061#, 16#006E#, 16#0069#,
             16#0073#, 16#0068#,
             others => 16#0000#),
           others => <>);
   --  csiso17spanish

   N109 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0064#, 16#0069#, 16#006E#, 16#0036#,
             16#0036#, 16#0030#, 16#0030#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  din66003

   N110 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0032#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  isoir21

   N111 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 2,
         Length   => 2,
         Value    =>
            (16#0064#, 16#0065#,
             others => 16#0000#),
           others => <>);
   --  de

   N112 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#0064#, 16#0065#,
             others => 16#0000#),
           others => <>);
   --  iso646de

   N113 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0032#, 16#0031#, 16#0067#,
             16#0065#, 16#0072#, 16#006D#, 16#0061#,
             16#006E#,
             others => 16#0000#),
           others => <>);
   --  csiso21german

   N114 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#006E#, 16#0073#, 16#0034#, 16#0035#,
             16#0035#, 16#0031#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  ns45511

   N115 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0036#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  isoir60

   N116 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#006E#, 16#006F#,
             others => 16#0000#),
           others => <>);
   --  iso646no

   N117 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 2,
         Length   => 2,
         Value    =>
            (16#006E#, 16#006F#,
             others => 16#0000#),
           others => <>);
   --  no

   N118 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 22,
         Length   => 22,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0036#, 16#0030#, 16#0064#,
             16#0061#, 16#006E#, 16#0069#, 16#0073#,
             16#0068#, 16#006E#, 16#006F#, 16#0072#,
             16#0077#, 16#0065#, 16#0067#, 16#0069#,
             16#0061#, 16#006E#,
             others => 16#0000#),
           others => <>);
   --  csiso60danishnorwegian

   N119 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 17,
         Length   => 17,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0036#, 16#0030#, 16#006E#,
             16#006F#, 16#0072#, 16#0077#, 16#0065#,
             16#0067#, 16#0069#, 16#0061#, 16#006E#,
             16#0031#,
             others => 16#0000#),
           others => <>);
   --  csiso60norwegian1

   N120 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#006E#, 16#0066#, 16#007A#, 16#0036#,
             16#0032#, 16#0030#, 16#0031#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  nfz62010

   N121 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0036#, 16#0039#,
             others => 16#0000#),
           others => <>);
   --  isoir69

   N122 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#0066#, 16#0072#,
             others => 16#0000#),
           others => <>);
   --  iso646fr

   N123 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 2,
         Length   => 2,
         Value    =>
            (16#0066#, 16#0072#,
             others => 16#0000#),
           others => <>);
   --  fr

   N124 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0036#, 16#0039#, 16#0066#,
             16#0072#, 16#0065#, 16#006E#, 16#0063#,
             16#0068#,
             others => 16#0000#),
           others => <>);
   --  csiso69french

   N125 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0031#,
             16#0030#, 16#0036#, 16#0034#, 16#0036#,
             16#0075#, 16#0074#, 16#0066#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  iso10646utf1

   N126 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 14,
         Length   => 14,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0030#, 16#0036#,
             16#0034#, 16#0036#, 16#0075#, 16#0074#,
             16#0066#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  csiso10646utf1

   N127 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 15,
         Length   => 15,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#0062#, 16#0061#,
             16#0073#, 16#0069#, 16#0063#, 16#0031#,
             16#0039#, 16#0038#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  iso646basic1983

   N128 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#0072#, 16#0065#, 16#0066#,
             others => 16#0000#),
           others => <>);
   --  ref

   N129 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 17,
         Length   => 17,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0036#, 16#0034#, 16#0036#,
             16#0062#, 16#0061#, 16#0073#, 16#0069#,
             16#0063#, 16#0031#, 16#0039#, 16#0038#,
             16#0033#,
             others => 16#0000#),
           others => <>);
   --  csiso646basic1983

   N130 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0069#, 16#006E#, 16#0076#, 16#0061#,
             16#0072#, 16#0069#, 16#0061#, 16#006E#,
             16#0074#,
             others => 16#0000#),
           others => <>);
   --  invariant

   N131 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#006E#,
             16#0076#, 16#0061#, 16#0072#, 16#0069#,
             16#0061#, 16#006E#, 16#0074#,
             others => 16#0000#),
           others => <>);
   --  csinvariant

   N132 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#0069#, 16#0072#,
             16#0076#, 16#0031#, 16#0039#, 16#0038#,
             16#0033#,
             others => 16#0000#),
           others => <>);
   --  iso646irv1983

   N133 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  isoir2

   N134 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#0069#, 16#0072#, 16#0076#,
             others => 16#0000#),
           others => <>);
   --  irv

   N135 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 20,
         Length   => 20,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0032#, 16#0069#, 16#006E#,
             16#0074#, 16#006C#, 16#0072#, 16#0065#,
             16#0066#, 16#0076#, 16#0065#, 16#0072#,
             16#0073#, 16#0069#, 16#006F#, 16#006E#,
             others => 16#0000#),
           others => <>);
   --  csiso2intlrefversion

   N136 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#006E#, 16#0061#, 16#0074#, 16#0073#,
             16#0073#, 16#0065#, 16#0066#, 16#0069#,
             others => 16#0000#),
           others => <>);
   --  natssefi

   N137 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0038#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  isoir81

   N138 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0063#, 16#0073#, 16#006E#, 16#0061#,
             16#0074#, 16#0073#, 16#0073#, 16#0065#,
             16#0066#, 16#0069#,
             others => 16#0000#),
           others => <>);
   --  csnatssefi

   N139 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#006E#, 16#0061#, 16#0074#, 16#0073#,
             16#0073#, 16#0065#, 16#0066#, 16#0069#,
             16#0061#, 16#0064#, 16#0064#,
             others => 16#0000#),
           others => <>);
   --  natssefiadd

   N140 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0038#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  isoir82

   N141 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#006E#, 16#0061#,
             16#0074#, 16#0073#, 16#0073#, 16#0065#,
             16#0066#, 16#0069#, 16#0061#, 16#0064#,
             16#0064#,
             others => 16#0000#),
           others => <>);
   --  csnatssefiadd

   N142 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#006E#, 16#0061#, 16#0074#, 16#0073#,
             16#0064#, 16#0061#, 16#006E#, 16#006F#,
             others => 16#0000#),
           others => <>);
   --  natsdano

   N143 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0039#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  isoir91

   N144 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0063#, 16#0073#, 16#006E#, 16#0061#,
             16#0074#, 16#0073#, 16#0064#, 16#0061#,
             16#006E#, 16#006F#,
             others => 16#0000#),
           others => <>);
   --  csnatsdano

   N145 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#006E#, 16#0061#, 16#0074#, 16#0073#,
             16#0064#, 16#0061#, 16#006E#, 16#006F#,
             16#0061#, 16#0064#, 16#0064#,
             others => 16#0000#),
           others => <>);
   --  natsdanoadd

   N146 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0039#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  isoir92

   N147 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#006E#, 16#0061#,
             16#0074#, 16#0073#, 16#0064#, 16#0061#,
             16#006E#, 16#006F#, 16#0061#, 16#0064#,
             16#0064#,
             others => 16#0000#),
           others => <>);
   --  csnatsdanoadd

   N148 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0073#, 16#0065#, 16#006E#, 16#0038#,
             16#0035#, 16#0030#, 16#0032#, 16#0030#,
             16#0030#, 16#0062#,
             others => 16#0000#),
           others => <>);
   --  sen850200b

   N149 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  isoir10

   N150 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 2,
         Length   => 2,
         Value    =>
            (16#0066#, 16#0069#,
             others => 16#0000#),
           others => <>);
   --  fi

   N151 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#0066#, 16#0069#,
             others => 16#0000#),
           others => <>);
   --  iso646fi

   N152 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#0073#, 16#0065#,
             others => 16#0000#),
           others => <>);
   --  iso646se

   N153 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 2,
         Length   => 2,
         Value    =>
            (16#0073#, 16#0065#,
             others => 16#0000#),
           others => <>);
   --  se

   N154 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 14,
         Length   => 14,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0030#, 16#0073#,
             16#0077#, 16#0065#, 16#0064#, 16#0069#,
             16#0073#, 16#0068#,
             others => 16#0000#),
           others => <>);
   --  csiso10swedish

   N155 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#006B#, 16#0073#, 16#0063#, 16#0035#,
             16#0036#, 16#0030#, 16#0031#, 16#0031#,
             16#0039#, 16#0038#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  ksc56011987

   N156 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0034#, 16#0039#,
             others => 16#0000#),
           others => <>);
   --  isoir149

   N157 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#006B#, 16#0073#, 16#0063#, 16#0035#,
             16#0036#, 16#0030#, 16#0031#, 16#0031#,
             16#0039#, 16#0038#, 16#0039#,
             others => 16#0000#),
           others => <>);
   --  ksc56011989

   N158 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#006B#, 16#0073#, 16#0063#, 16#0035#,
             16#0036#, 16#0030#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  ksc5601

   N159 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#006B#, 16#006F#, 16#0072#, 16#0065#,
             16#0061#, 16#006E#,
             others => 16#0000#),
           others => <>);
   --  korean

   N160 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#006B#, 16#0073#,
             16#0063#, 16#0035#, 16#0036#, 16#0030#,
             16#0031#, 16#0031#, 16#0039#, 16#0038#,
             16#0037#,
             others => 16#0000#),
           others => <>);
   --  csksc56011987

   N161 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0032#,
             16#0030#, 16#0032#, 16#0032#, 16#006B#,
             16#0072#,
             others => 16#0000#),
           others => <>);
   --  iso2022kr

   N162 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0032#, 16#0030#, 16#0032#,
             16#0032#, 16#006B#, 16#0072#,
             others => 16#0000#),
           others => <>);
   --  csiso2022kr

   N163 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0065#, 16#0075#, 16#0063#, 16#006B#,
             16#0072#,
             others => 16#0000#),
           others => <>);
   --  euckr

   N164 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0063#, 16#0073#, 16#0065#, 16#0075#,
             16#0063#, 16#006B#, 16#0072#,
             others => 16#0000#),
           others => <>);
   --  cseuckr

   N165 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0032#,
             16#0030#, 16#0032#, 16#0032#, 16#006A#,
             16#0070#,
             others => 16#0000#),
           others => <>);
   --  iso2022jp

   N166 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0032#, 16#0030#, 16#0032#,
             16#0032#, 16#006A#, 16#0070#,
             others => 16#0000#),
           others => <>);
   --  csiso2022jp

   N167 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0032#,
             16#0030#, 16#0032#, 16#0032#, 16#006A#,
             16#0070#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  iso2022jp2

   N168 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0032#, 16#0030#, 16#0032#,
             16#0032#, 16#006A#, 16#0070#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  csiso2022jp2

   N169 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 14,
         Length   => 14,
         Value    =>
            (16#006A#, 16#0069#, 16#0073#, 16#0063#,
             16#0036#, 16#0032#, 16#0032#, 16#0030#,
             16#0031#, 16#0039#, 16#0036#, 16#0039#,
             16#006A#, 16#0070#,
             others => 16#0000#),
           others => <>);
   --  jisc62201969jp

   N170 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#006A#, 16#0069#, 16#0073#, 16#0063#,
             16#0036#, 16#0032#, 16#0032#, 16#0030#,
             16#0031#, 16#0039#, 16#0036#, 16#0039#,
             others => 16#0000#),
           others => <>);
   --  jisc62201969

   N171 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  isoir13

   N172 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#006B#, 16#0061#, 16#0074#, 16#0061#,
             16#006B#, 16#0061#, 16#006E#, 16#0061#,
             others => 16#0000#),
           others => <>);
   --  katakana

   N173 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0078#, 16#0032#, 16#0030#, 16#0031#,
             16#0037#,
             others => 16#0000#),
           others => <>);
   --  x2017

   N174 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 17,
         Length   => 17,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0033#, 16#006A#,
             16#0069#, 16#0073#, 16#0063#, 16#0036#,
             16#0032#, 16#0032#, 16#0030#, 16#006A#,
             16#0070#,
             others => 16#0000#),
           others => <>);
   --  csiso13jisc6220jp

   N175 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 14,
         Length   => 14,
         Value    =>
            (16#006A#, 16#0069#, 16#0073#, 16#0063#,
             16#0036#, 16#0032#, 16#0032#, 16#0030#,
             16#0031#, 16#0039#, 16#0036#, 16#0039#,
             16#0072#, 16#006F#,
             others => 16#0000#),
           others => <>);
   --  jisc62201969ro

   N176 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  isoir14

   N177 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 2,
         Length   => 2,
         Value    =>
            (16#006A#, 16#0070#,
             others => 16#0000#),
           others => <>);
   --  jp

   N178 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#006A#, 16#0070#,
             others => 16#0000#),
           others => <>);
   --  iso646jp

   N179 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 17,
         Length   => 17,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0034#, 16#006A#,
             16#0069#, 16#0073#, 16#0063#, 16#0036#,
             16#0032#, 16#0032#, 16#0030#, 16#0072#,
             16#006F#,
             others => 16#0000#),
           others => <>);
   --  csiso14jisc6220ro

   N180 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 2,
         Length   => 2,
         Value    =>
            (16#0070#, 16#0074#,
             others => 16#0000#),
           others => <>);
   --  pt

   N181 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  isoir16

   N182 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#0070#, 16#0074#,
             others => 16#0000#),
           others => <>);
   --  iso646pt

   N183 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 17,
         Length   => 17,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0036#, 16#0070#,
             16#006F#, 16#0072#, 16#0074#, 16#0075#,
             16#0067#, 16#0075#, 16#0065#, 16#0073#,
             16#0065#,
             others => 16#0000#),
           others => <>);
   --  csiso16portuguese

   N184 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0067#, 16#0072#, 16#0065#, 16#0065#,
             16#006B#, 16#0037#, 16#006F#, 16#006C#,
             16#0064#,
             others => 16#0000#),
           others => <>);
   --  greek7old

   N185 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  isoir18

   N186 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 16,
         Length   => 16,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0038#, 16#0067#,
             16#0072#, 16#0065#, 16#0065#, 16#006B#,
             16#0037#, 16#006F#, 16#006C#, 16#0064#,
             others => 16#0000#),
           others => <>);
   --  csiso18greek7old

   N187 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#006C#, 16#0061#, 16#0074#, 16#0069#,
             16#006E#, 16#0067#, 16#0072#, 16#0065#,
             16#0065#, 16#006B#,
             others => 16#0000#),
           others => <>);
   --  latingreek

   N188 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0039#,
             others => 16#0000#),
           others => <>);
   --  isoir19

   N189 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 17,
         Length   => 17,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0039#, 16#006C#,
             16#0061#, 16#0074#, 16#0069#, 16#006E#,
             16#0067#, 16#0072#, 16#0065#, 16#0065#,
             16#006B#,
             others => 16#0000#),
           others => <>);
   --  csiso19latingreek

   N190 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#006E#, 16#0066#, 16#007A#, 16#0036#,
             16#0032#, 16#0030#, 16#0031#, 16#0030#,
             16#0031#, 16#0039#, 16#0037#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  nfz620101973

   N191 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0032#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  isoir25

   N192 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#0066#, 16#0072#,
             16#0031#,
             others => 16#0000#),
           others => <>);
   --  iso646fr1

   N193 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0032#, 16#0035#, 16#0066#,
             16#0072#, 16#0065#, 16#006E#, 16#0063#,
             16#0068#,
             others => 16#0000#),
           others => <>);
   --  csiso25french

   N194 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#006C#, 16#0061#, 16#0074#, 16#0069#,
             16#006E#, 16#0067#, 16#0072#, 16#0065#,
             16#0065#, 16#006B#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  latingreek1

   N195 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0032#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  isoir27

   N196 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 18,
         Length   => 18,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0032#, 16#0037#, 16#006C#,
             16#0061#, 16#0074#, 16#0069#, 16#006E#,
             16#0067#, 16#0072#, 16#0065#, 16#0065#,
             16#006B#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  csiso27latingreek1

   N197 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0035#,
             16#0034#, 16#0032#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  iso5427

   N198 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0033#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  isoir37

   N199 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 17,
         Length   => 17,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0035#, 16#0034#, 16#0032#,
             16#0037#, 16#0063#, 16#0079#, 16#0072#,
             16#0069#, 16#006C#, 16#006C#, 16#0069#,
             16#0063#,
             others => 16#0000#),
           others => <>);
   --  csiso5427cyrillic

   N200 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#006A#, 16#0069#, 16#0073#, 16#0063#,
             16#0036#, 16#0032#, 16#0032#, 16#0036#,
             16#0031#, 16#0039#, 16#0037#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  jisc62261978

   N201 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0034#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  isoir42

   N202 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 19,
         Length   => 19,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0034#, 16#0032#, 16#006A#,
             16#0069#, 16#0073#, 16#0063#, 16#0036#,
             16#0032#, 16#0032#, 16#0036#, 16#0031#,
             16#0039#, 16#0037#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  csiso42jisc62261978

   N203 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0062#, 16#0073#, 16#0076#, 16#0069#,
             16#0065#, 16#0077#, 16#0064#, 16#0061#,
             16#0074#, 16#0061#,
             others => 16#0000#),
           others => <>);
   --  bsviewdata

   N204 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0034#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  isoir47

   N205 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 17,
         Length   => 17,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0034#, 16#0037#, 16#0062#,
             16#0073#, 16#0076#, 16#0069#, 16#0065#,
             16#0077#, 16#0064#, 16#0061#, 16#0074#,
             16#0061#,
             others => 16#0000#),
           others => <>);
   --  csiso47bsviewdata

   N206 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 4,
         Length   => 4,
         Value    =>
            (16#0069#, 16#006E#, 16#0069#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  inis

   N207 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0034#, 16#0039#,
             others => 16#0000#),
           others => <>);
   --  isoir49

   N208 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0034#, 16#0039#, 16#0069#,
             16#006E#, 16#0069#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  csiso49inis

   N209 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0069#, 16#006E#, 16#0069#, 16#0073#,
             16#0038#,
             others => 16#0000#),
           others => <>);
   --  inis8

   N210 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0035#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  isoir50

   N211 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0035#, 16#0030#, 16#0069#,
             16#006E#, 16#0069#, 16#0073#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  csiso50inis8

   N212 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0069#, 16#006E#, 16#0069#, 16#0073#,
             16#0063#, 16#0079#, 16#0072#, 16#0069#,
             16#006C#, 16#006C#, 16#0069#, 16#0063#,
             others => 16#0000#),
           others => <>);
   --  iniscyrillic

   N213 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0035#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  isoir51

   N214 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 19,
         Length   => 19,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0035#, 16#0031#, 16#0069#,
             16#006E#, 16#0069#, 16#0073#, 16#0063#,
             16#0079#, 16#0072#, 16#0069#, 16#006C#,
             16#006C#, 16#0069#, 16#0063#,
             others => 16#0000#),
           others => <>);
   --  csiso51iniscyrillic

   N215 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0035#,
             16#0034#, 16#0032#, 16#0037#, 16#0031#,
             16#0039#, 16#0038#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  iso54271981

   N216 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0035#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  isoir54

   N217 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 19,
         Length   => 19,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0035#,
             16#0034#, 16#0032#, 16#0037#, 16#0063#,
             16#0079#, 16#0072#, 16#0069#, 16#006C#,
             16#006C#, 16#0069#, 16#0063#, 16#0031#,
             16#0039#, 16#0038#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  iso5427cyrillic1981

   N218 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0035#, 16#0034#, 16#0032#,
             16#0037#, 16#0031#, 16#0039#, 16#0038#,
             16#0031#,
             others => 16#0000#),
           others => <>);
   --  csiso54271981

   N219 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0035#,
             16#0034#, 16#0032#, 16#0038#, 16#0031#,
             16#0039#, 16#0038#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  iso54281980

   N220 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0035#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  isoir55

   N221 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 14,
         Length   => 14,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0035#, 16#0034#, 16#0032#,
             16#0038#, 16#0067#, 16#0072#, 16#0065#,
             16#0065#, 16#006B#,
             others => 16#0000#),
           others => <>);
   --  csiso5428greek

   N222 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0067#, 16#0062#, 16#0031#, 16#0039#,
             16#0038#, 16#0038#, 16#0038#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  gb198880

   N223 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0035#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  isoir57

   N224 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 2,
         Length   => 2,
         Value    =>
            (16#0063#, 16#006E#,
             others => 16#0000#),
           others => <>);
   --  cn

   N225 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#0063#, 16#006E#,
             others => 16#0000#),
           others => <>);
   --  iso646cn

   N226 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0035#, 16#0037#, 16#0067#,
             16#0062#, 16#0031#, 16#0039#, 16#0038#,
             16#0038#,
             others => 16#0000#),
           others => <>);
   --  csiso57gb1988

   N227 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0067#, 16#0062#, 16#0032#, 16#0033#,
             16#0031#, 16#0032#, 16#0038#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  gb231280

   N228 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0035#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  isoir58

   N229 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0063#, 16#0068#, 16#0069#, 16#006E#,
             16#0065#, 16#0073#, 16#0065#,
             others => 16#0000#),
           others => <>);
   --  chinese

   N230 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 15,
         Length   => 15,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0035#, 16#0038#, 16#0067#,
             16#0062#, 16#0032#, 16#0033#, 16#0031#,
             16#0032#, 16#0038#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  csiso58gb231280

   N231 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#006E#, 16#0073#, 16#0034#, 16#0035#,
             16#0035#, 16#0031#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  ns45512

   N232 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#006E#, 16#006F#,
             16#0032#,
             others => 16#0000#),
           others => <>);
   --  iso646no2

   N233 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0036#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  isoir61

   N234 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#006E#, 16#006F#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  no2

   N235 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 17,
         Length   => 17,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0036#, 16#0031#, 16#006E#,
             16#006F#, 16#0072#, 16#0077#, 16#0065#,
             16#0067#, 16#0069#, 16#0061#, 16#006E#,
             16#0032#,
             others => 16#0000#),
           others => <>);
   --  csiso61norwegian2

   N236 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0076#, 16#0069#, 16#0064#, 16#0065#,
             16#006F#, 16#0074#, 16#0065#, 16#0078#,
             16#0073#, 16#0075#, 16#0070#, 16#0070#,
             16#006C#,
             others => 16#0000#),
           others => <>);
   --  videotexsuppl

   N237 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0037#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  isoir70

   N238 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 20,
         Length   => 20,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0037#, 16#0030#, 16#0076#,
             16#0069#, 16#0064#, 16#0065#, 16#006F#,
             16#0074#, 16#0065#, 16#0078#, 16#0073#,
             16#0075#, 16#0070#, 16#0070#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  csiso70videotexsupp1

   N239 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#0070#, 16#0074#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  pt2

   N240 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0038#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  isoir84

   N241 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#0070#, 16#0074#,
             16#0032#,
             others => 16#0000#),
           others => <>);
   --  iso646pt2

   N242 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 18,
         Length   => 18,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0038#, 16#0034#, 16#0070#,
             16#006F#, 16#0072#, 16#0074#, 16#0075#,
             16#0067#, 16#0075#, 16#0065#, 16#0073#,
             16#0065#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  csiso84portuguese2

   N243 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#0065#, 16#0073#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  es2

   N244 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0038#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  isoir85

   N245 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#0065#, 16#0073#,
             16#0032#,
             others => 16#0000#),
           others => <>);
   --  iso646es2

   N246 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 15,
         Length   => 15,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0038#, 16#0035#, 16#0073#,
             16#0070#, 16#0061#, 16#006E#, 16#0069#,
             16#0073#, 16#0068#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  csiso85spanish2

   N247 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#006D#, 16#0073#, 16#007A#, 16#0037#,
             16#0037#, 16#0039#, 16#0035#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  msz77953

   N248 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0038#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  isoir86

   N249 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#0068#, 16#0075#,
             others => 16#0000#),
           others => <>);
   --  iso646hu

   N250 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 2,
         Length   => 2,
         Value    =>
            (16#0068#, 16#0075#,
             others => 16#0000#),
           others => <>);
   --  hu

   N251 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 16,
         Length   => 16,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0038#, 16#0036#, 16#0068#,
             16#0075#, 16#006E#, 16#0067#, 16#0061#,
             16#0072#, 16#0069#, 16#0061#, 16#006E#,
             others => 16#0000#),
           others => <>);
   --  csiso86hungarian

   N252 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#006A#, 16#0069#, 16#0073#, 16#0063#,
             16#0036#, 16#0032#, 16#0032#, 16#0036#,
             16#0031#, 16#0039#, 16#0038#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  jisc62261983

   N253 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0038#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  isoir87

   N254 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 4,
         Length   => 4,
         Value    =>
            (16#0078#, 16#0032#, 16#0030#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  x208

   N255 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#006A#, 16#0069#, 16#0073#, 16#0078#,
             16#0032#, 16#0030#, 16#0038#, 16#0031#,
             16#0039#, 16#0038#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  jisx2081983

   N256 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 14,
         Length   => 14,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0038#, 16#0037#, 16#006A#,
             16#0069#, 16#0073#, 16#0078#, 16#0032#,
             16#0030#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  csiso87jisx208

   N257 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0067#, 16#0072#, 16#0065#, 16#0065#,
             16#006B#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  greek7

   N258 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0038#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  isoir88

   N259 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0038#, 16#0038#, 16#0067#,
             16#0072#, 16#0065#, 16#0065#, 16#006B#,
             16#0037#,
             others => 16#0000#),
           others => <>);
   --  csiso88greek7

   N260 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0061#, 16#0073#, 16#006D#, 16#006F#,
             16#0034#, 16#0034#, 16#0039#,
             others => 16#0000#),
           others => <>);
   --  asmo449

   N261 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0039#,
             16#0030#, 16#0033#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  iso9036

   N262 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0061#, 16#0072#, 16#0061#, 16#0062#,
             16#0069#, 16#0063#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  arabic7

   N263 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0038#, 16#0039#,
             others => 16#0000#),
           others => <>);
   --  isoir89

   N264 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 14,
         Length   => 14,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0038#, 16#0039#, 16#0061#,
             16#0073#, 16#006D#, 16#006F#, 16#0034#,
             16#0034#, 16#0039#,
             others => 16#0000#),
           others => <>);
   --  csiso89asmo449

   N265 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0039#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  isoir90

   N266 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0039#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  csiso90

   N267 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#006A#, 16#0069#, 16#0073#, 16#0063#,
             16#0036#, 16#0032#, 16#0032#, 16#0039#,
             16#0031#, 16#0039#, 16#0038#, 16#0034#,
             16#0061#,
             others => 16#0000#),
           others => <>);
   --  jisc62291984a

   N268 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#006A#, 16#0070#, 16#006F#, 16#0063#,
             16#0072#, 16#0061#,
             others => 16#0000#),
           others => <>);
   --  jpocra

   N269 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 20,
         Length   => 20,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0039#, 16#0031#, 16#006A#,
             16#0069#, 16#0073#, 16#0063#, 16#0036#,
             16#0032#, 16#0032#, 16#0039#, 16#0031#,
             16#0039#, 16#0038#, 16#0034#, 16#0061#,
             others => 16#0000#),
           others => <>);
   --  csiso91jisc62291984a

   N270 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#006A#, 16#0069#, 16#0073#, 16#0063#,
             16#0036#, 16#0032#, 16#0032#, 16#0039#,
             16#0031#, 16#0039#, 16#0038#, 16#0034#,
             16#0062#,
             others => 16#0000#),
           others => <>);
   --  jisc62291984b

   N271 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#006A#, 16#0070#,
             16#006F#, 16#0063#, 16#0072#, 16#0062#,
             others => 16#0000#),
           others => <>);
   --  iso646jpocrb

   N272 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#006A#, 16#0070#, 16#006F#, 16#0063#,
             16#0072#, 16#0062#,
             others => 16#0000#),
           others => <>);
   --  jpocrb

   N273 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 20,
         Length   => 20,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0039#, 16#0032#, 16#006A#,
             16#0069#, 16#0073#, 16#0063#, 16#0036#,
             16#0032#, 16#0039#, 16#0039#, 16#0031#,
             16#0039#, 16#0038#, 16#0034#, 16#0062#,
             others => 16#0000#),
           others => <>);
   --  csiso92jisc62991984b

   N274 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 16,
         Length   => 16,
         Value    =>
            (16#006A#, 16#0069#, 16#0073#, 16#0063#,
             16#0036#, 16#0032#, 16#0032#, 16#0039#,
             16#0031#, 16#0039#, 16#0038#, 16#0034#,
             16#0062#, 16#0061#, 16#0064#, 16#0064#,
             others => 16#0000#),
           others => <>);
   --  jisc62291984badd

   N275 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0039#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  isoir93

   N276 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#006A#, 16#0070#, 16#006F#, 16#0063#,
             16#0072#, 16#0062#, 16#0061#, 16#0064#,
             16#0064#,
             others => 16#0000#),
           others => <>);
   --  jpocrbadd

   N277 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 22,
         Length   => 22,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0039#, 16#0033#, 16#006A#,
             16#0069#, 16#0073#, 16#0036#, 16#0032#,
             16#0032#, 16#0039#, 16#0031#, 16#0039#,
             16#0038#, 16#0034#, 16#0062#, 16#0061#,
             16#0064#, 16#0064#,
             others => 16#0000#),
           others => <>);
   --  csiso93jis62291984badd

   N278 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 16,
         Length   => 16,
         Value    =>
            (16#006A#, 16#0069#, 16#0073#, 16#0063#,
             16#0036#, 16#0032#, 16#0032#, 16#0039#,
             16#0031#, 16#0039#, 16#0038#, 16#0034#,
             16#0068#, 16#0061#, 16#006E#, 16#0064#,
             others => 16#0000#),
           others => <>);
   --  jisc62291984hand

   N279 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0039#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  isoir94

   N280 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#006A#, 16#0070#, 16#006F#, 16#0063#,
             16#0072#, 16#0068#, 16#0061#, 16#006E#,
             16#0064#,
             others => 16#0000#),
           others => <>);
   --  jpocrhand

   N281 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 22,
         Length   => 22,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0039#, 16#0034#, 16#006A#,
             16#0069#, 16#0073#, 16#0036#, 16#0032#,
             16#0032#, 16#0039#, 16#0031#, 16#0039#,
             16#0038#, 16#0034#, 16#0068#, 16#0061#,
             16#006E#, 16#0064#,
             others => 16#0000#),
           others => <>);
   --  csiso94jis62291984hand

   N282 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 19,
         Length   => 19,
         Value    =>
            (16#006A#, 16#0069#, 16#0073#, 16#0063#,
             16#0036#, 16#0032#, 16#0032#, 16#0039#,
             16#0031#, 16#0039#, 16#0038#, 16#0034#,
             16#0068#, 16#0061#, 16#006E#, 16#0064#,
             16#0061#, 16#0064#, 16#0064#,
             others => 16#0000#),
           others => <>);
   --  jisc62291984handadd

   N283 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0039#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  isoir95

   N284 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#006A#, 16#0070#, 16#006F#, 16#0063#,
             16#0072#, 16#0068#, 16#0061#, 16#006E#,
             16#0064#, 16#0061#, 16#0064#, 16#0064#,
             others => 16#0000#),
           others => <>);
   --  jpocrhandadd

   N285 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 31,
         Unused   => 25,
         Length   => 25,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0039#, 16#0035#, 16#006A#,
             16#0069#, 16#0073#, 16#0036#, 16#0032#,
             16#0032#, 16#0039#, 16#0031#, 16#0039#,
             16#0038#, 16#0034#, 16#0068#, 16#0061#,
             16#006E#, 16#0064#, 16#0061#, 16#0064#,
             16#0064#,
             others => 16#0000#),
           others => <>);
   --  csiso95jis62291984handadd

   N286 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 16,
         Length   => 16,
         Value    =>
            (16#006A#, 16#0069#, 16#0073#, 16#0063#,
             16#0036#, 16#0032#, 16#0032#, 16#0039#,
             16#0031#, 16#0039#, 16#0038#, 16#0034#,
             16#006B#, 16#0061#, 16#006E#, 16#0061#,
             others => 16#0000#),
           others => <>);
   --  jisc62291984kana

   N287 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0039#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  isoir96

   N288 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 23,
         Length   => 23,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0039#, 16#0036#, 16#006A#,
             16#0069#, 16#0073#, 16#0063#, 16#0036#,
             16#0032#, 16#0032#, 16#0039#, 16#0031#,
             16#0039#, 16#0038#, 16#0034#, 16#006B#,
             16#0061#, 16#006E#, 16#0061#,
             others => 16#0000#),
           others => <>);
   --  csiso96jisc62291984kana

   N289 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0032#,
             16#0030#, 16#0033#, 16#0033#, 16#0031#,
             16#0039#, 16#0038#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  iso20331983

   N290 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0039#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  isoir98

   N291 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 4,
         Length   => 4,
         Value    =>
            (16#0065#, 16#0031#, 16#0033#, 16#0062#,
             others => 16#0000#),
           others => <>);
   --  e13b

   N292 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0032#, 16#0030#, 16#0033#,
             16#0033#,
             others => 16#0000#),
           others => <>);
   --  csiso2033

   N293 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0061#, 16#006E#, 16#0073#, 16#0069#,
             16#0078#, 16#0033#, 16#0031#, 16#0031#,
             16#0030#, 16#0031#, 16#0039#, 16#0038#,
             16#0033#,
             others => 16#0000#),
           others => <>);
   --  ansix31101983

   N294 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0039#, 16#0039#,
             others => 16#0000#),
           others => <>);
   --  isoir99

   N295 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0061#, 16#0074#,
             16#0035#, 16#0030#, 16#0030#, 16#0031#,
             16#0039#, 16#0038#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  csat5001983

   N296 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#006E#, 16#0061#, 16#0070#, 16#006C#,
             16#0070#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  naplps

   N297 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0039#, 16#0039#, 16#006E#,
             16#0061#, 16#0070#, 16#006C#, 16#0070#,
             16#0073#,
             others => 16#0000#),
           others => <>);
   --  csiso99naplps

   N298 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0074#, 16#0036#, 16#0031#, 16#0037#,
             16#0062#, 16#0069#, 16#0074#,
             others => 16#0000#),
           others => <>);
   --  t617bit

   N299 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0030#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  isoir102

   N300 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 15,
         Length   => 15,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0030#, 16#0032#,
             16#0074#, 16#0036#, 16#0031#, 16#0037#,
             16#0062#, 16#0069#, 16#0074#,
             others => 16#0000#),
           others => <>);
   --  csiso102t617bit

   N301 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0074#, 16#0036#, 16#0031#, 16#0038#,
             16#0062#, 16#0069#, 16#0074#,
             others => 16#0000#),
           others => <>);
   --  t618bit

   N302 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#0074#, 16#0036#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  t61

   N303 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0030#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  isoir103

   N304 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 15,
         Length   => 15,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0030#, 16#0033#,
             16#0074#, 16#0036#, 16#0031#, 16#0038#,
             16#0062#, 16#0069#, 16#0074#,
             others => 16#0000#),
           others => <>);
   --  csiso103t618bit

   N305 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0065#, 16#0063#, 16#006D#, 16#0061#,
             16#0063#, 16#0079#, 16#0072#, 16#0069#,
             16#006C#, 16#006C#, 16#0069#, 16#0063#,
             others => 16#0000#),
           others => <>);
   --  ecmacyrillic

   N306 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0031#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  isoir111

   N307 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#006B#, 16#006F#, 16#0069#, 16#0038#,
             16#0065#,
             others => 16#0000#),
           others => <>);
   --  koi8e

   N308 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 20,
         Length   => 20,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0031#, 16#0031#,
             16#0065#, 16#0063#, 16#006D#, 16#0061#,
             16#0063#, 16#0079#, 16#0072#, 16#0069#,
             16#006C#, 16#006C#, 16#0069#, 16#0063#,
             others => 16#0000#),
           others => <>);
   --  csiso111ecmacyrillic

   N309 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0061#, 16#007A#,
             16#0032#, 16#0034#, 16#0033#, 16#0034#,
             16#0031#, 16#0039#, 16#0038#, 16#0035#,
             16#0031#,
             others => 16#0000#),
           others => <>);
   --  csaz243419851

   N310 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0032#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  isoir121

   N311 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#0063#, 16#0061#,
             others => 16#0000#),
           others => <>);
   --  iso646ca

   N312 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0073#, 16#0061#, 16#0037#,
             16#0031#,
             others => 16#0000#),
           others => <>);
   --  csa71

   N313 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 2,
         Length   => 2,
         Value    =>
            (16#0063#, 16#0061#,
             others => 16#0000#),
           others => <>);
   --  ca

   N314 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 17,
         Length   => 17,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0032#, 16#0031#,
             16#0063#, 16#0061#, 16#006E#, 16#0061#,
             16#0064#, 16#0069#, 16#0061#, 16#006E#,
             16#0031#,
             others => 16#0000#),
           others => <>);
   --  csiso121canadian1

   N315 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0061#, 16#007A#,
             16#0032#, 16#0034#, 16#0033#, 16#0034#,
             16#0031#, 16#0039#, 16#0038#, 16#0035#,
             16#0032#,
             others => 16#0000#),
           others => <>);
   --  csaz243419852

   N316 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0032#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  isoir122

   N317 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#0063#, 16#0061#,
             16#0032#,
             others => 16#0000#),
           others => <>);
   --  iso646ca2

   N318 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0073#, 16#0061#, 16#0037#,
             16#0032#,
             others => 16#0000#),
           others => <>);
   --  csa72

   N319 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 17,
         Length   => 17,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0032#, 16#0032#,
             16#0063#, 16#0061#, 16#006E#, 16#0061#,
             16#0064#, 16#0069#, 16#0061#, 16#006E#,
             16#0032#,
             others => 16#0000#),
           others => <>);
   --  csiso122canadian2

   N320 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 14,
         Length   => 14,
         Value    =>
            (16#0063#, 16#0073#, 16#0061#, 16#007A#,
             16#0032#, 16#0034#, 16#0033#, 16#0034#,
             16#0031#, 16#0039#, 16#0038#, 16#0035#,
             16#0067#, 16#0072#,
             others => 16#0000#),
           others => <>);
   --  csaz24341985gr

   N321 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0032#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  isoir123

   N322 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 22,
         Length   => 22,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0032#, 16#0033#,
             16#0063#, 16#0073#, 16#0061#, 16#007A#,
             16#0032#, 16#0034#, 16#0033#, 16#0034#,
             16#0031#, 16#0039#, 16#0038#, 16#0035#,
             16#0067#, 16#0072#,
             others => 16#0000#),
           others => <>);
   --  csiso123csaz24341985gr

   N323 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0036#,
             16#0065#,
             others => 16#0000#),
           others => <>);
   --  iso88596e

   N324 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0038#, 16#0038#, 16#0035#,
             16#0039#, 16#0036#, 16#0065#,
             others => 16#0000#),
           others => <>);
   --  csiso88596e

   N325 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0036#,
             16#0069#,
             others => 16#0000#),
           others => <>);
   --  iso88596i

   N326 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0038#, 16#0038#, 16#0035#,
             16#0039#, 16#0036#, 16#0069#,
             others => 16#0000#),
           others => <>);
   --  csiso88596i

   N327 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0074#, 16#0031#, 16#0030#, 16#0031#,
             16#0067#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  t101g2

   N328 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0032#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  isoir128

   N329 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 14,
         Length   => 14,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0032#, 16#0038#,
             16#0074#, 16#0031#, 16#0030#, 16#0031#,
             16#0067#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  csiso128t101g2

   N330 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0038#,
             16#0065#,
             others => 16#0000#),
           others => <>);
   --  iso88598e

   N331 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0038#, 16#0038#, 16#0035#,
             16#0039#, 16#0038#, 16#0065#,
             others => 16#0000#),
           others => <>);
   --  csiso88598e

   N332 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0038#,
             16#0069#,
             others => 16#0000#),
           others => <>);
   --  iso88598i

   N333 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0038#, 16#0038#, 16#0035#,
             16#0039#, 16#0038#, 16#0069#,
             others => 16#0000#),
           others => <>);
   --  csiso88598i

   N334 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#006E#, 16#0033#,
             16#0036#, 16#0039#, 16#0031#, 16#0030#,
             16#0033#,
             others => 16#0000#),
           others => <>);
   --  csn369103

   N335 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0033#, 16#0039#,
             others => 16#0000#),
           others => <>);
   --  isoir139

   N336 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 17,
         Length   => 17,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0033#, 16#0039#,
             16#0063#, 16#0073#, 16#006E#, 16#0033#,
             16#0036#, 16#0039#, 16#0031#, 16#0030#,
             16#0033#,
             others => 16#0000#),
           others => <>);
   --  csiso139csn369103

   N337 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#006A#, 16#0075#, 16#0073#, 16#0069#,
             16#0062#, 16#0031#, 16#0030#, 16#0030#,
             16#0032#,
             others => 16#0000#),
           others => <>);
   --  jusib1002

   N338 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0034#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  isoir141

   N339 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#0079#, 16#0075#,
             others => 16#0000#),
           others => <>);
   --  iso646yu

   N340 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 2,
         Length   => 2,
         Value    =>
            (16#006A#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  js

   N341 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 2,
         Length   => 2,
         Value    =>
            (16#0079#, 16#0075#,
             others => 16#0000#),
           others => <>);
   --  yu

   N342 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 17,
         Length   => 17,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0034#, 16#0031#,
             16#006A#, 16#0075#, 16#0073#, 16#0069#,
             16#0062#, 16#0031#, 16#0030#, 16#0030#,
             16#0032#,
             others => 16#0000#),
           others => <>);
   --  csiso141jusib1002

   N343 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0065#, 16#0063#, 16#0070#,
             16#0032#, 16#0037#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  iecp271

   N344 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0034#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  isoir143

   N345 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 15,
         Length   => 15,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0034#, 16#0033#,
             16#0069#, 16#0065#, 16#0063#, 16#0070#,
             16#0032#, 16#0037#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  csiso143iecp271

   N346 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#006A#, 16#0075#, 16#0073#, 16#0069#,
             16#0062#, 16#0031#, 16#0030#, 16#0030#,
             16#0033#, 16#0073#, 16#0065#, 16#0072#,
             16#0062#,
             others => 16#0000#),
           others => <>);
   --  jusib1003serb

   N347 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0034#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  isoir146

   N348 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0073#, 16#0065#, 16#0072#, 16#0062#,
             16#0069#, 16#0061#, 16#006E#,
             others => 16#0000#),
           others => <>);
   --  serbian

   N349 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 15,
         Length   => 15,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0034#, 16#0036#,
             16#0073#, 16#0065#, 16#0072#, 16#0062#,
             16#0069#, 16#0061#, 16#006E#,
             others => 16#0000#),
           others => <>);
   --  csiso146serbian

   N350 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#006A#, 16#0075#, 16#0073#, 16#0069#,
             16#0062#, 16#0031#, 16#0030#, 16#0030#,
             16#0033#, 16#006D#, 16#0061#, 16#0063#,
             others => 16#0000#),
           others => <>);
   --  jusib1003mac

   N351 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#006D#, 16#0061#, 16#0063#, 16#0065#,
             16#0064#, 16#006F#, 16#006E#, 16#0069#,
             16#0061#, 16#006E#,
             others => 16#0000#),
           others => <>);
   --  macedonian

   N352 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0034#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  isoir147

   N353 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 18,
         Length   => 18,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0034#, 16#0037#,
             16#006D#, 16#0061#, 16#0063#, 16#0065#,
             16#0064#, 16#006F#, 16#006E#, 16#0069#,
             16#0061#, 16#006E#,
             others => 16#0000#),
           others => <>);
   --  csiso147macedonian

   N354 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0067#, 16#0072#, 16#0065#, 16#0065#,
             16#006B#, 16#0063#, 16#0063#, 16#0069#,
             16#0074#, 16#0074#,
             others => 16#0000#),
           others => <>);
   --  greekccitt

   N355 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0035#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  isoir150

   N356 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0035#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  csiso150

   N357 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 18,
         Length   => 18,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0035#, 16#0030#,
             16#0067#, 16#0072#, 16#0065#, 16#0065#,
             16#006B#, 16#0063#, 16#0063#, 16#0069#,
             16#0074#, 16#0074#,
             others => 16#0000#),
           others => <>);
   --  csiso150greekccitt

   N358 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#006E#, 16#0063#, 16#006E#, 16#0063#,
             16#0031#, 16#0030#, 16#0038#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  ncnc1081

   N359 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 4,
         Length   => 4,
         Value    =>
            (16#0063#, 16#0075#, 16#0062#, 16#0061#,
             others => 16#0000#),
           others => <>);
   --  cuba

   N360 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0035#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  isoir151

   N361 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#0063#, 16#0075#,
             others => 16#0000#),
           others => <>);
   --  iso646cu

   N362 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0035#, 16#0031#,
             16#0063#, 16#0075#, 16#0062#, 16#0061#,
             others => 16#0000#),
           others => <>);
   --  csiso151cuba

   N363 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0039#, 16#0033#, 16#0037#, 16#0032#,
             16#0032#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  iso6937225

   N364 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0035#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  isoir152

   N365 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0036#, 16#0039#, 16#0033#,
             16#0037#, 16#0061#, 16#0064#, 16#0064#,
             others => 16#0000#),
           others => <>);
   --  csiso6937add

   N366 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0067#, 16#006F#, 16#0073#, 16#0074#,
             16#0031#, 16#0039#, 16#0037#, 16#0036#,
             16#0038#, 16#0037#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  gost1976874

   N367 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0073#, 16#0074#, 16#0073#, 16#0065#,
             16#0076#, 16#0033#, 16#0035#, 16#0038#,
             16#0038#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  stsev35888

   N368 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0035#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  isoir153

   N369 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 19,
         Length   => 19,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0035#, 16#0033#,
             16#0067#, 16#006F#, 16#0073#, 16#0074#,
             16#0031#, 16#0039#, 16#0037#, 16#0036#,
             16#0038#, 16#0037#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  csiso153gost1976874

   N370 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0073#,
             16#0075#, 16#0070#, 16#0070#,
             others => 16#0000#),
           others => <>);
   --  iso8859supp

   N371 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0035#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  isoir154

   N372 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#006C#, 16#0061#, 16#0074#, 16#0069#,
             16#006E#, 16#0031#, 16#0032#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  latin125

   N373 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0038#, 16#0038#, 16#0035#,
             16#0039#, 16#0073#, 16#0075#, 16#0070#,
             16#0070#,
             others => 16#0000#),
           others => <>);
   --  csiso8859supp

   N374 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0031#,
             16#0030#, 16#0033#, 16#0036#, 16#0037#,
             16#0062#, 16#006F#, 16#0078#,
             others => 16#0000#),
           others => <>);
   --  iso10367box

   N375 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0035#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  isoir155

   N376 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0030#, 16#0033#,
             16#0036#, 16#0037#, 16#0062#, 16#006F#,
             16#0078#,
             others => 16#0000#),
           others => <>);
   --  csiso10367box

   N377 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#006C#, 16#0061#, 16#0074#, 16#0069#,
             16#006E#, 16#006C#, 16#0061#, 16#0070#,
             others => 16#0000#),
           others => <>);
   --  latinlap

   N378 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#006C#, 16#0061#, 16#0070#,
             others => 16#0000#),
           others => <>);
   --  lap

   N379 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0035#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  isoir158

   N380 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0035#, 16#0038#,
             16#006C#, 16#0061#, 16#0070#,
             others => 16#0000#),
           others => <>);
   --  csiso158lap

   N381 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#006A#, 16#0069#, 16#0073#, 16#0078#,
             16#0032#, 16#0031#, 16#0032#, 16#0031#,
             16#0039#, 16#0039#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  jisx2121990

   N382 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 4,
         Length   => 4,
         Value    =>
            (16#0078#, 16#0032#, 16#0031#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  x212

   N383 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0035#, 16#0039#,
             others => 16#0000#),
           others => <>);
   --  isoir159

   N384 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 19,
         Length   => 19,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0035#, 16#0039#,
             16#006A#, 16#0069#, 16#0073#, 16#0078#,
             16#0032#, 16#0031#, 16#0032#, 16#0031#,
             16#0039#, 16#0039#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  csiso159jisx2121990

   N385 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0064#, 16#0073#, 16#0032#, 16#0030#,
             16#0038#, 16#0039#,
             others => 16#0000#),
           others => <>);
   --  ds2089

   N386 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#0064#, 16#006B#,
             others => 16#0000#),
           others => <>);
   --  iso646dk

   N387 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 2,
         Length   => 2,
         Value    =>
            (16#0064#, 16#006B#,
             others => 16#0000#),
           others => <>);
   --  dk

   N388 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 14,
         Length   => 14,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0036#, 16#0034#, 16#0036#,
             16#0064#, 16#0061#, 16#006E#, 16#0069#,
             16#0073#, 16#0068#,
             others => 16#0000#),
           others => <>);
   --  csiso646danish

   N389 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 4,
         Length   => 4,
         Value    =>
            (16#0075#, 16#0073#, 16#0064#, 16#006B#,
             others => 16#0000#),
           others => <>);
   --  usdk

   N390 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0063#, 16#0073#, 16#0075#, 16#0073#,
             16#0064#, 16#006B#,
             others => 16#0000#),
           others => <>);
   --  csusdk

   N391 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 4,
         Length   => 4,
         Value    =>
            (16#0064#, 16#006B#, 16#0075#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  dkus

   N392 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0063#, 16#0073#, 16#0064#, 16#006B#,
             16#0075#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  csdkus

   N393 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#006B#, 16#0073#, 16#0063#, 16#0035#,
             16#0036#, 16#0033#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  ksc5636

   N394 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0036#,
             16#0034#, 16#0036#, 16#006B#, 16#0072#,
             others => 16#0000#),
           others => <>);
   --  iso646kr

   N395 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#006B#, 16#0073#,
             16#0063#, 16#0035#, 16#0036#, 16#0033#,
             16#0036#,
             others => 16#0000#),
           others => <>);
   --  csksc5636

   N396 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0075#, 16#006E#, 16#0069#, 16#0063#,
             16#006F#, 16#0064#, 16#0065#, 16#0031#,
             16#0031#, 16#0075#, 16#0074#, 16#0066#,
             16#0037#,
             others => 16#0000#),
           others => <>);
   --  unicode11utf7

   N397 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 15,
         Length   => 15,
         Value    =>
            (16#0063#, 16#0073#, 16#0075#, 16#006E#,
             16#0069#, 16#0063#, 16#006F#, 16#0064#,
             16#0065#, 16#0031#, 16#0031#, 16#0075#,
             16#0074#, 16#0066#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  csunicode11utf7

   N398 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0032#,
             16#0030#, 16#0032#, 16#0032#, 16#0063#,
             16#006E#,
             others => 16#0000#),
           others => <>);
   --  iso2022cn

   N399 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0032#, 16#0030#, 16#0032#,
             16#0032#, 16#0063#, 16#006E#,
             others => 16#0000#),
           others => <>);
   --  csiso2022cn

   N400 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0032#,
             16#0030#, 16#0032#, 16#0032#, 16#0063#,
             16#006E#, 16#0065#, 16#0078#, 16#0074#,
             others => 16#0000#),
           others => <>);
   --  iso2022cnext

   N401 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 14,
         Length   => 14,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0032#, 16#0030#, 16#0032#,
             16#0032#, 16#0063#, 16#006E#, 16#0065#,
             16#0078#, 16#0074#,
             others => 16#0000#),
           others => <>);
   --  csiso2022cnext

   N402 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 4,
         Length   => 4,
         Value    =>
            (16#0075#, 16#0074#, 16#0066#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  utf8

   N403 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0063#, 16#0073#, 16#0075#, 16#0074#,
             16#0066#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  csutf8

   N404 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0031#,
             16#0033#,
             others => 16#0000#),
           others => <>);
   --  iso885913

   N405 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0038#, 16#0038#, 16#0035#,
             16#0039#, 16#0031#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  csiso885913

   N406 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0031#,
             16#0034#,
             others => 16#0000#),
           others => <>);
   --  iso885914

   N407 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0031#, 16#0039#, 16#0039#,
             others => 16#0000#),
           others => <>);
   --  isoir199

   N408 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0031#,
             16#0034#, 16#0031#, 16#0039#, 16#0039#,
             16#0038#,
             others => 16#0000#),
           others => <>);
   --  iso8859141998

   N409 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#006C#, 16#0061#, 16#0074#, 16#0069#,
             16#006E#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  latin8

   N410 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0063#,
             16#0065#, 16#006C#, 16#0074#, 16#0069#,
             16#0063#,
             others => 16#0000#),
           others => <>);
   --  isoceltic

   N411 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 2,
         Length   => 2,
         Value    =>
            (16#006C#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  l8

   N412 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0038#, 16#0038#, 16#0035#,
             16#0039#, 16#0031#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  csiso885914

   N413 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0031#,
             16#0035#,
             others => 16#0000#),
           others => <>);
   --  iso885915

   N414 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#006C#, 16#0061#, 16#0074#, 16#0069#,
             16#006E#, 16#0039#,
             others => 16#0000#),
           others => <>);
   --  latin9

   N415 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0038#, 16#0038#, 16#0035#,
             16#0039#, 16#0031#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  csiso885915

   N416 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0031#,
             16#0036#,
             others => 16#0000#),
           others => <>);
   --  iso885916

   N417 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0069#,
             16#0072#, 16#0032#, 16#0032#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  isoir226

   N418 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0031#,
             16#0036#, 16#0032#, 16#0030#, 16#0030#,
             16#0031#,
             others => 16#0000#),
           others => <>);
   --  iso8859162001

   N419 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#006C#, 16#0061#, 16#0074#, 16#0069#,
             16#006E#, 16#0031#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  latin10

   N420 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#006C#, 16#0031#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  l10

   N421 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0038#, 16#0038#, 16#0035#,
             16#0039#, 16#0031#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  csiso885916

   N422 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#0067#, 16#0062#, 16#006B#,
             others => 16#0000#),
           others => <>);
   --  gbk

   N423 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0039#, 16#0033#,
             16#0036#,
             others => 16#0000#),
           others => <>);
   --  cp936

   N424 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#006D#, 16#0073#, 16#0039#, 16#0033#,
             16#0036#,
             others => 16#0000#),
           others => <>);
   --  ms936

   N425 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0077#, 16#0069#, 16#006E#, 16#0064#,
             16#006F#, 16#0077#, 16#0073#, 16#0039#,
             16#0033#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  windows936

   N426 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0073#, 16#0067#, 16#0062#,
             16#006B#,
             others => 16#0000#),
           others => <>);
   --  csgbk

   N427 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0067#, 16#0062#, 16#0031#, 16#0038#,
             16#0030#, 16#0033#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  gb18030

   N428 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#0067#, 16#0062#,
             16#0031#, 16#0038#, 16#0030#, 16#0033#,
             16#0030#,
             others => 16#0000#),
           others => <>);
   --  csgb18030

   N429 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 14,
         Length   => 14,
         Value    =>
            (16#006F#, 16#0073#, 16#0064#, 16#0065#,
             16#0062#, 16#0063#, 16#0064#, 16#0069#,
             16#0063#, 16#0064#, 16#0066#, 16#0034#,
             16#0031#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  osdebcdicdf415

   N430 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 16,
         Length   => 16,
         Value    =>
            (16#0063#, 16#0073#, 16#006F#, 16#0073#,
             16#0064#, 16#0065#, 16#0062#, 16#0063#,
             16#0064#, 16#0069#, 16#0063#, 16#0064#,
             16#0066#, 16#0034#, 16#0031#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  csosdebcdicdf415

   N431 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 15,
         Length   => 15,
         Value    =>
            (16#006F#, 16#0073#, 16#0064#, 16#0065#,
             16#0062#, 16#0063#, 16#0064#, 16#0069#,
             16#0063#, 16#0064#, 16#0066#, 16#0033#,
             16#0069#, 16#0072#, 16#0076#,
             others => 16#0000#),
           others => <>);
   --  osdebcdicdf3irv

   N432 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 17,
         Length   => 17,
         Value    =>
            (16#0063#, 16#0073#, 16#006F#, 16#0073#,
             16#0064#, 16#0065#, 16#0062#, 16#0063#,
             16#0064#, 16#0069#, 16#0063#, 16#0064#,
             16#0066#, 16#0033#, 16#0069#, 16#0072#,
             16#0076#,
             others => 16#0000#),
           others => <>);
   --  csosdebcdicdf3irv

   N433 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#006F#, 16#0073#, 16#0064#, 16#0065#,
             16#0062#, 16#0063#, 16#0064#, 16#0069#,
             16#0063#, 16#0064#, 16#0066#, 16#0034#,
             16#0031#,
             others => 16#0000#),
           others => <>);
   --  osdebcdicdf41

   N434 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 15,
         Length   => 15,
         Value    =>
            (16#0063#, 16#0073#, 16#006F#, 16#0073#,
             16#0064#, 16#0065#, 16#0062#, 16#0063#,
             16#0064#, 16#0069#, 16#0063#, 16#0064#,
             16#0066#, 16#0034#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  csosdebcdicdf41

   N435 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0031#,
             16#0031#, 16#0035#, 16#0034#, 16#0038#,
             16#0031#,
             others => 16#0000#),
           others => <>);
   --  iso115481

   N436 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0074#,
             16#0072#, 16#0031#, 16#0031#, 16#0035#,
             16#0034#, 16#0038#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  isotr115481

   N437 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0073#,
             16#006F#, 16#0031#, 16#0031#, 16#0035#,
             16#0034#, 16#0038#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  csiso115481

   N438 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#006B#, 16#007A#, 16#0031#, 16#0030#,
             16#0034#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  kz1048

   N439 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0073#, 16#0074#, 16#0072#, 16#006B#,
             16#0031#, 16#0030#, 16#0034#, 16#0038#,
             16#0032#, 16#0030#, 16#0030#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  strk10482002

   N440 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0072#, 16#006B#, 16#0031#, 16#0030#,
             16#0034#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  rk1048

   N441 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#006B#, 16#007A#,
             16#0031#, 16#0030#, 16#0034#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  cskz1048

   N442 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0031#,
             16#0030#, 16#0036#, 16#0034#, 16#0036#,
             16#0075#, 16#0063#, 16#0073#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  iso10646ucs2

   N443 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#0075#, 16#006E#,
             16#0069#, 16#0063#, 16#006F#, 16#0064#,
             16#0065#,
             others => 16#0000#),
           others => <>);
   --  csunicode

   N444 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0031#,
             16#0030#, 16#0036#, 16#0034#, 16#0036#,
             16#0075#, 16#0063#, 16#0073#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  iso10646ucs4

   N445 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0063#, 16#0073#, 16#0075#, 16#0063#,
             16#0073#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  csucs4

   N446 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 16,
         Length   => 16,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0031#,
             16#0030#, 16#0036#, 16#0034#, 16#0036#,
             16#0075#, 16#0063#, 16#0073#, 16#0062#,
             16#0061#, 16#0073#, 16#0069#, 16#0063#,
             others => 16#0000#),
           others => <>);
   --  iso10646ucsbasic

   N447 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 14,
         Length   => 14,
         Value    =>
            (16#0063#, 16#0073#, 16#0075#, 16#006E#,
             16#0069#, 16#0063#, 16#006F#, 16#0064#,
             16#0065#, 16#0061#, 16#0073#, 16#0063#,
             16#0069#, 16#0069#,
             others => 16#0000#),
           others => <>);
   --  csunicodeascii

   N448 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 21,
         Length   => 21,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0031#,
             16#0030#, 16#0036#, 16#0034#, 16#0036#,
             16#0075#, 16#006E#, 16#0069#, 16#0063#,
             16#006F#, 16#0064#, 16#0065#, 16#006C#,
             16#0061#, 16#0074#, 16#0069#, 16#006E#,
             16#0031#,
             others => 16#0000#),
           others => <>);
   --  iso10646unicodelatin1

   N449 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 15,
         Length   => 15,
         Value    =>
            (16#0063#, 16#0073#, 16#0075#, 16#006E#,
             16#0069#, 16#0063#, 16#006F#, 16#0064#,
             16#0065#, 16#006C#, 16#0061#, 16#0074#,
             16#0069#, 16#006E#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  csunicodelatin1

   N450 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0031#,
             16#0030#, 16#0036#, 16#0034#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  iso10646

   N451 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0031#,
             16#0030#, 16#0036#, 16#0034#, 16#0036#,
             16#006A#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  iso10646j1

   N452 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 17,
         Length   => 17,
         Value    =>
            (16#0063#, 16#0073#, 16#0075#, 16#006E#,
             16#0069#, 16#0063#, 16#006F#, 16#0064#,
             16#0065#, 16#006A#, 16#0061#, 16#0070#,
             16#0061#, 16#006E#, 16#0065#, 16#0073#,
             16#0065#,
             others => 16#0000#),
           others => <>);
   --  csunicodejapanese

   N453 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 17,
         Length   => 17,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0075#,
             16#006E#, 16#0069#, 16#0063#, 16#006F#,
             16#0064#, 16#0065#, 16#0069#, 16#0062#,
             16#006D#, 16#0031#, 16#0032#, 16#0036#,
             16#0031#,
             others => 16#0000#),
           others => <>);
   --  isounicodeibm1261

   N454 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 16,
         Length   => 16,
         Value    =>
            (16#0063#, 16#0073#, 16#0075#, 16#006E#,
             16#0069#, 16#0063#, 16#006F#, 16#0064#,
             16#0065#, 16#0069#, 16#0062#, 16#006D#,
             16#0031#, 16#0032#, 16#0036#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  csunicodeibm1261

   N455 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 17,
         Length   => 17,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0075#,
             16#006E#, 16#0069#, 16#0063#, 16#006F#,
             16#0064#, 16#0065#, 16#0069#, 16#0062#,
             16#006D#, 16#0031#, 16#0032#, 16#0036#,
             16#0038#,
             others => 16#0000#),
           others => <>);
   --  isounicodeibm1268

   N456 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 16,
         Length   => 16,
         Value    =>
            (16#0063#, 16#0073#, 16#0075#, 16#006E#,
             16#0069#, 16#0063#, 16#006F#, 16#0064#,
             16#0065#, 16#0069#, 16#0062#, 16#006D#,
             16#0031#, 16#0032#, 16#0036#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  csunicodeibm1268

   N457 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 17,
         Length   => 17,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0075#,
             16#006E#, 16#0069#, 16#0063#, 16#006F#,
             16#0064#, 16#0065#, 16#0069#, 16#0062#,
             16#006D#, 16#0031#, 16#0032#, 16#0037#,
             16#0036#,
             others => 16#0000#),
           others => <>);
   --  isounicodeibm1276

   N458 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 16,
         Length   => 16,
         Value    =>
            (16#0063#, 16#0073#, 16#0075#, 16#006E#,
             16#0069#, 16#0063#, 16#006F#, 16#0064#,
             16#0065#, 16#0069#, 16#0062#, 16#006D#,
             16#0031#, 16#0032#, 16#0037#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  csunicodeibm1276

   N459 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 17,
         Length   => 17,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0075#,
             16#006E#, 16#0069#, 16#0063#, 16#006F#,
             16#0064#, 16#0065#, 16#0069#, 16#0062#,
             16#006D#, 16#0031#, 16#0032#, 16#0036#,
             16#0034#,
             others => 16#0000#),
           others => <>);
   --  isounicodeibm1264

   N460 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 16,
         Length   => 16,
         Value    =>
            (16#0063#, 16#0073#, 16#0075#, 16#006E#,
             16#0069#, 16#0063#, 16#006F#, 16#0064#,
             16#0065#, 16#0069#, 16#0062#, 16#006D#,
             16#0031#, 16#0032#, 16#0036#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  csunicodeibm1264

   N461 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 17,
         Length   => 17,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0075#,
             16#006E#, 16#0069#, 16#0063#, 16#006F#,
             16#0064#, 16#0065#, 16#0069#, 16#0062#,
             16#006D#, 16#0031#, 16#0032#, 16#0036#,
             16#0035#,
             others => 16#0000#),
           others => <>);
   --  isounicodeibm1265

   N462 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 16,
         Length   => 16,
         Value    =>
            (16#0063#, 16#0073#, 16#0075#, 16#006E#,
             16#0069#, 16#0063#, 16#006F#, 16#0064#,
             16#0065#, 16#0069#, 16#0062#, 16#006D#,
             16#0031#, 16#0032#, 16#0036#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  csunicodeibm1265

   N463 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0075#, 16#006E#, 16#0069#, 16#0063#,
             16#006F#, 16#0064#, 16#0065#, 16#0031#,
             16#0031#,
             others => 16#0000#),
           others => <>);
   --  unicode11

   N464 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0075#, 16#006E#,
             16#0069#, 16#0063#, 16#006F#, 16#0064#,
             16#0065#, 16#0031#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  csunicode11

   N465 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 4,
         Length   => 4,
         Value    =>
            (16#0073#, 16#0063#, 16#0073#, 16#0075#,
             others => 16#0000#),
           others => <>);
   --  scsu

   N466 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0063#, 16#0073#, 16#0073#, 16#0063#,
             16#0073#, 16#0075#,
             others => 16#0000#),
           others => <>);
   --  csscsu

   N467 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 4,
         Length   => 4,
         Value    =>
            (16#0075#, 16#0074#, 16#0066#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  utf7

   N468 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0063#, 16#0073#, 16#0075#, 16#0074#,
             16#0066#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  csutf7

   N469 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0075#, 16#0074#, 16#0066#, 16#0031#,
             16#0036#, 16#0062#, 16#0065#,
             others => 16#0000#),
           others => <>);
   --  utf16be

   N470 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#0075#, 16#0074#,
             16#0066#, 16#0031#, 16#0036#, 16#0062#,
             16#0065#,
             others => 16#0000#),
           others => <>);
   --  csutf16be

   N471 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0075#, 16#0074#, 16#0066#, 16#0031#,
             16#0036#, 16#006C#, 16#0065#,
             others => 16#0000#),
           others => <>);
   --  utf16le

   N472 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#0075#, 16#0074#,
             16#0066#, 16#0031#, 16#0036#, 16#006C#,
             16#0065#,
             others => 16#0000#),
           others => <>);
   --  csutf16le

   N473 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0075#, 16#0074#, 16#0066#, 16#0031#,
             16#0036#,
             others => 16#0000#),
           others => <>);
   --  utf16

   N474 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0063#, 16#0073#, 16#0075#, 16#0074#,
             16#0066#, 16#0031#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  csutf16

   N475 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0065#, 16#0073#, 16#0075#,
             16#0038#,
             others => 16#0000#),
           others => <>);
   --  cesu8

   N476 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0063#, 16#0073#, 16#0063#, 16#0065#,
             16#0073#, 16#0075#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  cscesu8

   N477 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0075#, 16#0074#, 16#0066#, 16#0033#,
             16#0032#,
             others => 16#0000#),
           others => <>);
   --  utf32

   N478 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0063#, 16#0073#, 16#0075#, 16#0074#,
             16#0066#, 16#0033#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  csutf32

   N479 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0075#, 16#0074#, 16#0066#, 16#0033#,
             16#0032#, 16#0062#, 16#0065#,
             others => 16#0000#),
           others => <>);
   --  utf32be

   N480 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#0075#, 16#0074#,
             16#0066#, 16#0033#, 16#0032#, 16#0062#,
             16#0065#,
             others => 16#0000#),
           others => <>);
   --  csutf32be

   N481 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0075#, 16#0074#, 16#0066#, 16#0033#,
             16#0032#, 16#006C#, 16#0065#,
             others => 16#0000#),
           others => <>);
   --  utf32le

   N482 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#0075#, 16#0074#,
             16#0066#, 16#0033#, 16#0032#, 16#006C#,
             16#0065#,
             others => 16#0000#),
           others => <>);
   --  csutf32le

   N483 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0062#, 16#006F#, 16#0063#, 16#0075#,
             16#0031#,
             others => 16#0000#),
           others => <>);
   --  bocu1

   N484 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0063#, 16#0073#, 16#0062#, 16#006F#,
             16#0063#, 16#0075#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  csbocu1

   N485 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 23,
         Length   => 23,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0031#,
             16#0077#, 16#0069#, 16#006E#, 16#0064#,
             16#006F#, 16#0077#, 16#0073#, 16#0033#,
             16#0030#, 16#006C#, 16#0061#, 16#0074#,
             16#0069#, 16#006E#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  iso88591windows30latin1

   N486 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 17,
         Length   => 17,
         Value    =>
            (16#0063#, 16#0073#, 16#0077#, 16#0069#,
             16#006E#, 16#0064#, 16#006F#, 16#0077#,
             16#0073#, 16#0033#, 16#0030#, 16#006C#,
             16#0061#, 16#0074#, 16#0069#, 16#006E#,
             16#0031#,
             others => 16#0000#),
           others => <>);
   --  cswindows30latin1

   N487 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 23,
         Length   => 23,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0031#,
             16#0077#, 16#0069#, 16#006E#, 16#0064#,
             16#006F#, 16#0077#, 16#0073#, 16#0033#,
             16#0031#, 16#006C#, 16#0061#, 16#0074#,
             16#0069#, 16#006E#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  iso88591windows31latin1

   N488 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 17,
         Length   => 17,
         Value    =>
            (16#0063#, 16#0073#, 16#0077#, 16#0069#,
             16#006E#, 16#0064#, 16#006F#, 16#0077#,
             16#0073#, 16#0033#, 16#0031#, 16#006C#,
             16#0061#, 16#0074#, 16#0069#, 16#006E#,
             16#0031#,
             others => 16#0000#),
           others => <>);
   --  cswindows31latin1

   N489 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 21,
         Length   => 21,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0032#,
             16#0077#, 16#0069#, 16#006E#, 16#0064#,
             16#006F#, 16#0077#, 16#0073#, 16#006C#,
             16#0061#, 16#0074#, 16#0069#, 16#006E#,
             16#0032#,
             others => 16#0000#),
           others => <>);
   --  iso88592windowslatin2

   N490 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 17,
         Length   => 17,
         Value    =>
            (16#0063#, 16#0073#, 16#0077#, 16#0069#,
             16#006E#, 16#0064#, 16#006F#, 16#0077#,
             16#0073#, 16#0033#, 16#0031#, 16#006C#,
             16#0061#, 16#0074#, 16#0069#, 16#006E#,
             16#0032#,
             others => 16#0000#),
           others => <>);
   --  cswindows31latin2

   N491 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 21,
         Length   => 21,
         Value    =>
            (16#0069#, 16#0073#, 16#006F#, 16#0038#,
             16#0038#, 16#0035#, 16#0039#, 16#0039#,
             16#0077#, 16#0069#, 16#006E#, 16#0064#,
             16#006F#, 16#0077#, 16#0073#, 16#006C#,
             16#0061#, 16#0074#, 16#0069#, 16#006E#,
             16#0035#,
             others => 16#0000#),
           others => <>);
   --  iso88599windowslatin5

   N492 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 17,
         Length   => 17,
         Value    =>
            (16#0063#, 16#0073#, 16#0077#, 16#0069#,
             16#006E#, 16#0064#, 16#006F#, 16#0077#,
             16#0073#, 16#0033#, 16#0031#, 16#006C#,
             16#0061#, 16#0074#, 16#0069#, 16#006E#,
             16#0035#,
             others => 16#0000#),
           others => <>);
   --  cswindows31latin5

   N493 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0068#, 16#0070#, 16#0072#, 16#006F#,
             16#006D#, 16#0061#, 16#006E#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  hproman8

   N494 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0072#, 16#006F#, 16#006D#, 16#0061#,
             16#006E#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  roman8

   N495 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 2,
         Length   => 2,
         Value    =>
            (16#0072#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  r8

   N496 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0063#, 16#0073#, 16#0068#, 16#0070#,
             16#0072#, 16#006F#, 16#006D#, 16#0061#,
             16#006E#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  cshproman8

   N497 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 21,
         Length   => 21,
         Value    =>
            (16#0061#, 16#0064#, 16#006F#, 16#0062#,
             16#0065#, 16#0073#, 16#0074#, 16#0061#,
             16#006E#, 16#0064#, 16#0061#, 16#0072#,
             16#0064#, 16#0065#, 16#006E#, 16#0063#,
             16#006F#, 16#0064#, 16#0069#, 16#006E#,
             16#0067#,
             others => 16#0000#),
           others => <>);
   --  adobestandardencoding

   N498 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 23,
         Length   => 23,
         Value    =>
            (16#0063#, 16#0073#, 16#0061#, 16#0064#,
             16#006F#, 16#0062#, 16#0065#, 16#0073#,
             16#0074#, 16#0061#, 16#006E#, 16#0064#,
             16#0061#, 16#0072#, 16#0064#, 16#0065#,
             16#006E#, 16#0063#, 16#006F#, 16#0064#,
             16#0069#, 16#006E#, 16#0067#,
             others => 16#0000#),
           others => <>);
   --  csadobestandardencoding

   N499 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0076#, 16#0065#, 16#006E#, 16#0074#,
             16#0075#, 16#0072#, 16#0061#, 16#0075#,
             16#0073#,
             others => 16#0000#),
           others => <>);
   --  venturaus

   N500 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0076#, 16#0065#,
             16#006E#, 16#0074#, 16#0075#, 16#0072#,
             16#0061#, 16#0075#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  csventuraus

   N501 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 20,
         Length   => 20,
         Value    =>
            (16#0076#, 16#0065#, 16#006E#, 16#0074#,
             16#0075#, 16#0072#, 16#0061#, 16#0069#,
             16#006E#, 16#0074#, 16#0065#, 16#0072#,
             16#006E#, 16#0061#, 16#0074#, 16#0069#,
             16#006F#, 16#006E#, 16#0061#, 16#006C#,
             others => 16#0000#),
           others => <>);
   --  venturainternational

   N502 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 22,
         Length   => 22,
         Value    =>
            (16#0063#, 16#0073#, 16#0076#, 16#0065#,
             16#006E#, 16#0074#, 16#0075#, 16#0072#,
             16#0061#, 16#0069#, 16#006E#, 16#0074#,
             16#0065#, 16#0072#, 16#006E#, 16#0061#,
             16#0074#, 16#0069#, 16#006F#, 16#006E#,
             16#0061#, 16#006C#,
             others => 16#0000#),
           others => <>);
   --  csventurainternational

   N503 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0064#, 16#0065#, 16#0063#, 16#006D#,
             16#0063#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  decmcs

   N504 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#0064#, 16#0065#, 16#0063#,
             others => 16#0000#),
           others => <>);
   --  dec

   N505 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0064#, 16#0065#,
             16#0063#, 16#006D#, 16#0063#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  csdecmcs

   N506 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0038#,
             16#0035#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  ibm850

   N507 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0038#, 16#0035#,
             16#0030#,
             others => 16#0000#),
           others => <>);
   --  cp850

   N508 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#0038#, 16#0035#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  850

   N509 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 19,
         Length   => 19,
         Value    =>
            (16#0063#, 16#0073#, 16#0070#, 16#0063#,
             16#0038#, 16#0035#, 16#0030#, 16#006D#,
             16#0075#, 16#006C#, 16#0074#, 16#0069#,
             16#006C#, 16#0069#, 16#006E#, 16#0067#,
             16#0075#, 16#0061#, 16#006C#,
             others => 16#0000#),
           others => <>);
   --  cspc850multilingual

   N510 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 18,
         Length   => 18,
         Value    =>
            (16#0070#, 16#0063#, 16#0038#, 16#0064#,
             16#0061#, 16#006E#, 16#0069#, 16#0073#,
             16#0068#, 16#006E#, 16#006F#, 16#0072#,
             16#0077#, 16#0065#, 16#0067#, 16#0069#,
             16#0061#, 16#006E#,
             others => 16#0000#),
           others => <>);
   --  pc8danishnorwegian

   N511 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 20,
         Length   => 20,
         Value    =>
            (16#0063#, 16#0073#, 16#0070#, 16#0063#,
             16#0038#, 16#0064#, 16#0061#, 16#006E#,
             16#0069#, 16#0073#, 16#0068#, 16#006E#,
             16#006F#, 16#0072#, 16#0077#, 16#0065#,
             16#0067#, 16#0069#, 16#0061#, 16#006E#,
             others => 16#0000#),
           others => <>);
   --  cspc8danishnorwegian

   N512 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0038#,
             16#0036#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  ibm862

   N513 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0038#, 16#0036#,
             16#0032#,
             others => 16#0000#),
           others => <>);
   --  cp862

   N514 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#0038#, 16#0036#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  862

   N515 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 18,
         Length   => 18,
         Value    =>
            (16#0063#, 16#0073#, 16#0070#, 16#0063#,
             16#0038#, 16#0036#, 16#0032#, 16#006C#,
             16#0061#, 16#0074#, 16#0069#, 16#006E#,
             16#0068#, 16#0065#, 16#0062#, 16#0072#,
             16#0065#, 16#0077#,
             others => 16#0000#),
           others => <>);
   --  cspc862latinhebrew

   N516 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0070#, 16#0063#, 16#0038#, 16#0074#,
             16#0075#, 16#0072#, 16#006B#, 16#0069#,
             16#0073#, 16#0068#,
             others => 16#0000#),
           others => <>);
   --  pc8turkish

   N517 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0063#, 16#0073#, 16#0070#, 16#0063#,
             16#0038#, 16#0074#, 16#0075#, 16#0072#,
             16#006B#, 16#0069#, 16#0073#, 16#0068#,
             others => 16#0000#),
           others => <>);
   --  cspc8turkish

   N518 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0073#,
             16#0079#, 16#006D#, 16#0062#, 16#006F#,
             16#006C#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  ibmsymbols

   N519 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0073#, 16#0079#, 16#006D#,
             16#0062#, 16#006F#, 16#006C#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  csibmsymbols

   N520 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0074#,
             16#0068#, 16#0061#, 16#0069#,
             others => 16#0000#),
           others => <>);
   --  ibmthai

   N521 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0074#, 16#0068#, 16#0061#,
             16#0069#,
             others => 16#0000#),
           others => <>);
   --  csibmthai

   N522 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0068#, 16#0070#, 16#006C#, 16#0065#,
             16#0067#, 16#0061#, 16#006C#,
             others => 16#0000#),
           others => <>);
   --  hplegal

   N523 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#0068#, 16#0070#,
             16#006C#, 16#0065#, 16#0067#, 16#0061#,
             16#006C#,
             others => 16#0000#),
           others => <>);
   --  cshplegal

   N524 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0068#, 16#0070#, 16#0070#, 16#0069#,
             16#0066#, 16#006F#, 16#006E#, 16#0074#,
             others => 16#0000#),
           others => <>);
   --  hppifont

   N525 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0063#, 16#0073#, 16#0068#, 16#0070#,
             16#0070#, 16#0069#, 16#0066#, 16#006F#,
             16#006E#, 16#0074#,
             others => 16#0000#),
           others => <>);
   --  cshppifont

   N526 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0068#, 16#0070#, 16#006D#, 16#0061#,
             16#0074#, 16#0068#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  hpmath8

   N527 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#0068#, 16#0070#,
             16#006D#, 16#0061#, 16#0074#, 16#0068#,
             16#0038#,
             others => 16#0000#),
           others => <>);
   --  cshpmath8

   N528 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 19,
         Length   => 19,
         Value    =>
            (16#0061#, 16#0064#, 16#006F#, 16#0062#,
             16#0065#, 16#0073#, 16#0079#, 16#006D#,
             16#0062#, 16#006F#, 16#006C#, 16#0065#,
             16#006E#, 16#0063#, 16#006F#, 16#0064#,
             16#0069#, 16#006E#, 16#0067#,
             others => 16#0000#),
           others => <>);
   --  adobesymbolencoding

   N529 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0063#, 16#0073#, 16#0068#, 16#0070#,
             16#0070#, 16#0073#, 16#006D#, 16#0061#,
             16#0074#, 16#0068#,
             others => 16#0000#),
           others => <>);
   --  cshppsmath

   N530 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0068#, 16#0070#, 16#0064#, 16#0065#,
             16#0073#, 16#006B#, 16#0074#, 16#006F#,
             16#0070#,
             others => 16#0000#),
           others => <>);
   --  hpdesktop

   N531 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0068#, 16#0070#,
             16#0064#, 16#0065#, 16#0073#, 16#006B#,
             16#0074#, 16#006F#, 16#0070#,
             others => 16#0000#),
           others => <>);
   --  cshpdesktop

   N532 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0076#, 16#0065#, 16#006E#, 16#0074#,
             16#0075#, 16#0072#, 16#0061#, 16#006D#,
             16#0061#, 16#0074#, 16#0068#,
             others => 16#0000#),
           others => <>);
   --  venturamath

   N533 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0076#, 16#0065#,
             16#006E#, 16#0074#, 16#0075#, 16#0072#,
             16#0061#, 16#006D#, 16#0061#, 16#0074#,
             16#0068#,
             others => 16#0000#),
           others => <>);
   --  csventuramath

   N534 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 19,
         Length   => 19,
         Value    =>
            (16#006D#, 16#0069#, 16#0063#, 16#0072#,
             16#006F#, 16#0073#, 16#006F#, 16#0066#,
             16#0074#, 16#0070#, 16#0075#, 16#0062#,
             16#006C#, 16#0069#, 16#0073#, 16#0068#,
             16#0069#, 16#006E#, 16#0067#,
             others => 16#0000#),
           others => <>);
   --  microsoftpublishing

   N535 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 21,
         Length   => 21,
         Value    =>
            (16#0063#, 16#0073#, 16#006D#, 16#0069#,
             16#0063#, 16#0072#, 16#006F#, 16#0073#,
             16#006F#, 16#0066#, 16#0074#, 16#0070#,
             16#0075#, 16#0062#, 16#006C#, 16#0069#,
             16#0073#, 16#0068#, 16#0069#, 16#006E#,
             16#0067#,
             others => 16#0000#),
           others => <>);
   --  csmicrosoftpublishing

   N536 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0077#, 16#0069#, 16#006E#, 16#0064#,
             16#006F#, 16#0077#, 16#0073#, 16#0033#,
             16#0031#, 16#006A#,
             others => 16#0000#),
           others => <>);
   --  windows31j

   N537 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0063#, 16#0073#, 16#0077#, 16#0069#,
             16#006E#, 16#0064#, 16#006F#, 16#0077#,
             16#0073#, 16#0033#, 16#0031#, 16#006A#,
             others => 16#0000#),
           others => <>);
   --  cswindows31j

   N538 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0067#, 16#0062#, 16#0032#, 16#0033#,
             16#0031#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  gb2312

   N539 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0067#, 16#0062#,
             16#0032#, 16#0033#, 16#0031#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  csgb2312

   N540 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 4,
         Length   => 4,
         Value    =>
            (16#0062#, 16#0069#, 16#0067#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  big5

   N541 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0063#, 16#0073#, 16#0062#, 16#0069#,
             16#0067#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  csbig5

   N542 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#006D#, 16#0061#, 16#0063#, 16#0069#,
             16#006E#, 16#0074#, 16#006F#, 16#0073#,
             16#0068#,
             others => 16#0000#),
           others => <>);
   --  macintosh

   N543 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#006D#, 16#0061#, 16#0063#,
             others => 16#0000#),
           others => <>);
   --  mac

   N544 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#006D#, 16#0061#,
             16#0063#, 16#0069#, 16#006E#, 16#0074#,
             16#006F#, 16#0073#, 16#0068#,
             others => 16#0000#),
           others => <>);
   --  csmacintosh

   N545 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0033#,
             16#0037#,
             others => 16#0000#),
           others => <>);
   --  ibm37

   N546 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 4,
         Length   => 4,
         Value    =>
            (16#0063#, 16#0070#, 16#0033#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  cp37

   N547 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0063#, 16#0070#,
             16#0075#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  ebcdiccpus

   N548 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0063#, 16#0070#,
             16#0063#, 16#0061#,
             others => 16#0000#),
           others => <>);
   --  ebcdiccpca

   N549 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0063#, 16#0070#,
             16#0077#, 16#0074#,
             others => 16#0000#),
           others => <>);
   --  ebcdiccpwt

   N550 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0063#, 16#0070#,
             16#006E#, 16#006C#,
             others => 16#0000#),
           others => <>);
   --  ebcdiccpnl

   N551 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0033#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  csibm37

   N552 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0033#,
             16#0038#,
             others => 16#0000#),
           others => <>);
   --  ibm38

   N553 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0069#, 16#006E#,
             16#0074#,
             others => 16#0000#),
           others => <>);
   --  ebcdicint

   N554 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 4,
         Length   => 4,
         Value    =>
            (16#0063#, 16#0070#, 16#0033#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  cp38

   N555 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0033#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  csibm38

   N556 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0032#,
             16#0037#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  ibm273

   N557 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0032#, 16#0037#,
             16#0033#,
             others => 16#0000#),
           others => <>);
   --  cp273

   N558 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0032#, 16#0037#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  csibm273

   N559 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0032#,
             16#0037#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  ibm274

   N560 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0062#, 16#0065#,
             others => 16#0000#),
           others => <>);
   --  ebcdicbe

   N561 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0032#, 16#0037#,
             16#0034#,
             others => 16#0000#),
           others => <>);
   --  cp274

   N562 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0032#, 16#0037#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  csibm274

   N563 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0032#,
             16#0037#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  ibm275

   N564 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0062#, 16#0072#,
             others => 16#0000#),
           others => <>);
   --  ebcdicbr

   N565 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0032#, 16#0037#,
             16#0035#,
             others => 16#0000#),
           others => <>);
   --  cp275

   N566 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0032#, 16#0037#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  csibm275

   N567 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0032#,
             16#0037#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  ibm277

   N568 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0063#, 16#0070#,
             16#0064#, 16#006B#,
             others => 16#0000#),
           others => <>);
   --  ebcdiccpdk

   N569 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0063#, 16#0070#,
             16#006E#, 16#006F#,
             others => 16#0000#),
           others => <>);
   --  ebcdiccpno

   N570 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0032#, 16#0037#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  csibm277

   N571 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0032#,
             16#0037#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  ibm278

   N572 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0032#, 16#0037#,
             16#0038#,
             others => 16#0000#),
           others => <>);
   --  cp278

   N573 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0063#, 16#0070#,
             16#0066#, 16#0069#,
             others => 16#0000#),
           others => <>);
   --  ebcdiccpfi

   N574 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0063#, 16#0070#,
             16#0073#, 16#0065#,
             others => 16#0000#),
           others => <>);
   --  ebcdiccpse

   N575 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0032#, 16#0037#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  csibm278

   N576 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0032#,
             16#0038#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  ibm280

   N577 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0032#, 16#0038#,
             16#0030#,
             others => 16#0000#),
           others => <>);
   --  cp280

   N578 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0063#, 16#0070#,
             16#0069#, 16#0074#,
             others => 16#0000#),
           others => <>);
   --  ebcdiccpit

   N579 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0032#, 16#0038#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  csibm280

   N580 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0032#,
             16#0038#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  ibm281

   N581 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#006A#, 16#0070#,
             16#0065#,
             others => 16#0000#),
           others => <>);
   --  ebcdicjpe

   N582 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0032#, 16#0038#,
             16#0031#,
             others => 16#0000#),
           others => <>);
   --  cp281

   N583 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0032#, 16#0038#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  csibm281

   N584 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0032#,
             16#0038#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  ibm284

   N585 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0032#, 16#0038#,
             16#0034#,
             others => 16#0000#),
           others => <>);
   --  cp284

   N586 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0063#, 16#0070#,
             16#0065#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  ebcdiccpes

   N587 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0032#, 16#0038#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  csibm284

   N588 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0032#,
             16#0038#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  ibm285

   N589 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0032#, 16#0038#,
             16#0035#,
             others => 16#0000#),
           others => <>);
   --  cp285

   N590 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0063#, 16#0070#,
             16#0067#, 16#0062#,
             others => 16#0000#),
           others => <>);
   --  ebcdiccpgb

   N591 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0032#, 16#0038#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  csibm285

   N592 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0032#,
             16#0039#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  ibm290

   N593 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0032#, 16#0039#,
             16#0030#,
             others => 16#0000#),
           others => <>);
   --  cp290

   N594 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#006A#, 16#0070#,
             16#006B#, 16#0061#, 16#006E#, 16#0061#,
             others => 16#0000#),
           others => <>);
   --  ebcdicjpkana

   N595 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0032#, 16#0039#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  csibm290

   N596 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0032#,
             16#0039#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  ibm297

   N597 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0032#, 16#0039#,
             16#0037#,
             others => 16#0000#),
           others => <>);
   --  cp297

   N598 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0063#, 16#0070#,
             16#0066#, 16#0072#,
             others => 16#0000#),
           others => <>);
   --  ebcdiccpfr

   N599 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0032#, 16#0039#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  csibm297

   N600 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0034#,
             16#0032#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  ibm420

   N601 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0034#, 16#0032#,
             16#0030#,
             others => 16#0000#),
           others => <>);
   --  cp420

   N602 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0063#, 16#0070#,
             16#0061#, 16#0072#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  ebcdiccpar1

   N603 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0034#, 16#0032#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  csibm420

   N604 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0034#,
             16#0032#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  ibm423

   N605 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0034#, 16#0032#,
             16#0033#,
             others => 16#0000#),
           others => <>);
   --  cp423

   N606 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0063#, 16#0070#,
             16#0067#, 16#0072#,
             others => 16#0000#),
           others => <>);
   --  ebcdiccpgr

   N607 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0034#, 16#0032#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  csibm423

   N608 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0034#,
             16#0032#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  ibm424

   N609 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0034#, 16#0032#,
             16#0034#,
             others => 16#0000#),
           others => <>);
   --  cp424

   N610 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0063#, 16#0070#,
             16#0068#, 16#0065#,
             others => 16#0000#),
           others => <>);
   --  ebcdiccphe

   N611 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0034#, 16#0032#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  csibm424

   N612 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0034#,
             16#0033#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  ibm437

   N613 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0034#, 16#0033#,
             16#0037#,
             others => 16#0000#),
           others => <>);
   --  cp437

   N614 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#0034#, 16#0033#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  437

   N615 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 16,
         Length   => 16,
         Value    =>
            (16#0063#, 16#0073#, 16#0070#, 16#0063#,
             16#0038#, 16#0063#, 16#006F#, 16#0064#,
             16#0065#, 16#0070#, 16#0061#, 16#0067#,
             16#0065#, 16#0034#, 16#0033#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  cspc8codepage437

   N616 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0035#,
             16#0030#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  ibm500

   N617 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0035#, 16#0030#,
             16#0030#,
             others => 16#0000#),
           others => <>);
   --  cp500

   N618 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0063#, 16#0070#,
             16#0062#, 16#0065#,
             others => 16#0000#),
           others => <>);
   --  ebcdiccpbe

   N619 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0063#, 16#0070#,
             16#0063#, 16#0068#,
             others => 16#0000#),
           others => <>);
   --  ebcdiccpch

   N620 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0035#, 16#0030#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  csibm500

   N621 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0038#,
             16#0035#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  ibm851

   N622 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0038#, 16#0035#,
             16#0031#,
             others => 16#0000#),
           others => <>);
   --  cp851

   N623 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#0038#, 16#0035#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  851

   N624 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0038#, 16#0035#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  csibm851

   N625 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0038#,
             16#0035#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  ibm852

   N626 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0038#, 16#0035#,
             16#0032#,
             others => 16#0000#),
           others => <>);
   --  cp852

   N627 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#0038#, 16#0035#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  852

   N628 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0070#, 16#0063#,
             16#0070#, 16#0038#, 16#0035#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  cspcp852

   N629 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0038#,
             16#0035#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  ibm855

   N630 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0038#, 16#0035#,
             16#0035#,
             others => 16#0000#),
           others => <>);
   --  cp855

   N631 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#0038#, 16#0035#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  855

   N632 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0038#, 16#0035#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  csibm855

   N633 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0038#,
             16#0035#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  ibm857

   N634 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0038#, 16#0035#,
             16#0037#,
             others => 16#0000#),
           others => <>);
   --  cp857

   N635 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#0038#, 16#0035#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  857

   N636 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0038#, 16#0035#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  csibm857

   N637 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0038#,
             16#0036#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  ibm860

   N638 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0038#, 16#0036#,
             16#0030#,
             others => 16#0000#),
           others => <>);
   --  cp860

   N639 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#0038#, 16#0036#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  860

   N640 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0038#, 16#0036#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  csibm860

   N641 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0038#,
             16#0036#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  ibm861

   N642 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0038#, 16#0036#,
             16#0031#,
             others => 16#0000#),
           others => <>);
   --  cp861

   N643 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#0038#, 16#0036#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  861

   N644 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 4,
         Length   => 4,
         Value    =>
            (16#0063#, 16#0070#, 16#0069#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  cpis

   N645 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0038#, 16#0036#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  csibm861

   N646 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0038#,
             16#0036#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  ibm863

   N647 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0038#, 16#0036#,
             16#0033#,
             others => 16#0000#),
           others => <>);
   --  cp863

   N648 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#0038#, 16#0036#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  863

   N649 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0038#, 16#0036#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  csibm863

   N650 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0038#,
             16#0036#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  ibm864

   N651 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0038#, 16#0036#,
             16#0034#,
             others => 16#0000#),
           others => <>);
   --  cp864

   N652 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0038#, 16#0036#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  csibm864

   N653 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0038#,
             16#0036#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  ibm865

   N654 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0038#, 16#0036#,
             16#0035#,
             others => 16#0000#),
           others => <>);
   --  cp865

   N655 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#0038#, 16#0036#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  865

   N656 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0038#, 16#0036#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  csibm865

   N657 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0038#,
             16#0036#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  ibm868

   N658 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0038#, 16#0036#,
             16#0038#,
             others => 16#0000#),
           others => <>);
   --  cp868

   N659 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 4,
         Length   => 4,
         Value    =>
            (16#0063#, 16#0070#, 16#0061#, 16#0072#,
             others => 16#0000#),
           others => <>);
   --  cpar

   N660 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0038#, 16#0036#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  csibm868

   N661 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0038#,
             16#0036#, 16#0039#,
             others => 16#0000#),
           others => <>);
   --  ibm869

   N662 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0038#, 16#0036#,
             16#0039#,
             others => 16#0000#),
           others => <>);
   --  cp869

   N663 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#0038#, 16#0036#, 16#0039#,
             others => 16#0000#),
           others => <>);
   --  869

   N664 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 4,
         Length   => 4,
         Value    =>
            (16#0063#, 16#0070#, 16#0067#, 16#0072#,
             others => 16#0000#),
           others => <>);
   --  cpgr

   N665 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0038#, 16#0036#, 16#0039#,
             others => 16#0000#),
           others => <>);
   --  csibm869

   N666 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0038#,
             16#0037#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  ibm870

   N667 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0038#, 16#0037#,
             16#0030#,
             others => 16#0000#),
           others => <>);
   --  cp870

   N668 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0063#, 16#0070#,
             16#0072#, 16#006F#, 16#0065#, 16#0063#,
             16#0065#,
             others => 16#0000#),
           others => <>);
   --  ebcdiccproece

   N669 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0063#, 16#0070#,
             16#0079#, 16#0075#,
             others => 16#0000#),
           others => <>);
   --  ebcdiccpyu

   N670 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0038#, 16#0037#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  csibm870

   N671 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0038#,
             16#0037#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  ibm871

   N672 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0038#, 16#0037#,
             16#0031#,
             others => 16#0000#),
           others => <>);
   --  cp871

   N673 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0063#, 16#0070#,
             16#0069#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  ebcdiccpis

   N674 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0038#, 16#0037#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  csibm871

   N675 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0038#,
             16#0038#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  ibm880

   N676 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0038#, 16#0038#,
             16#0030#,
             others => 16#0000#),
           others => <>);
   --  cp880

   N677 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 14,
         Length   => 14,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0063#, 16#0079#,
             16#0072#, 16#0069#, 16#006C#, 16#006C#,
             16#0069#, 16#0063#,
             others => 16#0000#),
           others => <>);
   --  ebcdiccyrillic

   N678 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0038#, 16#0038#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  csibm880

   N679 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0038#,
             16#0039#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  ibm891

   N680 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0038#, 16#0039#,
             16#0031#,
             others => 16#0000#),
           others => <>);
   --  cp891

   N681 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0038#, 16#0039#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  csibm891

   N682 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0039#,
             16#0030#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  ibm903

   N683 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0039#, 16#0030#,
             16#0033#,
             others => 16#0000#),
           others => <>);
   --  cp903

   N684 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0039#, 16#0030#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  csibm903

   N685 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0039#,
             16#0030#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  ibm904

   N686 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0039#, 16#0030#,
             16#0034#,
             others => 16#0000#),
           others => <>);
   --  cp904

   N687 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#0039#, 16#0030#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  904

   N688 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#0062#, 16#006D#, 16#0039#, 16#0030#,
             16#0034#,
             others => 16#0000#),
           others => <>);
   --  csibbm904

   N689 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0039#,
             16#0030#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  ibm905

   N690 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0039#, 16#0030#,
             16#0035#,
             others => 16#0000#),
           others => <>);
   --  cp905

   N691 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0063#, 16#0070#,
             16#0074#, 16#0072#,
             others => 16#0000#),
           others => <>);
   --  ebcdiccptr

   N692 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0039#, 16#0030#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  csibm905

   N693 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0039#,
             16#0031#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  ibm918

   N694 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0039#, 16#0031#,
             16#0038#,
             others => 16#0000#),
           others => <>);
   --  cp918

   N695 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0063#, 16#0070#,
             16#0061#, 16#0072#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  ebcdiccpar2

   N696 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0039#, 16#0031#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  csibm918

   N697 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0031#,
             16#0030#, 16#0032#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  ibm1026

   N698 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0063#, 16#0070#, 16#0031#, 16#0030#,
             16#0032#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  cp1026

   N699 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0031#, 16#0030#, 16#0032#,
             16#0036#,
             others => 16#0000#),
           others => <>);
   --  csibm1026

   N700 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0061#, 16#0074#,
             16#0064#, 16#0065#,
             others => 16#0000#),
           others => <>);
   --  ebcdicatde

   N701 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 15,
         Length   => 15,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0065#, 16#0062#, 16#0063#,
             16#0064#, 16#0069#, 16#0063#, 16#0061#,
             16#0074#, 16#0064#, 16#0065#,
             others => 16#0000#),
           others => <>);
   --  csibmebcdicatde

   N702 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0061#, 16#0074#,
             16#0064#, 16#0065#, 16#0061#,
             others => 16#0000#),
           others => <>);
   --  ebcdicatdea

   N703 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0065#, 16#0062#,
             16#0063#, 16#0064#, 16#0069#, 16#0063#,
             16#0061#, 16#0074#, 16#0064#, 16#0065#,
             16#0061#,
             others => 16#0000#),
           others => <>);
   --  csebcdicatdea

   N704 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0063#, 16#0061#,
             16#0066#, 16#0072#,
             others => 16#0000#),
           others => <>);
   --  ebcdiccafr

   N705 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0063#, 16#0073#, 16#0065#, 16#0062#,
             16#0063#, 16#0064#, 16#0069#, 16#0063#,
             16#0063#, 16#0061#, 16#0066#, 16#0072#,
             others => 16#0000#),
           others => <>);
   --  csebcdiccafr

   N706 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0064#, 16#006B#,
             16#006E#, 16#006F#,
             others => 16#0000#),
           others => <>);
   --  ebcdicdkno

   N707 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0063#, 16#0073#, 16#0065#, 16#0062#,
             16#0063#, 16#0064#, 16#0069#, 16#0063#,
             16#0064#, 16#006B#, 16#006E#, 16#006F#,
             others => 16#0000#),
           others => <>);
   --  csebcdicdkno

   N708 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0064#, 16#006B#,
             16#006E#, 16#006F#, 16#0061#,
             others => 16#0000#),
           others => <>);
   --  ebcdicdknoa

   N709 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0065#, 16#0062#,
             16#0063#, 16#0064#, 16#0069#, 16#0063#,
             16#0064#, 16#006B#, 16#006E#, 16#006F#,
             16#0061#,
             others => 16#0000#),
           others => <>);
   --  csebcdicdknoa

   N710 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0066#, 16#0069#,
             16#0073#, 16#0065#,
             others => 16#0000#),
           others => <>);
   --  ebcdicfise

   N711 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0063#, 16#0073#, 16#0065#, 16#0062#,
             16#0063#, 16#0064#, 16#0069#, 16#0063#,
             16#0066#, 16#0069#, 16#0073#, 16#0065#,
             others => 16#0000#),
           others => <>);
   --  csebcdicfise

   N712 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0066#, 16#0069#,
             16#0073#, 16#0065#, 16#0061#,
             others => 16#0000#),
           others => <>);
   --  ebcdicfisea

   N713 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0065#, 16#0062#,
             16#0063#, 16#0064#, 16#0069#, 16#0063#,
             16#0066#, 16#0069#, 16#0073#, 16#0065#,
             16#0061#,
             others => 16#0000#),
           others => <>);
   --  csebcdicfisea

   N714 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0066#, 16#0072#,
             others => 16#0000#),
           others => <>);
   --  ebcdicfr

   N715 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0063#, 16#0073#, 16#0065#, 16#0062#,
             16#0063#, 16#0064#, 16#0069#, 16#0063#,
             16#0066#, 16#0072#,
             others => 16#0000#),
           others => <>);
   --  csebcdicfr

   N716 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0069#, 16#0074#,
             others => 16#0000#),
           others => <>);
   --  ebcdicit

   N717 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0063#, 16#0073#, 16#0065#, 16#0062#,
             16#0063#, 16#0064#, 16#0069#, 16#0063#,
             16#0069#, 16#0074#,
             others => 16#0000#),
           others => <>);
   --  csebcdicit

   N718 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0070#, 16#0074#,
             others => 16#0000#),
           others => <>);
   --  ebcdicpt

   N719 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0063#, 16#0073#, 16#0065#, 16#0062#,
             16#0063#, 16#0064#, 16#0069#, 16#0063#,
             16#0070#, 16#0074#,
             others => 16#0000#),
           others => <>);
   --  csebcdicpt

   N720 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0065#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  ebcdices

   N721 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0063#, 16#0073#, 16#0065#, 16#0062#,
             16#0063#, 16#0064#, 16#0069#, 16#0063#,
             16#0065#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  csebcdices

   N722 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0065#, 16#0073#,
             16#0061#,
             others => 16#0000#),
           others => <>);
   --  ebcdicesa

   N723 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0065#, 16#0062#,
             16#0063#, 16#0064#, 16#0069#, 16#0063#,
             16#0065#, 16#0073#, 16#0061#,
             others => 16#0000#),
           others => <>);
   --  csebcdicesa

   N724 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0065#, 16#0073#,
             16#0073#,
             others => 16#0000#),
           others => <>);
   --  ebcdicess

   N725 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0065#, 16#0062#,
             16#0063#, 16#0064#, 16#0069#, 16#0063#,
             16#0065#, 16#0073#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  csebcdicess

   N726 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0075#, 16#006B#,
             others => 16#0000#),
           others => <>);
   --  ebcdicuk

   N727 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0063#, 16#0073#, 16#0065#, 16#0062#,
             16#0063#, 16#0064#, 16#0069#, 16#0063#,
             16#0075#, 16#006B#,
             others => 16#0000#),
           others => <>);
   --  csebcdicuk

   N728 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0075#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  ebcdicus

   N729 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0063#, 16#0073#, 16#0065#, 16#0062#,
             16#0063#, 16#0064#, 16#0069#, 16#0063#,
             16#0075#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  csebcdicus

   N730 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0075#, 16#006E#, 16#006B#, 16#006E#,
             16#006F#, 16#0077#, 16#006E#, 16#0038#,
             16#0062#, 16#0069#, 16#0074#,
             others => 16#0000#),
           others => <>);
   --  unknown8bit

   N731 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0075#, 16#006E#,
             16#006B#, 16#006E#, 16#006F#, 16#0077#,
             16#006E#, 16#0038#, 16#0062#, 16#0069#,
             16#0074#,
             others => 16#0000#),
           others => <>);
   --  csunknown8bit

   N732 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#006D#, 16#006E#, 16#0065#, 16#006D#,
             16#006F#, 16#006E#, 16#0069#, 16#0063#,
             others => 16#0000#),
           others => <>);
   --  mnemonic

   N733 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0063#, 16#0073#, 16#006D#, 16#006E#,
             16#0065#, 16#006D#, 16#006F#, 16#006E#,
             16#0069#, 16#0063#,
             others => 16#0000#),
           others => <>);
   --  csmnemonic

   N734 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 4,
         Length   => 4,
         Value    =>
            (16#006D#, 16#006E#, 16#0065#, 16#006D#,
             others => 16#0000#),
           others => <>);
   --  mnem

   N735 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0063#, 16#0073#, 16#006D#, 16#006E#,
             16#0065#, 16#006D#,
             others => 16#0000#),
           others => <>);
   --  csmnem

   N736 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0076#, 16#0069#, 16#0073#, 16#0063#,
             16#0069#, 16#0069#,
             others => 16#0000#),
           others => <>);
   --  viscii

   N737 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0076#, 16#0069#,
             16#0073#, 16#0063#, 16#0069#, 16#0069#,
             others => 16#0000#),
           others => <>);
   --  csviscii

   N738 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 4,
         Length   => 4,
         Value    =>
            (16#0076#, 16#0069#, 16#0071#, 16#0072#,
             others => 16#0000#),
           others => <>);
   --  viqr

   N739 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0063#, 16#0073#, 16#0076#, 16#0069#,
             16#0071#, 16#0072#,
             others => 16#0000#),
           others => <>);
   --  csviqr

   N740 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#006B#, 16#006F#, 16#0069#, 16#0038#,
             16#0072#,
             others => 16#0000#),
           others => <>);
   --  koi8r

   N741 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0063#, 16#0073#, 16#006B#, 16#006F#,
             16#0069#, 16#0038#, 16#0072#,
             others => 16#0000#),
           others => <>);
   --  cskoi8r

   N742 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0068#, 16#007A#, 16#0067#, 16#0062#,
             16#0032#, 16#0033#, 16#0031#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  hzgb2312

   N743 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0038#,
             16#0036#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  ibm866

   N744 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0038#, 16#0036#,
             16#0036#,
             others => 16#0000#),
           others => <>);
   --  cp866

   N745 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#0038#, 16#0036#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  866

   N746 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0038#, 16#0036#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  csibm866

   N747 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0037#,
             16#0037#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  ibm775

   N748 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0037#, 16#0037#,
             16#0035#,
             others => 16#0000#),
           others => <>);
   --  cp775

   N749 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0070#, 16#0063#,
             16#0037#, 16#0037#, 16#0035#, 16#0062#,
             16#0061#, 16#006C#, 16#0074#, 16#0069#,
             16#0063#,
             others => 16#0000#),
           others => <>);
   --  cspc775baltic

   N750 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#006B#, 16#006F#, 16#0069#, 16#0038#,
             16#0075#,
             others => 16#0000#),
           others => <>);
   --  koi8u

   N751 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0063#, 16#0073#, 16#006B#, 16#006F#,
             16#0069#, 16#0038#, 16#0075#,
             others => 16#0000#),
           others => <>);
   --  cskoi8u

   N752 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0038#,
             16#0035#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  ibm858

   N753 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0063#, 16#0073#, 16#0069#,
             16#0064#, 16#0038#, 16#0035#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  ccsid858

   N754 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0038#, 16#0035#,
             16#0038#,
             others => 16#0000#),
           others => <>);
   --  cp858

   N755 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 21,
         Length   => 21,
         Value    =>
            (16#0070#, 16#0063#, 16#006D#, 16#0075#,
             16#006C#, 16#0074#, 16#0069#, 16#006C#,
             16#0069#, 16#006E#, 16#0067#, 16#0075#,
             16#0061#, 16#006C#, 16#0038#, 16#0035#,
             16#0030#, 16#0065#, 16#0075#, 16#0072#,
             16#006F#,
             others => 16#0000#),
           others => <>);
   --  pcmultilingual850euro

   N756 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0038#, 16#0035#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  csibm858

   N757 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0039#,
             16#0032#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  ibm924

   N758 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0063#, 16#0073#, 16#0069#,
             16#0064#, 16#0039#, 16#0032#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  ccsid924

   N759 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0039#, 16#0032#,
             16#0034#,
             others => 16#0000#),
           others => <>);
   --  cp924

   N760 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 16,
         Length   => 16,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#006C#, 16#0061#,
             16#0074#, 16#0069#, 16#006E#, 16#0039#,
             16#0065#, 16#0075#, 16#0072#, 16#006F#,
             others => 16#0000#),
           others => <>);
   --  ebcdiclatin9euro

   N761 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0039#, 16#0032#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  csibm924

   N762 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0031#,
             16#0031#, 16#0034#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  ibm1140

   N763 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0063#, 16#0073#, 16#0069#,
             16#0064#, 16#0031#, 16#0031#, 16#0034#,
             16#0030#,
             others => 16#0000#),
           others => <>);
   --  ccsid1140

   N764 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0063#, 16#0070#, 16#0031#, 16#0031#,
             16#0034#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  cp1140

   N765 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 14,
         Length   => 14,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0075#, 16#0073#,
             16#0033#, 16#0037#, 16#0065#, 16#0075#,
             16#0072#, 16#006F#,
             others => 16#0000#),
           others => <>);
   --  ebcdicus37euro

   N766 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0031#, 16#0031#, 16#0034#,
             16#0030#,
             others => 16#0000#),
           others => <>);
   --  csibm1140

   N767 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0031#,
             16#0031#, 16#0034#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  ibm1141

   N768 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0063#, 16#0073#, 16#0069#,
             16#0064#, 16#0031#, 16#0031#, 16#0034#,
             16#0031#,
             others => 16#0000#),
           others => <>);
   --  ccsid1141

   N769 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0063#, 16#0070#, 16#0031#, 16#0031#,
             16#0034#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  cp1141

   N770 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 15,
         Length   => 15,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0064#, 16#0065#,
             16#0032#, 16#0037#, 16#0033#, 16#0065#,
             16#0075#, 16#0072#, 16#006F#,
             others => 16#0000#),
           others => <>);
   --  ebcdicde273euro

   N771 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0031#, 16#0031#, 16#0034#,
             16#0031#,
             others => 16#0000#),
           others => <>);
   --  csibm1141

   N772 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0031#,
             16#0031#, 16#0034#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  ibm1142

   N773 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0063#, 16#0073#, 16#0069#,
             16#0064#, 16#0031#, 16#0031#, 16#0034#,
             16#0032#,
             others => 16#0000#),
           others => <>);
   --  ccsid1142

   N774 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0063#, 16#0070#, 16#0031#, 16#0031#,
             16#0034#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  cp1142

   N775 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 15,
         Length   => 15,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0064#, 16#006B#,
             16#0032#, 16#0037#, 16#0037#, 16#0065#,
             16#0075#, 16#0072#, 16#006F#,
             others => 16#0000#),
           others => <>);
   --  ebcdicdk277euro

   N776 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 15,
         Length   => 15,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#006E#, 16#006F#,
             16#0032#, 16#0037#, 16#0037#, 16#0065#,
             16#0075#, 16#0072#, 16#006F#,
             others => 16#0000#),
           others => <>);
   --  ebcdicno277euro

   N777 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0031#, 16#0031#, 16#0034#,
             16#0032#,
             others => 16#0000#),
           others => <>);
   --  csibm1142

   N778 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0031#,
             16#0031#, 16#0034#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  ibm1143

   N779 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0063#, 16#0073#, 16#0069#,
             16#0064#, 16#0031#, 16#0031#, 16#0034#,
             16#0033#,
             others => 16#0000#),
           others => <>);
   --  ccsid1143

   N780 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0063#, 16#0070#, 16#0031#, 16#0031#,
             16#0034#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  cp1143

   N781 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 15,
         Length   => 15,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0066#, 16#0069#,
             16#0032#, 16#0037#, 16#0038#, 16#0065#,
             16#0075#, 16#0072#, 16#006F#,
             others => 16#0000#),
           others => <>);
   --  ebcdicfi278euro

   N782 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 15,
         Length   => 15,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0073#, 16#0065#,
             16#0032#, 16#0037#, 16#0038#, 16#0065#,
             16#0075#, 16#0072#, 16#006F#,
             others => 16#0000#),
           others => <>);
   --  ebcdicse278euro

   N783 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0031#, 16#0031#, 16#0034#,
             16#0033#,
             others => 16#0000#),
           others => <>);
   --  csibm1143

   N784 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0031#,
             16#0031#, 16#0034#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  ibm1144

   N785 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0063#, 16#0073#, 16#0069#,
             16#0064#, 16#0031#, 16#0031#, 16#0034#,
             16#0034#,
             others => 16#0000#),
           others => <>);
   --  ccsid1144

   N786 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0063#, 16#0070#, 16#0031#, 16#0031#,
             16#0034#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  cp1144

   N787 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 15,
         Length   => 15,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0069#, 16#0074#,
             16#0032#, 16#0038#, 16#0030#, 16#0065#,
             16#0075#, 16#0072#, 16#006F#,
             others => 16#0000#),
           others => <>);
   --  ebcdicit280euro

   N788 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0031#, 16#0031#, 16#0034#,
             16#0034#,
             others => 16#0000#),
           others => <>);
   --  csibm1144

   N789 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0031#,
             16#0031#, 16#0034#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  ibm1145

   N790 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0063#, 16#0073#, 16#0069#,
             16#0064#, 16#0031#, 16#0031#, 16#0034#,
             16#0035#,
             others => 16#0000#),
           others => <>);
   --  ccsid1145

   N791 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0063#, 16#0070#, 16#0031#, 16#0031#,
             16#0034#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  cp1145

   N792 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 15,
         Length   => 15,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0065#, 16#0073#,
             16#0032#, 16#0038#, 16#0034#, 16#0065#,
             16#0075#, 16#0072#, 16#006F#,
             others => 16#0000#),
           others => <>);
   --  ebcdices284euro

   N793 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0031#, 16#0031#, 16#0034#,
             16#0035#,
             others => 16#0000#),
           others => <>);
   --  csibm1145

   N794 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0031#,
             16#0031#, 16#0034#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  ibm1146

   N795 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0063#, 16#0073#, 16#0069#,
             16#0064#, 16#0031#, 16#0031#, 16#0034#,
             16#0036#,
             others => 16#0000#),
           others => <>);
   --  ccsid1146

   N796 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0063#, 16#0070#, 16#0031#, 16#0031#,
             16#0034#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  cp1146

   N797 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 15,
         Length   => 15,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0067#, 16#0062#,
             16#0032#, 16#0038#, 16#0035#, 16#0065#,
             16#0075#, 16#0072#, 16#006F#,
             others => 16#0000#),
           others => <>);
   --  ebcdicgb285euro

   N798 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0031#, 16#0031#, 16#0034#,
             16#0036#,
             others => 16#0000#),
           others => <>);
   --  csibm1146

   N799 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0031#,
             16#0031#, 16#0034#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  ibm1147

   N800 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0063#, 16#0073#, 16#0069#,
             16#0064#, 16#0031#, 16#0031#, 16#0034#,
             16#0037#,
             others => 16#0000#),
           others => <>);
   --  ccsid1147

   N801 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0063#, 16#0070#, 16#0031#, 16#0031#,
             16#0034#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  cp1147

   N802 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 15,
         Length   => 15,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0066#, 16#0072#,
             16#0032#, 16#0039#, 16#0037#, 16#0065#,
             16#0075#, 16#0072#, 16#006F#,
             others => 16#0000#),
           others => <>);
   --  ebcdicfr297euro

   N803 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0031#, 16#0031#, 16#0034#,
             16#0037#,
             others => 16#0000#),
           others => <>);
   --  csibm1147

   N804 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0031#,
             16#0031#, 16#0034#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  ibm1148

   N805 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0063#, 16#0073#, 16#0069#,
             16#0064#, 16#0031#, 16#0031#, 16#0034#,
             16#0038#,
             others => 16#0000#),
           others => <>);
   --  ccsid1148

   N806 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0063#, 16#0070#, 16#0031#, 16#0031#,
             16#0034#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  cp1148

   N807 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 31,
         Unused   => 26,
         Length   => 26,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0069#, 16#006E#,
             16#0074#, 16#0065#, 16#0072#, 16#006E#,
             16#0061#, 16#0074#, 16#0069#, 16#006F#,
             16#006E#, 16#0061#, 16#006C#, 16#0035#,
             16#0030#, 16#0030#, 16#0065#, 16#0075#,
             16#0072#, 16#006F#,
             others => 16#0000#),
           others => <>);
   --  ebcdicinternational500euro

   N808 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0031#, 16#0031#, 16#0034#,
             16#0038#,
             others => 16#0000#),
           others => <>);
   --  csibm1148

   N809 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0031#,
             16#0031#, 16#0034#, 16#0039#,
             others => 16#0000#),
           others => <>);
   --  ibm1149

   N810 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0063#, 16#0073#, 16#0069#,
             16#0064#, 16#0031#, 16#0031#, 16#0034#,
             16#0039#,
             others => 16#0000#),
           others => <>);
   --  ccsid1149

   N811 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0063#, 16#0070#, 16#0031#, 16#0031#,
             16#0034#, 16#0039#,
             others => 16#0000#),
           others => <>);
   --  cp1149

   N812 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 15,
         Length   => 15,
         Value    =>
            (16#0065#, 16#0062#, 16#0063#, 16#0064#,
             16#0069#, 16#0063#, 16#0069#, 16#0073#,
             16#0038#, 16#0037#, 16#0031#, 16#0065#,
             16#0075#, 16#0072#, 16#006F#,
             others => 16#0000#),
           others => <>);
   --  ebcdicis871euro

   N813 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0031#, 16#0031#, 16#0034#,
             16#0039#,
             others => 16#0000#),
           others => <>);
   --  csibm1149

   N814 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0062#, 16#0069#, 16#0067#, 16#0035#,
             16#0068#, 16#006B#, 16#0073#, 16#0063#,
             16#0073#,
             others => 16#0000#),
           others => <>);
   --  big5hkscs

   N815 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0062#, 16#0069#,
             16#0067#, 16#0035#, 16#0068#, 16#006B#,
             16#0073#, 16#0063#, 16#0073#,
             others => 16#0000#),
           others => <>);
   --  csbig5hkscs

   N816 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0069#, 16#0062#, 16#006D#, 16#0031#,
             16#0030#, 16#0034#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  ibm1047

   N817 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#0069#, 16#0062#,
             16#006D#, 16#0031#, 16#0030#, 16#0034#,
             16#0037#,
             others => 16#0000#),
           others => <>);
   --  csibm1047

   N818 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0070#, 16#0074#, 16#0063#, 16#0070#,
             16#0031#, 16#0035#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  ptcp154

   N819 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#0070#, 16#0074#,
             16#0063#, 16#0070#, 16#0031#, 16#0035#,
             16#0034#,
             others => 16#0000#),
           others => <>);
   --  csptcp154

   N820 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0070#, 16#0074#, 16#0031#, 16#0035#,
             16#0034#,
             others => 16#0000#),
           others => <>);
   --  pt154

   N821 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0070#, 16#0031#, 16#0035#,
             16#0034#,
             others => 16#0000#),
           others => <>);
   --  cp154

   N822 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0079#, 16#0072#, 16#0069#,
             16#006C#, 16#006C#, 16#0069#, 16#0063#,
             16#0061#, 16#0073#, 16#0069#, 16#0061#,
             16#006E#,
             others => 16#0000#),
           others => <>);
   --  cyrillicasian

   N823 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0061#, 16#006D#, 16#0069#, 16#0067#,
             16#0061#, 16#0031#, 16#0032#, 16#0035#,
             16#0031#,
             others => 16#0000#),
           others => <>);
   --  amiga1251

   N824 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0061#, 16#006D#, 16#0069#, 16#0031#,
             16#0032#, 16#0035#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  ami1251

   N825 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0063#, 16#0073#, 16#0061#, 16#006D#,
             16#0069#, 16#0067#, 16#0061#, 16#0031#,
             16#0032#, 16#0035#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  csamiga1251

   N826 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#006B#, 16#006F#, 16#0069#, 16#0037#,
             16#0073#, 16#0077#, 16#0069#, 16#0074#,
             16#0063#, 16#0068#, 16#0065#, 16#0064#,
             others => 16#0000#),
           others => <>);
   --  koi7switched

   N827 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 14,
         Length   => 14,
         Value    =>
            (16#0063#, 16#0073#, 16#006B#, 16#006F#,
             16#0069#, 16#0037#, 16#0073#, 16#0077#,
             16#0069#, 16#0074#, 16#0063#, 16#0068#,
             16#0065#, 16#0064#,
             others => 16#0000#),
           others => <>);
   --  cskoi7switched

   N828 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 3,
         Length   => 3,
         Value    =>
            (16#0062#, 16#0072#, 16#0066#,
             others => 16#0000#),
           others => <>);
   --  brf

   N829 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0063#, 16#0073#, 16#0062#, 16#0072#,
             16#0066#,
             others => 16#0000#),
           others => <>);
   --  csbrf

   N830 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
            (16#0074#, 16#0073#, 16#0063#, 16#0069#,
             16#0069#,
             others => 16#0000#),
           others => <>);
   --  tscii

   N831 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0063#, 16#0073#, 16#0074#, 16#0073#,
             16#0063#, 16#0069#, 16#0069#,
             others => 16#0000#),
           others => <>);
   --  cstscii

   N832 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0063#, 16#0070#, 16#0035#, 16#0031#,
             16#0039#, 16#0033#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  cp51932

   N833 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#0063#, 16#0070#,
             16#0035#, 16#0031#, 16#0039#, 16#0033#,
             16#0032#,
             others => 16#0000#),
           others => <>);
   --  cscp51932

   N834 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
            (16#0077#, 16#0069#, 16#006E#, 16#0064#,
             16#006F#, 16#0077#, 16#0073#, 16#0038#,
             16#0037#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  windows874

   N835 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
            (16#0063#, 16#0073#, 16#0077#, 16#0069#,
             16#006E#, 16#0064#, 16#006F#, 16#0077#,
             16#0073#, 16#0038#, 16#0037#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  cswindows874

   N836 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0077#, 16#0069#, 16#006E#, 16#0064#,
             16#006F#, 16#0077#, 16#0073#, 16#0031#,
             16#0032#, 16#0035#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  windows1250

   N837 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0077#, 16#0069#,
             16#006E#, 16#0064#, 16#006F#, 16#0077#,
             16#0073#, 16#0031#, 16#0032#, 16#0035#,
             16#0030#,
             others => 16#0000#),
           others => <>);
   --  cswindows1250

   N838 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0077#, 16#0069#, 16#006E#, 16#0064#,
             16#006F#, 16#0077#, 16#0073#, 16#0031#,
             16#0032#, 16#0035#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  windows1251

   N839 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0077#, 16#0069#,
             16#006E#, 16#0064#, 16#006F#, 16#0077#,
             16#0073#, 16#0031#, 16#0032#, 16#0035#,
             16#0031#,
             others => 16#0000#),
           others => <>);
   --  cswindows1251

   N840 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0063#, 16#0070#, 16#0031#, 16#0032#,
             16#0035#, 16#0031#,
             others => 16#0000#),
           others => <>);
   --  cp1251

   N841 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0077#, 16#0069#, 16#006E#, 16#0064#,
             16#006F#, 16#0077#, 16#0073#, 16#0031#,
             16#0032#, 16#0035#, 16#0032#,
             others => 16#0000#),
           others => <>);
   --  windows1252

   N842 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0077#, 16#0069#,
             16#006E#, 16#0064#, 16#006F#, 16#0077#,
             16#0073#, 16#0031#, 16#0032#, 16#0035#,
             16#0032#,
             others => 16#0000#),
           others => <>);
   --  cswindows1252

   N843 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0077#, 16#0069#, 16#006E#, 16#0064#,
             16#006F#, 16#0077#, 16#0073#, 16#0031#,
             16#0032#, 16#0035#, 16#0033#,
             others => 16#0000#),
           others => <>);
   --  windows1253

   N844 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0077#, 16#0069#,
             16#006E#, 16#0064#, 16#006F#, 16#0077#,
             16#0073#, 16#0031#, 16#0032#, 16#0035#,
             16#0033#,
             others => 16#0000#),
           others => <>);
   --  cswindows1253

   N845 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0077#, 16#0069#, 16#006E#, 16#0064#,
             16#006F#, 16#0077#, 16#0073#, 16#0031#,
             16#0032#, 16#0035#, 16#0034#,
             others => 16#0000#),
           others => <>);
   --  windows1254

   N846 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0077#, 16#0069#,
             16#006E#, 16#0064#, 16#006F#, 16#0077#,
             16#0073#, 16#0031#, 16#0032#, 16#0035#,
             16#0034#,
             others => 16#0000#),
           others => <>);
   --  cswindows1254

   N847 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0077#, 16#0069#, 16#006E#, 16#0064#,
             16#006F#, 16#0077#, 16#0073#, 16#0031#,
             16#0032#, 16#0035#, 16#0035#,
             others => 16#0000#),
           others => <>);
   --  windows1255

   N848 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0077#, 16#0069#,
             16#006E#, 16#0064#, 16#006F#, 16#0077#,
             16#0073#, 16#0031#, 16#0032#, 16#0035#,
             16#0035#,
             others => 16#0000#),
           others => <>);
   --  cswindows1255

   N849 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0077#, 16#0069#, 16#006E#, 16#0064#,
             16#006F#, 16#0077#, 16#0073#, 16#0031#,
             16#0032#, 16#0035#, 16#0036#,
             others => 16#0000#),
           others => <>);
   --  windows1256

   N850 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0077#, 16#0069#,
             16#006E#, 16#0064#, 16#006F#, 16#0077#,
             16#0073#, 16#0031#, 16#0032#, 16#0035#,
             16#0036#,
             others => 16#0000#),
           others => <>);
   --  cswindows1256

   N851 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0077#, 16#0069#, 16#006E#, 16#0064#,
             16#006F#, 16#0077#, 16#0073#, 16#0031#,
             16#0032#, 16#0035#, 16#0037#,
             others => 16#0000#),
           others => <>);
   --  windows1257

   N852 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0077#, 16#0069#,
             16#006E#, 16#0064#, 16#006F#, 16#0077#,
             16#0073#, 16#0031#, 16#0032#, 16#0035#,
             16#0037#,
             others => 16#0000#),
           others => <>);
   --  cswindows1257

   N853 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
            (16#0077#, 16#0069#, 16#006E#, 16#0064#,
             16#006F#, 16#0077#, 16#0073#, 16#0031#,
             16#0032#, 16#0035#, 16#0038#,
             others => 16#0000#),
           others => <>);
   --  windows1258

   N854 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
            (16#0063#, 16#0073#, 16#0077#, 16#0069#,
             16#006E#, 16#0064#, 16#006F#, 16#0077#,
             16#0073#, 16#0031#, 16#0032#, 16#0035#,
             16#0038#,
             others => 16#0000#),
           others => <>);
   --  cswindows1258

   N855 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
            (16#0074#, 16#0069#, 16#0073#, 16#0036#,
             16#0032#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  tis620

   N856 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
            (16#0063#, 16#0073#, 16#0074#, 16#0069#,
             16#0073#, 16#0036#, 16#0032#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  cstis620

   N857 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 7,
         Length   => 7,
         Value    =>
            (16#0063#, 16#0070#, 16#0035#, 16#0030#,
             16#0032#, 16#0032#, 16#0030#,
             others => 16#0000#),
           others => <>);
   --  cp50220

   N858 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
            (16#0063#, 16#0073#, 16#0063#, 16#0070#,
             16#0035#, 16#0030#, 16#0032#, 16#0032#,
             16#0030#,
             others => 16#0000#),
           others => <>);
   --  cscp50220

   To_MIB : constant array (Positive range <>) of IANA_Record
     := ((N1'Access, 3),
         (N2'Access, 3),
         (N3'Access, 3),
         (N4'Access, 3),
         (N5'Access, 3),
         (N6'Access, 3),
         (N7'Access, 3),
         (N8'Access, 3),
         (N9'Access, 3),
         (N10'Access, 3),
         (N11'Access, 4),
         (N12'Access, 4),
         (N13'Access, 4),
         (N14'Access, 4),
         (N15'Access, 4),
         (N16'Access, 4),
         (N17'Access, 4),
         (N18'Access, 4),
         (N19'Access, 5),
         (N20'Access, 5),
         (N21'Access, 5),
         (N22'Access, 5),
         (N23'Access, 5),
         (N24'Access, 5),
         (N25'Access, 6),
         (N26'Access, 6),
         (N27'Access, 6),
         (N28'Access, 6),
         (N29'Access, 6),
         (N30'Access, 6),
         (N31'Access, 7),
         (N32'Access, 7),
         (N33'Access, 7),
         (N34'Access, 7),
         (N35'Access, 7),
         (N36'Access, 7),
         (N37'Access, 8),
         (N38'Access, 8),
         (N39'Access, 8),
         (N40'Access, 8),
         (N41'Access, 8),
         (N42'Access, 9),
         (N43'Access, 9),
         (N44'Access, 9),
         (N45'Access, 9),
         (N46'Access, 9),
         (N47'Access, 9),
         (N48'Access, 9),
         (N49'Access, 10),
         (N50'Access, 10),
         (N51'Access, 10),
         (N52'Access, 10),
         (N53'Access, 10),
         (N54'Access, 10),
         (N55'Access, 10),
         (N56'Access, 10),
         (N57'Access, 11),
         (N58'Access, 11),
         (N59'Access, 11),
         (N60'Access, 11),
         (N61'Access, 11),
         (N62'Access, 12),
         (N63'Access, 12),
         (N64'Access, 12),
         (N65'Access, 12),
         (N66'Access, 12),
         (N67'Access, 12),
         (N68'Access, 13),
         (N69'Access, 13),
         (N70'Access, 13),
         (N71'Access, 13),
         (N72'Access, 13),
         (N73'Access, 13),
         (N74'Access, 14),
         (N75'Access, 14),
         (N76'Access, 14),
         (N77'Access, 15),
         (N78'Access, 15),
         (N79'Access, 15),
         (N80'Access, 16),
         (N81'Access, 16),
         (N82'Access, 17),
         (N83'Access, 17),
         (N84'Access, 17),
         (N85'Access, 18),
         (N86'Access, 18),
         (N87'Access, 18),
         (N88'Access, 19),
         (N89'Access, 19),
         (N90'Access, 20),
         (N91'Access, 20),
         (N92'Access, 20),
         (N93'Access, 20),
         (N94'Access, 20),
         (N95'Access, 20),
         (N96'Access, 21),
         (N97'Access, 21),
         (N98'Access, 21),
         (N99'Access, 21),
         (N100'Access, 21),
         (N101'Access, 22),
         (N102'Access, 22),
         (N103'Access, 22),
         (N104'Access, 22),
         (N105'Access, 23),
         (N106'Access, 23),
         (N107'Access, 23),
         (N108'Access, 23),
         (N109'Access, 24),
         (N110'Access, 24),
         (N111'Access, 24),
         (N112'Access, 24),
         (N113'Access, 24),
         (N114'Access, 25),
         (N115'Access, 25),
         (N116'Access, 25),
         (N117'Access, 25),
         (N118'Access, 25),
         (N119'Access, 25),
         (N120'Access, 26),
         (N121'Access, 26),
         (N122'Access, 26),
         (N123'Access, 26),
         (N124'Access, 26),
         (N125'Access, 27),
         (N126'Access, 27),
         (N127'Access, 28),
         (N128'Access, 28),
         (N129'Access, 28),
         (N130'Access, 29),
         (N131'Access, 29),
         (N132'Access, 30),
         (N133'Access, 30),
         (N134'Access, 30),
         (N135'Access, 30),
         (N136'Access, 31),
         (N137'Access, 31),
         (N138'Access, 31),
         (N139'Access, 32),
         (N140'Access, 32),
         (N141'Access, 32),
         (N142'Access, 33),
         (N143'Access, 33),
         (N144'Access, 33),
         (N145'Access, 34),
         (N146'Access, 34),
         (N147'Access, 34),
         (N148'Access, 35),
         (N149'Access, 35),
         (N150'Access, 35),
         (N151'Access, 35),
         (N152'Access, 35),
         (N153'Access, 35),
         (N154'Access, 35),
         (N155'Access, 36),
         (N156'Access, 36),
         (N157'Access, 36),
         (N158'Access, 36),
         (N159'Access, 36),
         (N160'Access, 36),
         (N161'Access, 37),
         (N162'Access, 37),
         (N163'Access, 38),
         (N164'Access, 38),
         (N165'Access, 39),
         (N166'Access, 39),
         (N167'Access, 40),
         (N168'Access, 40),
         (N169'Access, 41),
         (N170'Access, 41),
         (N171'Access, 41),
         (N172'Access, 41),
         (N173'Access, 41),
         (N174'Access, 41),
         (N175'Access, 42),
         (N176'Access, 42),
         (N177'Access, 42),
         (N178'Access, 42),
         (N179'Access, 42),
         (N180'Access, 43),
         (N181'Access, 43),
         (N182'Access, 43),
         (N183'Access, 43),
         (N184'Access, 44),
         (N185'Access, 44),
         (N186'Access, 44),
         (N187'Access, 45),
         (N188'Access, 45),
         (N189'Access, 45),
         (N190'Access, 46),
         (N191'Access, 46),
         (N192'Access, 46),
         (N193'Access, 46),
         (N194'Access, 47),
         (N195'Access, 47),
         (N196'Access, 47),
         (N197'Access, 48),
         (N198'Access, 48),
         (N199'Access, 48),
         (N200'Access, 49),
         (N201'Access, 49),
         (N202'Access, 49),
         (N203'Access, 50),
         (N204'Access, 50),
         (N205'Access, 50),
         (N206'Access, 51),
         (N207'Access, 51),
         (N208'Access, 51),
         (N209'Access, 52),
         (N210'Access, 52),
         (N211'Access, 52),
         (N212'Access, 53),
         (N213'Access, 53),
         (N214'Access, 53),
         (N215'Access, 54),
         (N216'Access, 54),
         (N217'Access, 54),
         (N218'Access, 54),
         (N219'Access, 55),
         (N220'Access, 55),
         (N221'Access, 55),
         (N222'Access, 56),
         (N223'Access, 56),
         (N224'Access, 56),
         (N225'Access, 56),
         (N226'Access, 56),
         (N227'Access, 57),
         (N228'Access, 57),
         (N229'Access, 57),
         (N230'Access, 57),
         (N231'Access, 58),
         (N232'Access, 58),
         (N233'Access, 58),
         (N234'Access, 58),
         (N235'Access, 58),
         (N236'Access, 59),
         (N237'Access, 59),
         (N238'Access, 59),
         (N239'Access, 60),
         (N240'Access, 60),
         (N241'Access, 60),
         (N242'Access, 60),
         (N243'Access, 61),
         (N244'Access, 61),
         (N245'Access, 61),
         (N246'Access, 61),
         (N247'Access, 62),
         (N248'Access, 62),
         (N249'Access, 62),
         (N250'Access, 62),
         (N251'Access, 62),
         (N252'Access, 63),
         (N253'Access, 63),
         (N254'Access, 63),
         (N255'Access, 63),
         (N256'Access, 63),
         (N257'Access, 64),
         (N258'Access, 64),
         (N259'Access, 64),
         (N260'Access, 65),
         (N261'Access, 65),
         (N262'Access, 65),
         (N263'Access, 65),
         (N264'Access, 65),
         (N265'Access, 66),
         (N266'Access, 66),
         (N267'Access, 67),
         (N268'Access, 67),
         (N269'Access, 67),
         (N270'Access, 68),
         (N271'Access, 68),
         (N272'Access, 68),
         (N273'Access, 68),
         (N274'Access, 69),
         (N275'Access, 69),
         (N276'Access, 69),
         (N277'Access, 69),
         (N278'Access, 70),
         (N279'Access, 70),
         (N280'Access, 70),
         (N281'Access, 70),
         (N282'Access, 71),
         (N283'Access, 71),
         (N284'Access, 71),
         (N285'Access, 71),
         (N286'Access, 72),
         (N287'Access, 72),
         (N288'Access, 72),
         (N289'Access, 73),
         (N290'Access, 73),
         (N291'Access, 73),
         (N292'Access, 73),
         (N293'Access, 74),
         (N294'Access, 74),
         (N295'Access, 74),
         (N296'Access, 74),
         (N297'Access, 74),
         (N298'Access, 75),
         (N299'Access, 75),
         (N300'Access, 75),
         (N301'Access, 76),
         (N302'Access, 76),
         (N303'Access, 76),
         (N304'Access, 76),
         (N305'Access, 77),
         (N306'Access, 77),
         (N307'Access, 77),
         (N308'Access, 77),
         (N309'Access, 78),
         (N310'Access, 78),
         (N311'Access, 78),
         (N312'Access, 78),
         (N313'Access, 78),
         (N314'Access, 78),
         (N315'Access, 79),
         (N316'Access, 79),
         (N317'Access, 79),
         (N318'Access, 79),
         (N319'Access, 79),
         (N320'Access, 80),
         (N321'Access, 80),
         (N322'Access, 80),
         (N323'Access, 81),
         (N324'Access, 81),
         (N325'Access, 82),
         (N326'Access, 82),
         (N327'Access, 83),
         (N328'Access, 83),
         (N329'Access, 83),
         (N330'Access, 84),
         (N331'Access, 84),
         (N332'Access, 85),
         (N333'Access, 85),
         (N334'Access, 86),
         (N335'Access, 86),
         (N336'Access, 86),
         (N337'Access, 87),
         (N338'Access, 87),
         (N339'Access, 87),
         (N340'Access, 87),
         (N341'Access, 87),
         (N342'Access, 87),
         (N343'Access, 88),
         (N344'Access, 88),
         (N345'Access, 88),
         (N346'Access, 89),
         (N347'Access, 89),
         (N348'Access, 89),
         (N349'Access, 89),
         (N350'Access, 90),
         (N351'Access, 90),
         (N352'Access, 90),
         (N353'Access, 90),
         (N354'Access, 91),
         (N355'Access, 91),
         (N356'Access, 91),
         (N357'Access, 91),
         (N358'Access, 92),
         (N359'Access, 92),
         (N360'Access, 92),
         (N361'Access, 92),
         (N362'Access, 92),
         (N363'Access, 93),
         (N364'Access, 93),
         (N365'Access, 93),
         (N366'Access, 94),
         (N367'Access, 94),
         (N368'Access, 94),
         (N369'Access, 94),
         (N370'Access, 95),
         (N371'Access, 95),
         (N372'Access, 95),
         (N373'Access, 95),
         (N374'Access, 96),
         (N375'Access, 96),
         (N376'Access, 96),
         (N377'Access, 97),
         (N378'Access, 97),
         (N379'Access, 97),
         (N380'Access, 97),
         (N381'Access, 98),
         (N382'Access, 98),
         (N383'Access, 98),
         (N384'Access, 98),
         (N385'Access, 99),
         (N386'Access, 99),
         (N387'Access, 99),
         (N388'Access, 99),
         (N389'Access, 100),
         (N390'Access, 100),
         (N391'Access, 101),
         (N392'Access, 101),
         (N393'Access, 102),
         (N394'Access, 102),
         (N395'Access, 102),
         (N396'Access, 103),
         (N397'Access, 103),
         (N398'Access, 104),
         (N399'Access, 104),
         (N400'Access, 105),
         (N401'Access, 105),
         (N402'Access, 106),
         (N403'Access, 106),
         (N404'Access, 109),
         (N405'Access, 109),
         (N406'Access, 110),
         (N407'Access, 110),
         (N408'Access, 110),
         (N409'Access, 110),
         (N410'Access, 110),
         (N411'Access, 110),
         (N412'Access, 110),
         (N413'Access, 111),
         (N414'Access, 111),
         (N415'Access, 111),
         (N416'Access, 112),
         (N417'Access, 112),
         (N418'Access, 112),
         (N419'Access, 112),
         (N420'Access, 112),
         (N421'Access, 112),
         (N422'Access, 113),
         (N423'Access, 113),
         (N424'Access, 113),
         (N425'Access, 113),
         (N426'Access, 113),
         (N427'Access, 114),
         (N428'Access, 114),
         (N429'Access, 115),
         (N430'Access, 115),
         (N431'Access, 116),
         (N432'Access, 116),
         (N433'Access, 117),
         (N434'Access, 117),
         (N435'Access, 118),
         (N436'Access, 118),
         (N437'Access, 118),
         (N438'Access, 119),
         (N439'Access, 119),
         (N440'Access, 119),
         (N441'Access, 119),
         (N442'Access, 1000),
         (N443'Access, 1000),
         (N444'Access, 1001),
         (N445'Access, 1001),
         (N446'Access, 1002),
         (N447'Access, 1002),
         (N448'Access, 1003),
         (N449'Access, 1003),
         (N450'Access, 1003),
         (N451'Access, 1004),
         (N452'Access, 1004),
         (N453'Access, 1005),
         (N454'Access, 1005),
         (N455'Access, 1006),
         (N456'Access, 1006),
         (N457'Access, 1007),
         (N458'Access, 1007),
         (N459'Access, 1008),
         (N460'Access, 1008),
         (N461'Access, 1009),
         (N462'Access, 1009),
         (N463'Access, 1010),
         (N464'Access, 1010),
         (N465'Access, 1011),
         (N466'Access, 1011),
         (N467'Access, 1012),
         (N468'Access, 1012),
         (N469'Access, 1013),
         (N470'Access, 1013),
         (N471'Access, 1014),
         (N472'Access, 1014),
         (N473'Access, 1015),
         (N474'Access, 1015),
         (N475'Access, 1016),
         (N476'Access, 1016),
         (N477'Access, 1017),
         (N478'Access, 1017),
         (N479'Access, 1018),
         (N480'Access, 1018),
         (N481'Access, 1019),
         (N482'Access, 1019),
         (N483'Access, 1020),
         (N484'Access, 1020),
         (N485'Access, 2000),
         (N486'Access, 2000),
         (N487'Access, 2001),
         (N488'Access, 2001),
         (N489'Access, 2002),
         (N490'Access, 2002),
         (N491'Access, 2003),
         (N492'Access, 2003),
         (N493'Access, 2004),
         (N494'Access, 2004),
         (N495'Access, 2004),
         (N496'Access, 2004),
         (N497'Access, 2005),
         (N498'Access, 2005),
         (N499'Access, 2006),
         (N500'Access, 2006),
         (N501'Access, 2007),
         (N502'Access, 2007),
         (N503'Access, 2008),
         (N504'Access, 2008),
         (N505'Access, 2008),
         (N506'Access, 2009),
         (N507'Access, 2009),
         (N508'Access, 2009),
         (N509'Access, 2009),
         (N510'Access, 2012),
         (N511'Access, 2012),
         (N512'Access, 2013),
         (N513'Access, 2013),
         (N514'Access, 2013),
         (N515'Access, 2013),
         (N516'Access, 2014),
         (N517'Access, 2014),
         (N518'Access, 2015),
         (N519'Access, 2015),
         (N520'Access, 2016),
         (N521'Access, 2016),
         (N522'Access, 2017),
         (N523'Access, 2017),
         (N524'Access, 2018),
         (N525'Access, 2018),
         (N526'Access, 2019),
         (N527'Access, 2019),
         (N528'Access, 2020),
         (N529'Access, 2020),
         (N530'Access, 2021),
         (N531'Access, 2021),
         (N532'Access, 2022),
         (N533'Access, 2022),
         (N534'Access, 2023),
         (N535'Access, 2023),
         (N536'Access, 2024),
         (N537'Access, 2024),
         (N538'Access, 2025),
         (N539'Access, 2025),
         (N540'Access, 2026),
         (N541'Access, 2026),
         (N542'Access, 2027),
         (N543'Access, 2027),
         (N544'Access, 2027),
         (N545'Access, 2028),
         (N546'Access, 2028),
         (N547'Access, 2028),
         (N548'Access, 2028),
         (N549'Access, 2028),
         (N550'Access, 2028),
         (N551'Access, 2028),
         (N552'Access, 2029),
         (N553'Access, 2029),
         (N554'Access, 2029),
         (N555'Access, 2029),
         (N556'Access, 2030),
         (N557'Access, 2030),
         (N558'Access, 2030),
         (N559'Access, 2031),
         (N560'Access, 2031),
         (N561'Access, 2031),
         (N562'Access, 2031),
         (N563'Access, 2032),
         (N564'Access, 2032),
         (N565'Access, 2032),
         (N566'Access, 2032),
         (N567'Access, 2033),
         (N568'Access, 2033),
         (N569'Access, 2033),
         (N570'Access, 2033),
         (N571'Access, 2034),
         (N572'Access, 2034),
         (N573'Access, 2034),
         (N574'Access, 2034),
         (N575'Access, 2034),
         (N576'Access, 2035),
         (N577'Access, 2035),
         (N578'Access, 2035),
         (N579'Access, 2035),
         (N580'Access, 2036),
         (N581'Access, 2036),
         (N582'Access, 2036),
         (N583'Access, 2036),
         (N584'Access, 2037),
         (N585'Access, 2037),
         (N586'Access, 2037),
         (N587'Access, 2037),
         (N588'Access, 2038),
         (N589'Access, 2038),
         (N590'Access, 2038),
         (N591'Access, 2038),
         (N592'Access, 2039),
         (N593'Access, 2039),
         (N594'Access, 2039),
         (N595'Access, 2039),
         (N596'Access, 2040),
         (N597'Access, 2040),
         (N598'Access, 2040),
         (N599'Access, 2040),
         (N600'Access, 2041),
         (N601'Access, 2041),
         (N602'Access, 2041),
         (N603'Access, 2041),
         (N604'Access, 2042),
         (N605'Access, 2042),
         (N606'Access, 2042),
         (N607'Access, 2042),
         (N608'Access, 2043),
         (N609'Access, 2043),
         (N610'Access, 2043),
         (N611'Access, 2043),
         (N612'Access, 2011),
         (N613'Access, 2011),
         (N614'Access, 2011),
         (N615'Access, 2011),
         (N616'Access, 2044),
         (N617'Access, 2044),
         (N618'Access, 2044),
         (N619'Access, 2044),
         (N620'Access, 2044),
         (N621'Access, 2045),
         (N622'Access, 2045),
         (N623'Access, 2045),
         (N624'Access, 2045),
         (N625'Access, 2010),
         (N626'Access, 2010),
         (N627'Access, 2010),
         (N628'Access, 2010),
         (N629'Access, 2046),
         (N630'Access, 2046),
         (N631'Access, 2046),
         (N632'Access, 2046),
         (N633'Access, 2047),
         (N634'Access, 2047),
         (N635'Access, 2047),
         (N636'Access, 2047),
         (N637'Access, 2048),
         (N638'Access, 2048),
         (N639'Access, 2048),
         (N640'Access, 2048),
         (N641'Access, 2049),
         (N642'Access, 2049),
         (N643'Access, 2049),
         (N644'Access, 2049),
         (N645'Access, 2049),
         (N646'Access, 2050),
         (N647'Access, 2050),
         (N648'Access, 2050),
         (N649'Access, 2050),
         (N650'Access, 2051),
         (N651'Access, 2051),
         (N652'Access, 2051),
         (N653'Access, 2052),
         (N654'Access, 2052),
         (N655'Access, 2052),
         (N656'Access, 2052),
         (N657'Access, 2053),
         (N658'Access, 2053),
         (N659'Access, 2053),
         (N660'Access, 2053),
         (N661'Access, 2054),
         (N662'Access, 2054),
         (N663'Access, 2054),
         (N664'Access, 2054),
         (N665'Access, 2054),
         (N666'Access, 2055),
         (N667'Access, 2055),
         (N668'Access, 2055),
         (N669'Access, 2055),
         (N670'Access, 2055),
         (N671'Access, 2056),
         (N672'Access, 2056),
         (N673'Access, 2056),
         (N674'Access, 2056),
         (N675'Access, 2057),
         (N676'Access, 2057),
         (N677'Access, 2057),
         (N678'Access, 2057),
         (N679'Access, 2058),
         (N680'Access, 2058),
         (N681'Access, 2058),
         (N682'Access, 2059),
         (N683'Access, 2059),
         (N684'Access, 2059),
         (N685'Access, 2060),
         (N686'Access, 2060),
         (N687'Access, 2060),
         (N688'Access, 2060),
         (N689'Access, 2061),
         (N690'Access, 2061),
         (N691'Access, 2061),
         (N692'Access, 2061),
         (N693'Access, 2062),
         (N694'Access, 2062),
         (N695'Access, 2062),
         (N696'Access, 2062),
         (N697'Access, 2063),
         (N698'Access, 2063),
         (N699'Access, 2063),
         (N700'Access, 2064),
         (N701'Access, 2064),
         (N702'Access, 2065),
         (N703'Access, 2065),
         (N704'Access, 2066),
         (N705'Access, 2066),
         (N706'Access, 2067),
         (N707'Access, 2067),
         (N708'Access, 2068),
         (N709'Access, 2068),
         (N710'Access, 2069),
         (N711'Access, 2069),
         (N712'Access, 2070),
         (N713'Access, 2070),
         (N714'Access, 2071),
         (N715'Access, 2071),
         (N716'Access, 2072),
         (N717'Access, 2072),
         (N718'Access, 2073),
         (N719'Access, 2073),
         (N720'Access, 2074),
         (N721'Access, 2074),
         (N722'Access, 2075),
         (N723'Access, 2075),
         (N724'Access, 2076),
         (N725'Access, 2076),
         (N726'Access, 2077),
         (N727'Access, 2077),
         (N728'Access, 2078),
         (N729'Access, 2078),
         (N730'Access, 2079),
         (N731'Access, 2079),
         (N732'Access, 2080),
         (N733'Access, 2080),
         (N734'Access, 2081),
         (N735'Access, 2081),
         (N736'Access, 2082),
         (N737'Access, 2082),
         (N738'Access, 2083),
         (N739'Access, 2083),
         (N740'Access, 2084),
         (N741'Access, 2084),
         (N742'Access, 2085),
         (N743'Access, 2086),
         (N744'Access, 2086),
         (N745'Access, 2086),
         (N746'Access, 2086),
         (N747'Access, 2087),
         (N748'Access, 2087),
         (N749'Access, 2087),
         (N750'Access, 2088),
         (N751'Access, 2088),
         (N752'Access, 2089),
         (N753'Access, 2089),
         (N754'Access, 2089),
         (N755'Access, 2089),
         (N756'Access, 2089),
         (N757'Access, 2090),
         (N758'Access, 2090),
         (N759'Access, 2090),
         (N760'Access, 2090),
         (N761'Access, 2090),
         (N762'Access, 2091),
         (N763'Access, 2091),
         (N764'Access, 2091),
         (N765'Access, 2091),
         (N766'Access, 2091),
         (N767'Access, 2092),
         (N768'Access, 2092),
         (N769'Access, 2092),
         (N770'Access, 2092),
         (N771'Access, 2092),
         (N772'Access, 2093),
         (N773'Access, 2093),
         (N774'Access, 2093),
         (N775'Access, 2093),
         (N776'Access, 2093),
         (N777'Access, 2093),
         (N778'Access, 2094),
         (N779'Access, 2094),
         (N780'Access, 2094),
         (N781'Access, 2094),
         (N782'Access, 2094),
         (N783'Access, 2094),
         (N784'Access, 2095),
         (N785'Access, 2095),
         (N786'Access, 2095),
         (N787'Access, 2095),
         (N788'Access, 2095),
         (N789'Access, 2096),
         (N790'Access, 2096),
         (N791'Access, 2096),
         (N792'Access, 2096),
         (N793'Access, 2096),
         (N794'Access, 2097),
         (N795'Access, 2097),
         (N796'Access, 2097),
         (N797'Access, 2097),
         (N798'Access, 2097),
         (N799'Access, 2098),
         (N800'Access, 2098),
         (N801'Access, 2098),
         (N802'Access, 2098),
         (N803'Access, 2098),
         (N804'Access, 2099),
         (N805'Access, 2099),
         (N806'Access, 2099),
         (N807'Access, 2099),
         (N808'Access, 2099),
         (N809'Access, 2100),
         (N810'Access, 2100),
         (N811'Access, 2100),
         (N812'Access, 2100),
         (N813'Access, 2100),
         (N814'Access, 2101),
         (N815'Access, 2101),
         (N816'Access, 2102),
         (N817'Access, 2102),
         (N818'Access, 2103),
         (N819'Access, 2103),
         (N820'Access, 2103),
         (N821'Access, 2103),
         (N822'Access, 2103),
         (N823'Access, 2104),
         (N824'Access, 2104),
         (N825'Access, 2104),
         (N826'Access, 2105),
         (N827'Access, 2105),
         (N828'Access, 2106),
         (N829'Access, 2106),
         (N830'Access, 2107),
         (N831'Access, 2107),
         (N832'Access, 2108),
         (N833'Access, 2108),
         (N834'Access, 2109),
         (N835'Access, 2109),
         (N836'Access, 2250),
         (N837'Access, 2250),
         (N838'Access, 2251),
         (N839'Access, 2251),
         (N840'Access, 2251),
         (N841'Access, 2252),
         (N842'Access, 2252),
         (N843'Access, 2253),
         (N844'Access, 2253),
         (N845'Access, 2254),
         (N846'Access, 2254),
         (N847'Access, 2255),
         (N848'Access, 2255),
         (N849'Access, 2256),
         (N850'Access, 2256),
         (N851'Access, 2257),
         (N852'Access, 2257),
         (N853'Access, 2258),
         (N854'Access, 2258),
         (N855'Access, 2259),
         (N856'Access, 2259),
         (N857'Access, 2260),
         (N858'Access, 2260));

end Matreshka.Internals.Text_Codecs.IANA_Registry;
