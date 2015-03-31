with Asis.Expressions;

package body Properties.Expressions.Named_Array_Aggregate is

   ----------
   -- Code --
   ----------

   function Code
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Expression;
      Name    : Engines.Text_Property)
      return League.Strings.Universal_String
   is
      Result : League.Strings.Universal_String;
      List : constant Asis.Association_List :=
        Asis.Expressions.Array_Component_Associations (Element);
   begin
      Result.Append ("function(_from,_to){");
      Result.Append ("var _first=_ec._pos(_from);");
      Result.Append ("var _len=Math.max(_ec._pos(_to) - _first + 1, 0);");
      Result.Append ("var _result=Array(_len);");
      Result.Append ("var _j=0;");
      Result.Append ("_result._first=_from;");
      Result.Append ("_result._last=_to;");
      Result.Append ("_result._length=_len;");
      Result.Append ("for (var _x=_from;_j<_len;_j++, _x=_ec._succ(_x)){");
      Result.Append ("switch(_x){");

      for J in List'Range loop
         Result.Append (Engine.Text.Get_Property (List (J), Name));
      end loop;

      Result.Append ("}}return _result;}(false,true)");

      return Result;
   end Code;

end Properties.Expressions.Named_Array_Aggregate;
