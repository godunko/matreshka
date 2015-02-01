with Asis;
with League.Strings;

package Properties.Tools is

   function Get_Aspect
     (Element : Asis.Declaration;
      Name    : Wide_String) return Wide_String;

   function Library_Level_Header
     (Unit : Asis.Compilation_Unit) return League.Strings.Universal_String;

end Properties.Tools;
