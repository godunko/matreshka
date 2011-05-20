package body AMF.Internals.CMOF_Operations is

   -----------------------
   -- Get_Owned_Element --
   -----------------------

   overriding function Get_Owned_Element
     (Self : not null access constant CMOF_Operation_Proxy)
      return AMF.CMOF.Elements.Collections.Set_Of_CMOF_Element
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Owned_Element unimplemented");
      raise Program_Error;
      return Get_Owned_Element (Self);
   end Get_Owned_Element;

   ---------------
   -- Get_Owner --
   ---------------

   overriding function Get_Owner
     (Self : not null access constant CMOF_Operation_Proxy)
      return AMF.CMOF.Elements.CMOF_Element
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Owner unimplemented");
      raise Program_Error;
      return Get_Owner (Self);
   end Get_Owner;

   -----------------------
   -- Get_Owned_Comment --
   -----------------------

   overriding function Get_Owned_Comment
     (Self : not null access constant CMOF_Operation_Proxy)
      return AMF.CMOF.Comments.Collections.Set_Of_CMOF_Comment
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Owned_Comment unimplemented");
      raise Program_Error;
      return Get_Owned_Comment (Self);
   end Get_Owned_Comment;

   --------------
   -- Get_Name --
   --------------

   overriding function Get_Name
     (Self : not null access constant CMOF_Operation_Proxy)
      return Optional_String
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Name unimplemented");
      raise Program_Error;
      return Get_Name (Self);
   end Get_Name;

   --------------
   -- Set_Name --
   --------------

   overriding procedure Set_Name
     (Self : not null access CMOF_Operation_Proxy;
      To   : Optional_String)
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Set_Name unimplemented");
      raise Program_Error;
   end Set_Name;

   --------------------
   -- Get_Visibility --
   --------------------

   overriding function Get_Visibility
     (Self : not null access constant CMOF_Operation_Proxy)
      return CMOF.Optional_CMOF_Visibility_Kind
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Visibility unimplemented");
      raise Program_Error;
      return Get_Visibility (Self);
   end Get_Visibility;

   --------------------
   -- Set_Visibility --
   --------------------

   overriding procedure Set_Visibility
     (Self : not null access CMOF_Operation_Proxy;
      To   : CMOF.Optional_CMOF_Visibility_Kind)
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Set_Visibility unimplemented");
      raise Program_Error;
   end Set_Visibility;

   -------------------
   -- Get_Namespace --
   -------------------

   overriding function Get_Namespace
     (Self : not null access constant CMOF_Operation_Proxy)
      return AMF.CMOF.Namespaces.CMOF_Namespace
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Namespace unimplemented");
      raise Program_Error;
      return Get_Namespace (Self);
   end Get_Namespace;

   ------------------------
   -- Get_Qualified_Name --
   ------------------------

   overriding function Get_Qualified_Name
     (Self : not null access constant CMOF_Operation_Proxy)
      return Optional_String
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Qualified_Name unimplemented");
      raise Program_Error;
      return Get_Qualified_Name (Self);
   end Get_Qualified_Name;

   -------------------------
   -- Get_Imported_Member --
   -------------------------

   overriding function Get_Imported_Member
     (Self : not null access constant CMOF_Operation_Proxy)
      return AMF.CMOF.Packageable_Elements.Collections.Set_Of_CMOF_Packageable_Element
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Imported_Member unimplemented");
      raise Program_Error;
      return Get_Imported_Member (Self);
   end Get_Imported_Member;

   ------------------------
   -- Get_Element_Import --
   ------------------------

   overriding function Get_Element_Import
     (Self : not null access constant CMOF_Operation_Proxy)
      return AMF.CMOF.Element_Imports.Collections.Set_Of_CMOF_Element_Import
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Element_Import unimplemented");
      raise Program_Error;
      return Get_Element_Import (Self);
   end Get_Element_Import;

   ------------------------
   -- Get_Package_Import --
   ------------------------

   overriding function Get_Package_Import
     (Self : not null access constant CMOF_Operation_Proxy)
      return AMF.CMOF.Package_Imports.Collections.Set_Of_CMOF_Package_Import
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Package_Import unimplemented");
      raise Program_Error;
      return Get_Package_Import (Self);
   end Get_Package_Import;

   ----------------------
   -- Get_Owned_Member --
   ----------------------

   overriding function Get_Owned_Member
     (Self : not null access constant CMOF_Operation_Proxy)
      return AMF.CMOF.Named_Elements.Collections.Set_Of_CMOF_Named_Element
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Owned_Member unimplemented");
      raise Program_Error;
      return Get_Owned_Member (Self);
   end Get_Owned_Member;

   ----------------
   -- Get_Member --
   ----------------

   overriding function Get_Member
     (Self : not null access constant CMOF_Operation_Proxy)
      return AMF.CMOF.Named_Elements.Collections.Set_Of_CMOF_Named_Element
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Member unimplemented");
      raise Program_Error;
      return Get_Member (Self);
   end Get_Member;

   --------------------
   -- Get_Owned_Rule --
   --------------------

   overriding function Get_Owned_Rule
     (Self : not null access constant CMOF_Operation_Proxy)
      return AMF.CMOF.Constraints.Collections.Set_Of_CMOF_Constraint
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Owned_Rule unimplemented");
      raise Program_Error;
      return Get_Owned_Rule (Self);
   end Get_Owned_Rule;

   ------------------------------
   -- Get_Redefinition_Context --
   ------------------------------

   overriding function Get_Redefinition_Context
     (Self : not null access constant CMOF_Operation_Proxy)
      return AMF.CMOF.Classifiers.Collections.Set_Of_CMOF_Classifier
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Redefinition_Context unimplemented");
      raise Program_Error;
      return Get_Redefinition_Context (Self);
   end Get_Redefinition_Context;

   ---------------------------
   -- Get_Redefined_Element --
   ---------------------------

   overriding function Get_Redefined_Element
     (Self : not null access constant CMOF_Operation_Proxy)
      return AMF.CMOF.Redefinable_Elements.Collections.Set_Of_CMOF_Redefinable_Element
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Redefined_Element unimplemented");
      raise Program_Error;
      return Get_Redefined_Element (Self);
   end Get_Redefined_Element;

   -----------------
   -- Get_Is_Leaf --
   -----------------

   overriding function Get_Is_Leaf
     (Self : not null access constant CMOF_Operation_Proxy)
      return Boolean
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Is_Leaf unimplemented");
      raise Program_Error;
      return Get_Is_Leaf (Self);
   end Get_Is_Leaf;

   -----------------
   -- Set_Is_Leaf --
   -----------------

   overriding procedure Set_Is_Leaf
     (Self : not null access CMOF_Operation_Proxy;
      To   : Boolean)
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Set_Is_Leaf unimplemented");
      raise Program_Error;
   end Set_Is_Leaf;

   ------------------------------
   -- Get_Featuring_Classifier --
   ------------------------------

   overriding function Get_Featuring_Classifier
     (Self : not null access constant CMOF_Operation_Proxy)
      return AMF.CMOF.Classifiers.Collections.Set_Of_CMOF_Classifier
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Featuring_Classifier unimplemented");
      raise Program_Error;
      return Get_Featuring_Classifier (Self);
   end Get_Featuring_Classifier;

   ------------------
   -- Get_Is_Query --
   ------------------

   overriding function Get_Is_Query
     (Self : not null access constant CMOF_Operation_Proxy)
      return Boolean
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Is_Query unimplemented");
      raise Program_Error;
      return Get_Is_Query (Self);
   end Get_Is_Query;

   ------------------
   -- Set_Is_Query --
   ------------------

   overriding procedure Set_Is_Query
     (Self : not null access CMOF_Operation_Proxy;
      To   : Boolean)
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Set_Is_Query unimplemented");
      raise Program_Error;
   end Set_Is_Query;

   --------------------
   -- Get_Is_Ordered --
   --------------------

   overriding function Get_Is_Ordered
     (Self : not null access constant CMOF_Operation_Proxy)
      return Boolean
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Is_Ordered unimplemented");
      raise Program_Error;
      return Get_Is_Ordered (Self);
   end Get_Is_Ordered;

   --------------------
   -- Set_Is_Ordered --
   --------------------

   overriding procedure Set_Is_Ordered
     (Self : not null access CMOF_Operation_Proxy;
      To   : Boolean)
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Set_Is_Ordered unimplemented");
      raise Program_Error;
   end Set_Is_Ordered;

   -------------------
   -- Get_Is_Unique --
   -------------------

   overriding function Get_Is_Unique
     (Self : not null access constant CMOF_Operation_Proxy)
      return Boolean
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Is_Unique unimplemented");
      raise Program_Error;
      return Get_Is_Unique (Self);
   end Get_Is_Unique;

   -------------------
   -- Set_Is_Unique --
   -------------------

   overriding procedure Set_Is_Unique
     (Self : not null access CMOF_Operation_Proxy;
      To   : Boolean)
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Set_Is_Unique unimplemented");
      raise Program_Error;
   end Set_Is_Unique;

   ---------------
   -- Get_Lower --
   ---------------

   overriding function Get_Lower
     (Self : not null access constant CMOF_Operation_Proxy)
      return Optional_Integer
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Lower unimplemented");
      raise Program_Error;
      return Get_Lower (Self);
   end Get_Lower;

   ---------------
   -- Set_Lower --
   ---------------

   overriding procedure Set_Lower
     (Self : not null access CMOF_Operation_Proxy;
      To   : Optional_Integer)
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Set_Lower unimplemented");
      raise Program_Error;
   end Set_Lower;

   ---------------
   -- Get_Upper --
   ---------------

   overriding function Get_Upper
     (Self : not null access constant CMOF_Operation_Proxy)
      return Optional_Unlimited_Natural
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Upper unimplemented");
      raise Program_Error;
      return Get_Upper (Self);
   end Get_Upper;

   ---------------
   -- Set_Upper --
   ---------------

   overriding procedure Set_Upper
     (Self : not null access CMOF_Operation_Proxy;
      To   : Optional_Unlimited_Natural)
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Set_Upper unimplemented");
      raise Program_Error;
   end Set_Upper;

   ---------------
   -- Get_Class --
   ---------------

   overriding function Get_Class
     (Self : not null access constant CMOF_Operation_Proxy)
      return AMF.CMOF.Classes.CMOF_Class
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Class unimplemented");
      raise Program_Error;
      return Get_Class (Self);
   end Get_Class;

   ---------------
   -- Set_Class --
   ---------------

   overriding procedure Set_Class
     (Self : not null access CMOF_Operation_Proxy;
      To   : AMF.CMOF.Classes.CMOF_Class)
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Set_Class unimplemented");
      raise Program_Error;
   end Set_Class;

   ------------------
   -- Get_Datatype --
   ------------------

   overriding function Get_Datatype
     (Self : not null access constant CMOF_Operation_Proxy)
      return AMF.CMOF.Data_Types.CMOF_Data_Type
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Datatype unimplemented");
      raise Program_Error;
      return Get_Datatype (Self);
   end Get_Datatype;

   ------------------
   -- Set_Datatype --
   ------------------

   overriding procedure Set_Datatype
     (Self : not null access CMOF_Operation_Proxy;
      To   : AMF.CMOF.Data_Types.CMOF_Data_Type)
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Set_Datatype unimplemented");
      raise Program_Error;
   end Set_Datatype;

   --------------------------
   -- Get_Raised_Exception --
   --------------------------

   overriding function Get_Raised_Exception
     (Self : not null access constant CMOF_Operation_Proxy)
      return AMF.CMOF.Types.Collections.Set_Of_CMOF_Type
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Raised_Exception unimplemented");
      raise Program_Error;
      return Get_Raised_Exception (Self);
   end Get_Raised_Exception;

   -----------------------------
   -- Get_Redefined_Operation --
   -----------------------------

   overriding function Get_Redefined_Operation
     (Self : not null access constant CMOF_Operation_Proxy)
      return AMF.CMOF.Operations.Collections.Set_Of_CMOF_Operation
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Redefined_Operation unimplemented");
      raise Program_Error;
      return Get_Redefined_Operation (Self);
   end Get_Redefined_Operation;

   --------------
   -- Get_Type --
   --------------

   overriding function Get_Type
     (Self : not null access constant CMOF_Operation_Proxy)
      return AMF.CMOF.Types.CMOF_Type
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Type unimplemented");
      raise Program_Error;
      return Get_Type (Self);
   end Get_Type;

   --------------
   -- Set_Type --
   --------------

   overriding procedure Set_Type
     (Self : not null access CMOF_Operation_Proxy;
      To   : AMF.CMOF.Types.CMOF_Type)
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Set_Type unimplemented");
      raise Program_Error;
   end Set_Type;

   -------------------------
   -- Get_Owned_Parameter --
   -------------------------

   overriding function Get_Owned_Parameter
     (Self : not null access constant CMOF_Operation_Proxy)
      return AMF.CMOF.Parameters.Collections.Ordered_Set_Of_CMOF_Parameter
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Owned_Parameter unimplemented");
      raise Program_Error;
      return Get_Owned_Parameter (Self);
   end Get_Owned_Parameter;

   ----------------------
   -- Get_Precondition --
   ----------------------

   overriding function Get_Precondition
     (Self : not null access constant CMOF_Operation_Proxy)
      return AMF.CMOF.Constraints.Collections.Set_Of_CMOF_Constraint
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Precondition unimplemented");
      raise Program_Error;
      return Get_Precondition (Self);
   end Get_Precondition;

   -----------------------
   -- Get_Postcondition --
   -----------------------

   overriding function Get_Postcondition
     (Self : not null access constant CMOF_Operation_Proxy)
      return AMF.CMOF.Constraints.Collections.Set_Of_CMOF_Constraint
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Postcondition unimplemented");
      raise Program_Error;
      return Get_Postcondition (Self);
   end Get_Postcondition;

   ------------------------
   -- Get_Body_Condition --
   ------------------------

   overriding function Get_Body_Condition
     (Self : not null access constant CMOF_Operation_Proxy)
      return AMF.CMOF.Constraints.CMOF_Constraint
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Body_Condition unimplemented");
      raise Program_Error;
      return Get_Body_Condition (Self);
   end Get_Body_Condition;

   ------------------------
   -- Set_Body_Condition --
   ------------------------

   overriding procedure Set_Body_Condition
     (Self : not null access CMOF_Operation_Proxy;
      To   : AMF.CMOF.Constraints.CMOF_Constraint)
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Set_Body_Condition unimplemented");
      raise Program_Error;
   end Set_Body_Condition;

end AMF.Internals.CMOF_Operations;
