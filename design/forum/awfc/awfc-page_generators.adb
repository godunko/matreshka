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
-- Copyright © 2015-2023, Vadim Godunko <vgodunko@gmail.com>                --
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

with Ada.Wide_Wide_Text_IO;

with XML.SAX.Error_Handlers;
with XML.SAX.Event_Readers;
with XML.SAX.Event_Writers;
with XML.SAX.File_Input_Sources;
with XML.SAX.HTML5_Writers;
with XML.SAX.Parse_Exceptions;
with XML.SAX.Simple_Readers;
with XML.SAX.String_Output_Destinations;

package body AWFC.Page_Generators is

   use type League.Strings.Universal_String;

   function "+"
    (Item : Wide_Wide_String) return League.Strings.Universal_String
       renames League.Strings.To_Universal_String;

   function Get_Stream
    (Context : not null access constant Servlet.Contexts.Servlet_Context'Class;
     File    : League.Strings.Universal_String)
       return XML.Templates.Streams.XML_Stream_Element_Vectors.Vector;
   --  Loads XML file and converts it into stream of SAX events.

   type Error_Handler is
     limited new XML.SAX.Error_Handlers.SAX_Error_Handler with null record;
   --  XXX This type should be declared to be reusable and should be integrated
   --  into some general logging facility.

   overriding function Error_String
    (Self : Error_Handler) return League.Strings.Universal_String;
   --  Returns error message when processing was terminated by error handler.

   overriding procedure Fatal_Error
    (Self       : in out Error_Handler;
     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception);
   --  Process fatal error in XML data. Outputs message to standard error.

   package Constants is
      Head_Tag  : League.Strings.Universal_String := +"head";
      Title_Tag : League.Strings.Universal_String := +"title";
      Base_Tag  : League.Strings.Universal_String := +"base";
      Body_Tag  : League.Strings.Universal_String := +"body";
      Target    : League.Strings.Universal_String
        := +"matreshka-page-content";
   end Constants;

   ------------------
   -- Error_String --
   ------------------

   overriding function Error_String
    (Self : Error_Handler) return League.Strings.Universal_String is
   begin
      return League.Strings.Empty_Universal_String;
   end Error_String;

   -----------------
   -- Fatal_Error --
   -----------------

   overriding procedure Fatal_Error
    (Self       : in out Error_Handler;
     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception)
   is
      Line   : constant Wide_Wide_String
        := Integer'Wide_Wide_Image (Occurrence.Line);
      Column : constant Wide_Wide_String
        := Integer'Wide_Wide_Image (Occurrence.Column);

   begin
      Ada.Wide_Wide_Text_IO.Put_Line
       (Ada.Wide_Wide_Text_IO.Standard_Error,
        Occurrence.System_Id.To_Wide_Wide_String
          & ':'
          & Line (Line'First + 1 .. Line'Last)
          & ':'
          & Column (Column'First + 1 .. Column'Last)
          & ": "
          & Occurrence.Message.To_Wide_Wide_String);
   end Fatal_Error;

   ------------------------------
   -- Get_Page_Template_Stream --
   ------------------------------

   function Get_Page_Template_Stream
     (Self : Abstract_Page_Generator'Class)
      return XML.Templates.Streams.XML_Stream_Element_Vectors.Vector is
   begin
      return Self.Page;
   end Get_Page_Template_Stream;

   ----------------
   -- Get_Stream --
   ----------------

   function Get_Stream
    (Context : not null access constant Servlet.Contexts.Servlet_Context'Class;
     File    : League.Strings.Universal_String)
       return XML.Templates.Streams.XML_Stream_Element_Vectors.Vector
   is
      Input  : aliased XML.SAX.File_Input_Sources.File_Input_Source;
      Reader : XML.SAX.Simple_Readers.Simple_Reader;
      Writer : aliased XML.SAX.Event_Writers.Event_Writer;
      Error  : aliased Error_Handler;

   begin
      --  Configure reader.

      Reader.Set_Input_Source (Input'Unchecked_Access);
      Reader.Set_Content_Handler (Writer'Unchecked_Access);
      Reader.Set_Lexical_Handler (Writer'Unchecked_Access);
      Reader.Set_Error_Handler (Error'Unchecked_Access);

      --  Parse file.

      Input.Open_By_File_Name (Context.Get_Real_Path (File));
      Reader.Parse;
      Input.Close;

      return Writer.Get_Stream;
   end Get_Stream;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize
    (Self             : in out Abstract_Page_Generator'Class;
     Context          :
       not null access constant Servlet.Contexts.Servlet_Context'Class;
     Page_Template    : League.Strings.Universal_String;
     Content_Template : League.Strings.Universal_String)
   is
      use XML.Templates.Streams;

      Content : XML.Templates.Streams.XML_Stream_Element_Vectors.Vector
        := Get_Stream (Context, Content_Template);
      Page    : XML.Templates.Streams.XML_Stream_Element_Vectors.Vector
        := Get_Stream (Context, Page_Template);

      procedure Append_Content_Body;

      procedure Append_Content_Head
        (Title_Item : in out XML.Templates.Streams.XML_Stream_Element;
         Title_Text : League.Strings.Universal_String;
         Base_Item  : in out XML.Templates.Streams.XML_Stream_Element);

      procedure Process_Title
        (Title_Text : out League.Strings.Universal_String);

      procedure Process_Body;
      procedure Process_Head;

      -------------------------
      -- Append_Content_Body --
      -------------------------

      procedure Append_Content_Body is
         Item : XML.Templates.Streams.XML_Stream_Element;

      begin
         for Body_Start in Content.First_Index .. Content.Last_Index loop
            --  Look for <body> in Content

            Item := Content.Element (Body_Start);

            if Item.Kind = Start_Element
              and then Item.Local_Name in Constants.Body_Tag
            then
               --  Look for </body> in Content

               for Index in Body_Start + 1 .. Content.Last_Index loop
                  Item := Content.Element (Index);

                  exit when Item.Kind = End_Element
                    and then Item.Local_Name in Constants.Body_Tag;

                  --  Copy everething else
                  Self.Page.Append (Item);
               end loop;

               exit;
            end if;
         end loop;
      end Append_Content_Body;

      -------------------------
      -- Append_Content_Head --
      -------------------------

      procedure Append_Content_Head
        (Title_Item : in out XML.Templates.Streams.XML_Stream_Element;
         Title_Text : League.Strings.Universal_String;
         Base_Item  : in out XML.Templates.Streams.XML_Stream_Element) is
      begin
         --  Look for <head> in Content
         while not Content.Is_Empty loop
            declare
               Item : constant XML.Templates.Streams.XML_Stream_Element
                 := Content.First_Element;
            begin
               Content.Delete_First;

               if Item.Kind = Start_Element
                 and then Item.Local_Name in Constants.Head_Tag
               then
                  exit;
               end if;
            end;
         end loop;

         while not Content.Is_Empty loop
            declare
               Item : constant XML.Templates.Streams.XML_Stream_Element
                 := Content.First_Element;
            begin
               Content.Delete_First;

               if Item.Kind = End_Element
                 and then Item.Local_Name in Constants.Head_Tag
               then
                  exit;
               elsif Item.Kind = Start_Element
                 and then Item.Local_Name in Constants.Title_Tag
               then
                  Title_Item := (Kind => Empty);
               elsif Item.Kind = Start_Element
                 and then Item.Local_Name in Constants.Base_Tag
               then
                  Base_Item := (Kind => Empty);
               end if;

               --  Copy everething else
               Self.Page.Append (Item);
            end;
         end loop;

         if Base_Item.Kind = Start_Element then
            Self.Page.Append (Base_Item);
            Self.Page.Append
              (XML_Stream_Element'
                 (Kind           => End_Element,
                  Location       => Base_Item.Location,
                  Namespace_URI  => Base_Item.Namespace_URI,
                  Local_Name     => Base_Item.Local_Name,
                  Qualified_Name => Base_Item.Qualified_Name));
         end if;

         if Title_Item.Kind = Start_Element then
            Self.Page.Append (Title_Item);

            if not Title_Text.Is_Empty then
               Self.Page.Append
                 (XML_Stream_Element'
                    (Kind     => Text,
                     Location => Title_Item.Location,
                     Text     => Title_Text));
            end if;

            Self.Page.Append
              (XML_Stream_Element'
                 (Kind           => End_Element,
                  Location       => Title_Item.Location,
                  Namespace_URI  => Title_Item.Namespace_URI,
                  Local_Name     => Title_Item.Local_Name,
                  Qualified_Name => Title_Item.Qualified_Name));
         end if;
      end Append_Content_Head;

      ------------------
      -- Process_Body --
      ------------------

      procedure Process_Body is
      begin
         --  Copy <body> of Page
         while not Page.Is_Empty loop
            declare
               Item : constant XML.Templates.Streams.XML_Stream_Element
                 := Page.First_Element;
            begin
               Page.Delete_First;

               if Item.Kind = Processing_Instruction
                 and then Item.Target in Constants.Target
               then
                  Append_Content_Body;
               else
                  Self.Page.Append (Item);
               end if;
            end;
         end loop;
      end Process_Body;

      ------------------
      -- Process_Head --
      ------------------

      procedure Process_Head is
         use Constants;

         Title_Item : XML_Stream_Element;
         Title_Text : League.Strings.Universal_String;
         Base_Item  : XML_Stream_Element;
      begin
         --  Look for <head> in Page and copy any element until we find it
         while not Page.Is_Empty loop
            declare
               Item : constant XML.Templates.Streams.XML_Stream_Element
                 := Page.First_Element;
            begin
               Page.Delete_First;
               Self.Page.Append (Item);

               if Item.Kind = Start_Element
                 and then Item.Local_Name = Head_Tag
               then
                  exit;
               end if;
            end;
         end loop;

         --  Process all elemnts in <head> of Page
         while not Page.Is_Empty loop
            declare
               Item : constant XML.Templates.Streams.XML_Stream_Element
                 := Page.First_Element;
            begin
               Page.Delete_First;

               if Item.Kind = End_Element
                 and then Item.Local_Name = Head_Tag
               then
                  Append_Content_Head (Title_Item, Title_Text, Base_Item);

                  Self.Page.Append (Item);
                  exit;
               elsif Item.Kind = Start_Element
                 and then Item.Local_Name = Title_Tag
               then
                  --  Remember <title> if found
                  Title_Item := Item;
                  Process_Title (Title_Text);
               elsif Item.Kind = Start_Element
                 and then Item.Local_Name = Base_Tag
               then
                  --  Remember <base> if found
                  Base_Item := Item;
               elsif Item.Kind = End_Element
                 and then Item.Local_Name = Base_Tag
               then
                  --  Ignore </base> if found
                  null;
               else
                  --  Copy everething else
                  Self.Page.Append (Item);
               end if;
            end;
         end loop;
      end Process_Head;

      -------------------
      -- Process_Title --
      -------------------

      procedure Process_Title
        (Title_Text : out League.Strings.Universal_String) is
      begin
         while not Page.Is_Empty loop
            declare
               Item : constant XML.Templates.Streams.XML_Stream_Element
                 := Page.First_Element;
            begin
               Page.Delete_First;

               if Item.Kind = End_Element
                 and then Item.Local_Name in Constants.Title_Tag
               then
                  exit;
               elsif Item.Kind = Text then
                  Title_Text.Append (Item.Text);
               end if;
            end;
         end loop;
      end Process_Title;

   begin
      Self.Page.Clear;

      Process_Head;
      Process_Body;
   end Initialize;

   ------------
   -- Render --
   ------------

   function Render
    (Self    : in out Abstract_Page_Generator'Class;
     Context : Abstract_Rendering_Context'Class)
       return League.Strings.Universal_String
   is
      Reader       : XML.SAX.Event_Readers.Event_Reader;
      Filter       : aliased XML.Templates.Processors.Template_Processor;
      Error        : aliased Error_Handler;
      HTML_Writer  : aliased XML.SAX.HTML5_Writers.HTML5_Writer;
      Output       : aliased
        XML.SAX.String_Output_Destinations.String_Output_Destination;

   begin
      --  Connect components.

      Reader.Set_Content_Handler (Filter'Unchecked_Access);
      Reader.Set_Lexical_Handler (Filter'Unchecked_Access);
      Reader.Set_Error_Handler (Error'Unchecked_Access);
      Filter.Set_Content_Handler (HTML_Writer'Unchecked_Access);
      Filter.Set_Lexical_Handler (HTML_Writer'Unchecked_Access);
      HTML_Writer.Set_Output_Destination (Output'Unchecked_Access);

      --  Bind template parameters.

      Self.Bind_Parameters (Context, Filter);

      --  Process template.

      Reader.Parse (Self.Page);

      return Output.Get_Text;
   end Render;

end AWFC.Page_Generators;
