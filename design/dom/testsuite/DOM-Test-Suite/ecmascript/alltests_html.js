var isLogging = false;
var loggedErrors = 0;
var loggedFailures = 0;
var loggedTests = 0;
var log = new Array();

function startLogging() {
  var logDoc = test_log.document;
  logDoc.write("Test logging started");
  logDoc.close();  
  loggedErrors = 0;
  loggedFailures = 0;
  loggedTests = 0;
  isLogging = true;
  return false;
}

function endLogging() {
  isLogging = false;
  var logDoc = test_log.document;
  logDoc.open();
  logDoc.writeln("<html><head>");
  logDoc.writeln("<meta HTTP-EQUIV='Content-Type' CONTENT='text/html; CHARSET=utf-16'>");    
  logDoc.write("<title>Test log</title></head><body><pre>");
  logDoc.writeln("&lt;testsuite errors='" + loggedErrors + "' failures='" + loggedFailures + "' tests='" + loggedTests + "'&gt;");
  for (i = 0; i < log.length; i++) {
     logDoc.writeln(log[i]);
  } 
  logDoc.writeln("&lt;/testsuite&gt;");
  logDoc.write("</pre></body></html>");
  logDoc.close();
  loggedErrors = 0;
  loggedFailures = 0;
  loggedTests = 0;
  log = new Array();
}

function setResult(testName, resultType, message) {
   var report = "";
   if (isLogging) {
      if (resultType == null) {
         report = "&lt;testcase name='" + testName + "'/&gt;\n";
         loggedTests++;
      } else {
         if (resultType == "skip") {
      	   report = "&lt;skip name='" + testName + "'";
      	   if (message != null) {
      	     report = report + " message='" + message + "'/&gt;\n";
      	   } else {
      	     report = report + "/&gt;\n";
      	   }
         } else {
           loggedTests++;
           report = "&lt;testcase name='" + testName + "'&gt;\n";
           if (resultType == "failure") {
             loggedFailures++;
             report = report + "&lt;failure";
           } else {
             loggedErrors++;
             report = report + "&lt;error";
           }
      	   if (message != null) {
      	     report = report + " message='" + message + "'/&gt;\n";
      	   } else {
      	     report = report + "/&gt;\n";
      	   }
      	   report = report + "&lt;/testcase&gt;\n";
         }
      }
      log[log.length] = report;
   }
}

