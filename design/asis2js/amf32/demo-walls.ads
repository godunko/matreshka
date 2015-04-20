with AMF3.Objects;
with AMF3.Slots.Long_Floats;
with AMF3.Metadata;

private with League.Strings;

package Demo.Walls is

   Wall_Descriptor : aliased constant AMF3.Metadata.Descriptor;

   Zero : aliased constant Long_Float := 0.0;

   type Wall (Metadata : access constant AMF3.Metadata.Descriptor
                  := Wall_Descriptor'Access) is
     new AMF3.Objects.Abstract_Object (Metadata) with record
      X1 : AMF3.Slots.Long_Floats.Long_Float_Slot (Wall'Access, Zero'Access);
      Y1 : AMF3.Slots.Long_Floats.Long_Float_Slot (Wall'Access, Zero'Access);
   end record;

private

   Dummy_Wall : constant Wall (null)
     with Import     => True,
          Convention => Ada;

   Wall_Descriptor : aliased constant AMF3.Metadata.Descriptor
     := (Name             => League.Strings.To_Universal_String ("Wall"),
         Superclass_Count => 1,
         Superclasses     =>
          (1 => (Metadata => AMF3.Objects.Object_Descriptor'Access)),
         Slot_Count       => 2,
         Slots            =>
          (1 => (League.Strings.To_Universal_String ("x1"),
                 Dummy_Wall.X1'Position),
           2 => (League.Strings.To_Universal_String ("x2"),
                 Dummy_Wall.Y1'Position)));

end Demo.Walls;
