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
with AWS.Messages;
with AWS.Response.Set;

package body Matreshka.Servlet_AWS_Responses is

   To_AWS_Status_Code : constant
     array (Servlet.HTTP_Responses.Status_Code) of AWS.Messages.Status_Code
       := (Servlet.HTTP_Responses.Continue               => AWS.Messages.S100,
           Servlet.HTTP_Responses.Switching_Protocols    => AWS.Messages.S101,

           Servlet.HTTP_Responses.OK                     => AWS.Messages.S200,
           Servlet.HTTP_Responses.Created                => AWS.Messages.S201,
           Servlet.HTTP_Responses.Accepted               => AWS.Messages.S202,
           Servlet.HTTP_Responses.Non_Authoritative_Information =>
                                                            AWS.Messages.S203,
           Servlet.HTTP_Responses.No_Content             => AWS.Messages.S204,
           Servlet.HTTP_Responses.Reset_Content          => AWS.Messages.S205,
           Servlet.HTTP_Responses.Partial_Content        => AWS.Messages.S206,

           Servlet.HTTP_Responses.Multiple_Choices       => AWS.Messages.S300,
           Servlet.HTTP_Responses.Moved_Permanently      => AWS.Messages.S301,
           Servlet.HTTP_Responses.Moved_Temporarily      => AWS.Messages.S302,
           Servlet.HTTP_Responses.Found                  => AWS.Messages.S302,
           Servlet.HTTP_Responses.See_Other              => AWS.Messages.S303,
           Servlet.HTTP_Responses.Not_Modified           => AWS.Messages.S304,
           Servlet.HTTP_Responses.Use_Proxy              => AWS.Messages.S305,
           Servlet.HTTP_Responses.Temporary_Redirect     => AWS.Messages.S307,

           Servlet.HTTP_Responses.Bad_Request            => AWS.Messages.S400,
           Servlet.HTTP_Responses.Unauthorized           => AWS.Messages.S401,
           Servlet.HTTP_Responses.Payment_Required       => AWS.Messages.S402,
           Servlet.HTTP_Responses.Forbidden              => AWS.Messages.S403,
           Servlet.HTTP_Responses.Not_Found              => AWS.Messages.S404,
           Servlet.HTTP_Responses.Method_Not_Allowed     => AWS.Messages.S405,
           Servlet.HTTP_Responses.Not_Acceptable         => AWS.Messages.S406,
           Servlet.HTTP_Responses.Proxy_Authentication_Required =>
                                                            AWS.Messages.S407,
           Servlet.HTTP_Responses.Request_Timeout        => AWS.Messages.S408,
           Servlet.HTTP_Responses.Conflict               => AWS.Messages.S409,
           Servlet.HTTP_Responses.Gone                   => AWS.Messages.S410,
           Servlet.HTTP_Responses.Length_Required        => AWS.Messages.S411,
           Servlet.HTTP_Responses.Precondition_Failed    => AWS.Messages.S412,
           Servlet.HTTP_Responses.Request_Entity_Too_Large =>
                                                            AWS.Messages.S413,
           Servlet.HTTP_Responses.Request_URI_Too_Long   => AWS.Messages.S414,
           Servlet.HTTP_Responses.Unsupported_Media_Type => AWS.Messages.S415,
           Servlet.HTTP_Responses.Requested_Range_Not_Satisfiable =>
                                                            AWS.Messages.S416,
           Servlet.HTTP_Responses.Expectation_Failed     => AWS.Messages.S417,

           Servlet.HTTP_Responses.Internal_Server_Error  => AWS.Messages.S500,
           Servlet.HTTP_Responses.Not_Implemented        => AWS.Messages.S501,
           Servlet.HTTP_Responses.Bad_Gateway            => AWS.Messages.S502,
           Servlet.HTTP_Responses.Service_Unavailable    => AWS.Messages.S503,
           Servlet.HTTP_Responses.Gateway_Timeout        => AWS.Messages.S504,
           Servlet.HTTP_Responses.HTTP_Version_Not_Supported =>
                                                            AWS.Messages.S505);

   -----------
   -- Build --
   -----------

   function Build
    (Self : AWS_Servlet_Response'Class) return AWS.Response.Data is
   begin
      return Self.Data;
   end Build;

   ----------------
   -- Set_Status --
   ----------------

   overriding procedure Set_Status
    (Self   : in out AWS_Servlet_Response;
     Status : Servlet.HTTP_Responses.Status_Code) is
   begin
      Matreshka.Servlet_HTTP_Responses.Abstract_Servlet_Response
       (Self).Set_Status (Status);

      AWS.Response.Set.Status_Code (Self.Data, To_AWS_Status_Code (Status));
   end Set_Status;

end Matreshka.Servlet_AWS_Responses;
