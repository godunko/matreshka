package body Forum.Topics is

   ------------
   -- Decode --
   ------------

   function Decode
     (Image : League.Strings.Universal_String;
      Value : out Topic_Identifier) return Boolean is
   begin
      --  XXX This subprogram must be rewritter without use of exceptions.

      Value := Topic_Identifier'Wide_Wide_Value (Image.To_Wide_Wide_String);

      return True;

   exception
      when Constraint_Error =>
         return False;
   end Decode;

   ------------
   -- Encode --
   ------------

   function Encode
     (Item : Topic_Identifier)
      return League.Strings.Universal_String
   is
      Aux : constant Wide_Wide_String
        := Topic_Identifier'Wide_Wide_Image (Item);

   begin
      return
        League.Strings.To_Universal_String (Aux (Aux'First + 1 .. Aux'Last));
   end Encode;

end Forum.Topics;
