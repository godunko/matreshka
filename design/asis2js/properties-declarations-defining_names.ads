with Asis;

with Engines;

with League.Strings;

package Properties.Declarations.Defining_Names is

   procedure Code
     (Engine  : in out Engines.Engine;
      Element : Asis.Declaration;
      Name    : League.Strings.Universal_String);

end Properties.Declarations.Defining_Names;
