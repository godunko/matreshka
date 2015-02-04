with Asis;
with League.Strings;

package Properties.Tools is

   function Get_Aspect
     (Element : Asis.Declaration;
      Name    : Wide_String) return Wide_String;

   function Library_Level_Header
     (Unit : Asis.Compilation_Unit) return League.Strings.Universal_String;

   function Corresponding_Type_Subprograms
     (Definition : Asis.Definition) return Asis.Declaration_List;
   --  For given type definition return list of primitive subprograms

   function Is_Primitive_Subprogram
     (Definition : Asis.Definition;
      Subprogram : Asis.Declaration) return Boolean;
   --  For given type definition return list of primitive subprograms

   function Is_Equal_Type
     (Left  : Asis.Declaration;
      Right : Asis.Declaration) return Boolean;

end Properties.Tools;
