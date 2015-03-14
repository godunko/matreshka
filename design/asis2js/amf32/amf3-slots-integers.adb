with League.Holders.Integers;

package body AMF3.Slots.Integers is

   ---------
   -- Get --
   ---------

   overriding function Get
     (Self : Integer_Slot)
      return League.Holders.Holder
   is
   begin
      return
        League.Holders.Integers.To_Holder (Self.Value (Self.Current_Value));
   end Get;

end AMF3.Slots.Integers;
