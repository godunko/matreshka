with League.Stream_Element_Vectors;

package Styx.Messages.Reads is

   type Read_Request is new Request with record
      FID    : Styx.Messages.FID;
      Offset : Interfaces.Unsigned_64;
      Count  : Size;
   end record;

   procedure Visit
     (Visiter : in out Styx.Request_Visiters.Request_Visiter'Class;
      Value   : Read_Request);

   type Read_Request_Access is access all Read_Request;

   type Read_Reply is new Reply with record
      Data  : League.Stream_Element_Vectors.Stream_Element_Vector;
   end record;

   procedure Visit
     (Visiter : in out Styx.Reply_Visiters.Reply_Visiter'Class;
      Value   : Read_Reply);

   type Directory_Entry_Array is array (Positive range <>) of Directory_Entry;

   type Read_Directory_Reply (Count : Natural) is new Reply with record
      Data : Directory_Entry_Array (1 .. Count);
   end record;

   procedure Visit
     (Visiter : in out Styx.Reply_Visiters.Reply_Visiter'Class;
      Value   : Read_Directory_Reply);

end Styx.Messages.Reads;
