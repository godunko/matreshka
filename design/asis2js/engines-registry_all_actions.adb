with League.Strings;

with Asis.Extensions.Flat_Kinds;

with Properties.Declarations.Constant_Declarations;
with Properties.Declarations.Defining_Names;
with Properties.Declarations.Function_Declarations;
with Properties.Declarations.Function_Renaming_Declaration;
with Properties.Declarations.Ordinary_Type;
with Properties.Declarations.Package_Declaration;
with Properties.Declarations.Private_Type;
with Properties.Declarations.Procedure_Body_Declarations;
with Properties.Declarations.Procedure_Declaration;
with Properties.Definitions.Access_To_Object;
with Properties.Definitions.Component_Definition;
with Properties.Definitions.Constrained_Array_Type;
with Properties.Definitions.Enumeration_Type;
with Properties.Definitions.Simple_Expression_Range;
with Properties.Definitions.Tagged_Record_Type;
with Properties.Definitions.Subtype_Indication;
with Properties.Expressions.Array_Component_Association;
with Properties.Expressions.Attribute_Reference;
with Properties.Expressions.Enumeration_Literal;
with Properties.Expressions.Explicit_Dereference;
with Properties.Expressions.Function_Calls;
with Properties.Expressions.Identifiers;
with Properties.Expressions.Indexed_Component;
with Properties.Expressions.Integer_Literal;
with Properties.Expressions.Named_Array_Aggregate;
with Properties.Expressions.Null_Literal;
with Properties.Expressions.Selected_Components;
with Properties.Expressions.String_Literal;
with Properties.Expressions.Type_Conversion;
with Properties.Statements.Assignment_Statement;
with Properties.Statements.Case_Statement;
with Properties.Statements.For_Loop_Statement;
with Properties.Statements.If_Statement;
with Properties.Statements.Null_Statement;
with Properties.Statements.Procedure_Call_Statement;
with Properties.Statements.Return_Statement;

procedure Engines.Registry_All_Actions
  (Self : in out Engines.Contexts.Context)
is
   type Text_Callback is access function
     (Engine  : access Engines.Contexts.Context;
      Element : Asis.Element;
      Name    : Engines.Text_Property) return League.Strings.Universal_String;

   type Action_Item is record
      Name   : Engines.Text_Property;
      Kind   : Asis.Extensions.Flat_Kinds.Flat_Element_Kinds;
      Action : Text_Callback;
   end record;

   type Action_Array is array (Positive range <>) of Action_Item;

   type Action_Range is record
      Name     : Engines.Text_Property;
      From, To : Asis.Extensions.Flat_Kinds.Flat_Element_Kinds;
      Action   : Text_Callback;
   end record;

   type Range_Array is array (Positive range <>) of Action_Range;

   package F renames Asis.Extensions.Flat_Kinds;
   package N renames Engines;
   package P renames Properties;

   Action_List : constant Action_Array :=
     --  Code
     ((Name   => N.Code,
       Kind   => F.A_Use_Package_Clause,
       Action => P.Statements.Null_Statement.Code'Access),
      (Name   => N.Code,
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
       Kind   => F.A_Private_Extension_Declaration,
       Action => P.Statements.Null_Statement.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Private_Type_Declaration,
       Action => P.Statements.Null_Statement.Code'Access),
      (Name   => N.Code,
       Kind   => F.An_Incomplete_Type_Declaration,
       Action => P.Statements.Null_Statement.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Procedure_Body_Declaration,
       Action => P.Declarations.Procedure_Body_Declarations.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Function_Body_Declaration,
       Action => P.Declarations.Procedure_Body_Declarations.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Procedure_Declaration,
       Action => P.Declarations.Function_Declarations.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Subtype_Declaration,
       Action => P.Statements.Null_Statement.Code'Access),
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
       Kind   => F.A_Subtype_Indication,
       Action => P.Definitions.Subtype_Indication.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Constrained_Array_Definition,
       Action => P.Statements.Null_Statement.Code'Access),  --  Ignore
      (Name   => N.Code,
       Kind   => F.A_Derived_Record_Extension_Definition,
       Action => P.Definitions.Tagged_Record_Type.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Tagged_Record_Type_Definition,
       Action => P.Definitions.Tagged_Record_Type.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Record_Type_Definition,
       Action => P.Statements.Null_Statement.Code'Access),  --  Ignore
      (Name   => N.Code,
       Kind   => F.An_Access_To_Variable,
       Action => P.Statements.Null_Statement.Code'Access),  --  Ignore
      (Name   => N.Code,
       Kind   => F.A_Pool_Specific_Access_To_Variable,
       Action => P.Statements.Null_Statement.Code'Access),  --  Ignore
      (Name   => N.Code,
       Kind   => F.A_Discrete_Simple_Expression_Range_As_Subtype_Definition,
       Action => P.Definitions.Simple_Expression_Range.Code'Access),
      (Name   => N.Code,
       Kind   => F.An_Enumeration_Literal,
       Action => P.Expressions.Enumeration_Literal.Code'Access),
      (Name   => N.Code,
       Kind   => F.An_Explicit_Dereference,
       Action => P.Expressions.Explicit_Dereference.Code'Access),
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
       Kind   => F.A_Real_Literal,
       Action => P.Expressions.Integer_Literal.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Named_Array_Aggregate,
       Action => P.Expressions.Named_Array_Aggregate.Code'Access),
      (Name   => N.Code,
       Kind   => F.An_Array_Component_Association,
       Action => P.Expressions.Array_Component_Association.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Null_Literal,
       Action => P.Expressions.Null_Literal.Code'Access),
      (Name   => N.Code,
       Kind   => F.A_Selected_Component,
       Action => P.Expressions.Selected_Components.Code'Access),
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
       Kind   => F.A_Case_Statement,
       Action => P.Statements.Case_Statement.Code'Access),
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
      (Name   => N.Code,
       Kind   => F.A_With_Clause,
       Action => P.Statements.Null_Statement.Code'Access),

      --  Initialize
      (Name   => N.Initialize,
       Kind   => F.A_Constant_Declaration,
       Action => P.Declarations.Constant_Declarations.Initialize'Access),
      (Name   => N.Initialize,
       Kind   => F.A_Component_Declaration,
       Action => P.Declarations.Constant_Declarations.Initialize'Access),
      (Name   => N.Initialize,
       Kind   => F.A_Variable_Declaration,
       Action => P.Declarations.Constant_Declarations.Initialize'Access),
      (Name   => N.Initialize,
       Kind   => F.An_Ordinary_Type_Declaration,
       Action => P.Declarations.Ordinary_Type.Code'Access),
      (Name   => N.Initialize,
       Kind   => F.A_Private_Extension_Declaration,
       Action => P.Declarations.Private_Type.Initialize'Access),
      (Name   => N.Initialize,
       Kind   => F.A_Component_Definition,
       Action => P.Definitions.Component_Definition.Initialize'Access),
      (Name   => N.Initialize,
       Kind   => F.A_Derived_Record_Extension_Definition,
       Action => P.Statements.Null_Statement.Code'Access),  --  Ignore
      (Name   => N.Initialize,
       Kind   => F.An_Access_To_Variable,
       Action => P.Definitions.Access_To_Object.Initialize'Access),
      (Name   => N.Initialize,
       Kind   => F.A_Constrained_Array_Definition,
       Action => P.Definitions.Constrained_Array_Type.Initialize'Access),
      (Name   => N.Initialize,
       Kind   => F.A_Subtype_Indication,
       Action => P.Definitions.Subtype_Indication.Initialize'Access),
      (Name   => N.Initialize,
       Kind   => F.An_Identifier,
       Action => P.Expressions.Identifiers.Initialize'Access),
      (Name   => N.Initialize,
       Kind   => F.A_Selected_Component,
       Action => P.Expressions.Selected_Components.Initialize'Access),

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
                   .Intrinsic_Name'Access)
     );

   Range_List : constant Range_Array :=
     ((N.Code,
       F.An_And_Operator, F.A_Not_Operator,
      P.Expressions.Identifiers.Code'Access),
      (N.Code,
       F.An_Access_Attribute, F.An_Implementation_Defined_Attribute,
       P.Expressions.Attribute_Reference.Code'Access),
      (N.Intrinsic_Name,
       F.An_And_Operator, F.A_Not_Operator,
       P.Expressions.Identifiers.Intrinsic_Name'Access));
begin
   for X of Action_List loop
      Self.Text.Register_Calculator (X.Kind, X.Name, X.Action);
   end loop;

   for X of Range_List loop
      for J in X.From .. X.To loop
         Self.Text.Register_Calculator (J, X.Name, X.Action);
      end loop;
   end loop;

   --  Call_Convention
   Self.Call_Convention.Register_Calculator
     (Name   => N.Call_Convention,
      Kind   => F.A_Function_Call,
      Action => P.Expressions.Function_Calls.Call_Convention'Access);
   Self.Call_Convention.Register_Calculator
     (Name   => N.Call_Convention,
      Kind   => F.An_Identifier,
      Action => P.Expressions.Identifiers.Call_Convention'Access);
   Self.Call_Convention.Register_Calculator
     (Name   => N.Call_Convention,
      Kind   => F.A_Function_Declaration,
      Action => P.Declarations.Function_Declarations.Call_Convention'Access);
   Self.Call_Convention.Register_Calculator
     (Name   => N.Call_Convention,
      Kind   => F.A_Function_Renaming_Declaration,
      Action => P.Declarations.Function_Renaming_Declaration
      .Call_Convention'Access);
   Self.Call_Convention.Register_Calculator
     (Name   => N.Call_Convention,
      Kind   => F.A_Procedure_Declaration,
      Action => P.Declarations.Procedure_Declaration.Call_Convention'Access);
   Self.Call_Convention.Register_Calculator
     (Name   => N.Call_Convention,
      Kind   => F.A_Selected_Component,
      Action => P.Expressions.Selected_Components.Call_Convention'Access);

   for X in F.An_And_Operator .. F.A_Not_Operator loop
      Self.Call_Convention.Register_Calculator
        (Kind    => X,
         Name    => N.Call_Convention,
         Action  => P.Expressions.Identifiers.Call_Convention'Access);
   end loop;

   --  Export
   Self.Boolean.Register_Calculator
     (Name   => N.Export,
      Kind   => F.A_Function_Body_Declaration,
      Action => P.Declarations.Procedure_Body_Declarations.Export'Access);
   Self.Boolean.Register_Calculator
     (Name   => N.Export,
      Kind   => F.A_Function_Declaration,
      Action => P.Declarations.Function_Declarations.Export'Access);
   Self.Boolean.Register_Calculator
     (Name   => N.Export,
      Kind   => F.A_Procedure_Body_Declaration,
      Action => P.Declarations.Procedure_Body_Declarations.Export'Access);
   Self.Boolean.Register_Calculator
     (Name   => N.Export,
      Kind   => F.A_Procedure_Declaration,
      Action => P.Declarations.Function_Declarations.Export'Access);

   for X in F.Flat_Declaration_Kinds loop
      Self.Boolean.Register_Calculator
        (Kind    => X,
         Name    => N.Inside_Package,
         Action  => P.Declarations.Inside_Package'Access);
   end loop;

   Self.Boolean.Register_Calculator
     (Kind    => F.A_Function_Declaration,
      Name    => N.Is_Dispatching,
      Action  => P.Declarations.Function_Declarations.Is_Dispatching'Access);
   Self.Boolean.Register_Calculator
     (Kind    => F.A_Procedure_Declaration,
      Name    => N.Is_Dispatching,
      Action  => P.Declarations.Function_Declarations.Is_Dispatching'Access);
   Self.Boolean.Register_Calculator
     (Kind    => F.A_Function_Body_Declaration,
      Name    => N.Is_Dispatching,
      Action  =>
        P.Declarations.Procedure_Body_Declarations.Is_Dispatching'Access);
   Self.Boolean.Register_Calculator
     (Kind    => F.A_Procedure_Body_Declaration,
      Name    => N.Is_Dispatching,
      Action  =>
        P.Declarations.Procedure_Body_Declarations.Is_Dispatching'Access);
   Self.Boolean.Register_Calculator
     (Kind    => F.A_Selected_Component,
      Name    => N.Is_Dispatching,
      Action  => P.Expressions.Selected_Components.Is_Dispatching'Access);
   Self.Boolean.Register_Calculator
     (Kind    => F.An_Identifier,
      Name    => N.Is_Dispatching,
      Action  => P.Expressions.Identifiers.Is_Dispatching'Access);
   Self.Boolean.Register_Calculator
     (Kind   => F.A_Function_Renaming_Declaration,
      Name   => N.Is_Dispatching,
      Action => P.Declarations.Function_Renaming_Declaration
                   .Is_Dispatching'Access);

   for X in F.An_And_Operator .. F.A_Not_Operator loop
      Self.Boolean.Register_Calculator
        (Kind    => X,
         Name    => N.Is_Dispatching,
         Action  => P.Expressions.Identifiers.Is_Dispatching'Access);
   end loop;

end Engines.Registry_All_Actions;
