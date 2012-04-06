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
--  This file is generated, don't edit it.
------------------------------------------------------------------------------
with AMF.Internals.Utp_Elements;
with AMF.String_Collections;
with AMF.UML.Behaviors;
with AMF.Utp.Test_Logs;
with AMF.Visitors;

package AMF.Internals.Utp_Test_Logs is

   type Utp_Test_Log_Proxy is
     limited new AMF.Internals.Utp_Elements.Utp_Element_Proxy
       and AMF.Utp.Test_Logs.Utp_Test_Log with null record;

   overriding function Get_Base_Behavior
    (Self : not null access constant Utp_Test_Log_Proxy)
       return AMF.UML.Behaviors.UML_Behavior_Access;
   --  Getter of TestLog::base_Behavior.
   --

   overriding procedure Set_Base_Behavior
    (Self : not null access Utp_Test_Log_Proxy;
     To   : AMF.UML.Behaviors.UML_Behavior_Access);
   --  Setter of TestLog::base_Behavior.
   --

   overriding function Get_Tester
    (Self : not null access constant Utp_Test_Log_Proxy)
       return AMF.String_Collections.Set_Of_String;
   --  Getter of TestLog::tester.
   --

   overriding function Get_Executed_At
    (Self : not null access constant Utp_Test_Log_Proxy)
       return AMF.Optional_String;
   --  Getter of TestLog::executedAt.
   --

   overriding procedure Set_Executed_At
    (Self : not null access Utp_Test_Log_Proxy;
     To   : AMF.Optional_String);
   --  Setter of TestLog::executedAt.
   --

   overriding function Get_Duration
    (Self : not null access constant Utp_Test_Log_Proxy)
       return AMF.Optional_String;
   --  Getter of TestLog::duration.
   --

   overriding procedure Set_Duration
    (Self : not null access Utp_Test_Log_Proxy;
     To   : AMF.Optional_String);
   --  Setter of TestLog::duration.
   --

   overriding function Get_Verdict
    (Self : not null access constant Utp_Test_Log_Proxy)
       return AMF.Utp.Utp_Verdict;
   --  Getter of TestLog::verdict.
   --

   overriding procedure Set_Verdict
    (Self : not null access Utp_Test_Log_Proxy;
     To   : AMF.Utp.Utp_Verdict);
   --  Setter of TestLog::verdict.
   --

   overriding function Get_Verdict_Reason
    (Self : not null access constant Utp_Test_Log_Proxy)
       return AMF.Optional_String;
   --  Getter of TestLog::verdictReason.
   --

   overriding procedure Set_Verdict_Reason
    (Self : not null access Utp_Test_Log_Proxy;
     To   : AMF.Optional_String);
   --  Setter of TestLog::verdictReason.
   --

   overriding function Get_Sut_Version
    (Self : not null access constant Utp_Test_Log_Proxy)
       return AMF.Optional_String;
   --  Getter of TestLog::sutVersion.
   --

   overriding procedure Set_Sut_Version
    (Self : not null access Utp_Test_Log_Proxy;
     To   : AMF.Optional_String);
   --  Setter of TestLog::sutVersion.
   --

   overriding procedure Enter_Element
    (Self    : not null access constant Utp_Test_Log_Proxy;
     Visitor : in out AMF.Visitors.Abstract_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control);

   overriding procedure Leave_Element
    (Self    : not null access constant Utp_Test_Log_Proxy;
     Visitor : in out AMF.Visitors.Abstract_Visitor'Class;
     Control : in out AMF.Visitors.Traverse_Control);

   overriding procedure Visit_Element
    (Self     : not null access constant Utp_Test_Log_Proxy;
     Iterator : in out AMF.Visitors.Abstract_Iterator'Class;
     Visitor  : in out AMF.Visitors.Abstract_Visitor'Class;
     Control  : in out AMF.Visitors.Traverse_Control);

end AMF.Internals.Utp_Test_Logs;
