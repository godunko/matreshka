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
with League.Calendars;

package WUI.Grid_Models is

   type Grid_Model is limited interface;
   type Grid_Model_Access is access all Grid_Model'Class
     with Storage_Size => 0;

   type Abstract_Row is limited interface;
   type Row_Access is access all Abstract_Row'Class
     with Storage_Size => 0;

   not overriding function Column_Count
    (Self   : not null access Grid_Model) return Natural is abstract;
   --  Return number of columns inside given Parent row

   not overriding function Row_Count
    (Self   : not null access Grid_Model;
     Parent : WUI.Grid_Models.Row_Access := null) return Natural is abstract;
   --  Return number of rows inside given Parent row

   not overriding function Row
    (Self   : not null access Grid_Model;
     Index  : Positive;
     Parent : WUI.Grid_Models.Row_Access := null)
       return not null WUI.Grid_Models.Row_Access is abstract;
   --  Return Index of row inside given Parent row with given row number

   not overriding function Row_Index
    (Self   : not null access Grid_Model;
     Index  : WUI.Grid_Models.Row_Access) return Positive is abstract;
   --  Return row number with given row Index

   not overriding function Parent
    (Self  : not null access Grid_Model;
     Index : not null WUI.Grid_Models.Row_Access)
       return WUI.Grid_Models.Row_Access is abstract;
   --  Return index of parent row

   type Cell_Visiter is limited interface;

   not overriding procedure String_Cell
    (Self  : not null access Cell_Visiter;
     Value : League.Strings.Universal_String) is abstract;

   not overriding procedure Integer_Cell
    (Self  : not null access Cell_Visiter;
     Value : Integer) is abstract;

   not overriding procedure Date_Time_Cell
    (Self  : not null access Cell_Visiter;
     Value : League.Calendars.Date_Time) is abstract;

   not overriding procedure Visit_Cell
    (Self    : not null access Grid_Model;
     Index   : not null WUI.Grid_Models.Row_Access;
     Column  : Positive;
     Visiter : not null access WUI.Grid_Models.Cell_Visiter'Class)
       is abstract;

   type Listener is limited interface;
   type Listener_Access is access all Listener'Class
     with Storage_Size => 0;

   not overriding procedure On_Row_Inserted
    (Self    : not null access Listener;
     Model   : not null access Grid_Model'Class;
     Index   : not null WUI.Grid_Models.Row_Access) is abstract;

   not overriding procedure On_Row_Deleted
    (Self    : not null access Listener;
     Model   : not null access Grid_Model'Class;
     Index   : not null WUI.Grid_Models.Row_Access) is abstract;

   not overriding procedure On_Row_Updated
    (Self    : not null access Listener;
     Model   : not null access Grid_Model'Class;
     Index   : not null WUI.Grid_Models.Row_Access) is abstract;

end WUI.Grid_Models;
