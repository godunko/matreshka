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

   function Corresponding_Type_Components
     (Definition : Asis.Definition) return Asis.Declaration_List;
   --  For given (non-array complex) type definition return list of component

   function Is_Primitive_Subprogram
     (Definition : Asis.Definition;
      Subprogram : Asis.Declaration) return Boolean;
   --  Check if given Subprogram is primitive subprograms for given type

   function Corresponding_Type
     (Declaration : Asis.Declaration) return Asis.Declaration;
   --  Return type declaration for given primitive subprogram

   function Is_Equal_Type
     (Left  : Asis.Declaration;
      Right : Asis.Declaration) return Boolean;

end Properties.Tools;
