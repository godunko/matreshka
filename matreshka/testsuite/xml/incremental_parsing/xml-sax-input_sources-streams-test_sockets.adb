------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               XML Processor                              --
--                                                                          --
--                            Testsuite Component                           --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- Copyright © 2010, Vadim Godunko <vgodunko@gmail.com>                     --
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
with Ada.Text_IO;
with Ada.Unchecked_Conversion;

package body XML.SAX.Input_Sources.Streams.Test_Sockets is

   Pass : Integer := 0;

   -------------------------------
   --  To_Stream_Element_Array  --
   -------------------------------

   function To_Stream_Element_Array (Value : String)
      return Ada.Streams.Stream_Element_Array;

   -------------------------------
   --  To_Stream_Element_Array  --
   -------------------------------

   function To_Stream_Element_Array (Value : String)
     return Ada.Streams.Stream_Element_Array
   is
      subtype Source is String (Value'Range);
      subtype Result is Ada.Streams.Stream_Element_Array
        (Ada.Streams.Stream_Element_Offset (Value'First)
           .. Ada.Streams.Stream_Element_Offset (Value'Last));

      function To_Array is
         new Ada.Unchecked_Conversion (Source, Result);
   begin
      return To_Array (Value);
   end To_Stream_Element_Array;

   ----------
   -- Read --
   ----------

   overriding procedure Read
    (Self        : in out Test_Socket_Input_Source;
     Buffer      : out Ada.Streams.Stream_Element_Array;
     Last        : out Ada.Streams.Stream_Element_Offset;
     End_Of_Data : out Boolean)
   is

   begin
      case Pass is
         --  Reading for the first time;

         when 0 =>
            declare
               S   : String := "<A x='0'>123</A>";
               Tmp : Ada.Streams.Stream_Element_Array
                 := To_Stream_Element_Array (S);

               I   : Ada.Streams.Stream_Element_Offset := Buffer'First;

            begin
               for J in Tmp'Range loop

                  Buffer (I) := Tmp (J);
                  Ada.Text_IO.Put_Line
                    (" Buffer [" & I'Img & "] = " & Character'Val (Buffer (I))
                       & " Tmp [" & J'Img & "] = " & Character'Val (Tmp (J)));
                  I := I + 1;
               end loop;

               Last := I - 1;

               Ada.Text_IO.Put_Line ("Last = " & Last'Img);

               End_Of_Data := False;
            end;

         --  Reading for the second time
         when 2 =>
               Last := Buffer'Last - 1;
               End_Of_Data := False;

         --  Reading for the second time
         when 3 =>
            declare
               Tmp : Ada.Streams.Stream_Element_Array
                 := To_Stream_Element_Array ("<B x='11'> 987 </B>");

               I   : Ada.Streams.Stream_Element_Offset;

            begin
               I := Buffer'First;

               for J in Tmp'Range loop
                  Buffer (I) := Tmp (J);
                  I := I + 1;
               end loop;

               Last := I - 1;

               End_Of_Data := False;
            end;

         when others =>
            Last := Buffer'Last - 1;
            End_Of_Data := True;
      end case;
      Pass := Pass + 1;
   end Read;

end XML.SAX.Input_Sources.Streams.Test_Sockets;
