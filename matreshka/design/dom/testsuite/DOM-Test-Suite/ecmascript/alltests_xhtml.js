var isLogging = false;
var loggedErrors = 0;
var loggedFailures = 0;
var loggedTests = 0;
var log = new Array();
var xhtmlNS = "http://www.w3.org/1999/xhtml";


function startLogging() {
  loggedErrors = 0;
  loggedFailures = 0;
  loggedTests = 0;
   isLogging = true;
   return false;
}

function endLogging() {
  isLogging = false;
  var logDoc = test_log.document;
  var i;
   var logDoc = test_log.document;
   var html = logDoc.createElementNS(xhtmlNS, "html");
   var head = logDoc.createElementNS(xhtmlNS, "head");
   html.appendChild(head);
   var titleElem = logDoc.createElementNS(xhtmlNS, "title");
   titleElem.appendChild(logDoc.createTextNode("test report"));
   head.appendChild(titleElem);
   var body = logDoc.createElementNS(xhtmlNS, "body");
   html.appendChild(body);
   var preElem = logDoc.createElementNS(xhtmlNS, "pre");
   body.appendChild(preElem);
   var logContent = "<testsuite tests='" + loggedTests + "' errors='" + loggedErrors + "' failures='" + loggedFailures + "'>\n";
   for (i = 0; i < log.length; i++) {
     logContent = logContent + (log[i] + "\n");
   }
   logContent = logContent + "</testsuite>\n";
   preElem.appendChild(logDoc.createTextNode(logContent));
   if (logDoc.documentElement != null) {
       logDoc.replaceChild(html, logDoc.documentElement);
   } else {
       logDoc.appendChild(html);
   }
   log = new Array();
}

function setResult(testName, resultType, message) {
   var report = "";
   if (isLogging) {
      if (resultType == null) {
         report = "<testcase name='" + testName + "'/>\n";
         loggedTests++;         
      } else {
         if (resultType == "skip") {
      	   report = "<skip name='" + testName + "'";
      	   if (message != null) {
      	     report = report + " message='" + message + "'/>\n";
      	   } else {
      	     report = report + "/>\n";
      	   }
         } else {
           loggedTests++;         
           report = "<testcase name='" + testName + "'>\n";
           if (resultType == "failure") {
             report = report + "<failure";
             loggedFailures++;
           } else {
             loggedErrors++;
             report = report + "<error";
           }
      	   if (message != null) {
      	     report = report + " message='" + message + "'/>\n";
      	   } else {
      	     report = report + "/>\n";
      	   }
      	   report = report + "</testcase>\n";
         }
      }
      log[log.length] = report;
   }
}

