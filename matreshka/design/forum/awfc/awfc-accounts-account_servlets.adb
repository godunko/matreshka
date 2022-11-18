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
with League.String_Vectors;
--  with League.IRIs;
--
--  with Servlet.Contexts;
--
with Servlet.HTTP_Sessions;
----  with Server.Pages.Account;
----  with Server.Sessions;
----  with Server.Users.Passwords;
----  with Security.Users;
--  with AWFC.Accounts.Password_Managers;
--  with AWFC.Accounts.Sessions;
with AWFC.Accounts.Users.Stores;

package body AWFC.Accounts.Account_Servlets is

   use type League.Strings.Universal_String;

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

--   Account_Template_File : constant League.Strings.Universal_String
--     := +"/WEB-INF/templates/account.xhtml.tmpl";
--
--   procedure Send_Account_Page
--    (Request  : Servlet.HTTP_Requests.HTTP_Servlet_Request'Class;
--     Response : in out Servlet.HTTP_Responses.HTTP_Servlet_Response'Class);
--   --  Sends '/account' page when current user is not anonymous. Reports
--   --  security event and send 404 Page Not Found overwise.
--
--   function Activate_By_Confirmation_Stage_1
--    (Context      :
--       not null access constant Servlet.Contexts.Servlet_Context'Class;
--     Session      : not null AWFC.Accounts.Sessions.Session_Access;
--     Confirmation : AWFC.Accounts.Password_Managers.Confirmation_Code)
--       return League.Strings.Universal_String;
--   --  First stage of activation of user's account. It returns account
--   --  activation page to be filled by user.
--
----   function Activate_By_Confirmation
----    (Context      :
----       not null access constant Servlet.Contexts.Servlet_Context'Class;
----     Session      : not null Server.Sessions.Session_Access;
----     Confirmation : Server.Users.Passwords.Confirmation_Code;
----     Password_1   : League.Strings.Universal_String;
----     Password_2   : League.Strings.Universal_String;
----     Agree        : Boolean)
----       return League.Strings.Universal_String;
----   --  Activate user's account.

   function Signup
    (Self    : in out Account_Servlet;
     Session : Servlet.HTTP_Sessions.HTTP_Session'Class;
     Email   : League.Strings.Universal_String)
       return League.Strings.Universal_String;
   --  Creates new user account (if not exists) or redirects user to
   --  activation, logon or restore password page.

   ------------
   -- Do_Get --
   ------------

   overriding procedure Do_Get
    (Self     : in out Account_Servlet;
     Request  : Servlet.HTTP_Requests.HTTP_Servlet_Request'Class;
     Response : in out Servlet.HTTP_Responses.HTTP_Servlet_Response'Class)
   is
      Path     : constant League.String_Vectors.Universal_String_Vector
        := Request.Get_Path_Info;
--      S        : League.String_Vectors.Universal_String_Vector;
--      Location : League.IRIs.IRI;

   begin
--      if Path.Is_Empty then
--         --  GET request for '/' resource fill and send page to edit account.
--
--         Send_Account_Page (Request, Response);

--      elsif Path.Length = 2 and then Path (1) = +"activate" then
--         --  Display account activation page.
--
--         Response.Set_Status (Servlet.HTTP_Responses.OK);
--         Response.Set_Content_Type (+"text/html");
--         Response.Set_Character_Encoding (+"UTF-8");
--         Response.Get_Output_Stream.Write
--          (Self.Activate_By_Confirmation_Stage_1
--            (Request.Get_Servlet_Context,
--             Request.Get_Session,
--             AWFC.Accounts.Password_Managers.From_Universal_String
--              (Path (2))));
--
--         return;
--
--      elsif Path.Length = 1 and then Path (1) = +"logoff" then
--         Server.Sessions.Session'Class (Request.Get_Session.all).Set_User
--          (Security.Users.Anonymous_User);
--
--         Location.Set_Scheme (Request.Get_Scheme);
--         Location.Set_Host (Request.Get_Server_Name);
--         Location.Set_Port (Request.Get_Server_Port);
--         Response.Send_Redirect (Location);
--
--         return;
--
--      elsif Path.Length = 1 and then Path (1) = +"logon" then
--         --  This request comes from navigation bar, there are no parameters
--         --  specified.
--
--         Response.Set_Status (Servlet.HTTP_Responses.OK);
--         Response.Set_Content_Type (+"text/html");
--         Response.Set_Character_Encoding (+"UTF-8");
--         Response.Get_Output_Stream.Write
--          (Server.Pages.Account.Logon
--            (Request.Get_Servlet_Context, Request.Get_Session));
--
--         return;
--
      if Path.Length = 1 and then Path (1) = +"signup" then
         --  GET form of this request always comes without parameters. Use of
         --  parameters is security weak because they are visible in URL.
         --
         --  XXX Check for empty set of parameters and report of security event
         --  should be added.

         Response.Set_Status (Servlet.HTTP_Responses.OK);
         Response.Set_Content_Type (+"text/html");
         Response.Set_Character_Encoding (+"UTF-8");
         Response.Get_Output_Stream.Write (Self.Signup_Page.Render_Form);

         return;
      end if;
   end Do_Get;

   -------------
   -- Do_Post --
   -------------

   overriding procedure Do_Post
    (Self     : in out Account_Servlet;
     Request  : Servlet.HTTP_Requests.HTTP_Servlet_Request'Class;
     Response : in out Servlet.HTTP_Responses.HTTP_Servlet_Response'Class)
   is
      Path        : constant League.String_Vectors.Universal_String_Vector
        := Request.Get_Path_Info;
--      Agrees      : constant League.String_Vectors.Universal_String_Vector
--        := Request.Get_Parameter_Values (+"agree");
      Emails      : constant League.String_Vectors.Universal_String_Vector
        := Request.Get_Parameter_Values (+"email");
--      Passwords   : constant League.String_Vectors.Universal_String_Vector
--        := Request.Get_Parameter_Values (+"password");
--      Passwords_1 : constant League.String_Vectors.Universal_String_Vector
--        := Request.Get_Parameter_Values (+"password1");
--      Passwords_2 : constant League.String_Vectors.Universal_String_Vector
--        := Request.Get_Parameter_Values (+"password2");
--      Location    : League.IRIs.IRI;
--
   begin
--      if Path.Length = 2 and then Path (1) = +"activate"
--        and then Passwords_1.Length = 1 and then Passwords_2.Length = 1
--      then
--         --  All URIs under '/account/activate/' is requests to activate
--         --  account with confirmation code passed as last segment of URI's
--         --  path.
--         --
--         --  There are 'password1', 'password2' parameters, user attempt to
--         --  activate account finally.
--
--         Response.Set_Status (Servlet.HTTP_Responses.OK);
--         Response.Set_Content_Type (+"text/html");
--         Response.Set_Character_Encoding (+"UTF-8");
--         Response.Get_Output_Stream.Write
--          (Server.Pages.Account.Activate_By_Confirmation
--            (Request.Get_Servlet_Context,
--             Request.Get_Session,
--             Server.Users.Passwords.From_Universal_String (Path (2)),
--             Passwords_1 (1),
--             Passwords_2 (1),
--             Agrees.Length = 1 and then Agrees (1) = +"yes"));
--
--         return;
--
--      elsif Path.Length = 1 and then Path (1) = +"activate"
--        and then Emails.Length = 1
--      then
--       --  '/activate' is used to force send of new account activation e-mail
--         --  to user.
--
--         Response.Set_Status (Servlet.HTTP_Responses.OK);
--         Response.Set_Content_Type (+"text/html");
--         Response.Set_Character_Encoding (+"UTF-8");
--         Response.Get_Output_Stream.Write
--          (Server.Pages.Account.Activate
--            (Request.Get_Servlet_Context, Request.Get_Session, Emails (1)));
--
--         return;
--
--      elsif Path.Length = 1 and then Path (1) = +"logoff" then
--         --  'logoff' request can be sent with POST method from logon bar.
--
--         Server.Sessions.Session'Class (Request.Get_Session.all).Set_User
--          (Security.Users.Anonymous_User);
--
--         Location.Set_Scheme (Request.Get_Scheme);
--         Location.Set_Host (Request.Get_Server_Name);
--         Location.Set_Port (Request.Get_Server_Port);
--         Response.Send_Redirect (Location);
--
--         return;
--
--      elsif Path.Length = 1 and then Path (1) = +"logon"
--        and then Emails.Length = 1 and then Passwords.Length = 1
--      then
--         Response.Set_Status (Servlet.HTTP_Responses.OK);
--         Response.Set_Content_Type (+"text/html");
--         Response.Set_Character_Encoding (+"UTF-8");
--         Response.Get_Output_Stream.Write
--          (Server.Pages.Account.Logon
--            (Request.Get_Servlet_Context,
--             Request.Get_Session,
--             Emails (1),
--             Passwords (1),
--             League.Strings.Empty_Universal_String));
--
--         --  XXX When Logon returns empty string we need send 302 reply.
--
--         return;
--
----            declare
----               Ref    : AWS.URL.Object;
----               Result : League.Strings.Universal_String;
----            begin
----               Ref := AWS.URL.Parse (AWS.Status.Referer (Request));
----               Result :=
----                   Server.Pages.Account.Logon
----                    (Session,
----                     League.Strings.From_UTF_8_String
----                      (AWS.Parameters.Get (Parameters, "email")),
----                     League.Strings.From_UTF_8_String
----                      (AWS.Parameters.Get (Parameters, "password")),
----                     League.Strings.From_UTF_8_String
----                      (AWS.URL.Abs_Path (Ref)));
----
----               if Result.Is_Empty then
----
----                  return AWS.Response.URL (AWS.URL.Abs_Path (Ref));
----               else
----
----                  return AWS.Response.Build
----                    (HTML_Mime_Type, Result.To_UTF_8_String);
----               end if;
----            end;

      if Path.Length = 1 and then Path (1) = +"signup"
        and then Emails.Length = 1
      then
         --  POST form of this means request to signup user with provided
         --  e-mail.

         Response.Set_Status (Servlet.HTTP_Responses.OK);
         Response.Set_Content_Type (+"text/html");
         Response.Set_Character_Encoding (+"UTF-8");
         Response.Get_Output_Stream.Write
          (Self.Signup (Request.Get_Session.all, Emails (1)));

         return;
      end if;
   end Do_Post;

   ----------------------
   -- Get_Servlet_Info --
   ----------------------

   overriding function Get_Servlet_Info
    (Self : Account_Servlet) return League.Strings.Universal_String is
   begin
      return +"Matreshka's Account Management Servlet";
   end Get_Servlet_Info;

   ----------------
   -- Initialize --
   ----------------

   overriding procedure Initialize
    (Self   : in out Account_Servlet;
     Config : not null access Servlet.Configs.Servlet_Config'Class)
   is
      Page_Template_File   : constant League.Strings.Universal_String
        := +"/WEB-INF/templates/page.xhtml.tmpl";
      Signup_Template_File : constant League.Strings.Universal_String
        := +"/WEB-INF/templates/account/signup.xhtml.tmpl";

   begin
      Servlet.HTTP_Servlets.HTTP_Servlet (Self).Initialize (Config);

      Self.Signup_Page.Initialize
       (Config.Get_Servlet_Context, Page_Template_File, Signup_Template_File);
   end Initialize;

   ------------
   -- Signup --
   ------------

   function Signup
    (Self    : in out Account_Servlet;
     Session : Servlet.HTTP_Sessions.HTTP_Session'Class;
     Email   : League.Strings.Universal_String)
       return League.Strings.Universal_String
   is
      use type AWFC.Accounts.Users.User_Access;
      use AWFC.Accounts.Pages.Signup;

      User_Store : AWFC.Accounts.Users.Stores.User_Store'Class
        renames AWFC.Accounts.Users.Stores.User_Store'Class
                 (Self.Password_Manager.Engine.Get_Store
                   (AWFC.Accounts.Users.User'Tag).all);
      Errors     : Signup_Errors := No_Signup_Errors;
      User       : AWFC.Accounts.Users.User_Access;

   begin
      if Email.Is_Empty then
         Errors (Email_Empty) := True;

      else
         User := User_Store.Incarnate (Email);

         if User /= null then
            --  User exists, suggest to activate account or to logon depending
            --  of whether account was enabled or not.

            Errors (Email_Used) := True;

            return Self.Signup_Page.Render_Error (User, Errors);
         end if;
      end if;

      if Errors /= No_Signup_Errors then
         return Self.Signup_Page.Render_Error (Email, Errors);
      end if;

      --  Create new account and assign confirmation code to it.

      User := User_Store.Create (Email);

--      return Activate (Context, Session, User, True);
      return Self.Signup_Page.Render_Done (User);
   end Signup;

--   -----------------------
--   -- Send_Account_Page --
--   -----------------------
--
--   procedure Send_Account_Page
--    (Request  : Servlet.HTTP_Requests.HTTP_Servlet_Request'Class;
--     Response : in out Servlet.HTTP_Responses.HTTP_Servlet_Response'Class) is
--   begin
--      if Server.Sessions.Session_Access
--          (Request.Get_Session).Get_User.Is_Anonymous
--      then
--       --  XXX Security event should be reported: there is no menu entry for
--         --  access to account of anonymous user.
--
--         Page_Not_Found (Request, Response);
--
--      else
--         Response.Set_Status (Servlet.HTTP_Responses.OK);
--         Response.Set_Content_Type (+"text/html");
--         Response.Set_Character_Encoding (+"UTF-8");
--         Response.Get_Output_Stream.Write
--          (Server.Pages.Process_Page
--            (Request.Get_Servlet_Context,
--             False,
--             Request.Get_Session,
--             Server.Pages.Get_Stream
--              (Request.Get_Servlet_Context, Account_Template_File),
--             Server.Pages.Parameter_Mappings.Empty_Map));
--      end if;
--   end Send_Account_Page;

--   function Activate
--  (Context : not null access constant Servlet.Contexts.Servlet_Context'Class;
--     Session : not null Server.Sessions.Session_Access;
--     Email   : League.Strings.Universal_String)
--       return League.Strings.Universal_String;
--   --  Sent activation e-mail to user.
--
--   function Logon
--  (Context : not null access constant Servlet.Contexts.Servlet_Context'Class;
--     Session : not null Server.Sessions.Session_Access)
--       return League.Strings.Universal_String;
--   --  Returns content of logon page.
--
--   function Logon
--    (Context  :
--       not null access constant Servlet.Contexts.Servlet_Context'Class;
--     Session  : not null Server.Sessions.Session_Access;
--     Email    : League.Strings.Universal_String;
--     Password : League.Strings.Universal_String;
--     Referer  : League.Strings.Universal_String)
--       return League.Strings.Universal_String;
--   --  Check email/password
--   --  This function returns empty string to redirect browser to Referer

--   use type Security.Users.User_Access;
--
--   type Error_Handler is
--     limited new XML.SAX.Error_Handlers.SAX_Error_Handler with record
--      null;
--   end record;
--
--   overriding function Error_String
--    (Self : Error_Handler) return League.Strings.Universal_String;
--   --  Returns error message when processing was terminated by error handler.
--
--   overriding procedure Fatal_Error
--    (Self       : in out Error_Handler;
--     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception);
--   --  Process fatal error in XML data. Outputs message to standard error.
--
--   Activate_Template_File         : constant League.Strings.Universal_String
--     := +"/WEB-INF/templates/account-activate.xhtml.tmpl";
--   Activate_Success_Template_File : constant League.Strings.Universal_String
--     := +"/WEB-INF/templates/account-activate-success.xhtml.tmpl";
--   Activation_Email_Template_File : constant League.Strings.Universal_String
--     := +"/WEB-INF/templates/email-activate.xhtml.tmpl";
--   Logon_Template_File            : constant League.Strings.Universal_String
--     := +"/WEB-INF/templates/account-logon.xhtml.tmpl";
--   Logon_Failure_Template_File    : constant League.Strings.Universal_String
--     := +"/WEB-INF/templates/account-logon-fail.xhtml.tmpl";
--   Logon_Success_Template_File    : constant League.Strings.Universal_String
--     := +"/WEB-INF/templates/account-logon-ok.xhtml.tmpl";
--   Recovery_Template_File         : constant League.Strings.Universal_String
--     := +"/WEB-INF/templates/account-recovery.xhtml.tmpl";
--   Signup_Exists_Template_File    : constant League.Strings.Universal_String
--     := +"/WEB-INF/templates/account-signup-exists.xhtml.tmpl";
--   Signup_Success_Template_File   : constant League.Strings.Universal_String
--     := +"/WEB-INF/templates/account-signup-success.xhtml.tmpl";
--
--   -------------------
--   -- Singup errors --
--   -------------------
--
--   type Signup_Error is (Email_Empty);
--   type Signup_Errors is array (Signup_Error) of Boolean;
--   No_Signup_Errors : constant Signup_Errors := (others => False);
--
--   Signup_Template_Parameters :
--     constant array (Signup_Error) of League.Strings.Universal_String
--       := (Email_Empty => +"emailEmpty");
--
--   -----------------------
--   -- Activation errors --
--   -----------------------
--
--   type Activate_Error is (Empty_Password, Password_Not_Match, Not_Agree);
--   type Activate_Errors is array (Activate_Error) of Boolean;
--   No_Activate_Errors : constant Activate_Errors := (others => False);
--
--   Activate_Template_Parameters :
--     constant array (Activate_Error) of League.Strings.Universal_String
--       := (Empty_Password     => +"emptyPassword",
--           Password_Not_Match => +"passwordNotMatch",
--           Not_Agree          => +"notAgree");
--
--   ------------------
--   -- Logon errors --
--   ------------------
--
--   type Logon_Error is
--     (Email_Empty,
--      Email_Not_Found,
--      Empty_Password,
--      Password_Not_Match,
--      Not_Active);
--   type Logon_Errors is array (Logon_Error) of Boolean;
--   No_Logon_Errors : constant Logon_Errors := (others => False);
--
--   Logon_Template_Parameters :
--     constant array (Logon_Error) of League.Strings.Universal_String
--       := (Email_Empty        => +"emailEmpty",
--           Email_Not_Found    => +"emailNotFound",
--           Empty_Password     => +"emptyPassword",
--           Password_Not_Match => +"passwordNotMatch",
--           Not_Active         => +"notActive");
--
--   function Process_Signup_Template
--  (Context : not null access constant Servlet.Contexts.Servlet_Context'Class;
--     Session : not null Server.Sessions.Session_Access;
--     Email   : League.Strings.Universal_String;
--     Errors  : Signup_Errors)
--       return League.Strings.Universal_String;
--   --  Parses page's and signup's templates and returns result.
--
--   function Process_Activate_Template
--  (Context : not null access constant Servlet.Contexts.Servlet_Context'Class;
--     Session : not null Server.Sessions.Session_Access;
--     Errors  : Activate_Errors)
--       return League.Strings.Universal_String;
--   --  Parses page's and activate's templates and returns result.
--
--   function Process_Recovery_Template
--  (Context : not null access constant Servlet.Contexts.Servlet_Context'Class;
--     Session : not null Server.Sessions.Session_Access;
--     Email   : League.Strings.Universal_String)
--       return League.Strings.Universal_String;
--   --  Parses page's and recovery's templates and returns result.
--
--   function Activate
--  (Context : not null access constant Servlet.Contexts.Servlet_Context'Class;
--     Session : not null Server.Sessions.Session_Access;
--     User    : Security.Users.User_Access;
--     Is_New  : Boolean)
--       return League.Strings.Universal_String;
--  Send activation e-mail to user. Is_New means that account just have been
--   --  created.
--
--   function Process_Mail_Template
--  (Context : not null access constant Servlet.Contexts.Servlet_Context'Class;
--     Code    : Server.Users.Passwords.Confirmation_Code)
--       return League.Strings.Universal_String;
--   --  Process activation e-mail content and return text.
--
--   --------------
--   -- Activate --
--   --------------
--
--   function Activate
--  (Context : not null access constant Servlet.Contexts.Servlet_Context'Class;
--     Session : not null Server.Sessions.Session_Access;
--     User    : Security.Users.User_Access;
--     Is_New  : Boolean)
--       return League.Strings.Universal_String
--   is
--      Parameters : Parameter_Mappings.Map;
--      Code       : Server.Users.Passwords.Confirmation_Code;
--      Mail_Text  : League.Strings.Universal_String;
--      Error      : League.Strings.Universal_String;
--
--   begin
--      Code := Server.Users.Passwords.Assign_Confirmation_Code (User);
--
--      --  Prepare and send activation e-mail.
--
--      Mail_Text := Process_Mail_Template (Context, Code);
--
--      Mail.Factory.Send
--        (To    => User.Get_Email,
--         Text  => Mail_Text,
--         Error => Error);
--
--      --  FIXME Put Error (if any) into page
--
--      Parameters.Insert
--        (+"newAccount", League.Holders.Booleans.To_Holder (Is_New));
--     Parameters.Insert (+"email", League.Holders.To_Holder (User.Get_Email));
--
--      return
--        Process_Page
--         (Context,
--          False,
--          Session,
--          Get_Stream (Context, Signup_Success_Template_File),
--          Parameters);
--   end Activate;
--
--   --------------
--   -- Activate --
--   --------------
--
--   function Activate
--  (Context : not null access constant Servlet.Contexts.Servlet_Context'Class;
--     Session : not null Server.Sessions.Session_Access;
--     Email   : League.Strings.Universal_String)
--       return League.Strings.Universal_String
--   is
--      User : Security.Users.User_Access;
--
--   begin
--      User := Server.Globals.User_Store.Incarnate (Email);
--
--      return Activate (Context, Session, User, False);
--   end Activate;
--
--   ------------------------------
--   -- Activate_By_Confirmation --
--   ------------------------------
--
--   function Activate_By_Confirmation
--    (Context      :
--       not null access constant Servlet.Contexts.Servlet_Context'Class;
--     Session      : not null Server.Sessions.Session_Access;
--     Confirmation : Server.Users.Passwords.Confirmation_Code)
--       return League.Strings.Universal_String is
--   begin
--     return Process_Activate_Template (Context, Session, No_Activate_Errors);
--   end Activate_By_Confirmation;
--
--   ------------------------------
--   -- Activate_By_Confirmation --
--   ------------------------------
--
--   function Activate_By_Confirmation
--    (Context      :
--       not null access constant Servlet.Contexts.Servlet_Context'Class;
--     Session      : not null Server.Sessions.Session_Access;
--     Confirmation : Server.Users.Passwords.Confirmation_Code;
--     Password_1   : League.Strings.Universal_String;
--     Password_2   : League.Strings.Universal_String;
--     Agree        : Boolean)
--       return League.Strings.Universal_String
--   is
--      use type League.Strings.Universal_String;
--
--      Errors : Activate_Errors := No_Activate_Errors;
--      User   : Security.Users.User_Access;
--
--   begin
--      if Password_1.Is_Empty then
--         Errors (Empty_Password) := True;
--      end if;
--
--      if Password_1 /= Password_2 then
--         Errors (Password_Not_Match) := True;
--      end if;
--
--      if not Agree then
--         Errors (Not_Agree) := True;
--      end if;
--
--      --  If there are errors - report them.
--
--      if Errors /= No_Activate_Errors then
--         return Process_Activate_Template (Context, Session, Errors);
--      end if;
--
--      --  Activate user's account.
--
--      User := Server.Users.Passwords.Get_User (Confirmation);
--
--      if User = null then
--         raise Program_Error;
--      end if;
--
--      User.Enable;
--
--      Server.Users.Passwords.Set_Password (User, Password_1);
--      Server.Users.Passwords.Remove_Confirmation_Code (User);
--
--      Session.Set_User (User);
----      Session.Regenerate_Session_Identifier;
--
--      return
--        Process_Page
--         (Context,
--          False,
--          Session,
--          Get_Stream (Context, Activate_Success_Template_File),
--          Parameter_Mappings.Empty_Map);
--   end Activate_By_Confirmation;
--
--   ------------------
--   -- Error_String --
--   ------------------
--
--   overriding function Error_String
--    (Self : Error_Handler) return League.Strings.Universal_String is
--   begin
--      return League.Strings.Empty_Universal_String;
--   end Error_String;
--
--   -----------------
--   -- Fatal_Error --
--   -----------------
--
--   overriding procedure Fatal_Error
--    (Self       : in out Error_Handler;
--     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception)
--   is
--      Line   : constant Wide_Wide_String
--        := Integer'Wide_Wide_Image (Occurrence.Line);
--      Column : constant Wide_Wide_String
--        := Integer'Wide_Wide_Image (Occurrence.Column);
--
--   begin
--      Ada.Wide_Wide_Text_IO.Put_Line
--       (Ada.Wide_Wide_Text_IO.Standard_Error,
--        Occurrence.System_Id.To_Wide_Wide_String
--          & ':'
--          & Line (Line'First + 1 .. Line'Last)
--          & ':'
--          & Column (Column'First + 1 .. Column'Last)
--          & ": "
--          & Occurrence.Message.To_Wide_Wide_String);
--   end Fatal_Error;
--
--   -----------
--   -- Logon --
--   -----------
--
--   function Logon
--  (Context : not null access constant Servlet.Contexts.Servlet_Context'Class;
--     Session : not null Server.Sessions.Session_Access)
--       return League.Strings.Universal_String is
--   begin
--      return
--        Process_Page
--         (Context,
--          False,
--          Session,
--          Get_Stream (Context, Logon_Template_File),
--          Parameter_Mappings.Empty_Map);
--   end Logon;
--
--   -----------
--   -- Logon --
--   -----------
--
--   function Logon
--    (Context  :
--       not null access constant Servlet.Contexts.Servlet_Context'Class;
--     Session  : not null Server.Sessions.Session_Access;
--     Email    : League.Strings.Universal_String;
--     Password : League.Strings.Universal_String;
--     Referer  : League.Strings.Universal_String)
--      return League.Strings.Universal_String
--   is
--      use type League.Strings.Universal_String;
--
--      Errors     : Logon_Errors := No_Logon_Errors;
--      Parameters : Parameter_Mappings.Map;
--      User       : Security.Users.User_Access;
--
--   begin
--      if Email.Is_Empty then
--         Errors (Email_Empty) := True;
--
--      elsif Password.Is_Empty then
--         Errors (Empty_Password) := True;
--
--      else
--         User := Server.Globals.User_Store.Incarnate (Email);
--
--         if User = null then
--            Errors (Email_Not_Found) := True;
--
--         else
--            --  User exists, check if account was enabled.
--
--            if not User.Is_Enabled then
--               Errors (Not_Active) := True;
--
--            elsif
--              not Server.Users.Passwords.Password_Match (User, Password)
--            then
--               Errors (Password_Not_Match) := True;
--            end if;
--         end if;
--      end if;
--
--      if Errors /= No_Logon_Errors then
--         for Error in Logon_Errors'Range loop
--            Parameters.Insert
--             (Logon_Template_Parameters (Error),
--              League.Holders.Booleans.To_Holder (Errors (Error)));
--         end loop;
--
--         return
--           Process_Page
--            (Context,
--             False,
--             Session,
--             Get_Stream (Context, Logon_Failure_Template_File),
--             Parameters);
--      end if;
--
--      --  Logon successful. Set session's user.
--
--      Session.Set_User (User);
--
--      if not Referer.Is_Empty and then Referer /= +"/account/logon" then
--         --  Return user to the page where login was performed
--
--         return League.Strings.Empty_Universal_String;
--      end if;
--
--      return
--        Process_Page
--         (Context,
--          False,
--          Session,
--          Get_Stream (Context, Logon_Success_Template_File),
--          Parameter_Mappings.Empty_Map);
--   end Logon;
--
--   -------------------------------
--   -- Process_Activate_Template --
--   -------------------------------
--
--   function Process_Activate_Template
--  (Context : not null access constant Servlet.Contexts.Servlet_Context'Class;
--     Session : not null Server.Sessions.Session_Access;
--     Errors  : Activate_Errors)
--       return League.Strings.Universal_String
--   is
--      Parameters : Parameter_Mappings.Map;
--
--   begin
--      Parameters.Insert
--       (+"hasErrors",
--        League.Holders.Booleans.To_Holder (Errors /= No_Activate_Errors));
--
--      for Error in Activate_Errors'Range loop
--         Parameters.Insert
--          (Activate_Template_Parameters (Error),
--           League.Holders.Booleans.To_Holder (Errors (Error)));
--      end loop;
--
--      return
--        Process_Page
--         (Context,
--          False,
--          Session,
--          Get_Stream (Context, Activate_Template_File),
--          Parameters);
--   end Process_Activate_Template;
--
--   ---------------------------
--   -- Process_Mail_Template --
--   ---------------------------
--
--   function Process_Mail_Template
--  (Context : not null access constant Servlet.Contexts.Servlet_Context'Class;
--     Code    : Server.Users.Passwords.Confirmation_Code)
--       return League.Strings.Universal_String
--   is
--      function Escape_HTTP_URL
--       (Source : League.Strings.Universal_String)
--          return League.Strings.Universal_String;
--    --  Replace each occurrence of '+' by its encoded form "%2B" because HTTP
--      --  uses '+' to represent space in URL.
--
--      ---------------------
--      -- Escape_HTTP_URL --
--      ---------------------
--
--      function Escape_HTTP_URL
--       (Source : League.Strings.Universal_String)
--          return League.Strings.Universal_String
--      is
--         Result : League.Strings.Universal_String := Source;
--         Index  : Natural;
--
--      begin
--         loop
--            Index := Result.Index (League.Characters.Latin.Plus_Sign);
--
--            exit when Index = 0;
--
--            Result.Replace
--             (Index, Index, League.Strings.To_Universal_String ("%2B"));
--         end loop;
--
--         return Result;
--      end Escape_HTTP_URL;
--
--    Input    : aliased XML.SAX.Input_Sources.Streams.Files.File_Input_Source;
--      Reader   : XML.SAX.Simple_Readers.Simple_Reader;
--      Filter   : aliased XML.Templates.Processors.Template_Processor;
--      Writer   : aliased XML.SAX.HTML5_Writers.HTML5_Writer;
--      Output   :
--       aliased XML.SAX.Output_Destinations.Strings.String_Output_Destination;
--      Error    : aliased Error_Handler;
--      URL      : League.IRIs.IRI;
--      Settings : League.Settings.Settings;
--
--   begin
--      --  Link components.
--
--      Reader.Set_Input_Source (Input'Unchecked_Access);
--      Reader.Set_Content_Handler (Filter'Unchecked_Access);
--      Reader.Set_Lexical_Handler (Filter'Unchecked_Access);
--      Reader.Set_Error_Handler (Error'Unchecked_Access);
--      Filter.Set_Content_Handler (Writer'Unchecked_Access);
--      Filter.Set_Lexical_Handler (Writer'Unchecked_Access);
--      Writer.Set_Output_Destination (Output'Unchecked_Access);
--
--      --  Define substitution data.
--
--      URL.Set_IRI
--       (League.Strings.Universal_String'
--         (League.Holders.Element (Settings.Value (+"/server/baseURL"))));
--      URL.Append_Segment (+"account");
--      URL.Append_Segment (+"activate");
--      URL.Append_Segment (Server.Users.Passwords.To_Universal_String (Code));
--
--      Filter.Set_Parameter
--        (+"activateURL",
--       League.Holders.To_Holder (Escape_HTTP_URL (URL.To_Universal_String)));
--      --  XXX URI must be constructed properly because text representation of
--      --  confirmation code uses restricted characters in URL.
--
--      --  Process template file.
--
--      Input.Open_By_File_Name
--       (Context.Get_Real_Path (Activation_Email_Template_File));
--      Reader.Parse;
--
--      return Output.Get_Text;
--   end Process_Mail_Template;
--
--   -------------------------------
--   -- Process_Recovery_Template --
--   -------------------------------
--
--   function Process_Recovery_Template
--  (Context : not null access constant Servlet.Contexts.Servlet_Context'Class;
--     Session : not null Server.Sessions.Session_Access;
--     Email   : League.Strings.Universal_String)
--       return League.Strings.Universal_String
--   is
--      Parameters : Parameter_Mappings.Map;
--
--   begin
--      Parameters.Insert (+"email", League.Holders.To_Holder (Email));
--
--      return
--        Process_Page
--         (Context,
--          False,
--          Session,
--          Get_Stream (Context, Recovery_Template_File),
--          Parameters);
--   end Process_Recovery_Template;
--
--   -----------------------------
--   -- Process_Signup_Template --
--   -----------------------------
--
--   function Process_Signup_Template
--  (Context : not null access constant Servlet.Contexts.Servlet_Context'Class;
--     Session : not null Server.Sessions.Session_Access;
--     Email   : League.Strings.Universal_String;
--     Errors  : Signup_Errors)
--       return League.Strings.Universal_String
--   is
--      Parameters : Parameter_Mappings.Map;
--
--   begin
--      Parameters.Insert (+"email", League.Holders.To_Holder (Email));
--      Parameters.Insert
--       (+"hasErrors",
--        League.Holders.Booleans.To_Holder (Errors /= No_Signup_Errors));
--
--      for Error in Signup_Errors'Range loop
--         Parameters.Insert
--          (Signup_Template_Parameters (Error),
--           League.Holders.Booleans.To_Holder (Errors (Error)));
--      end loop;
--
--      return
--        Process_Page
--         (Context,
--          False,
--          Session,
--          Get_Stream (Context, Signup_Template_File),
--          Parameters);
--   end Process_Signup_Template;
--
--   ------------
--   -- Signup --
--   ------------
--
--   function Signup
--  (Context : not null access constant Servlet.Contexts.Servlet_Context'Class;
--     Session : not null Server.Sessions.Session_Access)
--       return League.Strings.Universal_String is
--   begin
--      return
--        Process_Signup_Template
--         (Context,
--          Session,
--          League.Strings.Empty_Universal_String,
--          No_Signup_Errors);
--   end Signup;
--
--   ------------
--   -- Signup --
--   ------------
--
--   function Signup
--  (Context : not null access constant Servlet.Contexts.Servlet_Context'Class;
--     Session : not null Server.Sessions.Session_Access;
--     Email   : League.Strings.Universal_String)
--       return League.Strings.Universal_String
--   is
--      Errors     : Signup_Errors := No_Signup_Errors;
--      Parameters : Parameter_Mappings.Map;
--      User       : Security.Users.User_Access;
--
--   begin
--      if Email.Is_Empty then
--         Errors (Email_Empty) := True;
--
--      else
--         User := Server.Globals.User_Store.Incarnate (Email);
--
--         if User /= null then
--          --  User exists, suggest to activate account or to logon depending
--            --  of whether account was enabled or not.
--
--            Parameters.Insert (+"email", League.Holders.To_Holder (Email));
--            Parameters.Insert
--             (+"activate",
--              League.Holders.Booleans.To_Holder (not User.Is_Enabled));
--            Parameters.Insert
--             (+"logon", League.Holders.Booleans.To_Holder (User.Is_Enabled));
--
--            return
--              Process_Page
--               (Context,
--                False,
--                Session,
--                Get_Stream (Context, Signup_Exists_Template_File),
--                Parameters);
--         end if;
--      end if;
--
--      if Errors /= No_Signup_Errors then
--         return Process_Signup_Template (Context, Session, Email, Errors);
--      end if;
--
--      --  Create new account and assign confirmation code to it.
--
--      User := Server.Globals.User_Store.Create (Email);
--
--      return Activate (Context, Session, User, True);
--   end Signup;

end AWFC.Accounts.Account_Servlets;
