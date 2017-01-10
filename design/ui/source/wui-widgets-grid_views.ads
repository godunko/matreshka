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
-- Copyright © 2016-2017, Vadim Godunko <vgodunko@gmail.com>                --
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
with League.Strings;

with WUI.Grid_Models;

with WebAPI.DOM.Documents;
with WebAPI.DOM.Elements;
with WebAPI.HTML.Elements;

package WUI.Widgets.Grid_Views is

   type Grid_View is new WUI.Widgets.Abstract_Widget with private;

   type Grid_View_Access is access all Grid_View'Class;

   type Grid_Header is limited interface;
   type Grid_Header_Access is access all Grid_Header'Class;

   not overriding function Text
    (Self   : not null access Grid_Header;
     Column : Positive) return League.Strings.Universal_String is abstract;

   not overriding function Width
    (Self   : not null access Grid_Header;
     Column : Positive) return Natural is abstract;

   type Align is (Left, Center, Right);

   not overriding function Text_Align
    (Self   : not null access Grid_Header;
     Column : Positive) return WUI.Widgets.Grid_Views.Align is abstract;

   not overriding procedure Set_Model
    (Self   : in out Grid_View;
     Header : not null WUI.Widgets.Grid_Views.Grid_Header_Access;
     Model  : not null WUI.Grid_Models.Grid_Model_Access);

   package Constructors is

      procedure Initialize
       (Self    : in out Grid_View'Class;
        Parent  : not null access WUI.Widgets.Abstract_Widget'Class);

   end Constructors;

private

   type Grid_View is new WUI.Widgets.Abstract_Widget with record
      Document : WebAPI.DOM.Documents.Document_Access;
      Header   : WebAPI.DOM.Elements.Element_Access;
      Data     : WebAPI.DOM.Elements.Element_Access;
   end record;

end WUI.Widgets.Grid_Views;
