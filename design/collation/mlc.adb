with AllKeys_Reader;

procedure MLC is
   Collations : AllKeys_Reader.Collation_Information_Access;

begin
   Collations := AllKeys_Reader.Load_AllKeys_File;
end MLC;
