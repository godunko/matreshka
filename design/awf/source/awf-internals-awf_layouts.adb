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
with AWF.Internals.AWF_Widgets;

package body AWF.Internals.AWF_Layouts is

   ------------------
   -- Constructors --
   ------------------

   package body Constructors is

      ----------------
      -- Initialize --
      ----------------

      procedure Initialize (Self : not null access AWF_Layout_Proxy'Class) is
      begin
         League.Objects.Impl.Constructors.Initialize (Self);
      end Initialize;

   end Constructors;

   -----------------
   -- Render_Body --
   -----------------

   not overriding procedure Render_Body
    (Self    : not null access AWF_Layout_Proxy;
     Context : in out AWF.HTML_Writers.HTML_Writer'Class)
   is
      Children : constant League.Objects.Object_Access_Array
        := Self.Parent.Children;

   begin
      Context.Start_Table;
      Context.Start_Tr;

      for J in Children'Range loop
         if Children (J).all
              in AWF.Internals.AWF_Widgets.AWF_Widget_Proxy'Class
         then
            Context.Start_Td;
            AWF.Internals.AWF_Widgets.AWF_Widget_Proxy_Access
             (Children (J)).Render_Body (Context);
            Context.End_Td;
         end if;
      end loop;

      Context.End_Tr;
      Context.End_Table;
   end Render_Body;

end AWF.Internals.AWF_Layouts;
