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
with League.Holders.JSON_Objects;
with League.JSON.Objects;
with League.JSON.Values;

package body AWFC.Accounts.Pages.Signup is

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   Signup_Template_Parameters :
     constant array (Signup_Error) of League.Strings.Universal_String
       := (Email_Empty => +"emailEmpty");

   ---------------------
   -- Bind_Parameters --
   ---------------------

   overriding procedure Bind_Parameters
    (Self      : in out Signup_Page_Generator;
     Processor : in out XML.Templates.Processors.Template_Processor'Class)
   is
      Object : League.JSON.Objects.JSON_Object;

   begin
      Object.Insert (+"email", League.JSON.Values.To_JSON_Value (Self.Email));
      Object.Insert
       (+"hasErrors",
        League.JSON.Values.To_JSON_Value (Self.Errors /= No_Signup_Errors));

      for Error in Signup_Errors'Range loop
         Object.Insert
          (Signup_Template_Parameters (Error),
           League.JSON.Values.To_JSON_Value (Self.Errors (Error)));
      end loop;

      Processor.Set_Parameter
        (+"account", League.Holders.JSON_Objects.To_Holder (Object));
   end Bind_Parameters;

   ------------
   -- Render --
   ------------

   function Render
    (Self    : in out Signup_Page_Generator'Class;
     Session : Servlet.HTTP_Sessions.HTTP_Session'Class)
       return League.Strings.Universal_String is
   begin
      return
        Self.Render
         (Session,
          League.Strings.Empty_Universal_String,
          No_Signup_Errors);
   end Render;

   ------------
   -- Render --
   ------------

   function Render
    (Self    : in out Signup_Page_Generator'Class;
     Session : Servlet.HTTP_Sessions.HTTP_Session'Class;
     Email   : League.Strings.Universal_String;
     Errors  : Signup_Errors)
       return League.Strings.Universal_String is
   begin
      Self.Email  := Email;
      Self.Errors := Errors;

      return AWFC.Page_Generators.Render (Self, Session);
   end Render;

end AWFC.Accounts.Pages.Signup;
