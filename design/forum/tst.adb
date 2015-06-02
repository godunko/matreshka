with Forum.Forums.References;
with Forum.Forums.Objects.Stores;

procedure Tst is
   S : aliased Forum.Forums.Objects.Stores.Forum_Store;
   F : Forum.Forums.References.Forum_Reference;

begin
   F.Initialize (S'Unchecked_Access, 0);
   F.Object.Check;
end Tst;
