
package Zip is

   pragma Pure;

   type Zip_File_Offset is mod 2 ** 64;
   subtype Zip_File_Offset_16 is Zip_File_Offset range 0 .. 2 ** 16 - 1;

end Zip;
