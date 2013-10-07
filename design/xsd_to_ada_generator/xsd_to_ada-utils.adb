------------------------------------------------------------------------------
--                                                                          --
--                            Matreshka Project                             --
--                                                                          --
--                               XML Processor                              --
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
--  $Revision: 3559 $ $Date: 2012-12-07 13:08:31 +0200 (Пт., 07 дек. 2012) $
------------------------------------------------------------------------------

with Ada.Text_IO;
with Ada.Strings.Wide_Wide_Fixed;
with Ada.Strings.Wide_Wide_Maps;
with Ada.Strings.Wide_Wide_Unbounded;
with League.Strings;

with XML.SAX.Input_Sources.Streams.Files;
with XML.SAX.Simple_Readers;

with XML.Schema.Model_Groups;
with XML.Schema.Objects.Particles;
with XML.Schema.Objects.Terms.Model_Groups;
with XML.Schema.Object_Lists;
with XML.Schema.Complex_Type_Definitions;
with XML.Schema.Simple_Type_Definitions;
with XML.Schema.Element_Declarations;
with XML.Schema.Objects.Type_Definitions.Complex_Type_Definitions;
use XML.Schema.Objects.Type_Definitions.Complex_Type_Definitions;

with XSD_To_Ada.Mappings;
with XSD_To_Ada.Mappings_XML;
with League.String_Vectors;
with XML.Schema.Named_Maps;

with XML.Schema.Models;
with XML.Schema.Objects;
with XSD_To_Ada.Writers;
use XSD_To_Ada.Writers;

package body XSD_To_Ada.Utils is

   function Add_Separator
     (Text : Wide_Wide_String) return Wide_Wide_String
   is
      subtype Upper_Char_List  is Wide_Wide_Character range 'A' .. 'Z';
      subtype Lower_Char_List is Wide_Wide_Character range 'a' .. 'z';

      US_Text    : League.Strings.Universal_String;
      Uper_Count : Natural := 0;
   begin

      if Text = "" then
         return "Add_Separator ERROR";
--         raise Constraint_Error with "Add_Separator ERROR";
      end if;

      US_Text.Append (Text (Text'First));

      for J in 2 .. Text'Length - 1 loop

         if Text (J) in Upper_Char_List
           and then Text (J - 1) in Upper_Char_List
         then
            Uper_Count := Uper_Count + 1;
         end if;

         if Text (J) in Lower_Char_List
           and then Text (J - 1) in Lower_Char_List
         then
            Uper_Count := 0;
         end if;

         if Text (J) in Lower_Char_List
             and then Text (J + 1) in Upper_Char_List
         then
            US_Text.Append (Text (J));
            US_Text.Append ("_");
            Uper_Count := 0;

         elsif Uper_Count > 1
                and then Text (J) in Upper_Char_List
                and then Text (J + 2) in Lower_Char_List
         then
            US_Text.Append (Text (J));

            US_Text.Append ("_");
            Uper_Count := 0;
         else
            US_Text.Append (Text (J));
         end if;
      end loop;

      US_Text.Append (Text (Text'Last));

      return US_Text.To_Wide_Wide_String;

   end Add_Separator;

   function Add_Separator
     (Text : League.Strings.Universal_String) return Wide_Wide_String is
   begin
     return Add_Separator (Text.To_Wide_Wide_String);
   end Add_Separator;

   procedure Create_Element_Type
     (Model  : XML.Schema.Models.XS_Model;
      Writer : in out XSD_To_Ada.Writers.Writer)
   is
      Element_Declarations : constant XML.Schema.Named_Maps.XS_Named_Map :=
        Model.Get_Components_By_Namespace
          (Object_Type => XML.Schema.Element_Declaration,
           Namespace   => Namespace);

      Type_D : XML.Schema.Type_Definitions.XS_Type_Definition;

      Print_Element : Boolean := True;

   begin
      for J in 1 .. Element_Declarations.Length loop

         Print_Element := True;

         for X in 1 .. Types_Table'Last loop
            if Element_Declarations.Item (J).Get_Name.To_UTF_8_String
              = Types_Table (X).Type_Name.To_UTF_8_String
            then
               Print_Element := False;
            end if;
         end loop;

         if Print_Element
           and Element_Declarations.Item (J).Get_Name.To_UTF_8_String
           /= "Transaction"
         then
            declare
               XS_Term : XML.Schema.Objects.Terms.XS_Term;
               Decl    : XML.Schema.Element_Declarations.XS_Element_Declaration;
               Name    : League.Strings.Universal_String;
            begin
               Decl := Element_Declarations.Item (J).To_Element_Declaration;
               Type_D := Decl.Get_Type_Definition;

               Name := Find_Type (Type_D.Get_Name, Map);

               if Element_Declarations.Item (J).Get_Name.Length > 10
               then
                  if  League.Strings.Slice
                    (Element_Declarations.Item (J).Get_Name,
                     Element_Declarations.Item (J).Get_Name.Length - 7,
                     Element_Declarations.Item (J).Get_Name.Length).To_UTF_8_String = "Response"
                  then
                     Writers.P
                       (Writer,
                        "   type "
                        & Add_Separator
                          (Element_Declarations.Item (J).Get_Name)
                        & " is "
                        & Wide_Wide_Character'Val (10)
                        & "     new Abstract_IATS_Responce with "
                        & Wide_Wide_Character'Val (10)
                        & "       record"
                        & Wide_Wide_Character'Val (10)
                        & "         "
                        & Gen_Type_Line (Add_Separator (Type_D.Get_Name)
                        & " : "
                        & Name.To_Wide_Wide_String & ";", 12)
                        & Wide_Wide_Character'Val (10)
                        & "       end record;" & Wide_Wide_Character'Val (10));

                     Gen_Access_Type
                       (Writer,
                        Add_Separator (Element_Declarations.Item (J).Get_Name));
                  else

                     if XSD_To_Ada.Utils.Has_Element_Session
                       (Type_D.To_Type_Definition)
                       and then Type_D.Get_Base_Type.Get_Name.To_UTF_8_String = ""
                     then

                        Writers.P
                          (Writer,
                           "   type "
                           & Add_Separator
                             (Element_Declarations.Item (J).Get_Name.To_Wide_Wide_String)
                           & " is "
                           & Wide_Wide_Character'Val (10)
                           & "     new "
                           & Name.To_Wide_Wide_String
                           & " with null record;"
                           & Wide_Wide_Character'Val (10));
                     else

                        if Element_Declarations.Item (J).Get_Name.To_UTF_8_String
                          /= "OpenSession2"
                        then
                           Writers.P
                             (Writer,
                              "   type "
                              & Add_Separator
                                (Element_Declarations.Item (J).Get_Name.To_Wide_Wide_String)
                              & " is "
                              & Wide_Wide_Character'Val (10)
                              & "     new Web_Services.SOAP.Payloads.Abstract_SOAP_Payload"
                              & " with record");

                           XSD_To_Ada.Utils.Print_Content_Type
                             (Type_D,
                              "",
                              Writer, Writer,
                              Type_D.Get_Name,
                              Map);

                           Writers.P
                             (Writer,
                              "   end record;" & Wide_Wide_Character'Val (10));
                        end if;
                     end if;
                  end if;
               end if;
            end;
         end if;
      end loop;
   end Create_Element_Type;

   procedure Create_Simple_Type
     (Model  : XML.Schema.Models.XS_Model;
      Writer : in out XSD_To_Ada.Writers.Writer)
   is
      XS_Object : XML.Schema.Objects.XS_Object;
      STD       : XML.Schema.Simple_Type_Definitions.XS_Simple_Type_Definition;
      XS_Base   : XML.Schema.Type_Definitions.XS_Type_Definition;
      Type_D    : XML.Schema.Type_Definitions.XS_Type_Definition;

      Simple_Types : constant XML.Schema.Named_Maps.XS_Named_Map :=
        Model.Get_Components_By_Namespace
          (Object_Type => XML.Schema.Simple_Type,
           Namespace   => Namespace);

   begin
      for J in 1 .. Simple_Types.Length loop
         XS_Object := Simple_Types.Item (J);
         Type_D    := XS_Object.To_Type_Definition;
         XS_Base   := Type_D.Get_Base_Type;

         STD := XS_Object.To_Simple_Type_Definition;

         declare
            List : constant League.String_Vectors.Universal_String_Vector
              := STD.Get_Lexical_Enumeration;
         begin

            if List.Is_Empty then
               XSD_To_Ada.Writers.P
                 (Writer,
                  "type " &
                    XSD_To_Ada.Utils.Add_Separator (XS_Object.Get_Name)
                  & " is new "
                  & XSD_To_Ada.Utils.Add_Separator (XS_Base.Get_Name)
                  & ";" & Wide_Wide_Character'Val (10));
            else
               XSD_To_Ada.Writers.N
                 (Writer,
                  "type " &
                    XSD_To_Ada.Utils.Add_Separator (XS_Object.Get_Name)
                  & " is (");

               for J in 1 .. List.Length loop
                  if J /= List.Length then
                     XSD_To_Ada.Writers.N
                       (Writer,
                        League.Strings.To_Lowercase
                          (List.Element (J)).To_Wide_Wide_String & ", ");
                  else
                     XSD_To_Ada.Writers.P
                       (Writer,
                        League.Strings.To_Lowercase
                          (List.Element (J)).To_Wide_Wide_String
                        & ");"
                        & Wide_Wide_Character'Val (10));
                  end if;
               end loop;
            end if;
         end;
      end loop;
   end Create_Simple_Type;

   procedure Create_Enumeration_Simple_Type
     (Model  : XML.Schema.Models.XS_Model;
      Writer : in out XSD_To_Ada.Writers.Writer)
   is

      XS_Object : XML.Schema.Objects.XS_Object;
      STD       : XML.Schema.Simple_Type_Definitions.XS_Simple_Type_Definition;
      XS_Base   : XML.Schema.Type_Definitions.XS_Type_Definition;
      Type_D    : XML.Schema.Type_Definitions.XS_Type_Definition;

      Simple_Types : constant XML.Schema.Named_Maps.XS_Named_Map :=
        Model.Get_Components_By_Namespace
          (Object_Type => XML.Schema.Simple_Type,
           Namespace   => Namespace);

   begin
      for J in 1 .. Simple_Types.Length loop
         XS_Object := Simple_Types.Item (J);
         Type_D    := XS_Object.To_Type_Definition;
         XS_Base   := Type_D.Get_Base_Type;

         STD := XS_Object.To_Simple_Type_Definition;

         declare
            List : constant League.String_Vectors.Universal_String_Vector
              := STD.Get_Lexical_Enumeration;
         begin
            if not List.Is_Empty then
               XSD_To_Ada.Writers.N
                 (Writer,
                  "   type " &
                    XSD_To_Ada.Utils.Add_Separator
                    (XS_Object.Get_Name.To_Wide_Wide_String) & " is "
                    & Wide_Wide_Character'Val (10) & "     (");

               for J in 1 .. List.Length loop
                  Ada.Text_IO.Put_Line (List.Element (J).To_UTF_8_String);

                  if J /= List.Length then
                     XSD_To_Ada.Writers.N
                       (Writer,
                        League.Strings.To_Lowercase
                          (List.Element (J)).To_Wide_Wide_String & ", ");
                  else
                     XSD_To_Ada.Writers.P
                       (Writer,
                        League.Strings.To_Lowercase
                          (List.Element (J)).To_Wide_Wide_String
                        & ");"
                        & Wide_Wide_Character'Val (10));
                  end if;
               end loop;
            end if;
         end;
      end loop;
   end Create_Enumeration_Simple_Type;

   procedure Create_Complex_Type (Model  : XML.Schema.Models.XS_Model)
   is
      XS_Object : XML.Schema.Objects.XS_Object;
      Type_D    : XML.Schema.Type_Definitions.XS_Type_Definition;

      Complex_Types : constant XML.Schema.Named_Maps.XS_Named_Map :=
        Model.Get_Components_By_Namespace
          (Object_Type => XML.Schema.Complex_Type,
           Namespace   => Namespace);

      Payload_Writer          : XSD_To_Ada.Writers.Writer;
      Payload_Type_Writer     : XSD_To_Ada.Writers.Writer;

      US_Response : League.Strings.Universal_String;

      Current_Out_File : Ada.Text_IO.File_Type;

   begin
      Writers.P
        (Payload_Writer,
         "with Ada.Containers.Indefinite_Vectors;" & Wide_Wide_Character'Val (10)
         & "with League.Strings;" & Wide_Wide_Character'Val (10)
         & "with Interfaces;" & Wide_Wide_Character'Val (10)
         & "with ICTS.Types;" & Wide_Wide_Character'Val (10)
          & "with ICTS.Forex;" & Wide_Wide_Character'Val (10)
         & "with ICTSClient.Types;" & Wide_Wide_Character'Val (10)
         & "with Web_Services.SOAP.Payloads;" & Wide_Wide_Character'Val (10)
         & "with Ada.Strings.Unbounded;"
         & Wide_Wide_Character'Val (10) & Wide_Wide_Character'Val (10)
         & "package Payloads_2 is"
         & Wide_Wide_Character'Val (10) & Wide_Wide_Character'Val (10)
         & "   type Decimal_String is new Ada.Strings.Unbounded.Unbounded_String;"
         & Wide_Wide_Character'Val (10)
         & "   Null_Decimal : constant Decimal_String :="
         & Wide_Wide_Character'Val (10)
         & "     Decimal_String (Ada.Strings.Unbounded.Null_Unbounded_String);"
         & Wide_Wide_Character'Val (10) & Wide_Wide_Character'Val (10)
         & "   type Rate_String is new Ada.Strings.Unbounded.Unbounded_String;"
         & Wide_Wide_Character'Val (10)
         & "   Null_Rate : constant Rate_String :="
         & Wide_Wide_Character'Val (10)
         & "     Rate_String (Ada.Strings.Unbounded.Null_Unbounded_String);"
         & Wide_Wide_Character'Val (10) & Wide_Wide_Character'Val (10)
         & "   type TimeT is new Interfaces.Unsigned_64;"
         & Wide_Wide_Character'Val (10) & Wide_Wide_Character'Val (10)
         & "   type Diagnosis_Code is range 0 .. 2 ** 32 - 1;"
         & Wide_Wide_Character'Val (10) & Wide_Wide_Character'Val (10)
         & "   type Abstract_IATS_Responce is" & Wide_Wide_Character'Val (10)
         & "     abstract new Web_Services.SOAP.Payloads.Abstract_SOAP_Payload"
         & Wide_Wide_Character'Val (10)
         & "     with null record;"
         & Wide_Wide_Character'Val (10));

      Create_Enumeration_Simple_Type (Model, Payload_Writer);

      Map :=
        XSD_To_Ada.Utils.Read_Mapping
          (League.Strings.To_Universal_String ("./mapping.xml"));

      for J in 1 .. Complex_Types.Length loop
         Types_Table (J).Type_Name := Complex_Types.Item (J).Get_Name;
         Types_Table (J).Type_State := True;
      end loop;

      for J in 1 .. Complex_Types.Length loop
         XS_Object := Complex_Types.Item (J);

         for J in 1 .. Anonyn_Vector'Last loop
            Anonyn_Vector (J).Print_State := False;
            Anonyn_Vector (J).Term_State := False;
         end loop;

         if Complex_Types.Item (J).Get_Name.To_UTF_8_String /= "OpenSession"
--           if Complex_Types.Item (J).Get_Name.To_UTF_8_String = "ModifyOrderBase"
--             if Complex_Types.Item (J).Get_Name.To_UTF_8_String = "BindOrders"
         then
            Print_Type_Title
              (XS_Object.To_Type_Definition,
               Payload_Writer, Payload_Type_Writer);
         end if;
      end loop;

     Create_Element_Type (Model, Payload_Writer);

      Writers.N (Payload_Writer, "end Payloads_2;");

      Ada.Text_IO.Create
        (Current_Out_File, Ada.Text_IO.Out_File, "./Payloads_2.ads");
      Ada.Text_IO.Put_Line
        (Current_Out_File, Payload_Type_Writer.Text.To_UTF_8_String);
      Ada.Text_IO.Put_Line
        (Current_Out_File, Payload_Writer.Text.To_UTF_8_String);
      Ada.Text_IO.Close (Current_Out_File);
   end Create_Complex_Type;

   ---------------------------
   -- Create_Vector_Package --
   ---------------------------

   procedure Create_Vector_Package
     (Type_D_Name  : League.Strings.Universal_String;
      Writer       : in out Writers.Writer;
      Writer_types : in out Writers.Writer)
   is
      Added_Vector_Type : Boolean := False;
   begin
      Added_Vector_Type := True;

      for J in 1 .. Is_Vector_Type.Length loop
         if Type_D_Name.To_UTF_8_String
           = Is_Vector_Type.Element (J).To_UTF_8_String
         then
            Added_Vector_Type := False;
            exit;
         else
            Added_Vector_Type := True;
         end if;
      end loop;

      if Added_Vector_Type then
          Writers.P
           (Writer_Types,
            "   package "
            & Add_Separator (Type_D_Name) & "_Vectors is "
            & Wide_Wide_Character'Val (10)
            & Gen_Type_Line
              ("     new Ada.Containers.Indefinite_Vectors "
               & "(Positive, "
               & Add_Separator (Type_D_Name) & ");", 7)
            & Wide_Wide_Character'Val (10)
            & Wide_Wide_Character'Val (10)
            & Gen_Type_Line
              ("   subtype " & Add_Separator (Type_D_Name)
               & "s is " & Add_Separator (Type_D_Name)
               & "_Vectors.Vector;", 5)
            & Wide_Wide_Character'Val (10));

         Is_Vector_Type.Append (Type_D_Name);

         if not Is_Type_In_Map (Type_D_Name, Map) then
            Writers.N (Writer, "s");
         end if;

      end if;

      Writers.P (Writer, ";");
   end Create_Vector_Package;

   ---------------
   -- Find_Type --
   ---------------

   function Find_Type
     (Type_D_Name : League.Strings.Universal_String;
      Map         : XSD_To_Ada.Mappings_XML.Mapping_XML)
      return League.Strings.Universal_String
   is
   begin
      for j in 1 .. Map.Map_Vector.Length loop
         if Type_D_Name.To_UTF_8_String =
           Map.Map_Vector.Element (J).To_UTF_8_String
         then
            return Map.Ada_Vector.Element (J);
         end if;
      end loop;

      return League.Strings.To_Universal_String
        ("Payloads_2." & XSD_To_Ada.Utils.Add_Separator (Type_D_Name));
   end Find_Type;

   --------------------
   -- Is_Type_In_Map --
   --------------------

   function Is_Type_In_Map
     (Type_D_Name : League.Strings.Universal_String;
      Map         : XSD_To_Ada.Mappings_XML.Mapping_XML)
      return Boolean
   is
   begin
      for j in 1 .. Map.Map_Vector.Length loop
         if Type_D_Name.To_UTF_8_String =
           Map.Map_Vector.Element (J).To_UTF_8_String
         then
            return True;
         end if;
      end loop;

      return False;
   end Is_Type_In_Map;

   function Is_Type_In_Optional_Vector
     (Type_Name : League.Strings.Universal_String)
      return Boolean
   is
   begin
      for Index in 1 .. Optional_Vector.Length loop
         if Optional_Vector.Element (Index).To_Wide_Wide_String =
           Type_Name.To_Wide_Wide_String
         then
            return True;
         end if;
      end loop;

      Optional_Vector.Append (Type_Name);

      return False;
   end Is_Type_In_Optional_Vector;

   ---------------------
   -- Gen_Access_Type --
   ---------------------

   procedure Gen_Access_Type
     (Self   : in out XSD_To_Ada.Writers.Writer;
      Name   : Wide_Wide_String) is
   begin
      Writers.N
        (Self,
         "   type " & Name & "_Access is access all "
         & Wide_Wide_Character'Val (10)
         & "      " & Name & "'Class;"
         & Wide_Wide_Character'Val (10) & Wide_Wide_Character'Val (10));
   end Gen_Access_Type;

   ----------------
   --  Gen_Line  --
   ----------------

   procedure Gen_Line
     (Self : in out XSD_To_Ada.Writers.Writer; Str : Wide_Wide_String := "") is
      use Ada.Strings.Wide_Wide_Unbounded;
      use Ada.Strings.Wide_Wide_Maps;

      Set : constant Wide_Wide_Character_Set := "or"
        (To_Set (Span => ('(', '(')),
         "or" (To_Set (Span => ('.', '.')), To_Set (Span => (' ', ' '))));

      S   : Unbounded_Wide_Wide_String := To_Unbounded_Wide_Wide_String (Str);
      L   : Natural;
      Tab : constant Wide_Wide_String
        (1 .. Index_Non_Blank (S) + 2) := (others => ' ');

      In_Comment : Boolean := False;

      procedure Put (Txt : Wide_Wide_String);

      ---------
      -- Put --
      ---------

      procedure Put (Txt : Wide_Wide_String) is
         use Ada.Strings.Wide_Wide_Fixed;
      begin
         if In_Comment then
            Self.P (Tab (Tab'First .. Tab'Last - 2) & "--  " & Txt
                    (Index_Non_Blank (Txt) .. Txt'Last));
         else
            In_Comment := Index (Txt, "--") >= 1;
            Self.P (Txt);
         end if;
      end Put;

   begin
      if Length (S) > 79 then
         loop
            L := Index
              (S, Set, Positive'Min (79, Length (S)),
               Ada.Strings.Inside, Ada.Strings.Backward);
            exit when L < 1;

            if Element (S, L) = '.'
              and then L + 3 <= Length (S)
              and then Slice (S, L + 1, L + 3) = "all"
            then
               L := Index
                 (S, Set, L - 1, Ada.Strings.Inside, Ada.Strings.Backward);
               exit when L < 1;
            end if;

            if Element (S, L) = ' ' then
               Put (Slice
                    (S, 1, Index_Non_Blank (S, L - 1, Ada.Strings.Backward)));

            elsif Element (S, L) = '(' then
               L := L - 1;
               Put
                 (Slice
                    (S, 1, Index_Non_Blank (S, L, Ada.Strings.Backward)));

            else
               Put (Slice (S, 1, L));
            end if;

            S := To_Unbounded_Wide_Wide_String
                  (Tab & Slice (S, L + 1, Length (S)));
            exit when Length (S) < 80;
         end loop;

         if S /= Null_Unbounded_Wide_Wide_String then
            Put (To_Wide_Wide_String (S));
         end if;

      else
         Self.P (To_Wide_Wide_String (S));
      end if;
   end Gen_Line;

   -------------------
   -- Gen_Type_Line --
   -------------------

   function Gen_Type_Line
     (Str : Wide_Wide_String := ""; Tab : Natural := 0) return Wide_Wide_String
   is
      use Ada.Strings.Wide_Wide_Unbounded;
      use Ada.Strings.Wide_Wide_Maps;

      US      : League.Strings.Universal_String
        := League.Strings.To_Universal_String (Str);
      US_New : League.Strings.Universal_String;
   begin
      if US.Length > 79 then
         for J in 1 .. US.Length loop
            if US.Element (J).To_Wide_Wide_Character = ':'
              or US.Element (J).To_Wide_Wide_Character = '('
            then
               US_New.Append (Wide_Wide_Character'Val (10));

               for Count in 1 .. Tab loop
                  US_New.Append (" ");
               end loop;

               US_New.Append (US.Element (J));

            elsif US.Element (J).To_Wide_Wide_Character = ' '
              and then US.Element (J + 1).To_Wide_Wide_Character = 'i'
              and then US.Element (J + 2).To_Wide_Wide_Character = 's'
              and then US.Element (J + 3).To_Wide_Wide_Character = ' '
            then
               US_New.Append (Wide_Wide_Character'Val (10));

               for Count in 1 .. Tab loop
                  US_New.Append (" ");
               end loop;

               US_New.Append (US.Element (J));
            else
               US_New.Append (US.Element (J));
            end if;
         end loop;

         return US_New.To_Wide_Wide_String;
      else
         return Str;
      end if;
   end Gen_Type_Line;

   ---------------------
   -- Gen_Proc_Header --
   ---------------------

   procedure Gen_Proc_Header
     (Self   : in out XSD_To_Ada.Writers.Writer;
      Name   : Wide_Wide_String;
      Offset : Positive := 3)
   is
      D : constant Wide_Wide_String (1 .. Name'Length + 6) := (others => '-');
      O : constant Wide_Wide_String (1 .. Offset) := (others => ' ');
   begin

      if D'Length > 76 then
         return;
      end if;

      Gen_Line (Self, O & D);
      Gen_Line (Self, O & "-- " & Name & " --");
      Gen_Line (Self, O & D);
      Gen_Line (Self);
   end Gen_Proc_Header;

   ------------------------
   -- Has_Top_Level_Type --
   ------------------------

   function Has_Top_Level_Type
     (Type_D : XML.Schema.Type_Definitions.XS_Type_Definition;
      Table  : Types_Table_Type_Array)
      return Boolean is
   begin
      for j in 1 .. Table'Last loop
         if Type_D.Get_Name.To_Wide_Wide_String =
           Table (J).Type_Name.To_Wide_Wide_String
           and Table (J).Type_State
         then
            return True;
         end if;
      end loop;

      return False;

   end Has_Top_Level_Type;

   --------------
   -- New_Line --
   --------------

   procedure New_Line (Self : in out XSD_To_Ada.Writers.Writer) is
   begin
      Self.P ("");
   end New_Line;

   ------------------------
   -- Print_Content_Type --
   ------------------------

   procedure Print_Content_Type
     (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
      Indent       : String := "";
      Writer       : in out Writers.Writer;
      Writer_types : in out Writers.Writer;
      Name         : League.Strings.Universal_String;
      Map          : XSD_To_Ada.Mappings_XML.Mapping_XML)
   is
      use type XML.Schema.Type_Definitions.XS_Type_Definition;

      XS_Particle    : XML.Schema.Objects.Particles.XS_Particle;
      XS_Term        : XML.Schema.Objects.Terms.XS_Term;

      CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;
      STD  : XML.Schema.Simple_Type_Definitions.XS_Simple_Type_Definition;

      ----------------
      -- Print_Term --
      ----------------

      procedure Print_Term
        (XS_Term      : XML.Schema.Objects.Terms.XS_Term;
         Indent       : String := "";
         Writer       : in out Writers.Writer;
         Writer_types : in out Writers.Writer;
         Name         : League.Strings.Universal_String;
         Map          : XSD_To_Ada.Mappings_XML.Mapping_XML)
      is
         use type XML.Schema.Objects.Terms.Model_Groups.Compositor_Kinds;

         XS_Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
         XS_List        : XML.Schema.Object_Lists.XS_Object_List;
         XS_Particle    : XML.Schema.Objects.Particles.XS_Particle;
         Decl           : XML.Schema.Element_Declarations.XS_Element_Declaration;

         Type_D    : XML.Schema.Type_Definitions.XS_Type_Definition;
         Type_Name : League.Strings.Universal_String;
      begin
         Ada.Text_IO.Put (Indent);
         Ada.Text_IO.Put_Line ("Type " & XS_Term.Get_Type'Img);
         Ada.Text_IO.Put (Indent);
         Ada.Text_IO.Put_Line
           ("XS_Term.Get_Name =" & XS_Term.Get_Name.To_UTF_8_String);

         if XS_Term.Is_Model_Group then
            XS_Model_Group := XS_Term.To_Model_Group;
            XS_List := XS_Model_Group.Get_Particles;
            Ada.Text_IO.Put_Line (Indent & XS_Model_Group.Get_Compositor'Img);

            for J in 1 .. XS_List.Get_Length loop
               Ada.Text_IO.Put (Indent);
               XS_Particle := XS_List.Item (J).To_Particle;

               Print_Term
                 (XS_Particle.Get_Term,
                  Indent & "   ", Writer, Writer_types, Name, Map);
            end loop;

         elsif XS_Term.Is_Element_Declaration then
            Decl := XS_Term.To_Element_Declaration;
            Type_D := Decl.Get_Type_Definition;

            Type_Name := Find_Type (Type_D.Get_Name, Map);

            case Type_D.Get_Type_Category is
               when XML.Schema.Complex_Type | XML.Schema.Simple_Type =>
                  Writers.P
                    (Writer,
                     "      "
                     & XSD_To_Ada.Utils.Add_Separator
                       (XS_Term.Get_Name.To_Wide_Wide_String)
                     & " : "
                     & Type_Name.To_Wide_Wide_String & ";");

               when XML.Schema.None =>
                  Ada.Text_IO.Put_Line (Indent & "NONE!!!");
            end case;
         end if;
      end Print_Term;

   begin

      if Type_D.Get_Base_Type.Get_Name.To_UTF_8_String /= "" then
         Writers.P
           (Writer,
            Gen_Type_Line ("      "
            & Add_Separator (Type_D.Get_Base_Type.Get_Name.To_Wide_Wide_String)
            & " : Payloads_2."
            & Add_Separator (Type_D.Get_Base_Type.Get_Name.To_Wide_Wide_String)
            & ";", 8));
      end if;

      case Type_D.Get_Type_Category is
         when XML.Schema.Complex_Type =>
            CTD := Type_D.To_Complex_Type_Definition;

            if CTD.Get_Content_Type in Element_Only | Mixed then
               Ada.Text_IO.Put_Line
                 (Indent & "Complex_Type :" & Type_D.Get_Name.To_UTF_8_String);

                  XS_Particle := CTD.Get_Particle;
                  XS_Term := XS_Particle.Get_Term;

                  Print_Term
                    (XS_Term, Indent & "   ", Writer, Writer_types, Name, Map);

               Ada.Text_IO.Put_Line
                 (Indent & "End Complex_Type :" & Type_D.Get_Name.To_UTF_8_String);
            end if;

         when XML.Schema.Simple_Type =>
            Ada.Text_IO.Put
              (Indent & "Simple_Type : " & Type_D.Get_Name.To_UTF_8_String);
            STD := Type_D.To_Simple_Type_Definition;

         when XML.Schema.None =>
            Ada.Text_IO.Put_Line (Indent & "NONE!!!");
      end case;
   end Print_Content_Type;

   ----------------------
   -- Print_Type_Title --
   ----------------------

   procedure Print_Type_Title
     (Type_D      : XML.Schema.Type_Definitions.XS_Type_Definition;
      Writer      : in out XSD_To_Ada.Writers.Writer;
      Type_Writer : in out XSD_To_Ada.Writers.Writer)
   is
      Is_Record   : Boolean := False;

      US_Response : League.Strings.Universal_String;

      Payload_Writer      : XSD_To_Ada.Writers.Writer;
      Payload_Type_Writer : XSD_To_Ada.Writers.Writer;
   begin

      Ada.Text_IO.Put_Line
        ("START Print_Type_Title Type_D="  & Type_D.Get_Name.To_UTF_8_String);

      for J in 1 .. Types_Table'Last loop
         if Type_D.Get_Name.To_UTF_8_String = Types_Table (J).Type_Name.To_UTF_8_String
           and then Types_Table (J).Type_State
         then
            Types_Table (J).Type_State := False;

            if Type_D.Get_Name.Length > 10 then
               US_Response := League.Strings.Slice
                 (Type_D.Get_Name,
                  Type_D.Get_Name.Length - 7,
                  Type_D.Get_Name.Length);
            end if;

            if Type_D.Get_Name.Length > 10
              and
                US_Response.To_UTF_8_String = "Response"
            then
               XSD_To_Ada.Utils.Gen_Proc_Header
                 (Payload_Writer,
                  XSD_To_Ada.Utils.Add_Separator
                    (Type_D.Get_Name.To_Wide_Wide_String));

               Writers.P
                 (Payload_Writer,
                  "   type "
                  & XSD_To_Ada.Utils.Add_Separator
                    (Type_D.Get_Name.To_Wide_Wide_String)
                  & " is new Abstract_IATS_Responce with"
                  & Wide_Wide_Character'Val (10)
                  & "     record");

               XSD_To_Ada.Utils.Print_Type_Definition
                 (Type_D,
                  "",
                  Payload_Writer, Payload_Type_Writer,
                  Type_D.Get_Name,
                  False,
                  Map,
                  Types_Table);

               Writers.P
                 (Payload_Writer, "     end record;"
                  & Wide_Wide_Character'Val (10));

               XSD_To_Ada.Utils.Gen_Access_Type
                 (Payload_Writer,
                  XSD_To_Ada.Utils.Add_Separator
                    (Type_D.Get_Name.To_Wide_Wide_String));
               US_Response.Clear;
            else
               if XSD_To_Ada.Utils.Has_Element_Session
                 (Type_D.To_Type_Definition)
               then
                  XSD_To_Ada.Utils.Gen_Proc_Header
                    (Payload_Writer,
                     XSD_To_Ada.Utils.Add_Separator
                       (Type_D.Get_Name.To_Wide_Wide_String));

                  Writers.P
                    (Payload_Writer,
                     "   type "
                     & XSD_To_Ada.Utils.Add_Separator
                       (Type_D.Get_Name.To_Wide_Wide_String)
                     & " is" & Wide_Wide_Character'Val (10)
                     & "     new Web_Services.SOAP.Payloads.Abstract_SOAP_Payload"
                     & Wide_Wide_Character'Val (10)
                     & "   with record");

                  XSD_To_Ada.Utils.Print_Type_Definition
                    (Type_D,
                     "",
                     Payload_Writer, Payload_Type_Writer,
                     Type_D.Get_Name, False, Map,
                     Types_Table);

                  Writers.P (Payload_Writer,
                             "   end record;" & Wide_Wide_Character'Val (10));
               else
                  Is_Record := True;

                  Writers.N
                    (Payload_Writer,
                     "   type "
                     & XSD_To_Ada.Utils.Add_Separator
                       (Type_D.Get_Name.To_Wide_Wide_String) & " ");

                  XSD_To_Ada.Utils.Print_Type_Definition
                    (Type_D.To_Type_Definition,
                     "",
                     Payload_Writer, Payload_Type_Writer,
                     Type_D.Get_Name,
                     Is_Record,
                     Map,
                     Types_Table);

                  Writers.P (Payload_Writer,
                             "   end record;"
                             & Wide_Wide_Character'Val (10));
              end if;
            end if;

            Writer.N (Payload_Type_Writer.Text);
            Writer.N (Payload_Writer.Text);
         end if;
         US_Response.Clear;
      end loop;

      Ada.Text_IO.Put_Line ("END Print_Type_Title");
   end Print_Type_Title;

   ---------------------------
   -- Print_Type_Definition --
   ---------------------------

   procedure Print_Type_Definition
     (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
      Indent       : String := "";
      Writer       : in out Writers.Writer;
      Writer_types : in out Writers.Writer;
      Name         : League.Strings.Universal_String;
      Is_Record    : Boolean := False;
      Map          : XSD_To_Ada.Mappings_XML.Mapping_XML;
      Table        : in out Types_Table_Type_Array;
      Is_Max_Occur : Boolean := False)
   is
      use type XML.Schema.Type_Definitions.XS_Type_Definition;

      XS_Particle    : XML.Schema.Objects.Particles.XS_Particle;
      XS_Term        : XML.Schema.Objects.Terms.XS_Term;
      XS_Base        : XML.Schema.Type_Definitions.XS_Type_Definition;

      CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;
      STD  : XML.Schema.Simple_Type_Definitions.XS_Simple_Type_Definition;

      Choice     : Boolean := False;
      Now_Add    : Boolean := False;
      Add_Choise : Boolean := False;
      Add_Anonym : Boolean := False;
      Max_Occurs : Boolean := False;
      Min_Occurs : Boolean := False;

      Name_Kind   : League.Strings.Universal_String;
      Name_Case   : League.Strings.Universal_String;
      Anonym_Kind : League.Strings.Universal_String;
      Anonym_Vector : League.Strings.Universal_String;
      Vectop_US   : League.Strings.Universal_String;

      Vector_Package : Writers.Writer;

      ----------------
      -- Print_Term --
      ----------------

      procedure Print_Term
        (XS_Term      : XML.Schema.Objects.Terms.XS_Term;
         Indent       : String := "";
         Writer       : in out Writers.Writer;
         Writer_types : in out Writers.Writer;
         Name         : League.Strings.Universal_String;
         Map          : XSD_To_Ada.Mappings_XML.Mapping_XML;
         Table        : in out Types_Table_Type_Array)
      is
         use type XML.Schema.Objects.Terms.Model_Groups.Compositor_Kinds;
         use type League.Strings.Universal_String;

         XS_Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
         XS_List        : XML.Schema.Object_Lists.XS_Object_List;
         XS_Particle    : XML.Schema.Objects.Particles.XS_Particle;
         Decl           : XML.Schema.Element_Declarations.XS_Element_Declaration;

         Type_D         : XML.Schema.Type_Definitions.XS_Type_Definition;
         Type_Name : League.Strings.Universal_String;
      begin

         Now_Term_Level := Now_Term_Level + 1;

         Ada.Text_IO.Put (Indent);
         Ada.Text_IO.Put_Line ("Type " & XS_Term.Get_Type'Img);
         Ada.Text_IO.Put (Indent);
         Ada.Text_IO.Put_Line
           ("XS_Term.Get_Name =" & XS_Term.Get_Name.To_UTF_8_String
            & "; Anonym=" & Anonyn_Vector (Now_Term_Level - 1).Term_State'Img);

         if XS_Term.Is_Model_Group then
            XS_Model_Group := XS_Term.To_Model_Group;
            XS_List := XS_Model_Group.Get_Particles;
            Ada.Text_IO.Put (Indent);
            Ada.Text_IO.Put_Line (XS_Model_Group.Get_Compositor'Img);

            if XS_Model_Group.Get_Compositor =
              XML.Schema.Objects.Terms.Model_Groups.Compositor_Choice
            then
               Choice := True;

               if Is_Max_Occur then

                  Writers.N
                    (Writer,
                     Gen_Type_Line
                       ("      "
                        & XSD_To_Ada.Utils.Add_Separator (Name)
                        & " : "
                        & XSD_To_Ada.Utils.Add_Separator (Name)
                        & "_Case", 8));

                  Create_Vector_Package
                    (League.Strings.To_Universal_String
                       (Name.To_Wide_Wide_String
                        & "_"
                        & Decl.Get_Name.To_Wide_Wide_String & "Case"),
                     Writer,
                     Vector_Package);
               else
                  Writers.P
                    (Writer,
                     Gen_Type_Line
                       ("      "
                        & XSD_To_Ada.Utils.Add_Separator (Name)
                        & " : "
                        & XSD_To_Ada.Utils.Add_Separator (Name)
                        & "_Case;", 8));
               end if;

               Name_Kind.Append
                 ("   type "
                  & XSD_To_Ada.Utils.Add_Separator (Name) & "_Kind is "
                  & Wide_Wide_Character'Val (10) &  "     (");

               Name_Case.Append
                 ("   type "
                  & XSD_To_Ada.Utils.Add_Separator (Name) & "_Case "
                  & Wide_Wide_Character'Val (10)
                  & "     (Kind : "
                  & XSD_To_Ada.Utils.Add_Separator (Name) & "_Kind "
                    & Wide_Wide_Character'Val (10)
                  & "      := "
                  & XSD_To_Ada.Utils.Add_Separator (Name)
                  & "_Kind'First) is record"
                  & Wide_Wide_Character'Val (10)
                  & "      case Kind is"
                  & Wide_Wide_Character'Val (10));

               Add_Choise := True;
            end if;

            if Anonyn_Vector (Now_Term_Level - 1).Term_State
              and not Choice
            then

               Writers.P
                 (Writer,
                  Gen_Type_Line
                    ("      "
                     & XSD_To_Ada.Utils.Add_Separator (Name)
                     & " : "
                     & XSD_To_Ada.Utils.Add_Separator (Name)
                     & "_Anonyms;", 8));

               Anonym_Vector.Append
                 ("   package "
                  & XSD_To_Ada.Utils.Add_Separator (Name)
                  & "_Anonyms_Vectors is "
                  & Wide_Wide_Character'Val (10)
                  & "     new Ada.Containers.Indefinite_Vectors "
                  & Wide_Wide_Character'Val (10)
                  & "        (Positive, "
                  & XSD_To_Ada.Utils.Add_Separator (Name) & "_Anonym);"
                  & Wide_Wide_Character'Val (10)
                  & Wide_Wide_Character'Val (10)
                  & Gen_Type_Line
                    ("   subtype " & XSD_To_Ada.Utils.Add_Separator (Name)
                     & "_Anonyms is " & XSD_To_Ada.Utils.Add_Separator (Name)
                     & "_Anonyms_Vectors.Vector;", 5)
                  & Wide_Wide_Character'Val (10));

               Anonym_Kind.Append
                 ("   type "
                  & XSD_To_Ada.Utils.Add_Separator (Name) & "_Anonym is record"
                  & Wide_Wide_Character'Val (10));
               Add_Anonym := True;
            end if;

            for J in 1 .. XS_List.Get_Length loop
               Ada.Text_IO.Put (Indent);

               XS_Particle := XS_List.Item (J).To_Particle;

               Min_Occurs := False;

               if XS_Particle.Get_Max_Occurs.Unbounded
               then
                  Max_Occurs := True;
                  Ada.Text_IO.Put ("Get_Max_Occurs = <>;");
               else
                  if XS_Particle.Get_Max_Occurs.Value > 1 then
                     Max_Occurs := True;
                     Ada.Text_IO.Put ("Get_Max_Occurs > 1;");

                     if Choice then

                     Writers.P
                       (Writer,
                        Gen_Type_Line
                          ("      "
                           & XSD_To_Ada.Utils.Add_Separator (Name)
                           & " : "
                           & XSD_To_Ada.Utils.Add_Separator (Name)
                           & "_Cases;", 8));

                        Max_Occurs := False;
                     else
                        Ada.Text_IO.Put ("ELSE Get_Max_Occurs > 1;");
                     end if;
                  else
                     Ada.Text_IO.Put ("Get_Max_Occurs = 0;");
                  end if;
               end if;

               if XS_Particle.Get_Min_Occurs = 0 then
                     Min_Occurs := True;
                     Ada.Text_IO.Put ("Min_Occurs = 0;");
               end if;

               Print_Term
                 (XS_Particle.Get_Term,
                  Indent & "   ", Writer, Writer_types, Name, Map,
                  Table);

               if J /=  XS_List.Get_Length and Choice then
                  Name_Kind.Append
                    (", " & Wide_Wide_Character'Val (10) & "      ") ;
               end if;
            end loop;

            Choice := False;

         elsif XS_Term.Is_Element_Declaration then
            Decl := XS_Term.To_Element_Declaration;
            Type_D := Decl.Get_Type_Definition;

            Type_Name := Find_Type (Type_D.Get_Name, Map);

            if Type_D.Get_Name.To_UTF_8_String = "" then

               Anonyn_Vector (Now_Term_Level).Term_State := True;

               if Max_Occurs then
                  Print_Type_Definition
                    (Type_D, Indent & "   ", Writer, Writer_types,
                     Name & '_' & Decl.Get_Name,
                     False,
                     Map,
                     Table, Max_Occurs);

                  Max_Occurs := False;
               else
                  Print_Type_Definition
                    (Type_D, Indent & "   ", Writer, Writer_types,
                     Name & "_" & Decl.Get_Name,
                     False,
                     Map,
                     Table);
               end if;

               Add_Anonym := False;
            end if;

            if Choice then

               if Has_Top_Level_Type (Type_D, Table) then
                     XSD_To_Ada.Utils.Print_Type_Title
                          (Type_D, Writer_types, Writer_types);
               end if;

               Name_Kind.Append
                 (League.Strings.To_Universal_String
                    (XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
                     & "_Case"));

               Name_Case.Append
                 ("        when "
                  & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
                  & "_Case =>"
                  & Wide_Wide_Character'Val (10)
                  & Gen_Type_Line ("           "
                  & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
                  & " : "
                  & Type_Name.To_Wide_Wide_String & ";", 15)
                  & Wide_Wide_Character'Val (10));
            end if;

            if Type_D.Get_Name.To_UTF_8_String /= ""
              and then not Anonyn_Vector (Now_Term_Level - 2).Term_State
              and then not Choice
            then
               case Type_D.Get_Type_Category is
               when XML.Schema.Complex_Type =>

                  if Has_Top_Level_Type (Type_D, Table) then
                     XSD_To_Ada.Utils.Print_Type_Title
                          (Type_D,
                           Writer_types,
                           Writer_types);
                  end if;

                  Writers.N
                    (Writer,
                     "      "
                     & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
                     & " : "
                     & Type_Name);

                  if Max_Occurs then
                     Max_Occurs := False;

                     Create_Vector_Package
                       (Type_D.Get_Name, Writer, Writer_types);

                  else
                     Writers.P (Writer, ";");
                  end if;

               when XML.Schema.Simple_Type =>

                  if Min_Occurs
                    and Type_D.Get_Base_Type.Get_Name.To_UTF_8_String
                      = "string"
                  then

                     if not Is_Type_In_Optional_Vector
                       (Type_D.Get_Base_Type.Get_Name)
                     then
                        Writers.P
                          (Writer_types,
                           "   type Optional_"
                           & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
                           & " is record"
                           & Wide_Wide_Character'Val (10)
                           & "     Is_Set : Boolean := False;"
                           & Wide_Wide_Character'Val (10)
                           & "     "
                           & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
                           & " : "
                           & Type_Name
                           & ";"
                           & Wide_Wide_Character'Val (10)
                           & "   end record;"
                           & Wide_Wide_Character'Val (10));
                     end if;

                     Writers.P
                       (Writer,
                        "      "
                        & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
                        & " : Optional_"
                        & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
                        & "; ");

                     Min_Occurs := False;
                  else
                     Writers.P
                       (Writer,
                        "      "
                        & XSD_To_Ada.Utils.Add_Separator
                          (XS_Term.Get_Name.To_Wide_Wide_String)
                        & " : " & Type_Name & ";");
                  end if;

               when XML.Schema.None =>
                  Ada.Text_IO.Put_Line (Indent & "NONE!!!");
               end case;
            end if;

            if Anonyn_Vector (Now_Term_Level - 2).Term_State
              and not Choice
            then

               case Type_D.Get_Type_Category is
               when XML.Schema.Complex_Type =>

                  if Has_Top_Level_Type (Type_D, Table) then
                     XSD_To_Ada.Utils.Print_Type_Title
                          (Type_D, Writer_types, Writer_types);
                  end if;

                  Anonym_Kind.Append
                    ("      "
                     & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
                     & " : "
                     & Type_Name & ";"
                     & Wide_Wide_Character'Val (10));

                  if Max_Occurs then
                     Max_Occurs := False;

                     Create_Vector_Package
                       (Type_D.Get_Name, Writer, Writer_types);
                  else
                     Writers.P (Writer, ";");
                  end if;

               when XML.Schema.Simple_Type =>

                  if Min_Occurs
                    and Type_D.Get_Base_Type.Get_Name.To_UTF_8_String
                      = "string"
                  then

                     if not Is_Type_In_Optional_Vector
                       (Type_D.Get_Base_Type.Get_Name)
                     then
                        Writers.P
                          (Writer_types,
                           "   type Optional_"
                           & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
                           & " is record"
                           & Wide_Wide_Character'Val (10)
                           & "     Is_Set : Boolean := False;"
                           & Wide_Wide_Character'Val (10)
                           & "     "
                           & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
                           & " : "
                           & Type_Name
                           & ";"
                           & Wide_Wide_Character'Val (10)
                           & "   end record;"
                           & Wide_Wide_Character'Val (10));
                     end if;

                     Anonym_Kind.Append
                        ("      "
                        & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
                        & " : Optional_"
                        & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
                         & ";"
                         & Wide_Wide_Character'Val (10));

                     Min_Occurs := False;
                  else
                     Anonym_Kind.Append
                       ("      "
                        & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
                        & " : "
                        & Type_Name & ";"
                        & Wide_Wide_Character'Val (10));
                  end if;

               when XML.Schema.None =>
                  Ada.Text_IO.Put_Line (Indent & "NONE!!!");
               end case;
            end if;
         end if;
         Now_Term_Level := Now_Term_Level - 1;
      end Print_Term;

   begin

      Now_Print_Level := Now_Print_Level + 1;

      XS_Base := Type_D.Get_Base_Type;
      if Is_Record then
         Writers.P (Writer, " is record");
      end if;

      case Type_D.Get_Type_Category is
         when XML.Schema.Complex_Type =>
            CTD := Type_D.To_Complex_Type_Definition;

            if CTD.Get_Content_Type in Element_Only | Mixed then
               Ada.Text_IO.Put_Line
                 (Indent & "Complex_Type :" & Type_D.Get_Name.To_UTF_8_String);
               XS_Particle := CTD.Get_Particle;
               XS_Term := XS_Particle.Get_Term;

               Print_Term
                 (XS_Term, Indent & "   ", Writer, Writer_types, Name, Map,
                  Table);

               Ada.Text_IO.Put_Line
                 (Indent & "End Complex_Type :" & Type_D.Get_Name.To_UTF_8_String);
            end if;

         when XML.Schema.Simple_Type =>
            Ada.Text_IO.Put
              (Indent & "Simple_Type : " & Type_D.Get_Name.To_UTF_8_String);
            STD := Type_D.To_Simple_Type_Definition;

         when XML.Schema.None =>
            Ada.Text_IO.Put_Line (Indent & "NONE!!!");
      end case;

      if XS_Base.Get_Type_Category in
        XML.Schema.Complex_Type .. XML.Schema.Simple_Type
        and XS_Base /= Type_D  --  This is to filter predefined types
      then
         Ada.Text_IO.Put_Line (Indent & " is new");
         Print_Type_Definition
           (XS_Base,
            Indent & "   ",
            Writer, Writer_types, Name, False, Map,
            Table);
      end if;

      if Add_Choise then
         Writers.P
           (Writer_types,
            Name_Kind.To_Wide_Wide_String &  ");"
            & Wide_Wide_Character'Val (10));

         Writers.P
           (Writer_types,
            Name_Case.To_Wide_Wide_String
            & "      end case;" & Wide_Wide_Character'Val (10)
            & "   end record;" & Wide_Wide_Character'Val (10));

         Name_Kind.Clear;
         Name_Case.Clear;
         Now_Add := False;
         Add_Choise := False;
      end if;

      if Add_Anonym then
         Writers.P
           (Writer_types,
            Anonym_Kind.To_Wide_Wide_String
            & "   end record;"
            & Wide_Wide_Character'Val (10));

         Writers.P (Writer_types, Anonym_Vector);

         Anonym_Kind.Clear;
      end if;

      Writers.N (Writer_types, Vector_Package.Text);

      Choice := False;
      Now_Print_Level := Now_Print_Level - 1;
   end Print_Type_Definition;

--     ---------------------------
--     -- Print_Type_Definition_MaxOccur --
--     ---------------------------
--
--     procedure Print_Type_Definition_MaxOccur
--       (Type_D       : XML.Schema.Type_Definitions.XS_Type_Definition;
--        Indent       : String := "";
--        Writer       : in out Writers.Writer;
--        Writer_types : in out Writers.Writer;
--        Name         : League.Strings.Universal_String;
--        Is_Record    : Boolean := False;
--        Map          : XSD_To_Ada.Mappings_XML.Mapping_XML;
--        Table        : in out Types_Table_Type_Array)
--     is
--        use type XML.Schema.Type_Definitions.XS_Type_Definition;
--        use type League.Strings.Universal_String;
--
--        XS_Particle    : XML.Schema.Objects.Particles.XS_Particle;
--        XS_Term        : XML.Schema.Objects.Terms.XS_Term;
--        XS_Base        : XML.Schema.Type_Definitions.XS_Type_Definition;
--
--        CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;
--        STD  : XML.Schema.Simple_Type_Definitions.XS_Simple_Type_Definition;
--
--        Choice      : Natural := 0;
--        Now_Add     : Boolean := False;
--        Add_Choise  : Boolean := False;
--        Add_Anonym  : Boolean := False;
--        Max_Occurs  : Boolean := False;
--        Min_Occurs  : Boolean := False;
--
--        Name_Kind   : League.Strings.Universal_String;
--        Name_Case   : League.Strings.Universal_String;
--        Anonym_Kind : League.Strings.Universal_String;
--        Anonym_Vector : League.Strings.Universal_String;
--        Vectop_US   : League.Strings.Universal_String;
--
--        Vector_Package : Writers.Writer;
--
--        ----------------
--        -- Print_Term --
--        ----------------
--
--        procedure Print_Term
--          (XS_Term      : XML.Schema.Objects.Terms.XS_Term;
--           Indent       : String := "";
--           Writer       : in out Writers.Writer;
--           Writer_types : in out Writers.Writer;
--           Name         : League.Strings.Universal_String;
--           Map          : XSD_To_Ada.Mappings_XML.Mapping_XML;
--           Table        : in out Types_Table_Type_Array)
--        is
--           use type XML.Schema.Objects.Terms.Model_Groups.Compositor_Kinds;
--
--           XS_Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
--           XS_List        : XML.Schema.Object_Lists.XS_Object_List;
--           XS_Particle    : XML.Schema.Objects.Particles.XS_Particle;
--           Decl           : XML.Schema.Element_Declarations.XS_Element_Declaration;
--
--           Type_D         : XML.Schema.Type_Definitions.XS_Type_Definition;
--           Type_Name : League.Strings.Universal_String;
--        begin
--
--           Now_Term_Level := Now_Term_Level + 1;
--
--           Ada.Text_IO.Put (Indent);
--           Ada.Text_IO.Put_Line ("Type " & XS_Term.Get_Type'Img);
--           Ada.Text_IO.Put (Indent);
--           Ada.Text_IO.Put_Line
--             ("XS_Term.Get_Name =" & XS_Term.Get_Name.To_UTF_8_String
--              & "; Anonym=" & Anonyn_Vector (Now_Term_Level - 1).Term_State'Img);
--
--           if XS_Term.Is_Model_Group then
--              XS_Model_Group := XS_Term.To_Model_Group;
--              XS_List := XS_Model_Group.Get_Particles;
--              Ada.Text_IO.Put (Indent);
--              Ada.Text_IO.Put_Line (XS_Model_Group.Get_Compositor'Img);
--
--              if XS_Model_Group.Get_Compositor =
--                XML.Schema.Objects.Terms.Model_Groups.Compositor_Choice
--              then
--                 Choice := 1;
--
--                 Writers.N
--                   (Writer,
--                    Gen_Type_Line
--                      ("      "
--                       & XSD_To_Ada.Utils.Add_Separator (Name)
--                       & " : "
--                       & XSD_To_Ada.Utils.Add_Separator (Name)
--                       & "_Case", 8));
--
--                 Create_Vector_Package
--                   (League.Strings.To_Universal_String
--                      (Name.To_Wide_Wide_String
--                       & "_"
--                       & Decl.Get_Name.To_Wide_Wide_String & "Case"),
--                    Writer,
--                    Vector_Package);
--
--                 Name_Kind.Append
--                   ("   type "
--                    & XSD_To_Ada.Utils.Add_Separator
--                      (Name.To_Wide_Wide_String) & "_Kind is "
--                    & Wide_Wide_Character'Val (10) &  "     (");
--
--                 Name_Case.Append
--                   ("   type "
--                    & XSD_To_Ada.Utils.Add_Separator
--                      (Name.To_Wide_Wide_String) & "_Case "
--                    & Wide_Wide_Character'Val (10)
--                    & "     (Kind : "
--                    & XSD_To_Ada.Utils.Add_Separator
--                      (Name.To_Wide_Wide_String) & "_Kind "
--                      & Wide_Wide_Character'Val (10)
--                    & "      := "
--                    & XSD_To_Ada.Utils.Add_Separator
--                        (Name.To_Wide_Wide_String)
--                    & "_Kind'First) is record"
--                    & Wide_Wide_Character'Val (10)
--                    & "      case Kind is"
--                    & Wide_Wide_Character'Val (10));
--
--                 Add_Choise := True;
--              end if;
--
--              if Anonyn_Vector (Now_Term_Level - 1).Term_State
--                and Choice = 0
--              then
--
--                 Writers.P
--                   (Writer,
--                    Gen_Type_Line
--                      ("      "
--                       & XSD_To_Ada.Utils.Add_Separator
--                         (Name.To_Wide_Wide_String) & " : "
--                       & XSD_To_Ada.Utils.Add_Separator
--                         (Name.To_Wide_Wide_String) & "_Anonyms;", 8));
--
--                 Anonym_Vector.Append
--                   ("   package "
--                    & XSD_To_Ada.Utils.Add_Separator
--                         (Name.To_Wide_Wide_String) & "_Anonyms_Vectors is "
--                    & Wide_Wide_Character'Val (10)
--                    & "     new Ada.Containers.Indefinite_Vectors "
--                    & Wide_Wide_Character'Val (10)
--                    & "        (Positive, "
--                       & XSD_To_Ada.Utils.Add_Separator
--                         (Name.To_Wide_Wide_String) & "_Anonym);"
--                    & Wide_Wide_Character'Val (10)
--                    & Wide_Wide_Character'Val (10)
--                    & Gen_Type_Line
--                      ("   subtype " & XSD_To_Ada.Utils.Add_Separator
--                         (Name.To_Wide_Wide_String)
--                       & "_Anonyms is " & XSD_To_Ada.Utils.Add_Separator
--                         (Name.To_Wide_Wide_String)
--                       & "_Anonyms_Vectors.Vector;", 5)
--                    & Wide_Wide_Character'Val (10));
--
--                 Anonym_Kind.Append
--                   ("   type "
--                    & XSD_To_Ada.Utils.Add_Separator
--                      (Name.To_Wide_Wide_String) & "_Anonym is record"
--                    & Wide_Wide_Character'Val (10));
--                 Add_Anonym := True;
--              end if;
--
--              for J in 1 .. XS_List.Get_Length loop
--                 Ada.Text_IO.Put (Indent);
--
--                 XS_Particle := XS_List.Item (J).To_Particle;
--
--                 Min_Occurs := False;
--
--                 if XS_Particle.Get_Min_Occurs = 0 then
--                       Min_Occurs := True;
--                       Ada.Text_IO.Put ("Min_Occurs = 0;");
--                 end if;
--
--                 if XS_Particle.Get_Max_Occurs.Unbounded
--                 then
--                    Max_Occurs := True;
--                    Ada.Text_IO.Put ("Get_Max_Occurs = <>;");
--                 else
--                    if XS_Particle.Get_Max_Occurs.Value > 1 then
--                       Max_Occurs := True;
--                       Ada.Text_IO.Put ("Get_Max_Occurs > 1;");
--
--                       if Choice = 1 then
--
--                       Writers.P
--                         (Writer,
--                          Gen_Type_Line
--                            ("      "
--                             & XSD_To_Ada.Utils.Add_Separator
--                               (Name.To_Wide_Wide_String)
--                             & " : "
--                             & XSD_To_Ada.Utils.Add_Separator
--                               (Name.To_Wide_Wide_String)
--                             & "_Cases;", 8));
--
--                          Max_Occurs := False;
--                       else
--                          Ada.Text_IO.Put ("ELSE Get_Max_Occurs > 1;");
--                       end if;
--                    else
--                       Ada.Text_IO.Put ("Get_Max_Occurs = 0;");
--                    end if;
--                 end if;
--
--                 Print_Term
--                   (XS_Particle.Get_Term,
--                    Indent & "   ", Writer, Writer_types, Name, Map,
--                    Table);
--
--                 if J /=  XS_List.Get_Length and Choice = 1 then
--                    Name_Kind.Append
--                      (", " & Wide_Wide_Character'Val (10) & "      ") ;
--                 end if;
--              end loop;
--
--              Choice := 0;
--
--           elsif XS_Term.Is_Element_Declaration then
--              Decl := XS_Term.To_Element_Declaration;
--              Type_D := Decl.Get_Type_Definition;
--
--              Type_Name := Find_Type (Type_D.Get_Name, Map);
--
--              if Type_D.Get_Name.To_UTF_8_String = "" then
--
--                 Anonyn_Vector (Now_Term_Level).Term_State := True;
--
--                 Print_Type_Definition
--                   (Type_D, Indent & "   ", Writer, Writer_types,
--                    League.Strings.To_Universal_String
--                      (Name.To_Wide_Wide_String & "_" & Decl.Get_Name.To_Wide_Wide_String),
--                    False,
--                    Map,
--                    Table);
--
--                 if Max_Occurs then
--
--                    Max_Occurs := False;
--
--                    Print_Type_Definition_MaxOccur
--                      (Type_D, Indent & "   ", Writer, Writer_types,
--                       League.Strings.To_Universal_String
--                         (Name.To_Wide_Wide_String & "_" & Decl.Get_Name.To_Wide_Wide_String),
--                       False,
--                       Map,
--                       Table);
--                 else
--                    Print_Type_Definition
--                      (Type_D, Indent & "   ", Writer, Writer_types,
--                       League.Strings.To_Universal_String
--                         (Name.To_Wide_Wide_String & "_" & Decl.Get_Name.To_Wide_Wide_String),
--                       False,
--                       Map,
--                       Table);
--                 end if;
--
--                 Add_Anonym := False;
--              end if;
--
--              if Choice = 1 then
--
--                 if Has_Top_Level_Type (Type_D, Table) then
--                       XSD_To_Ada.Utils.Print_Type_Title
--                            (Type_D, Writer_types, Writer_types);
--                 end if;
--
--                 Name_Kind.Append
--                   (League.Strings.To_Universal_String
--                      (XSD_To_Ada.Utils.Add_Separator
--                         (XS_Term.Get_Name.To_Wide_Wide_String) & "_Case"));
--
--                 Name_Case.Append
--                   ("        when "
--                    & XSD_To_Ada.Utils.Add_Separator
--                      (XS_Term.Get_Name.To_Wide_Wide_String) & "_Case =>"
--                    & Wide_Wide_Character'Val (10)
--                    & Gen_Type_Line ("           "
--                    & XSD_To_Ada.Utils.Add_Separator
--                      (XS_Term.Get_Name.To_Wide_Wide_String)
--                    & " : "
--                    & Type_Name.To_Wide_Wide_String & ";", 15)
--                    & Wide_Wide_Character'Val (10));
--              end if;
--
--              if Type_D.Get_Name.To_UTF_8_String /= ""
--                and then not Anonyn_Vector (Now_Term_Level - 2).Term_State
--                and then Choice = 0
--              then
--                 case Type_D.Get_Type_Category is
--                 when XML.Schema.Complex_Type =>
--
--                    if Has_Top_Level_Type (Type_D, Table) then
--                       XSD_To_Ada.Utils.Print_Type_Title
--                            (Type_D,
--                             Writer_types,
--                             Writer_types);
--                    end if;
--
--                    Writers.N
--                      (Writer,
--                       "      "
--                       & XSD_To_Ada.Utils.Add_Separator
--                         (XS_Term.Get_Name.To_Wide_Wide_String)
--                       & " : "
--                       & Type_Name.To_Wide_Wide_String);
--
--                    if Max_Occurs then
--                       Max_Occurs := False;
--
--                       Create_Vector_Package
--                         (Type_D.Get_Name, Writer, Writer_types);
--
--                    else
--                       Writers.P (Writer, ";");
--                    end if;
--
--                 when XML.Schema.Simple_Type =>
--                    if Min_Occurs
--                      and Type_D.Get_Base_Type.Get_Name.To_UTF_8_String
--                        = "string"
--                    then
--
--                       if not Is_Type_In_Optional_Vector
--                         (Type_D.Get_Base_Type.Get_Name)
--                       then
--                          Writers.P
--                            (Writer_types,
--                             "   type Optional_"
--                             & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
--                             & " is record"
--                             & Wide_Wide_Character'Val (10)
--                             & "     Is_Set : Boolean := False;"
--                             & Wide_Wide_Character'Val (10)
--                             & "     "
--                             & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
--                             & " : "
--                             & Type_Name
--                             & ";"
--                             & Wide_Wide_Character'Val (10)
--                             & "   end record;"
--                             & Wide_Wide_Character'Val (10));
--                       end if;
--
--                       Writers.P
--                         (Writer,
--                          "      "
--                          & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
--                          & " : Optional_"
--                          & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
--                          & ";");
--
--                       Min_Occurs := False;
--                    else
--                       Writers.P
--                         (Writer,
--                          "      "
--                          & XSD_To_Ada.Utils.Add_Separator
--                            (XS_Term.Get_Name.To_Wide_Wide_String)
--                          & " : " & Type_Name & ";");
--                    end if;
--
--                 when XML.Schema.None =>
--                    Ada.Text_IO.Put_Line (Indent & "NONE!!!");
--                 end case;
--              end if;
--
--              if Anonyn_Vector (Now_Term_Level - 2).Term_State
--                and Choice = 0
--              then
--
--                 case Type_D.Get_Type_Category is
--                 when XML.Schema.Complex_Type =>
--
--                    if Has_Top_Level_Type (Type_D, Table) then
--                       XSD_To_Ada.Utils.Print_Type_Title
--                            (Type_D, Writer_types, Writer_types);
--                    end if;
--
--                    Anonym_Kind.Append
--                      ("      "
--                       & XSD_To_Ada.Utils.Add_Separator
--                         (XS_Term.Get_Name.To_Wide_Wide_String)
--                       & " : "
--                       & Type_Name.To_Wide_Wide_String & ";"
--                       & Wide_Wide_Character'Val (10));
--
--                    if Max_Occurs then
--                       Max_Occurs := False;
--
--                       Create_Vector_Package
--                         (Type_D.Get_Name, Writer, Writer_types);
--                    else
--                       Writers.P (Writer, ";");
--                    end if;
--
--                 when XML.Schema.Simple_Type =>
--
--                    if Min_Occurs
--                      and Type_D.Get_Base_Type.Get_Name.To_UTF_8_String
--                        = "string"
--                    then
--
--                       if not Is_Type_In_Optional_Vector
--                         (Type_D.Get_Base_Type.Get_Name)
--                       then
--                          Writers.P
--                            (Writer_types,
--                             "   type Optional_"
--                             & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
--                             & " is record"
--                             & Wide_Wide_Character'Val (10)
--                             & "     Is_Set : Boolean := False;"
--                             & Wide_Wide_Character'Val (10)
--                             & "     "
--                             & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
--                             & " : "
--                             & Type_Name
--                             & ";"
--                             & Wide_Wide_Character'Val (10)
--                             & "   end record;"
--                             & Wide_Wide_Character'Val (10));
--                       end if;
--
--                       Anonym_Kind.Append
--                          ("      "
--                          & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
--                          & " : Optional_"
--                          & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
--                           & ";  --  XXXXX"
--                           & Wide_Wide_Character'Val (10));
--
--                       Min_Occurs := False;
--                    else
--                       Anonym_Kind.Append
--                         ("      "
--                          & XSD_To_Ada.Utils.Add_Separator (XS_Term.Get_Name)
--                          & " : "
--                          & Type_Name & ";  --  YYYYY"
--                          & Wide_Wide_Character'Val (10));
--                    end if;
--
--                 when XML.Schema.None =>
--                    Ada.Text_IO.Put_Line (Indent & "NONE!!!");
--                 end case;
--              end if;
--           end if;
--           Now_Term_Level := Now_Term_Level - 1;
--        end Print_Term;
--
--     begin
--
--        Now_Print_Level := Now_Print_Level + 1;
--
--        XS_Base := Type_D.Get_Base_Type;
--        if Is_Record then
--           Writers.P (Writer, " is record");
--        end if;
--
--        case Type_D.Get_Type_Category is
--           when XML.Schema.Complex_Type =>
--              CTD := Type_D.To_Complex_Type_Definition;
--
--              if CTD.Get_Content_Type in Element_Only | Mixed then
--                 Ada.Text_IO.Put_Line
--                   (Indent & "Complex_Type :" & Type_D.Get_Name.To_UTF_8_String);
--                 XS_Particle := CTD.Get_Particle;
--                 XS_Term := XS_Particle.Get_Term;
--
--                 Print_Term
--                   (XS_Term, Indent & "   ", Writer, Writer_types, Name, Map,
--                    Table);
--
--                 Ada.Text_IO.Put_Line
--                   (Indent & "End Complex_Type :" & Type_D.Get_Name.To_UTF_8_String);
--              end if;
--
--           when XML.Schema.Simple_Type =>
--              Ada.Text_IO.Put
--                (Indent & "Simple_Type : " & Type_D.Get_Name.To_UTF_8_String);
--              STD := Type_D.To_Simple_Type_Definition;
--
--           when XML.Schema.None =>
--              Ada.Text_IO.Put_Line (Indent & "NONE!!!");
--        end case;
--
--        if XS_Base.Get_Type_Category in
--          XML.Schema.Complex_Type .. XML.Schema.Simple_Type
--          and XS_Base /= Type_D  --  This is to filter predefined types
--        then
--           Ada.Text_IO.Put_Line (Indent & " is new");
--           Print_Type_Definition
--             (XS_Base,
--              Indent & "   ",
--              Writer, Writer_types, Name, False, Map,
--              Table);
--        end if;
--
--        if Add_Choise then
--           Writers.P
--             (Writer_types,
--              Name_Kind.To_Wide_Wide_String &  ");"
--              & Wide_Wide_Character'Val (10));
--
--           Writers.P
--             (Writer_types,
--              Name_Case.To_Wide_Wide_String
--              & "      end case;" & Wide_Wide_Character'Val (10)
--              & "   end record;" & Wide_Wide_Character'Val (10));
--
--           Name_Kind.Clear;
--           Name_Case.Clear;
--           Now_Add := False;
--           Add_Choise := False;
--        end if;
--
--        if Add_Anonym then
--           Writers.P
--             (Writer_types,
--              Anonym_Kind.To_Wide_Wide_String
--              & "   end record;"
--              & Wide_Wide_Character'Val (10));
--
--           Writers.P (Writer_types, Anonym_Vector.To_Wide_Wide_String);
--
--           Anonym_Kind.Clear;
--        end if;
--
--        Writers.N (Writer_types, Vector_Package.Text);
--
--        Choice := 0;
--        Now_Print_Level := Now_Print_Level - 1;
--     end Print_Type_Definition_MaxOccur;

   -------------------------
   -- Has_Element_Session --
   -------------------------

   function Has_Element_Session
     (Type_D : XML.Schema.Type_Definitions.XS_Type_Definition)
     return Boolean
   is
      use type XML.Schema.Type_Definitions.XS_Type_Definition;

      XS_Particle    : XML.Schema.Objects.Particles.XS_Particle;
      XS_Term        : XML.Schema.Objects.Terms.XS_Term;
      XS_Model_Group : XML.Schema.Model_Groups.XS_Model_Group;
      XS_List        : XML.Schema.Object_Lists.XS_Object_List;

      Decl : XML.Schema.Element_Declarations.XS_Element_Declaration;
      CTD  : XML.Schema.Complex_Type_Definitions.XS_Complex_Type_Definition;
      STD  : XML.Schema.Simple_Type_Definitions.XS_Simple_Type_Definition;
   begin
      case Type_D.Get_Type_Category is
         when XML.Schema.Complex_Type =>
            CTD := Type_D.To_Complex_Type_Definition;

            if CTD.Get_Content_Type in Element_Only | Mixed then
               XS_Particle    := CTD.Get_Particle;
               XS_Term        := XS_Particle.Get_Term;
               XS_Model_Group := XS_Term.To_Model_Group;
               XS_List        := XS_Model_Group.Get_Particles;

               for J in 1 .. XS_List.Get_Length loop
                  XS_Particle := XS_List.Item (J).To_Particle;
                  XS_Term := XS_Particle.Get_Term;
                  Decl := XS_Term.To_Element_Declaration;

                  if Decl.Get_Name.To_UTF_8_String = "Session" then
                     return True;
                  end if;

                  return Has_Element_Session (Decl.Get_Type_Definition);
               end loop;
            end if;

         when XML.Schema.Simple_Type =>
            STD := Type_D.To_Simple_Type_Definition;

         when XML.Schema.None =>
            null;
      end case;

      return False;
   end Has_Element_Session;

   ----------------
   -- Put_Header --
   ----------------

   procedure Put_Header (Self : in out XSD_To_Ada.Writers.Writer) is
      Lin : constant Wide_Wide_String (1 .. 77) := (others => '-');
   begin
      Self.P (Lin);
      Self.P ("--  Copyright © 2013 ACTForex, Inc.");
      Self.P ("--  All rights reserved.");
      Self.P (Lin);
      Self.P
        ("--  This file is generated by pipe_api_generator, don't edit it.");
      Self.P (Lin);
      Self.P ("");
   end Put_Header;

   function Read_Mapping
     (File_Name : League.Strings.Universal_String)
      return XSD_To_Ada.Mappings_XML.Mapping_XML
   is
      Source  : aliased XML.SAX.Input_Sources.Streams.Files.File_Input_Source;
      Reader  : aliased XML.SAX.Simple_Readers.SAX_Simple_Reader;
      Handler : aliased XSD_To_Ada.Mappings_XML.Mapping_XML;
   begin
      Reader.Set_Content_Handler (Handler'Unchecked_Access);
      Source.Open_By_File_Name (File_Name);
      Reader.Parse (Source'Access);
      return Handler;
   end Read_Mapping;

end XSD_To_Ada.Utils;
