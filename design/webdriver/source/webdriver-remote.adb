------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               Web Framework                              --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2017, Vadim Godunko <vgodunko@gmail.com>                     --
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

with AWS.Client;

with League.JSON.Objects;
with League.String_Vectors;

with WebDriver.Elements;
with WebDriver.Sessions;

package body WebDriver.Remote is

   type Method_Kinds is (Get, Post);

   type Command is record
      Method     : Method_Kinds;
      Path       : League.Strings.Universal_String;
      Session_Id : League.Strings.Universal_String;
      Parameters : League.JSON.Objects.JSON_Object;
   end record;

   type Response is record
      Session_Id : League.Strings.Universal_String;
      State      : League.Strings.Universal_String;
      Status     : Integer;
      Value      : League.JSON.Objects.JSON_Object;
   end record;

   package Executors is
      type HTTP_Command_Executor is tagged limited record
         Server : AWS.Client.HTTP_Connection;
      end record;

      not overriding function Execute
        (Self    : access HTTP_Command_Executor;
         Command : Remote.Command) return Response;
   end Executors;

   package body Executors is separate;

   package Elements is
      type Element is new WebDriver.Elements.Element with record
         Session_Id : League.Strings.Universal_String;
         Element_Id : League.Strings.Universal_String;
         Executor   : access Executors.HTTP_Command_Executor;
      end record;

      overriding function Is_Selected (Self : access Element) return Boolean;

      overriding function Is_Enabled (Self : access Element) return Boolean;

      overriding function Get_Attribute
        (Self : access Element;
         Name : League.Strings.Universal_String)
           return League.Strings.Universal_String;

      overriding function Get_Property
        (Self : access Element;
         Name : League.Strings.Universal_String)
           return League.Strings.Universal_String;

      overriding function Get_CSS_Value
        (Self : access Element;
         Name : League.Strings.Universal_String)
           return League.Strings.Universal_String;

      overriding function Get_Text
        (Self : access Element) return League.Strings.Universal_String;

      overriding function Get_Tag_Name
        (Self : access Element) return League.Strings.Universal_String;

      overriding procedure Click (Self : access Element);
      overriding procedure Clear (Self : access Element);

      overriding procedure Send_Keys
        (Self : access Element;
         Text : League.String_Vectors.Universal_String_Vector);

   end Elements;

   package body Elements is separate;

   package Sessions is

      type Session is new WebDriver.Sessions.Session with record
         Session_Id : League.Strings.Universal_String;
         Executor   : access Executors.HTTP_Command_Executor;
      end record;

      overriding procedure Go
        (Self : access Session;
         URL  : League.Strings.Universal_String);

      overriding function Get_Current_URL
        (Self : access Session) return League.Strings.Universal_String;

      overriding function Find_Element
        (Self     : access Session;
         Strategy : WebDriver.Location_Strategy;
         Selector : League.Strings.Universal_String)
         return WebDriver.Elements.Element_Access;

   end Sessions;

   package body Sessions is separate;

   package Drivers is

      type Driver is limited new WebDriver.Drivers.Driver with record
         Executor   : aliased Executors.HTTP_Command_Executor;
      end record;

      overriding function New_Session
        (Self : access Driver) return WebDriver.Sessions.Session_Access;

   end Drivers;

   package body Drivers is separate;

   ------------
   -- Create --
   ------------

   function Create
     (URL : League.Strings.Universal_String)
      return WebDriver.Drivers.Driver'Class
   is
   begin
      return Result : Drivers.Driver do
         AWS.Client.Create
           (Result.Executor.Server,
            Host => URL.To_UTF_8_String);
      end return;
   end Create;

end WebDriver.Remote;
