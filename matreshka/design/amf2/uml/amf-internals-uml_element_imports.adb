package body AMF.Internals.UML_Element_Imports is

   ---------------
   -- Get_Alias --
   ---------------

   overriding function Get_Alias
     (Self : not null access constant UML_Element_Import_Proxy)
      return AMF.Optional_String
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Alias unimplemented");
      raise Program_Error with "Unimplemented function Get_Alias";
      return Get_Alias (Self);
   end Get_Alias;

   ---------------
   -- Set_Alias --
   ---------------

   overriding procedure Set_Alias
     (Self : not null access UML_Element_Import_Proxy;
      To   : AMF.Optional_String)
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Set_Alias unimplemented");
      raise Program_Error with "Unimplemented procedure Set_Alias";
   end Set_Alias;

   --------------------------
   -- Get_Imported_Element --
   --------------------------

   overriding function Get_Imported_Element
     (Self : not null access constant UML_Element_Import_Proxy)
      return AMF.UML.Packageable_Elements.UML_Packageable_Element_Access
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Imported_Element unimplemented");
      raise Program_Error with "Unimplemented function Get_Imported_Element";
      return Get_Imported_Element (Self);
   end Get_Imported_Element;

   --------------------------
   -- Set_Imported_Element --
   --------------------------

   overriding procedure Set_Imported_Element
     (Self : not null access UML_Element_Import_Proxy;
      To   : AMF.UML.Packageable_Elements.UML_Packageable_Element_Access)
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Set_Imported_Element unimplemented");
      raise Program_Error with "Unimplemented procedure Set_Imported_Element";
   end Set_Imported_Element;

   -----------------------------
   -- Get_Importing_Namespace --
   -----------------------------

   overriding function Get_Importing_Namespace
     (Self : not null access constant UML_Element_Import_Proxy)
      return AMF.UML.Namespaces.UML_Namespace_Access
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Importing_Namespace unimplemented");
      raise Program_Error with "Unimplemented function Get_Importing_Namespace";
      return Get_Importing_Namespace (Self);
   end Get_Importing_Namespace;

   -----------------------------
   -- Set_Importing_Namespace --
   -----------------------------

   overriding procedure Set_Importing_Namespace
     (Self : not null access UML_Element_Import_Proxy;
      To   : AMF.UML.Namespaces.UML_Namespace_Access)
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Set_Importing_Namespace unimplemented");
      raise Program_Error with "Unimplemented procedure Set_Importing_Namespace";
   end Set_Importing_Namespace;

   --------------------
   -- Get_Visibility --
   --------------------

   overriding function Get_Visibility
     (Self : not null access constant UML_Element_Import_Proxy)
      return AMF.UML.UML_Visibility_Kind
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Visibility unimplemented");
      raise Program_Error with "Unimplemented function Get_Visibility";
      return Get_Visibility (Self);
   end Get_Visibility;

   --------------------
   -- Set_Visibility --
   --------------------

   overriding procedure Set_Visibility
     (Self : not null access UML_Element_Import_Proxy;
      To   : AMF.UML.UML_Visibility_Kind)
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Set_Visibility unimplemented");
      raise Program_Error with "Unimplemented procedure Set_Visibility";
   end Set_Visibility;

   ----------------
   -- Get_Source --
   ----------------

   overriding function Get_Source
     (Self : not null access constant UML_Element_Import_Proxy)
      return AMF.UML.Elements.Collections.Set_Of_UML_Element
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Source unimplemented");
      raise Program_Error with "Unimplemented function Get_Source";
      return Get_Source (Self);
   end Get_Source;

   ----------------
   -- Get_Target --
   ----------------

   overriding function Get_Target
     (Self : not null access constant UML_Element_Import_Proxy)
      return AMF.UML.Elements.Collections.Set_Of_UML_Element
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Target unimplemented");
      raise Program_Error with "Unimplemented function Get_Target";
      return Get_Target (Self);
   end Get_Target;

   -------------------------
   -- Get_Related_Element --
   -------------------------

   overriding function Get_Related_Element
     (Self : not null access constant UML_Element_Import_Proxy)
      return AMF.UML.Elements.Collections.Set_Of_UML_Element
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Related_Element unimplemented");
      raise Program_Error with "Unimplemented function Get_Related_Element";
      return Get_Related_Element (Self);
   end Get_Related_Element;

   -----------------------
   -- Get_Owned_Comment --
   -----------------------

   overriding function Get_Owned_Comment
     (Self : not null access constant UML_Element_Import_Proxy)
      return AMF.UML.Comments.Collections.Set_Of_UML_Comment
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Owned_Comment unimplemented");
      raise Program_Error with "Unimplemented function Get_Owned_Comment";
      return Get_Owned_Comment (Self);
   end Get_Owned_Comment;

   -----------------------
   -- Get_Owned_Element --
   -----------------------

   overriding function Get_Owned_Element
     (Self : not null access constant UML_Element_Import_Proxy)
      return AMF.UML.Elements.Collections.Set_Of_UML_Element
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Owned_Element unimplemented");
      raise Program_Error with "Unimplemented function Get_Owned_Element";
      return Get_Owned_Element (Self);
   end Get_Owned_Element;

   ---------------
   -- Get_Owner --
   ---------------

   overriding function Get_Owner
     (Self : not null access constant UML_Element_Import_Proxy)
      return AMF.UML.Elements.UML_Element_Access
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Owner unimplemented");
      raise Program_Error with "Unimplemented function Get_Owner";
      return Get_Owner (Self);
   end Get_Owner;

   --------------
   -- Get_Name --
   --------------

   overriding function Get_Name
     (Self : not null access constant UML_Element_Import_Proxy)
      return League.Strings.Universal_String
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Get_Name unimplemented");
      raise Program_Error with "Unimplemented function Get_Name";
      return Get_Name (Self);
   end Get_Name;

   ------------------------
   -- All_Owned_Elements --
   ------------------------

   overriding function All_Owned_Elements
     (Self : not null access constant UML_Element_Import_Proxy)
      return AMF.UML.Elements.Collections.Set_Of_UML_Element
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "All_Owned_Elements unimplemented");
      raise Program_Error with "Unimplemented function All_Owned_Elements";
      return All_Owned_Elements (Self);
   end All_Owned_Elements;

   -------------------
   -- Must_Be_Owned --
   -------------------

   overriding function Must_Be_Owned
     (Self : not null access constant UML_Element_Import_Proxy)
      return Boolean
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "Must_Be_Owned unimplemented");
      raise Program_Error with "Unimplemented function Must_Be_Owned";
      return Must_Be_Owned (Self);
   end Must_Be_Owned;

end AMF.Internals.UML_Element_Imports;
