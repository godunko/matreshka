with WebAPI.Consoles; use WebAPI.Consoles;

package body REPORT is

   TYPE STATUS IS (PASS, FAIL, DOES_NOT_APPLY, ACTION_REQUIRED,
                   UNKNOWN);

   TEST_STATUS : STATUS := FAIL;

   -------------
   -- COMMENT --
   -------------

   procedure COMMENT
     (DESCR : STRING)
   is
   begin
      null;
   end COMMENT;

   -----------
   -- EQUAL --
   -----------

   function EQUAL
     (X, Y : INTEGER)
      return BOOLEAN
   is
   begin
      return X = Y;
   end EQUAL;

   ------------
   -- FAILED --
   ------------

   procedure FAILED
     (DESCR : STRING)
   is
   begin
      TEST_STATUS := FAIL;
   end FAILED;

   ----------------
   -- IDENT_BOOL --
   ----------------

   function IDENT_BOOL
     (X : BOOLEAN)
      return BOOLEAN
   is
   begin
      return X;
   end IDENT_BOOL;

   ----------------
   -- IDENT_CHAR --
   ----------------

   function IDENT_CHAR
     (X : CHARACTER)
      return CHARACTER
   is
   begin
      return X;
   end IDENT_CHAR;

   ---------------
   -- IDENT_INT --
   ---------------

   function IDENT_INT
     (X : INTEGER)
      return INTEGER
   is
   begin
      return X;
   end IDENT_INT;

   ---------------
   -- IDENT_STR --
   ---------------

   function IDENT_STR
     (X : STRING)
      return STRING
   is
   begin
      return X;
   end IDENT_STR;

   ---------------------
   -- IDENT_WIDE_CHAR --
   ---------------------

   function IDENT_WIDE_CHAR
     (X : WIDE_CHARACTER)
      return WIDE_CHARACTER
   is
   begin
      return X;
   end IDENT_WIDE_CHAR;

   --------------------
   -- IDENT_WIDE_STR --
   --------------------

   function IDENT_WIDE_STR
     (X : WIDE_STRING)
      return WIDE_STRING
   is
   begin
      return X;
   end IDENT_WIDE_STR;

   ---------------------
   -- LEGAL_FILE_NAME --
   ---------------------

   function LEGAL_FILE_NAME
     (X : FILE_NUM := 1;
      NAM : STRING := "")
      return STRING
   is
   begin
      return NAM;
   end LEGAL_FILE_NAME;

   --------------------
   -- NOT_APPLICABLE --
   --------------------

   procedure NOT_APPLICABLE
     (DESCR : STRING)
   is
   begin
      IF TEST_STATUS = PASS  --  OR TEST_STATUS = ACTION_REQUIRED
      THEN
         TEST_STATUS := DOES_NOT_APPLY;
      END IF;
   end NOT_APPLICABLE;

   ------------
   -- RESULT --
   ------------

   procedure RESULT is
   begin
      case TEST_STATUS is
         when PASS =>
            Console.Log ("==== PASSED");
         when DOES_NOT_APPLY =>
            Console.Log ("++++ NOT-APPLICABLE");
         when ACTION_REQUIRED =>
            Console.Log ("!!!! TENTATIVELY PASSED");
         when others =>
            Console.Log ("**** FAILED");
      end case;

      TEST_STATUS := FAIL;
   end RESULT;

   --------------------
   -- SPECIAL_ACTION --
   --------------------

   procedure SPECIAL_ACTION
     (DESCR : STRING)
   is
   begin
      IF TEST_STATUS = PASS THEN
         TEST_STATUS := ACTION_REQUIRED;
      END IF;
   end SPECIAL_ACTION;

   ----------
   -- TEST --
   ----------

   procedure TEST
     (NAME : STRING;
      DESCR : STRING)
   is
   begin
      TEST_STATUS := PASS;
      Console.Log (NAME & " " & DESCR);
   end TEST;

   ----------------
   -- TIME_STAMP --
   ----------------

   function TIME_STAMP
      return STRING
   is
   begin
      return "112233";
   end TIME_STAMP;

end REPORT;
