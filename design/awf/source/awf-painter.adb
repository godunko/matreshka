------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
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
with AWF.HTML_Writers;
with AWF.Internals.Java_Script_Registry;

package body AWF.Painter is

   use type League.Strings.Universal_String;

   ----------
   -- Draw --
   ----------

   function Draw
    (Widget : not null AWF.Internals.AWF_Widgets.AWF_Widget_Proxy_Access)
       return League.Strings.Universal_String
   is
      Writer : AWF.HTML_Writers.HTML_Writer;

   begin
      Writer.Start_HTML;
      Writer.Start_Head;
      Writer.Start_Script
       ("demo.fcgi/"
          & AWF.Internals.Java_Script_Registry.Java_Script_Resource_Path.Join
             ('/'));
      Writer.End_Script;
--   W.Start_Title;
--   W.Characters (League.Strings.To_Universal_String ("AWF Demo"));
--   W.End_Title;
      Widget.Render_Head (Writer);
      Writer.End_Head;
      Writer.Start_Body;
      Widget.Render_Body (Writer);
--   B.Draw (W);
----   W.Start_Div;
----   W.Characters (League.Strings.To_Universal_String ("Push"));
----   W.End_Div;
      Writer.End_Body;
      Writer.End_HTML;

      return Writer.Text;
   end Draw;

end AWF.Painter;
