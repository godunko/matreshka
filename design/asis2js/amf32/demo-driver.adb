with Ada.Tags;
with Ada.Text_IO; use Ada.Text_IO;
with System.Storage_Elements;

with AMF3.Objects;  use AMF3.Objects;
with AMF3.Metadata; use AMF3.Metadata;
with AMF3.Slots;
with XMI.Writers;

with Demo.Walls;

procedure Demo.Driver is
   W : Demo.Walls.Wall;

begin
   XMI.Writers.Dump_XMI (W);
end Demo.Driver;
