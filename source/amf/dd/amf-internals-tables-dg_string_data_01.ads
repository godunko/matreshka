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
-- Copyright © 2010-2017, Vadim Godunko <vgodunko@gmail.com>                --
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
with Matreshka.Internals.Strings;

package AMF.Internals.Tables.DG_String_Data_01 is

   --  "LineTo"

   MS_0100 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
          (16#004C#, 16#0069#, 16#006E#, 16#0065#,
           16#0054#, 16#006F#,
           others => 16#0000#),
         others => <>);

   --  "a"

   MS_0101 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 1,
         Length   => 1,
         Value    =>
          (16#0061#,
           others => 16#0000#),
         others => <>);

   --  "a real number (>=0 and >=1) representing a ratio of the graphical element's width that is the x end point of the gradient."

   MS_0102 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 127,
         Unused   => 122,
         Length   => 122,
         Value    =>
          (16#0061#, 16#0020#, 16#0072#, 16#0065#,
           16#0061#, 16#006C#, 16#0020#, 16#006E#,
           16#0075#, 16#006D#, 16#0062#, 16#0065#,
           16#0072#, 16#0020#, 16#0028#, 16#003E#,
           16#003D#, 16#0030#, 16#0020#, 16#0061#,
           16#006E#, 16#0064#, 16#0020#, 16#003E#,
           16#003D#, 16#0031#, 16#0029#, 16#0020#,
           16#0072#, 16#0065#, 16#0070#, 16#0072#,
           16#0065#, 16#0073#, 16#0065#, 16#006E#,
           16#0074#, 16#0069#, 16#006E#, 16#0067#,
           16#0020#, 16#0061#, 16#0020#, 16#0072#,
           16#0061#, 16#0074#, 16#0069#, 16#006F#,
           16#0020#, 16#006F#, 16#0066#, 16#0020#,
           16#0074#, 16#0068#, 16#0065#, 16#0020#,
           16#0067#, 16#0072#, 16#0061#, 16#0070#,
           16#0068#, 16#0069#, 16#0063#, 16#0061#,
           16#006C#, 16#0020#, 16#0065#, 16#006C#,
           16#0065#, 16#006D#, 16#0065#, 16#006E#,
           16#0074#, 16#0027#, 16#0073#, 16#0020#,
           16#0077#, 16#0069#, 16#0064#, 16#0074#,
           16#0068#, 16#0020#, 16#0074#, 16#0068#,
           16#0061#, 16#0074#, 16#0020#, 16#0069#,
           16#0073#, 16#0020#, 16#0074#, 16#0068#,
           16#0065#, 16#0020#, 16#0078#, 16#0020#,
           16#0065#, 16#006E#, 16#0064#, 16#0020#,
           16#0070#, 16#006F#, 16#0069#, 16#006E#,
           16#0074#, 16#0020#, 16#006F#, 16#0066#,
           16#0020#, 16#0074#, 16#0068#, 16#0065#,
           16#0020#, 16#0067#, 16#0072#, 16#0061#,
           16#0064#, 16#0069#, 16#0065#, 16#006E#,
           16#0074#, 16#002E#,
           others => 16#0000#),
         others => <>);

   --  "RadialGradient is a kind of gradient that fills a graphical element by smoothly changing color values in a circle."

   MS_0103 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 119,
         Unused   => 114,
         Length   => 114,
         Value    =>
          (16#0052#, 16#0061#, 16#0064#, 16#0069#,
           16#0061#, 16#006C#, 16#0047#, 16#0072#,
           16#0061#, 16#0064#, 16#0069#, 16#0065#,
           16#006E#, 16#0074#, 16#0020#, 16#0069#,
           16#0073#, 16#0020#, 16#0061#, 16#0020#,
           16#006B#, 16#0069#, 16#006E#, 16#0064#,
           16#0020#, 16#006F#, 16#0066#, 16#0020#,
           16#0067#, 16#0072#, 16#0061#, 16#0064#,
           16#0069#, 16#0065#, 16#006E#, 16#0074#,
           16#0020#, 16#0074#, 16#0068#, 16#0061#,
           16#0074#, 16#0020#, 16#0066#, 16#0069#,
           16#006C#, 16#006C#, 16#0073#, 16#0020#,
           16#0061#, 16#0020#, 16#0067#, 16#0072#,
           16#0061#, 16#0070#, 16#0068#, 16#0069#,
           16#0063#, 16#0061#, 16#006C#, 16#0020#,
           16#0065#, 16#006C#, 16#0065#, 16#006D#,
           16#0065#, 16#006E#, 16#0074#, 16#0020#,
           16#0062#, 16#0079#, 16#0020#, 16#0073#,
           16#006D#, 16#006F#, 16#006F#, 16#0074#,
           16#0068#, 16#006C#, 16#0079#, 16#0020#,
           16#0063#, 16#0068#, 16#0061#, 16#006E#,
           16#0067#, 16#0069#, 16#006E#, 16#0067#,
           16#0020#, 16#0063#, 16#006F#, 16#006C#,
           16#006F#, 16#0072#, 16#0020#, 16#0076#,
           16#0061#, 16#006C#, 16#0075#, 16#0065#,
           16#0073#, 16#0020#, 16#0069#, 16#006E#,
           16#0020#, 16#0061#, 16#0020#, 16#0063#,
           16#0069#, 16#0072#, 16#0063#, 16#006C#,
           16#0065#, 16#002E#,
           others => 16#0000#),
         others => <>);

   --  "a list of path commands that define the geometry of the custom shape."

   MS_0104 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 71,
         Unused   => 69,
         Length   => 69,
         Value    =>
          (16#0061#, 16#0020#, 16#006C#, 16#0069#,
           16#0073#, 16#0074#, 16#0020#, 16#006F#,
           16#0066#, 16#0020#, 16#0070#, 16#0061#,
           16#0074#, 16#0068#, 16#0020#, 16#0063#,
           16#006F#, 16#006D#, 16#006D#, 16#0061#,
           16#006E#, 16#0064#, 16#0073#, 16#0020#,
           16#0074#, 16#0068#, 16#0061#, 16#0074#,
           16#0020#, 16#0064#, 16#0065#, 16#0066#,
           16#0069#, 16#006E#, 16#0065#, 16#0020#,
           16#0074#, 16#0068#, 16#0065#, 16#0020#,
           16#0067#, 16#0065#, 16#006F#, 16#006D#,
           16#0065#, 16#0074#, 16#0072#, 16#0079#,
           16#0020#, 16#006F#, 16#0066#, 16#0020#,
           16#0074#, 16#0068#, 16#0065#, 16#0020#,
           16#0063#, 16#0075#, 16#0073#, 16#0074#,
           16#006F#, 16#006D#, 16#0020#, 16#0073#,
           16#0068#, 16#0061#, 16#0070#, 16#0065#,
           16#002E#,
           others => 16#0000#),
         others => <>);

   --  "a real number (>=0 and <=1) representing the opacity of the stroke used for a graphical element. A value of 0 means totally transparent, while a value of 1 means totally opaque. The default is 1."

   MS_0105 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 207,
         Unused   => 195,
         Length   => 195,
         Value    =>
          (16#0061#, 16#0020#, 16#0072#, 16#0065#,
           16#0061#, 16#006C#, 16#0020#, 16#006E#,
           16#0075#, 16#006D#, 16#0062#, 16#0065#,
           16#0072#, 16#0020#, 16#0028#, 16#003E#,
           16#003D#, 16#0030#, 16#0020#, 16#0061#,
           16#006E#, 16#0064#, 16#0020#, 16#003C#,
           16#003D#, 16#0031#, 16#0029#, 16#0020#,
           16#0072#, 16#0065#, 16#0070#, 16#0072#,
           16#0065#, 16#0073#, 16#0065#, 16#006E#,
           16#0074#, 16#0069#, 16#006E#, 16#0067#,
           16#0020#, 16#0074#, 16#0068#, 16#0065#,
           16#0020#, 16#006F#, 16#0070#, 16#0061#,
           16#0063#, 16#0069#, 16#0074#, 16#0079#,
           16#0020#, 16#006F#, 16#0066#, 16#0020#,
           16#0074#, 16#0068#, 16#0065#, 16#0020#,
           16#0073#, 16#0074#, 16#0072#, 16#006F#,
           16#006B#, 16#0065#, 16#0020#, 16#0075#,
           16#0073#, 16#0065#, 16#0064#, 16#0020#,
           16#0066#, 16#006F#, 16#0072#, 16#0020#,
           16#0061#, 16#0020#, 16#0067#, 16#0072#,
           16#0061#, 16#0070#, 16#0068#, 16#0069#,
           16#0063#, 16#0061#, 16#006C#, 16#0020#,
           16#0065#, 16#006C#, 16#0065#, 16#006D#,
           16#0065#, 16#006E#, 16#0074#, 16#002E#,
           16#0020#, 16#0041#, 16#0020#, 16#0076#,
           16#0061#, 16#006C#, 16#0075#, 16#0065#,
           16#0020#, 16#006F#, 16#0066#, 16#0020#,
           16#0030#, 16#0020#, 16#006D#, 16#0065#,
           16#0061#, 16#006E#, 16#0073#, 16#0020#,
           16#0074#, 16#006F#, 16#0074#, 16#0061#,
           16#006C#, 16#006C#, 16#0079#, 16#0020#,
           16#0074#, 16#0072#, 16#0061#, 16#006E#,
           16#0073#, 16#0070#, 16#0061#, 16#0072#,
           16#0065#, 16#006E#, 16#0074#, 16#002C#,
           16#0020#, 16#0077#, 16#0068#, 16#0069#,
           16#006C#, 16#0065#, 16#0020#, 16#0061#,
           16#0020#, 16#0076#, 16#0061#, 16#006C#,
           16#0075#, 16#0065#, 16#0020#, 16#006F#,
           16#0066#, 16#0020#, 16#0031#, 16#0020#,
           16#006D#, 16#0065#, 16#0061#, 16#006E#,
           16#0073#, 16#0020#, 16#0074#, 16#006F#,
           16#0074#, 16#0061#, 16#006C#, 16#006C#,
           16#0079#, 16#0020#, 16#006F#, 16#0070#,
           16#0061#, 16#0071#, 16#0075#, 16#0065#,
           16#002E#, 16#0020#, 16#0054#, 16#0068#,
           16#0065#, 16#0020#, 16#0064#, 16#0065#,
           16#0066#, 16#0061#, 16#0075#, 16#006C#,
           16#0074#, 16#0020#, 16#0069#, 16#0073#,
           16#0020#, 16#0031#, 16#002E#,
           others => 16#0000#),
         others => <>);

   --  "a reference to a fill that is used to paint the enclosed regions of a graphical element. A fill value is exclusive with a fillColor value. If both are specified, the fill value is used. If none is specified, no fill is applied (i.e. the element becomes see-through)."

   MS_0106 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 279,
         Unused   => 266,
         Length   => 266,
         Value    =>
          (16#0061#, 16#0020#, 16#0072#, 16#0065#,
           16#0066#, 16#0065#, 16#0072#, 16#0065#,
           16#006E#, 16#0063#, 16#0065#, 16#0020#,
           16#0074#, 16#006F#, 16#0020#, 16#0061#,
           16#0020#, 16#0066#, 16#0069#, 16#006C#,
           16#006C#, 16#0020#, 16#0074#, 16#0068#,
           16#0061#, 16#0074#, 16#0020#, 16#0069#,
           16#0073#, 16#0020#, 16#0075#, 16#0073#,
           16#0065#, 16#0064#, 16#0020#, 16#0074#,
           16#006F#, 16#0020#, 16#0070#, 16#0061#,
           16#0069#, 16#006E#, 16#0074#, 16#0020#,
           16#0074#, 16#0068#, 16#0065#, 16#0020#,
           16#0065#, 16#006E#, 16#0063#, 16#006C#,
           16#006F#, 16#0073#, 16#0065#, 16#0064#,
           16#0020#, 16#0072#, 16#0065#, 16#0067#,
           16#0069#, 16#006F#, 16#006E#, 16#0073#,
           16#0020#, 16#006F#, 16#0066#, 16#0020#,
           16#0061#, 16#0020#, 16#0067#, 16#0072#,
           16#0061#, 16#0070#, 16#0068#, 16#0069#,
           16#0063#, 16#0061#, 16#006C#, 16#0020#,
           16#0065#, 16#006C#, 16#0065#, 16#006D#,
           16#0065#, 16#006E#, 16#0074#, 16#002E#,
           16#0020#, 16#0041#, 16#0020#, 16#0066#,
           16#0069#, 16#006C#, 16#006C#, 16#0020#,
           16#0076#, 16#0061#, 16#006C#, 16#0075#,
           16#0065#, 16#0020#, 16#0069#, 16#0073#,
           16#0020#, 16#0065#, 16#0078#, 16#0063#,
           16#006C#, 16#0075#, 16#0073#, 16#0069#,
           16#0076#, 16#0065#, 16#0020#, 16#0077#,
           16#0069#, 16#0074#, 16#0068#, 16#0020#,
           16#0061#, 16#0020#, 16#0066#, 16#0069#,
           16#006C#, 16#006C#, 16#0043#, 16#006F#,
           16#006C#, 16#006F#, 16#0072#, 16#0020#,
           16#0076#, 16#0061#, 16#006C#, 16#0075#,
           16#0065#, 16#002E#, 16#0020#, 16#0049#,
           16#0066#, 16#0020#, 16#0062#, 16#006F#,
           16#0074#, 16#0068#, 16#0020#, 16#0061#,
           16#0072#, 16#0065#, 16#0020#, 16#0073#,
           16#0070#, 16#0065#, 16#0063#, 16#0069#,
           16#0066#, 16#0069#, 16#0065#, 16#0064#,
           16#002C#, 16#0020#, 16#0074#, 16#0068#,
           16#0065#, 16#0020#, 16#0066#, 16#0069#,
           16#006C#, 16#006C#, 16#0020#, 16#0076#,
           16#0061#, 16#006C#, 16#0075#, 16#0065#,
           16#0020#, 16#0069#, 16#0073#, 16#0020#,
           16#0075#, 16#0073#, 16#0065#, 16#0064#,
           16#002E#, 16#0020#, 16#0049#, 16#0066#,
           16#0020#, 16#006E#, 16#006F#, 16#006E#,
           16#0065#, 16#0020#, 16#0069#, 16#0073#,
           16#0020#, 16#0073#, 16#0070#, 16#0065#,
           16#0063#, 16#0069#, 16#0066#, 16#0069#,
           16#0065#, 16#0064#, 16#002C#, 16#0020#,
           16#006E#, 16#006F#, 16#0020#, 16#0066#,
           16#0069#, 16#006C#, 16#006C#, 16#0020#,
           16#0069#, 16#0073#, 16#0020#, 16#0061#,
           16#0070#, 16#0070#, 16#006C#, 16#0069#,
           16#0065#, 16#0064#, 16#0020#, 16#0028#,
           16#0069#, 16#002E#, 16#0065#, 16#002E#,
           16#0020#, 16#0074#, 16#0068#, 16#0065#,
           16#0020#, 16#0065#, 16#006C#, 16#0065#,
           16#006D#, 16#0065#, 16#006E#, 16#0074#,
           16#0020#, 16#0062#, 16#0065#, 16#0063#,
           16#006F#, 16#006D#, 16#0065#, 16#0073#,
           16#0020#, 16#0073#, 16#0065#, 16#0065#,
           16#002D#, 16#0074#, 16#0068#, 16#0072#,
           16#006F#, 16#0075#, 16#0067#, 16#0068#,
           16#0029#, 16#002E#,
           others => 16#0000#),
         others => <>);

   --  "packagedFill"

   MS_0107 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
          (16#0070#, 16#0061#, 16#0063#, 16#006B#,
           16#0061#, 16#0067#, 16#0065#, 16#0064#,
           16#0046#, 16#0069#, 16#006C#, 16#006C#,
           others => 16#0000#),
         others => <>);

   --  "packagedStyle"

   MS_0108 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 13,
         Length   => 13,
         Value    =>
          (16#0070#, 16#0061#, 16#0063#, 16#006B#,
           16#0061#, 16#0067#, 16#0065#, 16#0064#,
           16#0053#, 16#0074#, 16#0079#, 16#006C#,
           16#0065#,
           others => 16#0000#),
         others => <>);

   --  "Group defines a group of graphical elements that can be styled, clipped and/or transformed together."

   MS_0109 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 103,
         Unused   => 100,
         Length   => 100,
         Value    =>
          (16#0047#, 16#0072#, 16#006F#, 16#0075#,
           16#0070#, 16#0020#, 16#0064#, 16#0065#,
           16#0066#, 16#0069#, 16#006E#, 16#0065#,
           16#0073#, 16#0020#, 16#0061#, 16#0020#,
           16#0067#, 16#0072#, 16#006F#, 16#0075#,
           16#0070#, 16#0020#, 16#006F#, 16#0066#,
           16#0020#, 16#0067#, 16#0072#, 16#0061#,
           16#0070#, 16#0068#, 16#0069#, 16#0063#,
           16#0061#, 16#006C#, 16#0020#, 16#0065#,
           16#006C#, 16#0065#, 16#006D#, 16#0065#,
           16#006E#, 16#0074#, 16#0073#, 16#0020#,
           16#0074#, 16#0068#, 16#0061#, 16#0074#,
           16#0020#, 16#0063#, 16#0061#, 16#006E#,
           16#0020#, 16#0062#, 16#0065#, 16#0020#,
           16#0073#, 16#0074#, 16#0079#, 16#006C#,
           16#0065#, 16#0064#, 16#002C#, 16#0020#,
           16#0063#, 16#006C#, 16#0069#, 16#0070#,
           16#0070#, 16#0065#, 16#0064#, 16#0020#,
           16#0061#, 16#006E#, 16#0064#, 16#002F#,
           16#006F#, 16#0072#, 16#0020#, 16#0074#,
           16#0072#, 16#0061#, 16#006E#, 16#0073#,
           16#0066#, 16#006F#, 16#0072#, 16#006D#,
           16#0065#, 16#0064#, 16#0020#, 16#0074#,
           16#006F#, 16#0067#, 16#0065#, 16#0074#,
           16#0068#, 16#0065#, 16#0072#, 16#002E#,
           others => 16#0000#),
         others => <>);

   --  "command"

   MS_010A : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 7,
         Length   => 7,
         Value    =>
          (16#0063#, 16#006F#, 16#006D#, 16#006D#,
           16#0061#, 16#006E#, 16#0064#,
           others => 16#0000#),
         others => <>);

   --  "angle"

   MS_010B : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
          (16#0061#, 16#006E#, 16#0067#, 16#006C#,
           16#0065#,
           others => 16#0000#),
         others => <>);

   --  "Canvas"

   MS_010C : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
          (16#0043#, 16#0061#, 16#006E#, 16#0076#,
           16#0061#, 16#0073#,
           others => 16#0000#),
         others => <>);

   --  "fill"

   MS_010D : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 4,
         Length   => 4,
         Value    =>
          (16#0066#, 16#0069#, 16#006C#, 16#006C#,
           others => 16#0000#),
         others => <>);

   --  "a real number (>=0 and >=1) representing a ratio of the graphical element's height that is the y end point of the gradient."

   MS_010E : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 127,
         Unused   => 123,
         Length   => 123,
         Value    =>
          (16#0061#, 16#0020#, 16#0072#, 16#0065#,
           16#0061#, 16#006C#, 16#0020#, 16#006E#,
           16#0075#, 16#006D#, 16#0062#, 16#0065#,
           16#0072#, 16#0020#, 16#0028#, 16#003E#,
           16#003D#, 16#0030#, 16#0020#, 16#0061#,
           16#006E#, 16#0064#, 16#0020#, 16#003E#,
           16#003D#, 16#0031#, 16#0029#, 16#0020#,
           16#0072#, 16#0065#, 16#0070#, 16#0072#,
           16#0065#, 16#0073#, 16#0065#, 16#006E#,
           16#0074#, 16#0069#, 16#006E#, 16#0067#,
           16#0020#, 16#0061#, 16#0020#, 16#0072#,
           16#0061#, 16#0074#, 16#0069#, 16#006F#,
           16#0020#, 16#006F#, 16#0066#, 16#0020#,
           16#0074#, 16#0068#, 16#0065#, 16#0020#,
           16#0067#, 16#0072#, 16#0061#, 16#0070#,
           16#0068#, 16#0069#, 16#0063#, 16#0061#,
           16#006C#, 16#0020#, 16#0065#, 16#006C#,
           16#0065#, 16#006D#, 16#0065#, 16#006E#,
           16#0074#, 16#0027#, 16#0073#, 16#0020#,
           16#0068#, 16#0065#, 16#0069#, 16#0067#,
           16#0068#, 16#0074#, 16#0020#, 16#0074#,
           16#0068#, 16#0061#, 16#0074#, 16#0020#,
           16#0069#, 16#0073#, 16#0020#, 16#0074#,
           16#0068#, 16#0065#, 16#0020#, 16#0079#,
           16#0020#, 16#0065#, 16#006E#, 16#0064#,
           16#0020#, 16#0070#, 16#006F#, 16#0069#,
           16#006E#, 16#0074#, 16#0020#, 16#006F#,
           16#0066#, 16#0020#, 16#0074#, 16#0068#,
           16#0065#, 16#0020#, 16#0067#, 16#0072#,
           16#0061#, 16#0064#, 16#0069#, 16#0065#,
           16#006E#, 16#0074#, 16#002E#,
           others => 16#0000#),
         others => <>);

   --  "A_startMarker_markedElement"

   MS_010F : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 31,
         Unused   => 27,
         Length   => 27,
         Value    =>
          (16#0041#, 16#005F#, 16#0073#, 16#0074#,
           16#0061#, 16#0072#, 16#0074#, 16#004D#,
           16#0061#, 16#0072#, 16#006B#, 16#0065#,
           16#0072#, 16#005F#, 16#006D#, 16#0061#,
           16#0072#, 16#006B#, 16#0065#, 16#0064#,
           16#0045#, 16#006C#, 16#0065#, 16#006D#,
           16#0065#, 16#006E#, 16#0074#,
           others => 16#0000#),
         others => <>);

   --  "Rotate"

   MS_0110 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
          (16#0052#, 16#006F#, 16#0074#, 16#0061#,
           16#0074#, 16#0065#,
           others => 16#0000#),
         others => <>);

   --  "the center point of the circle in the x-y coordinate system."

   MS_0111 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 63,
         Unused   => 60,
         Length   => 60,
         Value    =>
          (16#0074#, 16#0068#, 16#0065#, 16#0020#,
           16#0063#, 16#0065#, 16#006E#, 16#0074#,
           16#0065#, 16#0072#, 16#0020#, 16#0070#,
           16#006F#, 16#0069#, 16#006E#, 16#0074#,
           16#0020#, 16#006F#, 16#0066#, 16#0020#,
           16#0074#, 16#0068#, 16#0065#, 16#0020#,
           16#0063#, 16#0069#, 16#0072#, 16#0063#,
           16#006C#, 16#0065#, 16#0020#, 16#0069#,
           16#006E#, 16#0020#, 16#0074#, 16#0068#,
           16#0065#, 16#0020#, 16#0078#, 16#002D#,
           16#0079#, 16#0020#, 16#0063#, 16#006F#,
           16#006F#, 16#0072#, 16#0064#, 16#0069#,
           16#006E#, 16#0061#, 16#0074#, 16#0065#,
           16#0020#, 16#0073#, 16#0079#, 16#0073#,
           16#0074#, 16#0065#, 16#006D#, 16#002E#,
           others => 16#0000#),
         others => <>);

   --  "scale factors cannot be negative."

   MS_0112 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 39,
         Unused   => 33,
         Length   => 33,
         Value    =>
          (16#0073#, 16#0063#, 16#0061#, 16#006C#,
           16#0065#, 16#0020#, 16#0066#, 16#0061#,
           16#0063#, 16#0074#, 16#006F#, 16#0072#,
           16#0073#, 16#0020#, 16#0063#, 16#0061#,
           16#006E#, 16#006E#, 16#006F#, 16#0074#,
           16#0020#, 16#0062#, 16#0065#, 16#0020#,
           16#006E#, 16#0065#, 16#0067#, 16#0061#,
           16#0074#, 16#0069#, 16#0076#, 16#0065#,
           16#002E#,
           others => 16#0000#),
         others => <>);

   --  "A_clipPath_clippedElement"

   MS_0113 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 31,
         Unused   => 25,
         Length   => 25,
         Value    =>
          (16#0041#, 16#005F#, 16#0063#, 16#006C#,
           16#0069#, 16#0070#, 16#0050#, 16#0061#,
           16#0074#, 16#0068#, 16#005F#, 16#0063#,
           16#006C#, 16#0069#, 16#0070#, 16#0070#,
           16#0065#, 16#0064#, 16#0045#, 16#006C#,
           16#0065#, 16#006D#, 16#0065#, 16#006E#,
           16#0074#,
           others => 16#0000#),
         others => <>);

   --  "backgroundFill"

   MS_0114 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 14,
         Length   => 14,
         Value    =>
          (16#0062#, 16#0061#, 16#0063#, 16#006B#,
           16#0067#, 16#0072#, 16#006F#, 16#0075#,
           16#006E#, 16#0064#, 16#0046#, 16#0069#,
           16#006C#, 16#006C#,
           others => 16#0000#),
         others => <>);

   --  "a list of locally-owned styles for this graphical element."

   MS_0115 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 63,
         Unused   => 58,
         Length   => 58,
         Value    =>
          (16#0061#, 16#0020#, 16#006C#, 16#0069#,
           16#0073#, 16#0074#, 16#0020#, 16#006F#,
           16#0066#, 16#0020#, 16#006C#, 16#006F#,
           16#0063#, 16#0061#, 16#006C#, 16#006C#,
           16#0079#, 16#002D#, 16#006F#, 16#0077#,
           16#006E#, 16#0065#, 16#0064#, 16#0020#,
           16#0073#, 16#0074#, 16#0079#, 16#006C#,
           16#0065#, 16#0073#, 16#0020#, 16#0066#,
           16#006F#, 16#0072#, 16#0020#, 16#0074#,
           16#0068#, 16#0069#, 16#0073#, 16#0020#,
           16#0067#, 16#0072#, 16#0061#, 16#0070#,
           16#0068#, 16#0069#, 16#0063#, 16#0061#,
           16#006C#, 16#0020#, 16#0065#, 16#006C#,
           16#0065#, 16#006D#, 16#0065#, 16#006E#,
           16#0074#, 16#002E#,
           others => 16#0000#),
         others => <>);

   --  "a set of styles packaged by the canvas and referenced by graphical elements in the canvas as shared styles."

   MS_0116 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 111,
         Unused   => 107,
         Length   => 107,
         Value    =>
          (16#0061#, 16#0020#, 16#0073#, 16#0065#,
           16#0074#, 16#0020#, 16#006F#, 16#0066#,
           16#0020#, 16#0073#, 16#0074#, 16#0079#,
           16#006C#, 16#0065#, 16#0073#, 16#0020#,
           16#0070#, 16#0061#, 16#0063#, 16#006B#,
           16#0061#, 16#0067#, 16#0065#, 16#0064#,
           16#0020#, 16#0062#, 16#0079#, 16#0020#,
           16#0074#, 16#0068#, 16#0065#, 16#0020#,
           16#0063#, 16#0061#, 16#006E#, 16#0076#,
           16#0061#, 16#0073#, 16#0020#, 16#0061#,
           16#006E#, 16#0064#, 16#0020#, 16#0072#,
           16#0065#, 16#0066#, 16#0065#, 16#0072#,
           16#0065#, 16#006E#, 16#0063#, 16#0065#,
           16#0064#, 16#0020#, 16#0062#, 16#0079#,
           16#0020#, 16#0067#, 16#0072#, 16#0061#,
           16#0070#, 16#0068#, 16#0069#, 16#0063#,
           16#0061#, 16#006C#, 16#0020#, 16#0065#,
           16#006C#, 16#0065#, 16#006D#, 16#0065#,
           16#006E#, 16#0074#, 16#0073#, 16#0020#,
           16#0069#, 16#006E#, 16#0020#, 16#0074#,
           16#0068#, 16#0065#, 16#0020#, 16#0063#,
           16#0061#, 16#006E#, 16#0076#, 16#0061#,
           16#0073#, 16#0020#, 16#0061#, 16#0073#,
           16#0020#, 16#0073#, 16#0068#, 16#0061#,
           16#0072#, 16#0065#, 16#0064#, 16#0020#,
           16#0073#, 16#0074#, 16#0079#, 16#006C#,
           16#0065#, 16#0073#, 16#002E#,
           others => 16#0000#),
         others => <>);

   --  "backgroundColor"

   MS_0117 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 15,
         Length   => 15,
         Value    =>
          (16#0062#, 16#0061#, 16#0063#, 16#006B#,
           16#0067#, 16#0072#, 16#006F#, 16#0075#,
           16#006E#, 16#0064#, 16#0043#, 16#006F#,
           16#006C#, 16#006F#, 16#0072#,
           others => 16#0000#),
         others => <>);

   --  "f"

   MS_0118 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 1,
         Length   => 1,
         Value    =>
          (16#0066#,
           others => 16#0000#),
         others => <>);

   --  "fontItalic"

   MS_0119 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 10,
         Length   => 10,
         Value    =>
          (16#0066#, 16#006F#, 16#006E#, 16#0074#,
           16#0049#, 16#0074#, 16#0061#, 16#006C#,
           16#0069#, 16#0063#,
           others => 16#0000#),
         others => <>);

   --  "valid_focus_point"

   MS_011A : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 17,
         Length   => 17,
         Value    =>
          (16#0076#, 16#0061#, 16#006C#, 16#0069#,
           16#0064#, 16#005F#, 16#0066#, 16#006F#,
           16#0063#, 16#0075#, 16#0073#, 16#005F#,
           16#0070#, 16#006F#, 16#0069#, 16#006E#,
           16#0074#,
           others => 16#0000#),
         others => <>);

   --  "ClosePath"

   MS_011B : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 9,
         Length   => 9,
         Value    =>
          (16#0043#, 16#006C#, 16#006F#, 16#0073#,
           16#0065#, 16#0050#, 16#0061#, 16#0074#,
           16#0068#,
           others => 16#0000#),
         others => <>);

   --  "strokeDashLength"

   MS_011C : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 23,
         Unused   => 16,
         Length   => 16,
         Value    =>
          (16#0073#, 16#0074#, 16#0072#, 16#006F#,
           16#006B#, 16#0065#, 16#0044#, 16#0061#,
           16#0073#, 16#0068#, 16#004C#, 16#0065#,
           16#006E#, 16#0067#, 16#0074#, 16#0068#,
           others => 16#0000#),
         others => <>);

   --  "member"

   MS_011D : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 6,
         Length   => 6,
         Value    =>
          (16#006D#, 16#0065#, 16#006D#, 16#0062#,
           16#0065#, 16#0072#,
           others => 16#0000#),
         others => <>);

   --  "CubicCurveTo"

   MS_011E : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 12,
         Length   => 12,
         Value    =>
          (16#0043#, 16#0075#, 16#0062#, 16#0069#,
           16#0063#, 16#0043#, 16#0075#, 16#0072#,
           16#0076#, 16#0065#, 16#0054#, 16#006F#,
           others => 16#0000#),
         others => <>);

   --  "Gradient"

   MS_011F : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 8,
         Length   => 8,
         Value    =>
          (16#0047#, 16#0072#, 16#0061#, 16#0064#,
           16#0069#, 16#0065#, 16#006E#, 16#0074#,
           others => 16#0000#),
         others => <>);

   --  "startMarker"

   MS_0120 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 15,
         Unused   => 11,
         Length   => 11,
         Value    =>
          (16#0073#, 16#0074#, 16#0061#, 16#0072#,
           16#0074#, 16#004D#, 16#0061#, 16#0072#,
           16#006B#, 16#0065#, 16#0072#,
           others => 16#0000#),
         others => <>);

   --  "0"

   MS_0121 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 1,
         Length   => 1,
         Value    =>
          (16#0030#,
           others => 16#0000#),
         others => <>);

   --  "Group"

   MS_0122 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 7,
         Unused   => 5,
         Length   => 5,
         Value    =>
          (16#0047#, 16#0072#, 16#006F#, 16#0075#,
           16#0070#,
           others => 16#0000#),
         others => <>);

   --  "a real number (>=0 and<=1) representing the offset of this gradient stop as a ratio of the distance between the start and end positions of the gradient."

   MS_0123 : aliased Matreshka.Internals.Strings.Shared_String
     := (Capacity => 159,
         Unused   => 152,
         Length   => 152,
         Value    =>
          (16#0061#, 16#0020#, 16#0072#, 16#0065#,
           16#0061#, 16#006C#, 16#0020#, 16#006E#,
           16#0075#, 16#006D#, 16#0062#, 16#0065#,
           16#0072#, 16#0020#, 16#0028#, 16#003E#,
           16#003D#, 16#0030#, 16#0020#, 16#0061#,
           16#006E#, 16#0064#, 16#003C#, 16#003D#,
           16#0031#, 16#0029#, 16#0020#, 16#0072#,
           16#0065#, 16#0070#, 16#0072#, 16#0065#,
           16#0073#, 16#0065#, 16#006E#, 16#0074#,
           16#0069#, 16#006E#, 16#0067#, 16#0020#,
           16#0074#, 16#0068#, 16#0065#, 16#0020#,
           16#006F#, 16#0066#, 16#0066#, 16#0073#,
           16#0065#, 16#0074#, 16#0020#, 16#006F#,
           16#0066#, 16#0020#, 16#0074#, 16#0068#,
           16#0069#, 16#0073#, 16#0020#, 16#0067#,
           16#0072#, 16#0061#, 16#0064#, 16#0069#,
           16#0065#, 16#006E#, 16#0074#, 16#0020#,
           16#0073#, 16#0074#, 16#006F#, 16#0070#,
           16#0020#, 16#0061#, 16#0073#, 16#0020#,
           16#0061#, 16#0020#, 16#0072#, 16#0061#,
           16#0074#, 16#0069#, 16#006F#, 16#0020#,
           16#006F#, 16#0066#, 16#0020#, 16#0074#,
           16#0068#, 16#0065#, 16#0020#, 16#0064#,
           16#0069#, 16#0073#, 16#0074#, 16#0061#,
           16#006E#, 16#0063#, 16#0065#, 16#0020#,
           16#0062#, 16#0065#, 16#0074#, 16#0077#,
           16#0065#, 16#0065#, 16#006E#, 16#0020#,
           16#0074#, 16#0068#, 16#0065#, 16#0020#,
           16#0073#, 16#0074#, 16#0061#, 16#0072#,
           16#0074#, 16#0020#, 16#0061#, 16#006E#,
           16#0064#, 16#0020#, 16#0065#, 16#006E#,
           16#0064#, 16#0020#, 16#0070#, 16#006F#,
           16#0073#, 16#0069#, 16#0074#, 16#0069#,
           16#006F#, 16#006E#, 16#0073#, 16#0020#,
           16#006F#, 16#0066#, 16#0020#, 16#0074#,
           16#0068#, 16#0065#, 16#0020#, 16#0067#,
           16#0072#, 16#0061#, 16#0064#, 16#0069#,
           16#0065#, 16#006E#, 16#0074#, 16#002E#,
           others => 16#0000#),
         others => <>);

end AMF.Internals.Tables.DG_String_Data_01;
