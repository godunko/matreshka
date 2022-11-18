------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Open Document Toolkit                           --
--                                                                          --
--                              Tools Component                             --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2014, Vadim Godunko <vgodunko@gmail.com>                     --
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
with Ada.Containers.Ordered_Maps;
with Ada.Containers.Ordered_Sets;

with League.Strings;

package ODFGen is

   type Element_Information is record
      Group            : League.Strings.Universal_String;
      Element          : League.Strings.Universal_String;
      Group_Ada_Name   : League.Strings.Universal_String;
      Element_Ada_Name : League.Strings.Universal_String;
   end record;

   function Less
    (Left  : Element_Information;
     Right : Element_Information) return Boolean;

   package Element_Sets is
     new Ada.Containers.Ordered_Sets (Element_Information, Less);

   subtype Attribute_Information is Element_Information;

   package Attribute_Sets renames Element_Sets;

   type Namespace_Information is record
      Prefix            : League.Strings.Universal_String;
      Namespace_URI     : League.Strings.Universal_String;
      Prefix_Ada_Name   : League.Strings.Universal_String;
      URI_Ada_Name      : League.Strings.Universal_String;
   end record;

   function Less
    (Left  : Namespace_Information;
     Right : Namespace_Information) return Boolean;

   package Namespace_Sets is
     new Ada.Containers.Ordered_Sets (Namespace_Information, Less);

   package Universal_String_Maps is
     new Ada.Containers.Ordered_Maps
          (League.Strings.Universal_String,
           League.Strings.Universal_String,
           League.Strings."<",
           League.Strings."=");

   Namespaces : Namespace_Sets.Set;
   Elements   : Element_Sets.Set;
   Strings    : Universal_String_Maps.Map;
   Attributes : Element_Sets.Set;

end ODFGen;
