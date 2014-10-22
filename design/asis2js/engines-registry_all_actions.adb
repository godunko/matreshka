with Engines.Property_Names;

with Properties.Declarations.Constant_Declarations;
with Properties.Declarations.Defining_Names;
with Properties.Declarations.Function_Declarations;
with Properties.Declarations.Function_Renaming_Declaration;
with Properties.Declarations.Ordinary_Type;
with Properties.Declarations.Package_Declaration;
with Properties.Declarations.Procedure_Body_Declarations;
with Properties.Declarations.Procedure_Declaration;
with Properties.Definitions.Enumeration_Type;
with Properties.Definitions.Simple_Expression_Range;
with Properties.Expressions.Function_Calls;
with Properties.Expressions.Identifiers;
with Properties.Expressions.Indexed_Component;
with Properties.Expressions.Integer_Literal;
with Properties.Expressions.Null_Literal;
with Properties.Expressions.Selected_Components;
with Properties.Expressions.String_Literal;
with Properties.Expressions.Type_Conversion;
with Properties.Statements.Assignment_Statement;
with Properties.Statements.For_Loop_Statement;
with Properties.Statements.If_Statement;
with Properties.Statements.Null_Statement;
with Properties.Statements.Procedure_Call_Statement;
with Properties.Statements.Return_Statement;

procedure Engines.Registry_All_Actions (Self : in out Engine) is
   type Action_Item is record
      Name   : League.Strings.Universal_String;
      Kind   : Asis.Extensions.Flat_Kinds.Flat_Element_Kinds;
      Action : Action_Callback;
   end record;

   type Action_Array is array (Positive range <>) of Action_Item;

   type Action_Range is record
      Name     : League.Strings.Universal_String;
      From, To : Asis.Extensions.Flat_Kinds.Flat_Element_Kinds;
      Action   : Action_Callback;
   end record;

   type Range_Array is array (Positive range <>) of Action_Range;

   package F renames Asis.Extensions.Flat_Kinds;
   package N renames Engines.Property_Names;
   package P renames Properties;

   Action_List : constant Action_Array :=
     --  Code
     ((Name   => N.Code,
       Kind   => F.A_Constant_Declaration,
       Action => P.Declarations.Constant_Declarations.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Deferred_Constant_Declaration,
       Action => P.Statements.Null_Statement.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Function_Declaration,
       Action => P.Declarations.Function_Declarations.Code'Access),
      (Name   => N.Code,
       Kind   => F.An_Ordinary_Type_Declaration,
       Action => P.Declarations.Ordinary_Type.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Package_Declaration,
       Action => P.Declarations.Package_Declaration.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Procedure_Body_Declaration,
       Action => P.Declarations.Procedure_Body_Declarations.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Procedure_Declaration,
       Action => P.Declarations.Function_Declarations.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Variable_Declaration,
       Action => P.Declarations.Constant_Declarations.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Function_Renaming_Declaration,
       Action => P.Statements.Null_Statement.Code'Access),  --  Ignore
      (Name   => N.Code,
       Kind   => F.A_Defining_Identifier,
       Action => P.Declarations.Defining_Names.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Defining_Expanded_Name,
       Action => P.Declarations.Defining_Names.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Package_Instantiation,
       Action => P.Statements.Null_Statement.Code'Access),  --  Ignore
      (Name   => N.Code,
       Kind   => F.An_Enumeration_Type_Definition,
       Action => P.Definitions.Enumeration_Type.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Record_Type_Definition,
       Action => P.Statements.Null_Statement.Code'Access),  --  Ignore
      (Name   => N.Code,
       Kind   => F.A_Discrete_Simple_Expression_Range_As_Subtype_Definition,
       Action => P.Definitions.Simple_Expression_Range.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Function_Call,
       Action => P.Expressions.Function_Calls.Code'Access),
      (Name   => N.Code,
       Kind   => F.An_Identifier,
       Action => P.Expressions.Identifiers.Code'Access),
      (Name   => N.Code,
       Kind   => F.An_Indexed_Component,
       Action => P.Expressions.Indexed_Component.Code'Access),
      (Name   => N.Code,
       Kind   => F.An_Integer_Literal,
       Action => P.Expressions.Integer_Literal.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Null_Literal,
       Action => P.Expressions.Null_Literal.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_String_Literal,
       Action => P.Expressions.String_Literal.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Type_Conversion,
       Action => P.Expressions.Type_Conversion.Code'Access),
      (Name   => N.Code,
       Kind   => F.An_Assignment_Statement,
       Action => P.Statements.Assignment_Statement.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_For_Loop_Statement,
       Action => P.Statements.For_Loop_Statement.Code'Access),
      (Name   => N.Code,
       Kind   => F.An_If_Statement,
       Action => P.Statements.If_Statement.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Null_Statement,
       Action => P.Statements.Null_Statement.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Use_Type_Clause,
       Action => P.Statements.Null_Statement.Code'Access),  --  Ignore
      (Name   => N.Code,
       Kind   => F.A_Procedure_Call_Statement,
       Action => P.Statements.Procedure_Call_Statement.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Return_Statement,
       Action => P.Statements.Return_Statement.Code'Access),

      --  Call_Convention
      (Name   => N.Call_Convention,
       Kind   => F.A_Function_Call,
       Action => P.Expressions.Function_Calls.Call_Convention'Access),
      (Name   => N.Call_Convention,
       Kind   => F.An_Identifier,
       Action => P.Expressions.Identifiers.Call_Convention'Access),
      (Name   => N.Call_Convention,
       Kind   => F.A_Function_Declaration,
       Action => P.Declarations.Function_Declarations.Call_Convention'Access),
      (Name   => N.Call_Convention,
       Kind   => F.A_Function_Renaming_Declaration,
       Action => P.Declarations.Function_Renaming_Declaration
                   .Call_Convention'Access),
      (Name   => N.Call_Convention,
       Kind   => F.A_Procedure_Declaration,
       Action => P.Declarations.Procedure_Declaration.Call_Convention'Access),
      (Name   => N.Call_Convention,
       Kind   => F.A_Selected_Component,
       Action => P.Expressions.Selected_Components
                   .Call_Convention'Access),
      --  Export
      (Name   => N.Export,
       Kind   => F.A_Procedure_Body_Declaration,
       Action => P.Declarations.Procedure_Body_Declarations.Export'Access),
      (Name   => N.Export,
       Kind   => F.A_Procedure_Declaration,
       Action => P.Declarations.Function_Declarations.Export'Access),

      --  Intrinsic_Name
      (Name   => N.Intrinsic_Name,
       Kind   => F.A_Function_Declaration,
       Action => P.Declarations.Function_Declarations.Intrinsic_Name'Access),
      (Name   => N.Intrinsic_Name,
       Kind   => F.A_Function_Renaming_Declaration,
       Action => P.Declarations.Function_Renaming_Declaration
                   .Intrinsic_Name'Access),
      (Name   => N.Intrinsic_Name,
       Kind   => F.A_Procedure_Declaration,
       Action => P.Declarations.Procedure_Declaration.Intrinsic_Name'Access),
      (Name   => N.Intrinsic_Name,
       Kind   => F.An_Identifier,
       Action => P.Expressions.Identifiers.Intrinsic_Name'Access),
      (Name   => N.Intrinsic_Name,
       Kind   => F.A_Selected_Component,
       Action => P.Expressions.Selected_Components
                   .Call_Convention'Access)
     );

   Range_List : constant Range_Array :=
     ((N.Code,
       F.An_And_Operator, F.A_Not_Operator,
       P.Expressions.Identifiers.Code'Access),
      (N.Call_Convention,
       F.An_And_Operator, F.A_Not_Operator,
       P.Expressions.Identifiers.Call_Convention'Access),
      (N.Intrinsic_Name,
       F.An_And_Operator, F.A_Not_Operator,
       P.Expressions.Identifiers.Intrinsic_Name'Access));
begin
   for X of Action_List loop
      Self.Register_Calculator (X.Kind, X.Name, X.Action);
   end loop;

   for X of Range_List loop
      for J in X.From .. X.To loop
         Self.Register_Calculator (J, X.Name, X.Action);
      end loop;
   end loop;
end Engines.Registry_All_Actions;
