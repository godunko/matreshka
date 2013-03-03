/*
Copyright (c) 2003-2004 World Wide Web Consortium,
(Massachusetts Institute of Technology, Institut National de
Recherche en Informatique et en Automatique, Keio University). All
Rights Reserved. This program is distributed under the W3C's Software
Intellectual Property License. This program is distributed in the
hope that it will be useful, but WITHOUT ANY WARRANTY; without even
the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.
See W3C License http://www.w3.org/Consortium/Legal/ for more details.
*/

function updateImplementationAttribute(options, implAttribute) {
   var builderVal = builder.getImplementationAttribute(implAttribute);
   var disabled = false;
   for (var i = 0; i < builder.fixedAttributeNames.length; i++) {
      if (implAttribute == builder.fixedAttributeNames[i]) {
        disabled = true;
        break;
      }
   }
   updateTrueFalse(options, builderVal, disabled);
}

function updateTrueFalse(checkbox, builderVal, disabled) {
   checkbox.checked = builderVal;
   checkbox.disabled = disabled;
}


function onImplementationChange() {
    var implOptions = document.forms[0].implementation;
    var implName = null;
    for(var i = 0; i < implOptions.length; i++) {
        if (implOptions[i].checked) {
        	implName = implOptions[i].value;
            builder = createBuilder(implName);
            break;
        }
    }
    document.forms[0].dom3lsFeatures.disabled = !(implName == "dom3ls");
    update();
}



function update() {
    var svgOption;
    updateTrueFalse(document.forms[0].asynchronous, builder.async, !builder.supportsAsyncChange);
    updateImplementationAttribute(document.forms[0].expandEntityReferences, "expandEntityReferences");
    updateImplementationAttribute(document.forms[0].ignoringElementContentWhitespace, "ignoringElementContentWhitespace");
    updateImplementationAttribute(document.forms[0].validating, "validating");
    updateImplementationAttribute(document.forms[0].coalescing, "coalescing");
    updateImplementationAttribute(document.forms[0].namespaceAware, "namespaceAware");
    updateImplementationAttribute(document.forms[0].ignoringComments, "ignoringComments");

    var contentTypes = document.forms[0].contentType;
    for(i = 0; i < contentTypes.length; i++) {
        if (contentTypes[i].value == builder.contentType) {
            contentTypes[i].checked = true;
        }
        var disabled = true;
        for(var j = 0; j < builder.supportedContentTypes.length; j++) {
            if (contentTypes[i].value == builder.supportedContentTypes[j]) {
                disabled = false;
                break;
            }
        }
        contentTypes[i].disabled = disabled;
    }

    if (typeof(ActiveXObject) == 'undefined')
    {
      document.getElementById('msxml3Impl').disabled = true;
      document.getElementById('msxml4Impl').disabled = true;
    }
    if (typeof(document.implementation) != 'undefined')
    {
      var impl = document.implementation;
      if (impl && typeof(impl.createLSParser) == 'undefined')
      {
        document.getElementById('dom3lsImpl').disabled = true;
      }
      if (impl && typeof(impl.createDocument) == 'undefined')
      {
        document.getElementById('mozillaXMLImpl').disabled = true;
      }
    }
    if (document.location.href.indexOf('/html/') != -1)
    {
      // HTML test suites do not have SVG files
      svgOption = document.getElementById('svgpluginImpl');
      if (svgOption != null) {
         svgOption.disabled = true;
      }
      svgOption = document.getElementById('contentTypeSVG');
      if (svgOption != null) {
         svgOption.disabled = true;
      }
    }
    
}


function setImplementationAttribute(implAttr, implValue) {
    try {
        builder.setImplementationAttribute(implAttr, implValue);
    } catch(msg) {
        alert(msg);
        update();
    }
}

function setContentType(contentType) {
    for (var i = 0; i < builder.supportedContentTypes.length; i++) {
        if (builder.supportedContentTypes[i] == contentType) {
            builder.setContentType(contentType);
            update();
            return;
        }
    }
    alert(contentType + " not supported by selected implementation");
    update();
}


function fixTestPagePath() {
    var options = document.forms[0].testpage.options;
    for (var i = 0; i < options.length; i++) {
        if (options[i].selected && options[i].value.indexOf(':') == -1) {
            var pageURL = location.href;
            if (pageURL.indexOf('?') != -1) {
                pageURL = pageURL.substring(0, pageURL.indexOf('?'));
            }
            var baseURL = pageURL.substring(0, pageURL.lastIndexOf('/') + 1);
            options[i].value = baseURL + options[i].value;
        }
    }
    return true;
}

function updateTestSubmission() {
   var hostname = "localhost";
   if (document.forms[0].submitCheckbox.checked) {
   	  document.forms[0].resultid.disabled = false;
   	  document.forms[0].submitresults.disabled = false;
   	  if (document.location.protocol == "http") {
   	  	hostname = document.location.hostname;
   	  }
   	  document.forms[0].submitresults.value = hostname + ":8080/jsunit/acceptor";
   } else {
   	  document.forms[0].resultid.disabled = true;
   	  document.forms[0].submitresults.disabled = true;
   	  document.forms[0].submitresults.value = "";
   }
}


