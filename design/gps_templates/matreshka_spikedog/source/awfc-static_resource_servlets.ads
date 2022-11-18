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
-- Copyright © 2015-2017, Vadim Godunko <vgodunko@gmail.com>                --
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
--  $Revision: 5612 $ $Date: 2016-09-04 12:58:00 +0300 (Вс, 04 сен 2016) $
------------------------------------------------------------------------------
--  This servlet can be used to return static resources - content of files
--  in deployment directory.
------------------------------------------------------------------------------
private with League.Calendars;
with League.Strings;
with League.String_Vectors;

private with Servlet.Generic_Servlets;
private with Servlet.HTTP_Requests;
private with Servlet.HTTP_Responses;
with Servlet.HTTP_Servlets;

package AWFC.Static_Resource_Servlets is

   type Static_Resource_Servlet is
     new Servlet.HTTP_Servlets.HTTP_Servlet with private;

   type Static_Resource_Servlet_Access is
     access all Static_Resource_Servlet'Class;

   type Content_Type_Handler is interface;

   not overriding function Content_Type
    (Self      : access Content_Type_Handler;
     Path_Info : League.String_Vectors.Universal_String_Vector;
     Default   : League.Strings.Universal_String)
       return League.Strings.Universal_String is abstract;

   not overriding procedure Set_Content_Type_Handler
     (Self  : in out Static_Resource_Servlet;
      Value : access Content_Type_Handler'Class);
   --  Set content type handler

private

   type Static_Resource_Servlet is new Servlet.HTTP_Servlets.HTTP_Servlet with
     record
        Handler : access Content_Type_Handler'Class;
     end record;

   overriding procedure Do_Get
    (Self     : in out Static_Resource_Servlet;
     Request  : Servlet.HTTP_Requests.HTTP_Servlet_Request'Class;
     Response : in out Servlet.HTTP_Responses.HTTP_Servlet_Response'Class);

   overriding function Get_Last_Modified
    (Self     : in out Static_Resource_Servlet;
     Request  : Servlet.HTTP_Requests.HTTP_Servlet_Request'Class)
      return League.Calendars.Date_Time;

   overriding function Get_Servlet_Info
    (Self : Static_Resource_Servlet) return League.Strings.Universal_String;

   overriding function Instantiate
    (Parameters : not null access
       Servlet.Generic_Servlets.Instantiation_Parameters'Class)
         return Static_Resource_Servlet;

end AWFC.Static_Resource_Servlets;
