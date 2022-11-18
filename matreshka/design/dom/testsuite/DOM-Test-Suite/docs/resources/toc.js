// Copyright (c) 2001 World Wide Web Consortium,
// (Massachusetts Institute of Technology, Institut National de
// Recherche en Informatique et en Automatique, Keio University). All
// Rights Reserved. This program is distributed under the W3C's Software
// Intellectual Property License. This program is distributed in the
// hope that it will be useful, but WITHOUT ANY WARRANTY; without even
// the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
// PURPOSE.
// See W3C License http://www.w3.org/Consortium/Legal/ for more details.
//
// $Id: toc.js,v 1.2 2002/08/22 03:08:50 dom-ts-4 Exp $

// This is a demo of DOM Level 1

// maximun depth of div to consider
var MAX_LEVEL = 3;

// return the text content of a node and its descendants. No serialization
// is performed, the return does not contain any markup.
// The string returned is made of the text content of this node depending on
// its type.
function getTextContent(node) {
    var _result = "";
    if (node == null) {
	return _result;
    }
    var childrens = node.childNodes;
    var i = 0;
    while (i < childrens.length) {
	var child = childrens.item(i);
	switch (child.nodeType) {
	case 1: // ELEMENT_NODE
	case 5: // ENTITY_REFERENCE_NODE
	case 6: // ENTITY_NODE
	case 11: // DOCUMENT_FRAGMENT_NODE
	    _result += getTextContent(child);
	    break;
	case 2: // ATTRIBUTE_NODE
	    _result += child.value;
	    break;
	case 8: // COMMENT_NODE
	case 7: // PROCESSING_INSTRUCTION_NODE
	case 4: // CDATA_SECTION_NODE
	case 3: // TEXT_NODE
	    _result += child.data;
	    break;
	case 9: // DOCUMENT_NODE
	case 10: // DOCUMENT_TYPE_NODE
	case 12: // NOTATION_NODE
	    return null;
	}
	i ++;
    }
    return _result;
}

var countDiv = 0;

function getChildsTOC(level, current) {

    if (level > MAX_LEVEL) {
	return null;
    }
    var childs = current.getElementsByTagName("h" + level);

    if (childs.length != 0) {
	var newlist = document.createElement("ol");
	var i = 0;

	while (i < childs.length) {
	    var child = childs.item(i);
	    var div = child.parentNode;
	    if (div.getAttribute("id") == null) {
		div.setAttribute("id", "generated" + countDiv);		
	    }
	    countDiv ++;
	    if (div != null) {
		var li = document.createElement("li");
		var a = document.createElement("a");
		a.setAttribute("href", "#" + div.getAttribute("id"));		
		a.appendChild(document.createTextNode(getTextContent(child)));
		li.appendChild(a);
		var sublist = getChildsTOC(level+1, div);
		if (sublist != null) {
		    li.appendChild(sublist);
		}
		newlist.appendChild(li);
	    }
	    i ++;
	}
	return newlist;
    }
    return null;
}

function init() {
    if (document.implementation
	&& document.implementation.hasFeature
	&& document.implementation.hasFeature("HTML", "1.0")) {

	var olist = getChildsTOC(2, document.documentElement);

	var firstDiv = document.getElementsByTagName("div").item(0);
	var body = firstDiv.parentNode;
	var newDiv = document.createElement("div");
	newDiv.setAttribute("id", "TableOfContents");
	var title = document.createElement("h2");
	title.appendChild(document.createTextNode("Table of contents"));
	newDiv.appendChild(title);
	newDiv.appendChild(olist);
	body.insertBefore(newDiv, firstDiv);
    }
}
