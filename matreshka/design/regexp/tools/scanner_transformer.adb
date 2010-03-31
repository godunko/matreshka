--  This program extracts data from the code generated by aflex, and generate
--  actual implementation of scanner for regular expression engine.

with Asis.Ada_Environments;
with Asis.Compilation_Units;
with Asis.Elements;
with Asis.Implementation;

with Scanner_Extractor;
with Scanner_Generator;

procedure Scanner_Transformer is
   Transformer_Context : Asis.Context;
   Scanner_Unit        : Asis.Compilation_Unit;
   Scanner_Body        : Asis.Element;

begin
   Asis.Implementation.Initialize ("-asis05");
   Asis.Ada_Environments.Associate (Transformer_Context, "Transformer_Context", "-C1 .gen/regexp_scanner.adt");
   Asis.Ada_Environments.Open (Transformer_Context);

   Scanner_Unit := Asis.Compilation_Units.Compilation_Unit_Body ("Regexp_Scanner", Transformer_Context);
   Scanner_Body := Asis.Elements.Unit_Declaration (Scanner_Unit);

   Scanner_Extractor.Extract (Scanner_Body);
   Scanner_Generator.Generate_Scanner_Code;
   Scanner_Generator.Generate_Scanner_Tables;

   Asis.Ada_Environments.Close (Transformer_Context);
   Asis.Ada_Environments.Dissociate (Transformer_Context);
   Asis.Implementation.Finalize;
end Scanner_Transformer;
