with League.Strings;

package Types.Conventions is

   pragma Preelaborate;

   type Convention is limited interface;
   --  XXX May be this type can be used to represent convention of types also

   type Convention_Access is access all Convention'Class
     with Storage_Size => 0;
   --  Equal conventions always have the same access value

   not overriding function Is_Ada
    (Self : Convention) return Boolean is abstract;
   -- ARM 6.3.1(3/3)

   not overriding function Is_Intrinsic
    (Self : Convention) return Boolean is abstract;
   -- ARM 6.3.1(4)

   not overriding function Is_Protected
    (Self : Convention) return Boolean is abstract;
   -- ARM 6.3.1(12)

   not overriding function Is_Entry
    (Self : Convention) return Boolean is abstract;
   -- ARM 6.3.1(13)

   not overriding function Name
    (Self : Convention) return League.Strings.Universal_String is abstract;

end Types.Conventions;
