with Ada.Wide_Wide_Text_IO;

with League.Application;
with League.Strings;
with XML.SAX.Error_Handlers;
with XML.SAX.Parse_Exceptions;

with Matreshka.XML_Schema.AST;
with Matreshka.XML_Schema.Loader;

procedure Driver is

   type Error_Handler is
     limited new XML.SAX.Error_Handlers.SAX_Error_Handler with null record;

   overriding procedure Error
    (Self       : in out Error_Handler;
     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception;
     Success    : in out Boolean);

   overriding function Error_String
    (Self : Error_Handler) return League.Strings.Universal_String;

   overriding procedure Fatal_Error
    (Self       : in out Error_Handler;
     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception);

   overriding procedure Warning
    (Self       : in out Error_Handler;
     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception;
     Success    : in out Boolean);

   -----------
   -- Error --
   -----------

   overriding procedure Error
    (Self       : in out Error_Handler;
     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception;
     Success    : in out Boolean)
   is
      Line_Image   : constant Wide_Wide_String
        := Integer'Wide_Wide_Image (Occurrence.Line);
      Column_Image : constant Wide_Wide_String
        := Integer'Wide_Wide_Image (Occurrence.Column);

   begin
      Ada.Wide_Wide_Text_IO.Put_Line
       (Occurrence.System_Id.To_Wide_Wide_String
          & ':'
          & Line_Image (2 .. Line_Image'Last)
          & ':'
          & Column_Image (2 .. Column_Image'Last)
          & ": error: "
          & Occurrence.Message.To_Wide_Wide_String);
   end Error;

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
      Line_Image   : constant Wide_Wide_String
        := Integer'Wide_Wide_Image (Occurrence.Line);
      Column_Image : constant Wide_Wide_String
        := Integer'Wide_Wide_Image (Occurrence.Column);

   begin
      Ada.Wide_Wide_Text_IO.Put_Line
       (Occurrence.System_Id.To_Wide_Wide_String
          & ':'
          & Line_Image (2 .. Line_Image'Last)
          & ':'
          & Column_Image (2 .. Column_Image'Last)
          & ": fatal error: "
          & Occurrence.Message.To_Wide_Wide_String);
   end Fatal_Error;

   -------------
   -- Warning --
   -------------

   overriding procedure Warning
    (Self       : in out Error_Handler;
     Occurrence : XML.SAX.Parse_Exceptions.SAX_Parse_Exception;
     Success    : in out Boolean)
   is
      Line_Image   : constant Wide_Wide_String
        := Integer'Wide_Wide_Image (Occurrence.Line);
      Column_Image : constant Wide_Wide_String
        := Integer'Wide_Wide_Image (Occurrence.Column);

   begin
      Ada.Wide_Wide_Text_IO.Put_Line
       (Occurrence.System_Id.To_Wide_Wide_String
          & ':'
          & Line_Image (2 .. Line_Image'Last)
          & ':'
          & Column_Image (2 .. Column_Image'Last)
          & ": warning: "
          & Occurrence.Message.To_Wide_Wide_String);
   end Warning;

   ErrorH : aliased Error_Handler;
   Model  : Matreshka.XML_Schema.AST.Model_Access;

begin
   Model :=
     Matreshka.XML_Schema.Loader.Load_XML_Schema_Model
      (League.Application.Arguments.Element (1), ErrorH'Unchecked_Access);
end Driver;
