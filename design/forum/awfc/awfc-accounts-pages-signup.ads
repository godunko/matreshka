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
-- Copyright © 2015, Vadim Godunko <vgodunko@gmail.com>                     --
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
--  Account signup page provides form to be filled to signup in system using
--  e-mail address. It can contains list of errors found during signup
--  procedure.
--
--  It binds parameters to be used by templates:
--   - account (object)
--      - hasErrors (boolean)   errors has been detected
--      - emailEmpty (boolean)  provided e-mail is empty
--      - emailUsed (boolean)   provided e-mail is empty
--      - done (boolean)        user's account has been created successfully
--      - hasUser (boolean)     user object is not null XXX will be removed
--                                when templates language will allow to check
--                                for null object
--      - user (object)
--         - email (string)     e-mail address used to create account
--         - exists (boolean)   account exits
--         - active (boolean)   account is activated
------------------------------------------------------------------------------
with League.Strings;
with Servlet.HTTP_Sessions;
private with XML.Templates.Processors;

with AWFC.Accounts.Users;
with AWFC.Page_Generators;

package AWFC.Accounts.Pages.Signup is

   type Signup_Error is (Email_Empty, Email_Used);
   type Signup_Errors is array (Signup_Error) of Boolean;
   No_Signup_Errors : constant Signup_Errors := (others => False);

   type Signup_Page_Generator is
     new AWFC.Page_Generators.Abstract_Page_Generator with private;

   function Render_Form
    (Self    : in out Signup_Page_Generator'Class)
       return League.Strings.Universal_String;

   function Render_Error
    (Self    : in out Signup_Page_Generator'Class;
     Email   : League.Strings.Universal_String;
     Errors  : Signup_Errors)
       return League.Strings.Universal_String;

   function Render_Error
    (Self    : in out Signup_Page_Generator'Class;
     User    : not null AWFC.Accounts.Users.User_Access;
     Errors  : Signup_Errors)
       return League.Strings.Universal_String;

   function Render_Done
    (Self    : in out Signup_Page_Generator'Class;
     User    : not null AWFC.Accounts.Users.User_Access)
       return League.Strings.Universal_String;

private

   type Signup_Page_Generator is
     new AWFC.Page_Generators.Abstract_Page_Generator with record
      Email  : League.Strings.Universal_String;
      User   : AWFC.Accounts.Users.User_Access;
      Errors : Signup_Errors;
      Done   : Boolean;
   end record;

   overriding procedure Bind_Parameters
    (Self      : in out Signup_Page_Generator;
     Processor : in out XML.Templates.Processors.Template_Processor'Class);

end AWFC.Accounts.Pages.Signup;
