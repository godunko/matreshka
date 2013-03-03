/*
Copyright (c) 2001-2005 World Wide Web Consortium,
(Massachusetts Institute of Technology, Institut National de
Recherche en Informatique et en Automatique, Keio University). All
Rights Reserved. This program is distributed under the W3C's Software
Intellectual Property License. This program is distributed in the
hope that it will be useful, but WITHOUT ANY WARRANTY; without even
the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.
See W3C License http://www.w3.org/Consortium/Legal/ for more details.
*/
  function assertSize(descr, expected, actual) {
    var actualSize;
    assertNotNull(descr, actual);
    actualSize = actual.length;
    assertEquals(descr, expected, actualSize);
  }

  function assertEqualsAutoCase(context, descr, expected, actual) {
  	if (builder.contentType == "text/html") {
  	    if(context == "attribute") {
  	    	assertEquals(descr, expected.toLowerCase(), actual.toLowerCase());
  	    } else {
  	        assertEquals(descr, expected.toUpperCase(), actual);
  	    }
  	} else {
  		assertEquals(descr, expected, actual); 
  	}
  }
  

  function assertEqualsCollectionAutoCase(context, descr, expected, actual) {
    //
    //  if they aren't the same size, they aren't equal
    assertEquals(descr, expected.length, actual.length);
    
    //
    //  if there length is the same, then every entry in the expected list
    //     must appear once and only once in the actual list
    var expectedLen = expected.length;
    var expectedValue;
    var actualLen = actual.length;
    var i;
    var j;
    var matches;
    for(i = 0; i < expectedLen; i++) {
        matches = 0;
        expectedValue = expected[i];
        for(j = 0; j < actualLen; j++) {
        	if (builder.contentType == "text/html") {
        		if (context == "attribute") {
        			if (expectedValue.toLowerCase() == actual[j].toLowerCase()) {
        				matches++;
        			}
        		} else {
        			if (expectedValue.toUpperCase() == actual[j]) {
        				matches++;
        			}
        		}
        	} else {
            	if(expectedValue == actual[j]) {
                	matches++;
                }
            }
        }
        if(matches == 0) {
            assert(descr + ": No match found for " + expectedValue,false);
        }
        if(matches > 1) {
            assert(descr + ": Multiple matches found for " + expectedValue, false);
        }
    }
  }

  function assertEqualsCollection(descr, expected, actual) {
    //
    //  if they aren't the same size, they aren't equal
    assertEquals(descr, expected.length, actual.length);
    //
    //  if there length is the same, then every entry in the expected list
    //     must appear once and only once in the actual list
    var expectedLen = expected.length;
    var expectedValue;
    var actualLen = actual.length;
    var i;
    var j;
    var matches;
    for(i = 0; i < expectedLen; i++) {
        matches = 0;
        expectedValue = expected[i];
        for(j = 0; j < actualLen; j++) {
            if(expectedValue == actual[j]) {
                matches++;
            }
        }
        if(matches == 0) {
            assert(descr + ": No match found for " + expectedValue,false);
        }
        if(matches > 1) {
            assert(descr + ": Multiple matches found for " + expectedValue, false);
        }
    }
  }


  function assertEqualsListAutoCase(context, descr, expected, actual) {
	var minLength = expected.length;
	if (actual.length < minLength) {
	    minLength = actual.length;
	}
    //
    for(var i = 0; i < minLength; i++) {
		assertEqualsAutoCase(context, descr, expected[i], actual[i]);
    }
    //
    //  if they aren't the same size, they aren't equal
    assertEquals(descr, expected.length, actual.length);
  }


  function assertEqualsList(descr, expected, actual) {
	var minLength = expected.length;
	if (actual.length < minLength) {
	    minLength = actual.length;
	}
    //
    for(var i = 0; i < minLength; i++) {
        if(expected[i] != actual[i]) {
			assertEquals(descr, expected[i], actual[i]);
        }
    }
    //
    //  if they aren't the same size, they aren't equal
    assertEquals(descr, expected.length, actual.length);
  }

  function assertInstanceOf(descr, type, obj) {
    if(type == "Attr") {
        assertEquals(descr,2,obj.nodeType);
        var specd = obj.specified;
    }
  }

  function assertSame(descr, expected, actual) {
    if(expected != actual) {
        assertEquals(descr, expected.nodeType, actual.nodeType);
        assertEquals(descr, expected.nodeValue, actual.nodeValue);
    }
  }

  function assertURIEquals(assertID, scheme, path, host, file, name, query, fragment, isAbsolute, actual) {
    //
    //  URI must be non-null
    assertNotNull(assertID, actual);

    var uri = actual;

    var lastPound = actual.lastIndexOf("#");
    var actualFragment = "";
    if(lastPound != -1) {
        //
        //   substring before pound
        //
        uri = actual.substring(0,lastPound);
        actualFragment = actual.substring(lastPound+1);
    }
    if(fragment != null) assertEquals(assertID,fragment, actualFragment);

    var lastQuestion = uri.lastIndexOf("?");
    var actualQuery = "";
    if(lastQuestion != -1) {
        //
        //   substring before pound
        //
        uri = actual.substring(0,lastQuestion);
        actualQuery = actual.substring(lastQuestion+1);
    }
    if(query != null) assertEquals(assertID, query, actualQuery);

    var firstColon = uri.indexOf(":");
    var firstSlash = uri.indexOf("/");
    var actualPath = uri;
    var actualScheme = "";
    if(firstColon != -1 && firstColon < firstSlash) {
        actualScheme = uri.substring(0,firstColon);
        actualPath = uri.substring(firstColon + 1);
    }

    if(scheme != null) {
        assertEquals(assertID, scheme, actualScheme);
    }

    if(path != null) {
        assertEquals(assertID, path, actualPath);
    }

    if(host != null) {
        var actualHost = "";
        if(actualPath.substring(0,2) == "//") {
            var termSlash = actualPath.substring(2).indexOf("/") + 2;
            actualHost = actualPath.substring(0,termSlash);
        }
        assertEquals(assertID, host, actualHost);
    }

    if(file != null || name != null) {
        var actualFile = actualPath;
        var finalSlash = actualPath.lastIndexOf("/");
        if(finalSlash != -1) {
            actualFile = actualPath.substring(finalSlash+1);
        }
        if (file != null) {
            assertEquals(assertID, file, actualFile);
        }
        if (name != null) {
            var actualName = actualFile;
            var finalDot = actualFile.lastIndexOf(".");
            if (finalDot != -1) {
                actualName = actualName.substring(0, finalDot);
            }
            assertEquals(assertID, name, actualName);
        }
    }

    if(isAbsolute != null) {
        assertEquals(assertID, isAbsolute, actualPath.substring(0,1) == "/");
    }
  }


// size() used by assertSize element
function size(collection)
{
  return collection.length;
}

function same(expected, actual)
{
  return expected === actual;
}

function getSuffix(contentType) {
    switch(contentType) {
        case "text/html":
        return ".html";

        case "text/xml":
        return ".xml";

        case "application/xhtml+xml":
        return ".xhtml";

        case "image/svg+xml":
        return ".svg";

        case "text/mathml":
        return ".mml";
    }
    return ".html";
}

function equalsAutoCase(context, expected, actual) {
	if (builder.contentType == "text/html") {
		if (context == "attribute") {
			return expected.toLowerCase() == actual;
		}
		return expected.toUpperCase() == actual;
	}
	return expected == actual;
}

function catchInitializationError(blder, ex) {
       if (blder == null) {
          alert(ex);
       } else {
	      blder.initializationError = ex;
	      blder.initializationFatalError = ex;
	   }
}

function checkInitialization(blder, testname) {
    if (blder.initializationError != null) {
        if (blder.skipIncompatibleTests) {
        	info(testname + " not run:" + blder.initializationError);
        	return blder.initializationError;
        } else {
        	//
        	//   if an exception was thrown
        	//        rethrow it and do not run the test
            if (blder.initializationFatalError != null) {
        		throw blder.initializationFatalError;
        	} else {
        		//
        		//   might be recoverable, warn but continue the test
        		warn(testname + ": " +  blder.initializationError);
        	}
        }
    }
    return null;
}
function createTempURI(scheme) {
   if (scheme == "http") {
   	  return "http://localhost:8080/webdav/tmp" + Math.floor(Math.random() * 100000) + ".xml";
   }
   return "file:///tmp/domts" + Math.floor(Math.random() * 100000) + ".xml";
}


function EventMonitor() {
  this.atEvents = new Array();
  this.bubbledEvents = new Array();
  this.capturedEvents = new Array();
  this.allEvents = new Array();
}

EventMonitor.prototype.handleEvent = function(evt) {
    switch(evt.eventPhase) {
       case 1:
       monitor.capturedEvents[monitor.capturedEvents.length] = evt;
       break;
       
       case 2:
       monitor.atEvents[monitor.atEvents.length] = evt;
       break;

       case 3:
       monitor.bubbledEvents[monitor.bubbledEvents.length] = evt;
       break;
    }
    monitor.allEvents[monitor.allEvents.length] = evt;
}

function DOMErrorImpl(err) {
  this.severity = err.severity;
  this.message = err.message;
  this.type = err.type;
  this.relatedException = err.relatedException;
  this.relatedData = err.relatedData;
  this.location = err.location;
}



function DOMErrorMonitor() {
  this.allErrors = new Array();
}

DOMErrorMonitor.prototype.handleError = function(err) {
    errorMonitor.allErrors[errorMonitor.allErrors.length] = new DOMErrorImpl(err);
}

DOMErrorMonitor.prototype.assertLowerSeverity = function(id, severity) {
    var i;
    for (i = 0; i < errorMonitor.allErrors.length; i++) {
        if (errorMonitor.allErrors[i].severity >= severity) {
           assertEquals(id, severity - 1, errorMonitor.allErrors[i].severity);
        }
    }
}

function UserDataNotification(operation, key, data, src, dst) {
    this.operation = operation;
    this.key = key;
    this.data = data;
    this.src = src;
    this.dst = dst;
}

function UserDataMonitor() {
	this.allNotifications = new Array();
}

UserDataMonitor.prototype.handle = function(operation, key, data, src, dst) {
    userDataMonitor.allNotifications[this.allNotifications.length] =
         new UserDataNotification(operation, key, data, src, dst);
}



function IFrameBuilder() {
    this.contentType = "text/html";
    this.supportedContentTypes = [ "text/html", 
        "text/xml",
        "image/svg+xml",
        "application/xhtml+xml" ];    

    this.supportsAsyncChange = false;
    this.async = true;
    this.fixedAttributeNames = [
        "validating",  "expandEntityReferences", "coalescing", 
        "signed", "hasNullString", "ignoringElementContentWhitespace", "namespaceAware", "ignoringComments", "schemaValidating"];

    this.fixedAttributeValues = [false,  true, false, true, true , false, false, true, false ];
    this.configurableAttributeNames = [ ];
    this.configurableAttributeValues = [ ];
    this.initializationError = null;
    this.initializationFatalError = null;
    this.skipIncompatibleTests = false;
}

IFrameBuilder.prototype.hasFeature = function(feature, version) {
    return document.implementation.hasFeature(feature, version);
}

IFrameBuilder.prototype.getImplementation = function() {
    return document.implementation;
}

IFrameBuilder.prototype.setContentType = function(contentType) {
    this.contentType = contentType;
    if (contentType == "text/html") {
        this.fixedAttributeValues[6] = false;
    } else {
        this.fixedAttributeValues[6] = true;
    }
}



IFrameBuilder.prototype.preload = function(frame, varname, url) {
  if (this.contentType == "text/html" || this.contentType == "application/xhtml+xml") {
  	if (url.substring(0,5) == "staff" || url == "nodtdstaff" || url == "datatype_normalization") {
    	throw "Tests using staff or nodtdstaff are not supported by HTML processors";
  	}  
  }
  var iframe = document.createElement("iframe");
  var srcname = url + getSuffix(this.contentType);
  iframe.setAttribute("name", srcname);
  iframe.setAttribute("src", fileBase + srcname);
  //
  //   HTML and XHTML have onload attributes that will invoke loadComplete
  //       
  if (this.contentType != "text/html" && this.contentType != "application/xhtml+xml") {
     iframe.addEventListener("load", loadComplete, false);       
  }
  document.getElementsByTagName("body").item(0).appendChild(iframe);
  return 0; 
}

IFrameBuilder.prototype.load = function(frame, varname, url) {
	if (this.contentType == "text/html") {
    	return frame.document;
    }
    var name = url + getSuffix(this.contentType);
    var iframes = document.getElementsByTagName("iframe");
    for(var i = 0; i < iframes.length; i++) {
       if (iframes.item(i).getAttribute("name") == name) {
           var item = iframes.item(i);
           if (typeof(item.contentDocument) != 'undefined') {
               return item.contentDocument;
           }
           if (typeof(item.document) != 'undefined') {
           	   return item.document;
           }
           return null;
       }
    }
    return null;
}

IFrameBuilder.prototype.getImplementationAttribute = function(attr) {
    for (var i = 0; i < this.fixedAttributeNames.length; i++) {
        if (this.fixedAttributeNames[i] == attr) {
            return this.fixedAttributeValues[i];
        }
    }
    throw "Unrecognized implementation attribute: " + attr;
}



IFrameBuilder.prototype.setImplementationAttribute = function(attribute, value) {
    var supported = this.getImplementationAttribute(attribute);
    if (supported != value) {
        this.initializationError = "IFrame loader does not support " + attribute + "=" + value;
    }
}


IFrameBuilder.prototype.canSetImplementationAttribute = function(attribute, value) {
    var supported = this.getImplementationAttribute(attribute);
    return (supported == value);
}



function SVGPluginBuilder() {
    this.contentType = "image/svg+xml";
    this.supportedContentTypes = [ "image/svg+xml" ];

    this.supportsAsyncChange = false;
    this.async = true;
    this.fixedAttributeNames = [
        "validating",  "expandEntityReferences", "coalescing", 
        "signed", "hasNullString", "ignoringElementContentWhitespace", "namespaceAware", "ignoringComments" , "schemaValidating"];

    this.fixedAttributeValues = [false,  true, false, true, true , false, true, false, false ];
    this.configurableAttributeNames = [ ];
    this.configurableAttributeValues = [ ];
    this.initializationError = null;
    this.initializationFatalError = null;
    this.skipIncompatibleTests = false;
}

SVGPluginBuilder.prototype.hasFeature = function(feature, version) {
    if (feature == "XML") {
        if (version == null || version == "1.0" || version == "2.0") {
            return true;
        }
    }
    return false;
}

SVGPluginBuilder.prototype.setContentType = function(contentType) {
    this.contentType = contentType;
}

SVGPluginBuilder.prototype.getImplementation = function() {
  var embed = document.createElement("embed");
  embed.src = fileBase + url + getSuffix(this.contentType);
  embed.height = 100;
  embed.width = 100;
  embed.type = "image/svg+xml";
  embed.id = varname;
  var child = document.documentElement.firstChild;
  while(child != null) {
      if (child.nodeName != null && child.nodeName.toUpperCase() == "BODY") {
          child.appendChild(embed);
          return child.getSVGDocument.implementation;
      }
      child = child.nextSibling;
  }
  return null;
}

var svgloadcount = 0;
function SVGPluginBuilder_pollreadystate() {
  var newCount = 0;
  var child = document.documentElement.firstChild;
  while(child != null) {
      if (child.nodeName != null && child.nodeName.toUpperCase() == "BODY") {
          var grand = child.firstChild;
          while (grand != null) {
             if (grand.nodeName.toUpperCase() == 'EMBED' && grand.readystate == 4) {
                newCount++;
             }
             grand = grand.nextSibling;
          }
          break;
      }
      child = child.nextSibling;
  }
  if (newCount > svgloadcount) {
    svgloadcount++;
    loadComplete();
    if (setUpPageStatus == 'complete') {
        return;
    }
  }
  setTimeout(SVGPluginBuilder_pollreadystate, 100);
}

SVGPluginBuilder.prototype.preload = function(frame, varname, url) {
  var embed = document.createElement("embed");
  embed.src = fileBase + url + getSuffix(this.contentType);
  embed.height = 100;
  embed.width = 100;
  embed.type = "image/svg+xml";
  embed.id = varname;
  var child = document.documentElement.firstChild;
  while(child != null) {
      if (child.nodeName != null && child.nodeName.toUpperCase() == "BODY") {
          child.appendChild(embed);
          break;
      }
      child = child.nextSibling;
  }
  //
  //   if unable to monitor ready state change then
  //     check if load is complete every in 0.1 second
  setTimeout(SVGPluginBuilder_pollreadystate , 100);
  return 0;
}

SVGPluginBuilder.prototype.load = function(frame, varname, url) {
  var child = document.documentElement.firstChild;
  while(child != null) {
      if (child.nodeName != null && child.nodeName.toUpperCase() == "BODY") {
		  var grand = child.firstChild;
		  while (grand != null) {
			if (grand.id == varname) {
				return grand.getSVGDocument();
			}
			grand = grand.nextSibling;
		  }
	  }
      child = child.nextSibling;
   }
   return null;
}

SVGPluginBuilder.prototype.getImplementationAttribute = function(attr) {
    for (var i = 0; i < this.fixedAttributeNames.length; i++) {
        if (this.fixedAttributeNames[i] == attr) {
            return this.fixedAttributeValues[i];
        }
    }
    throw "Unrecognized implementation attribute: " + attr;
}


SVGPluginBuilder.prototype.setImplementationAttribute = function(attribute, value) {
    var supported = this.getImplementationAttribute(attribute);
    if (supported != value) {
        this.initializationError = "SVG Plugin loader does not support " + attribute + "=" + value;
    }
}

SVGPluginBuilder.prototype.canSetImplementationAttribute = function(attribute, value) {
    var supported = this.getImplementationAttribute(attribute);
    return (supported == value);
}




function MSXMLBuilder(progID) {
    this.progID = progID;
    this.configurableAttributeNames = [
        "validating", "ignoringElementContentWhitespace"];
    this.configurableAttributeValues = [ false, false ];
    this.fixedAttributeNames = [ "signed", "hasNullString", 
        "expandEntityReferences", "coalescing", "namespaceAware", "ignoringComments", "schemaValidating" ];
    this.fixedAttributeValues = [ true, true, false, false, false, false, false ];

    this.contentType = "text/xml";
    this.supportedContentTypes = [ 
        "text/xml", 
        "image/svg+xml", 
        "application/xhtml+xml",
        "text/mathml" ];

    this.async = false;
    this.supportsAsyncChange = true;
    this.parser = null;
    this.initializationError = null;
    this.initializationFatalError = null;
    this.skipIncompatibleTests = false;
}

MSXMLBuilder.prototype.createMSXML = function() {
    var parser = new ActiveXObject(this.progID);
    parser.async = this.async;
    parser.preserveWhiteSpace = !this.configurableAttributeValues[1];
    parser.validateOnParse = this.configurableAttributeValues[0];
    return parser;
  }
  
MSXMLBuilder.prototype.setContentType = function(contentType) {
    this.contentType = contentType;
}
  

MSXMLBuilder.prototype.preload = function(frame, varname, url) {
  if (this.async) {
     this.parser = this.createMSXML();
     parser.async = true;
     parser.onreadystatechange = MSXMLBuilder_onreadystatechange;
     parser.load(fileBase + url + getSuffix(this.contentType));
     if (parser.readystate != 4) {
        return 0;
     }
  }
  return 1;
}

MSXMLBuilder.prototype.load = function(frame, varname, url) {
    var parser = this.createMSXML();
	if(!parser.load(fileBase + url + getSuffix(this.contentType))) {
		throw parser.parseError.reason;
	}
    //
    //   if the first child of the document is a PI representing
    //      the XML Declaration, remove it from the tree.
    //
    //   According to the DOM FAQ, this behavior is not wrong,
    //      but the tests are written assuming that it is not there.
    //
    var xmlDecl = parser.firstChild;
    if(xmlDecl != null && xmlDecl.nodeType == 7 && xmlDecl.target.toLowerCase() == "xml") {
        parser.removeChild(xmlDecl);
    }
	return parser;
}

MSXMLBuilder.prototype.getImplementationAttribute = function(attr) {
    var i;
    for (i = 0; i < this.fixedAttributeNames.length; i++) {
        if (this.fixedAttributeNames[i] == attr) {
            return this.fixedAttributeValues[i];
        }
    }

    for (i = 0; i < this.configurableAttributeNames.length; i++) {
        if (this.configurableAttributeNames[i] == attr) {
            return this.configurableAttributeValues[i];
        }
    }

    throw "Unrecognized implementation attribute: " + attr;
}


MSXMLBuilder.prototype.setImplementationAttribute = function(attribute, value) {
    var i;
    for (i = 0; i < this.fixedAttributeNames.length; i++) {
        if (this.fixedAttributeNames[i] == attribute) {
            if (this.fixedAttributeValues[i] != value) {
                this.initializationError = "MSXML does not support " + attribute + "=" + value;
            }
            return;
        }
    }
    for (i = 0; i < this.configurableAttributeNames.length; i++) {
        if (this.configurableAttributeNames[i] == attribute) {
            this.configurableAttributeValues[i] = value;
            return;
        }
    }
    this.initializationError = "Unrecognized implementation attribute: " + attr;
}
            

MSXMLBuilder.prototype.canSetImplementationAttribute = function(attribute, value) {
    var i;
    for (i = 0; i < this.fixedAttributeNames.length; i++) {
        if (this.fixedAttributeNames[i] == attribute) {
            return (this.fixedAttributeValues[i] == value);
        }
    }
    for (i = 0; i < this.configurableAttributeNames.length; i++) {
        if (this.configurableAttributeNames[i] == attribute) {
        	return true;
        }
    }
    return false;
}


MSXMLBuilder.prototype.getImplementation = function() {
    var doc = this.CreateMSXML();
    return doc.implementation;
}

//
//   Only used to select tests compatible with implementation
//      not used on tests that actually test hasFeature()
//
MSXMLBuilder.prototype.hasFeature = function(feature, version) {
    //
    //   MSXML will take null, unfortunately 
    //      there is no way to get it to there from script
    //      without a type mismatch error
    if(version == null) {
		switch(feature.toUpperCase()) {
		   case "XML":
		   case "CORE":
		   return true;
		   
		   case "HTML":
		   case "ORG.W3C.DOM":
		   return false;
		}
		if(this.getDOMImplementation().hasFeature(feature,"1.0")) {
		   return true;
		}
		if(this.getDOMImplementation().hasFeature(feature,"2.0")) {
		   return true;
		}
		if(this.getDOMImplementation().hasFeature(feature,"3.0")) {
		   return true;
		}
    }
	return this.getDOMImplementation().hasFeature(feature,version);
  }



function MozillaXMLBuilder() {
    this.contentType = "text/xml";

    this.configurableAttributeNames = [ ];
    this.configurableAttributeValues = [ ];
    this.fixedAttributeNames = [ "validating", "ignoringElementContentWhitespace", "signed", 
        "hasNullString", "expandEntityReferences", "coalescing", "namespaceAware", "ignoringComments", "schemaValidating" ];
    this.fixedAttributeValues = [ false, false, true, true, false, false, false, false, false ];

    this.contentType = "text/xml";
    this.supportedContentTypes = [ 
        "text/xml", 
        "image/svg+xml", 
        "application/xhtml+xml",
        "text/mathml" ];

    this.async = true;
    this.supportsAsyncChange = false;

    this.docs = new Array();
    this.docnames = new Array();
    this.initializationError = null;
    this.initializationFatalError = null;
    this.skipIncompatibleTests = false;
}

MozillaXMLBuilder.prototype.getImplementation = function() {
    return document.implementation;
}

MozillaXMLBuilder.prototype.setContentType = function(contentType) {
    this.contentType = contentType;
}



MozillaXMLBuilder.prototype.preload = function(frame, varname, url) {
  var domimpl = document.implementation;
  var doc = domimpl.createDocument("", "temp", null);
  doc.addEventListener("load", loadComplete, false);
  doc.load(fileBase + url + getSuffix(this.contentType));
  this.docs[this.docs.length] = doc;
  this.docnames[this.docnames.length] = varname;
  return 0;
}

MozillaXMLBuilder.prototype.load = function(frame, varname, url) {
    for(i = 0; i < this.docnames.length; i++) {
        if (this.docnames[i] == varname) {
            return this.docs[i];
        }
    }
    return null;
}


MozillaXMLBuilder.prototype.getImplementationAttribute = function(attr) {
    for (var i = 0; i < this.fixedAttributeNames.length; i++) {
        if (this.fixedAttributeNames[i] == attr) {
            return this.fixedAttributeValues[i];
        }
    }
    return false;
}


MozillaXMLBuilder.prototype.hasFeature = function(feature, version)
{
  return this.getImplementation().hasFeature(feature, version);
}

MozillaXMLBuilder.prototype.setImplementationAttribute = function(attribute, value) {
    var supported = this.getImplementationAttribute(attribute);
    if (supported != value) {
        this.initializationError = "Mozilla XML loader does not support " + attribute + "=" + value;
    }
}


MozillaXMLBuilder.prototype.canSetImplementationAttribute = function(attribute, value) {
    var supported = this.getImplementationAttribute(attribute);
    return (supported == value);
}

function DOM3LSBuilder() {
    this.contentType = "text/xml";

    this.fixedAttributeNames = [ "signed", "hasNullString" ];
    this.fixedAttributeValues = [ true, true ];
    this.configurableAttributeNames = [ "validating", "ignoringElementContentWhitespace", 
        "expandEntityReferences", "coalescing", "namespaceAware", "ignoringComments", "schemaValidating" ];
    this.configurableAttributeValues = [ false, false, true, true, false, false, true, false, false ];
    this.domConfigNames = [ "validate", "element-content-whitespace", 
        "entities", "cdata-sections", "namespaces", "comments", "validate" ];
    this.domConfigSense = [ true, false, false, false, true, false, true ];

    this.contentType = "text/xml";
    this.supportedContentTypes = [ 
        "text/xml", 
        "image/svg+xml", 
        "application/xhtml+xml",
        "text/mathml" ];

    this.async = false;
    this.supportsAsyncChange = true;

    this.docs = new Array();
    this.docnames = new Array();
    this.initializationError = null;
    this.initializationFatalError = null;
    this.skipIncompatibleTests = false;    
    var domimpl = document.implementation;
    this.lsparser = domimpl.createLSParser(2, null);
}

DOM3LSBuilder.prototype.getImplementation = function() {
    return document.implementation;
}


DOM3LSBuilder.prototype.setContentType = function(contentType) {
    this.contentType = contentType;
}

DOM3LSBuilder.prototype.preload = function(frame, varname, url) {
  if (!this.async) {
  	 return 1;
  }
  var domimpl = document.implementation;
  this.lsparser.addEventListener("load", loadComplete, false);
  var uri = fileBase + url + getSuffix(this.contentType);
  var doc = this.lsparser.parseURI(uri);
  this.docs[this.docs.length] = doc;
  this.docnames[this.docnames.length] = varname;
  return 0;
}

DOM3LSBuilder.prototype.load = function(frame, varname, url) {
    if (this.async) {
        for(i = 0; i < this.docnames.length; i++) {
            if (this.docnames[i] == varname) {
                return this.docs[i];
            }
        }
        return null;
    }
    this.lsparser = document.implementation.createLSParser(1, null);
    var uri = fileBase + url + getSuffix(this.contentType);
    return this.lsparser.parseURI(uri);
}


DOM3LSBuilder.prototype.getImplementationAttribute = function(attr) {
    if (attr == "schemaValidating") {
        return (this.lsparser.domConfig.getParameter("validate") &&
            this.lsparser.domConfig.getParameter("schema-type") ==
               "http://www.w3.org/2001/XMLSchema"); 
    }
    var i;
    for (i = 0; i < this.fixedAttributeNames.length; i++) {
       if (this.fixedAttributeNames[i] == attr) {
           return this.fixedAttributeValues[i];
        }
    }
    for (i = 0; i < this.configurableAttributeNames.length; i++) {
        if (this.configurableAttributeNames[i] == attr) {
        	if(this.lsparser.domConfig.getParameter(this.domConfigNames[i])) {
        		return this.domConfigSense[i];
        	} else {
        		return !this.domConfigSense[i];
        	}
        }
    }
    throw "unrecognized implementation attribute " + att;
}

DOM3LSBuilder.prototype.hasFeature = function(feature, version) {
    return document.implementation.hasFeature(feature, version);
}


DOM3LSBuilder.prototype.setImplementationAttribute = function(attr, value) {
    if (attr == "schemaValidating") {
        this.lsparser.domConfig.setParameter("validate", true);
        this.lsparser.domConfig.setParameter("schema-type",
               "http://www.w3.org/2001/XMLSchema"); 
        return;
    }
    var i;
    for (i = 0; i < this.fixedAttributeNames.length; i++) {
       if (this.fixedAttributeNames[i] == attr) {
           if (value != this.fixedAttributeValue) {
               this.initializationError = "DOM3LS does not support " + attribute + " = " + value;
               return;
           }
        }
    }
    for (i = 0; i < this.configurableAttributeNames.length; i++) {
        if (this.configurableAttributeNames[i] == attr) {
            var paramValue = value;
            if (!this.domConfigSense[i]) {
                paramValue = !value;
            }
            var oldValue = this.lsparser.domConfig.getParameter(this.domConfigNames[i]);
            if (paramValue != oldValue) {
                if (this.lsparser.domConfig.canSetParameter(this.domConfigNames[i], paramValue)) {
                	this.lsparser.domConfig.setParameter(this.domConfigNames[i], paramValue);
                }
            }
            return;
        }
    }
    throw "Unrecognized configuration attribute " + attr;
}


DOM3LSBuilder.prototype.canSetImplementationAttribute = function(attr, value) {
    for (i = 0; i < this.configurableAttributeNames.length; i++) {
        if (this.configurableAttributeNames[i] == attr) {
            var paramValue = value;
            if (!this.domConfigSense[i]) {
                paramValue = !value;
            }
            return this.lsparser.domConfig.canSetParameter(this.domConfigNames[i], paramValue);
         }
     }
     return false;
}


function XMLHttpRequestBuilder() {
    this.contentType = "text/xml";

    this.fixedAttributeNames = [ "signed", "hasNullString",
        "validating", "ignoringElementContentWhitespace", 
        "expandEntityReferences", "coalescing", "namespaceAware", "ignoringComments", "schemaValidating" ];
    this.fixedAttributeValues = [ true, true, false, false, 
        true, true, false, false, true, false, false ];
    this.configurableAttributeNames = [  ];
    this.configurableAttributeValues = [  ];

    this.supportedContentTypes = [ 
        "text/xml", 
        "image/svg+xml", 
        "application/xhtml+xml",
        "text/mathml" ];

    this.async = false;
    this.supportsAsyncChange = true;

    this.docs = new Array();
    this.docnames = new Array();
    this.initializationError = null;
    this.initializationFatalError = null;
    this.skipIncompatibleTests = false;    
}

XMLHttpRequestBuilder.prototype.getImplementation = function() {
    return this.req.responseXML.implementation;
}


XMLHttpRequestBuilder.prototype.setContentType = function(contentType) {
    this.contentType = contentType;
}

XMLHttpRequestBuilder.prototype.createParser = function() {
  var req = false;
  if (window.XMLHttpRequest) {
    try {
      req = new XMLHttpRequest();
    } catch(e) {
      req = false;
    }
  } else if(window.ActiveXObject) {
    try {
       req = new ActiveXObject("Msxml2.XMLHTTP");
    } catch(e) {
       try {
         req = new ActiveXObject("Microsoft.XMLHTTP");
       } catch(e) {
         req = false;
       }
    }
  }
  return req;
}

XMLHttpRequestBuilder.prototype.preload = function(frame, varname, url) {
  if (!this.async) {
  	 return 1;
  }
  var uri = fileBase + url + getSuffix(this.contentType);
  var req = this.createParser();
  req.onreadystatechange =  MSXMLBuilder_onreadystatechange;
  req.open("GET", uri, true);
  req.send("");
  this.docs[this.docs.length] = req;
  this.docnames[this.docnames.length] = varname;
  return 0;
}

XMLHttpRequestBuilder.prototype.load = function(frame, varname, url) {
    if (this.async) {
        for(i = 0; i < this.docnames.length; i++) {
            if (this.docnames[i] == varname) {
                return this.docs[i];
            }
        }
        return null;
    }
    var req = this.createParser();
    var uri = fileBase + url + getSuffix(this.contentType);
    req.open("GET", uri, false);
    req.send("");
    return req.responseXML;
}


XMLHttpRequestBuilder.prototype.getImplementationAttribute = function(attr) {
    var i;
    for (i = 0; i < this.fixedAttributeNames.length; i++) {
       if (this.fixedAttributeNames[i] == attr) {
           return this.fixedAttributeValues[i];
        }
    }
    throw "unrecognized implementation attribute " + att;
}

XMLHttpRequestBuilder.prototype.hasFeature = function(feature, version) {
    if (feature == "XML" || 
      (feature.length == 3 && feature.toUpperCase() == "XML")) {
      return true;
    }
    return document.implementation.hasFeature(feature, version); 
}


XMLHttpRequestBuilder.prototype.setImplementationAttribute = function(attr, value) {
    throw "Unrecognized configuration attribute " + attr;
}


XMLHttpRequestBuilder.prototype.canSetImplementationAttribute = function(attr, value) {
    return false;
}



function createBuilder(implementation) {
  if (implementation == null) {
  	return new IFrameBuilder();
  }
  switch(implementation) {
    case "msxml3":
    return new MSXMLBuilder("Msxml2.DOMDocument.3.0");
    
    case "msxml4":
    return new MSXMLBuilder("Msxml2.DOMDocument.4.0");

    case "mozillaXML":
    return new MozillaXMLBuilder();

    case "svgplugin":
    return new SVGPluginBuilder();

    case "dom3ls":
    return new DOM3LSBuilder();
    
    case "iframe":
    return new IFrameBuilder();

    case "xmlhttprequest":
    return new XMLHttpRequestBuilder();
    
    default:
    alert ("unrecognized implementation " + implementation);
  }
  return new IFrameBuilder();
}

function checkFeature(feature, version)
{
  if (!builder.hasFeature(feature, version))
  {
    //
    //   don't throw exception so that users can select to ignore the precondition
    //
    builder.initializationError = "builder does not support feature " + feature + " version " + version;
  }
}

function createConfiguredBuilder() {
	var builder = null;
	var contentType = null;
	var i;
	var contentTypeSet = false;
	var parm = null;
	if (top && typeof(top.jsUnitParmHash) != 'undefined') {
    	builder = createBuilder(top.jsUnitGetParm('implementation'));
    	
    	parm = top.jsUnitGetParm("skipincompatibletests");
    	if (parm) {
        	if (parm == 'true') {
        	    builder.skipIncompatibleTests = true;
        	} else {
        	    builder.skipIncompatibleTests = false;
        	}
    	}
    	
    	if (top.jsUnitGetParm('asynchronous') == 'true' && builder.supportAsync) {
        	builder.async = true;
    	}
    	if (top.jsUnitGetParm('expandentityreferences')) {
        	if (top.jsUnitGetParm('expandEntityReferences') == 'true') {
            	builder.setImplementationAttribute('expandEntityReferences', true);
        	} else {
            	builder.setImplementationAttribute('expandEntityReferences', false);
        	}
    	}
    	if (top.jsUnitGetParm('ignoringelementcontentwhitespace')) {
        	if (top.jsUnitGetParm('ignoringElementContentWhitespace') == 'true') {
            	builder.setImplementationAttribute('ignoringElementContentWhitespace', true);
        	} else {
            	builder.setImplementationAttribute('ignoringElementContentWhitespace', false);
            }
        }
    	if (top.jsUnitGetParm('validating')) {
        	if (top.jsUnitGetParm('validating') == 'true') {
            	builder.setImplementationAttribute('validating', true);
        	} else {
            	builder.setImplementationAttribute('validating', false);
        	}
    	}
    	if (top.jsUnitGetParm('coalescing')) {
        	if (top.jsUnitGetParm('coalescing') == 'true') {
            	builder.setImplementationAttribute('coalescing', true);
        	} else {
            	builder.setImplementationAttribute('coalescing', false);
        	}
    	}
    	if (top.jsUnitGetParm('namespaceaware')) {
        	if (top.jsUnitGetParm('namespaceaware') == 'true') {
            	builder.setImplementationAttribute('namespaceAware', true);
        	} else {
            	builder.setImplementationAttribute('namespaceAware', false);
        	}
    	}
    	contentType = top.jsUnitGetParm('contenttype');
    	if (contentType != null) {
        	contentTypeSet = false;
        	for (i = 0; i < builder.supportedContentTypes.length; i++) {
            	if (builder.supportedContentTypes[i] == contentType) {
                	builder.setContentType(contentType);
                	contentTypeSet = true;
                	break;
            	}
        	}
        	if (!contentTypeSet) {
            	this.exception = "Builder does not support content type " + contentType;
        	}
    	}
    	if (top.jsUnitGetParm('ignoringcomments')) {
        	if (top.jsUnitGetParm('ignoringcomments') == 'true') {
            	builder.setImplementationAttribute('ignoringComments', true);
        	} else {
            	builder.setImplementationAttribute('ignoringComments', false);
        	}
    	}
	} else {
    	builder = new IFrameBuilder();
	}
	return builder;
}


function preload(frame, varname, url) {
  return builder.preload(frame, varname, url);
}

function load(frame, varname, url) {
    return builder.load(frame, varname, url);
}

function getImplementationAttribute(attr) {
    return builder.getImplementationAttribute(attr);
}


function setImplementationAttribute(attribute, value) {
    builder.setImplementationAttribute(attribute, value);
}

function setAsynchronous(value) {
    if (builder.supportsAsyncChange) {
      builder.async = value;
    } else {
      update();
    }
}


function createXPathEvaluator(doc) {
    try {
        return doc.getFeature("XPath", null);
    }
    catch(ex) {
    }
    return doc;
}

function toLowerArray(src) {
   var newArray = new Array();
   var i;
   for (i = 0; i < src.length; i++) {
      newArray[i] = src[i].toLowerCase();
   }
   return newArray;
}

function MSXMLBuilder_onreadystatechange() {
    if (builder.parser.readyState == 4) {
        loadComplete();
    }
}



var fileBase = location.href;
if (fileBase.indexOf('?') != -1) {
   fileBase = fileBase.substring(0, fileBase.indexOf('?'));
}
fileBase = fileBase.substring(0, fileBase.lastIndexOf('/') + 1) + "files/";

function getResourceURI(name, scheme, contentType) {
    return fileBase + name + getSuffix(contentType);
}


function getImplementation() {
    return builder.getImplementation();
}

