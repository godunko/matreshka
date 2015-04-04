with AMF3.Objects;
with AMF3.Slots.Long_Floats;
with AMF3.Metadata;

private with League.Strings;

package Demo.Walls is

   Wall_Descriptor : aliased constant AMF3.Metadata.Descriptor;

   type Wall (Metadata : access constant AMF3.Metadata.Descriptor
                  := Wall_Descriptor'Access) is
     new AMF3.Objects.Abstract_Object (Metadata) with record
      X1 : AMF3.Slots.Long_Floats.Long_Float_Slot;
      Y1 : AMF3.Slots.Long_Floats.Long_Float_Slot;
   end record;

private

   Dummy_Wall : constant Wall (null)
     with Import     => True,
          Convention => Ada;

   Wall_Descriptor : aliased constant AMF3.Metadata.Descriptor
     := (1 => (AMF3.Metadata.Slot,
               League.Strings.To_Universal_String ("x1"),
               Dummy_Wall.X1'Position),
         2 => (AMF3.Metadata.Slot,
               League.Strings.To_Universal_String ("x2"),
               Dummy_Wall.Y1'Position),
         3 => (AMF3.Metadata.Superclass,
               AMF3.Objects.Object_Descriptor'Access));

end Demo.Walls;
