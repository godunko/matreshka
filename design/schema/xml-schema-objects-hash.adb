with System.Address_To_Access_Conversions;
with System.Storage_Elements;

with Matreshka.XML_Schema.AST.Objects;

function XML.Schema.Objects.Hash
  (Self : XS_Object) return Ada.Containers.Hash_Type
is
   use type System.Storage_Elements.Integer_Address;

   package Conv is new System.Address_To_Access_Conversions
     (Matreshka.XML_Schema.AST.Objects.Abstract_Object_Node'Class);
   Addr : constant System.Address :=
     Conv.To_Address (Conv.Object_Pointer (Self.Node));
   Int : constant System.Storage_Elements.Integer_Address :=
     System.Storage_Elements.To_Integer (Addr);
begin
   return Ada.Containers.Hash_Type (Int mod Ada.Containers.Hash_Type'Modulus);
end XML.Schema.Objects.Hash;
