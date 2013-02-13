------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                          Open Document Toolkit                           --
--                                                                          --
--                        Runtime Library Component                         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2013, Vadim Godunko <vgodunko@gmail.com>                     --
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
with Ada.Containers.Hashed_Maps;

with AWS.Response;
with AWS.Status;

with ODF.DOM.Documents;
with XML.DOM.Nodes;

package ODF.Web is

   function To_JSON
    (Styles  : not null ODF.DOM.Documents.ODF_Document_Access;
     Content : not null ODF.DOM.Documents.ODF_Document_Access)
       return String;

   function Callback (Request : AWS.Status.Data) return AWS.Response.Data;

   type ODF_File is record
      Styles  : ODF.DOM.Documents.ODF_Document_Access;
      Content : ODF.DOM.Documents.ODF_Document_Access;
   end record;

   function Hash (Item : Positive) return Ada.Containers.Hash_Type;

   function Hash
    (Item : XML.DOM.Nodes.DOM_Node_Access) return Ada.Containers.Hash_Type;

   package Identifier_Node_Maps is
     new Ada.Containers.Hashed_Maps
          (Positive,
           XML.DOM.Nodes.DOM_Node_Access,
           Hash,
           "=",
           XML.DOM.Nodes."=");

   package Node_Identifier_Maps is
     new Ada.Containers.Hashed_Maps
          (XML.DOM.Nodes.DOM_Node_Access,
           Positive,
           Hash,
           XML.DOM.Nodes."=");

   Document      : ODF_File;
   To_Node       : Identifier_Node_Maps.Map;
   To_Identifier : Node_Identifier_Maps.Map;
   Unused_Id     : Positive := 1;

end ODF.Web;
