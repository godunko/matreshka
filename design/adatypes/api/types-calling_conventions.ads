package Types.Calling_Conventions is

   pragma Preelaborate;

   type Calling_Convention is limited interface;
   --  XXX I tend to make Calling_Convention enum type, but it seems there are
   --  some unknown/implementation defined conventions, such as CPP, Java, etc

   type Calling_Convention_Access is access all Calling_Convention'Class
     with Storage_Size => 0;

   --     not overriding function Is_The_Same
   --      (Left, Right : Calling_Convention) return Boolean is abstract;
   --  We need a way to compare two conventions.

   not overriding function Is_Ada
    (Self : Calling_Convention) return Boolean is abstract;
   -- ARM 6.3.1(3/3)

   not overriding function Is_Intrinsic
    (Self : Calling_Convention) return Boolean is abstract;
   -- ARM 6.3.1(4)

   not overriding function Is_Protected
    (Self : Calling_Convention) return Boolean is abstract;
   -- ARM 6.3.1(12)

   not overriding function Is_Entry
    (Self : Calling_Convention) return Boolean is abstract;
   -- ARM 6.3.1(13)

   not overriding function Name
    (Self : Calling_Convention) return Wide_String is abstract;

end Types.Calling_Conventions;
