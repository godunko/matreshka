
//  OdfElementBase is base class for all ODF classes. Its constructor is able
//  to construct instance of the class (and any subclass) from JSON object.

function OdfElementBase (object)
{
    if (typeof object === 'object')
    {
        for (var property in this)
	{
            if (object.hasOwnProperty (property))
            {
                this[property] = object[property];
            }
        }
    }
}

//  OdfDocument

function OdfDocument (object)
{
    OdfElementBase.call (this, object);
}

OdfDocument.prototype = new OdfElementBase ();
OdfDocument.prototype.constructor = OdfDocument;
OdfDocument.prototype.styles = [];
OdfDocument.prototype.content = null;

OdfDocument.prototype.showCursor = function (cursor) {
    this.content.showCursor (cursor);
}

//  OdfStyleStyle

function OdfStyleStyle (object)
{
    OdfElementBase.call (this, object);
}

OdfStyleStyle.prototype = new OdfElementBase ();
OdfStyleStyle.prototype.constructor = OdfStyleStyle;
OdfStyleStyle.prototype.kind = "automatic";
OdfStyleStyle.prototype.name = "";
OdfStyleStyle.prototype.family = "";
OdfStyleStyle.prototype.parentStyleName = "";
OdfStyleStyle.prototype.textFontStyle = "";
OdfStyleStyle.prototype.textFontWeight = "";
OdfStyleStyle.prototype.textUnderlineStyle = "";

//  OdfTableTable

function OdfTableTable (object)
{
    OdfElementBase.call (this, object);
}

OdfTableTable.prototype = new OdfElementBase ();
OdfTableTable.prototype.constructor = OdfTableTable;
OdfTableTable.prototype.children = [];
OdfTableTable.prototype.render = function (htmlDocument, parentElement) {
    var tableElement = htmlDocument.createElement ('table');
    var tbodyElement = htmlDocument.createElement ('tbody');
    parentElement.appendChild (tableElement);
    tableElement.appendChild (tbodyElement);

    for (var i = 0; i < this.children.length; i++)
    {
        this.children [i].render (htmlDocument, tbodyElement);
    }
};

OdfTableTable.prototype.showCursor = function (cursor) {
    for (var i = 0; i < this.children.length; i++)
    {
        if (this.children [i].showCursor (cursor)) {
            break;
        }
    }
}

//  OdfTableTableCell

function OdfTableTableCell (object)
{
    OdfElementBase.call (this, object);
}

OdfTableTableCell.prototype = new OdfElementBase ();
OdfTableTableCell.prototype.constructor = OdfTableTableCell;
OdfTableTableCell.prototype.children = [];
OdfTableTableCell.prototype.render = function (htmlDocument, parentElement) {
    var element = htmlDocument.createElement ('td');
    parentElement.appendChild (element);

    for (var i = 0; i < this.children.length; i++)
    {
        this.children [i].render (htmlDocument, element);
    }
};

OdfTableTableCell.prototype.showCursor = function (cursor) {
    for (var i = 0; i < this.children.length; i++)
    {
        if (this.children [i].showCursor (cursor)) {
            break;
        }
    }
}

//  OdfTableTableRow

function OdfTableTableRow (object)
{
    OdfElementBase.call (this, object);
}

OdfTableTableRow.prototype = new OdfElementBase ();
OdfTableTableRow.prototype.constructor = OdfTableTableRow;
OdfTableTableRow.prototype.children = [];
OdfTableTableRow.prototype.render = function (htmlDocument, parentElement) {
    var element = htmlDocument.createElement ('tr');
    parentElement.appendChild (element);

    for (var i = 0; i < this.children.length; i++)
    {
        this.children [i].render (htmlDocument, element);
    }
};

OdfTableTableRow.prototype.showCursor = function (cursor) {
    for (var i = 0; i < this.children.length; i++)
    {
        if (this.children [i].showCursor (cursor)) {
            break;
        }
    }
}

//  OdfTextH

function OdfTextH (object)
{
    OdfElementBase.call (this, object);
}

OdfTextH.prototype = new OdfElementBase ();
OdfTextH.prototype.constructor = OdfTextH;
OdfTextH.prototype.styleName = "";
OdfTextH.prototype.htmlElement = null;
OdfTextH.prototype.children = [];
OdfTextH.prototype.render = function (htmlDocument, parentElement) {
    this.htmlElement = htmlDocument.createElement ('p');
    parentElement.appendChild (this.htmlElement);
//    this.htmlElement.contentEditable = true;

    SetCSS (this);

    for (var i = 0; i < this.children.length; i++)
    {
        if (typeof this.children [i] === 'string')
	{
            var text = htmlDocument.createTextNode (this.children [i]);
	    this.htmlElement.appendChild (text);
	}
	else
	{
            this.children [i].render (htmlDocument, this.htmlElement);
	}
    }
};

OdfTextH.prototype.showCursor = function (cursor) {
    for (var i = 0; i < this.children.length; i++)
    {
        if (typeof this.children [i] === 'string') {
//            this.htmlElement.contentEditable = true;
//            console.log ('Focus');
//            console.log (this.htmlElement);
//            this.htmlElement.focus ();
//            this.htmlElement.contents().focus ();
//            console.log (this.htmlElement.childNodes [i]);
//            this.htmlElement.childNodes [i].focus ();
//            this.htmlElement.onkeydown = function (e) { console.log ('key press'); console.log (e); };
//            this.htmlElement.selectionStart = 0;
//            this.htmlElement.selectionEnd = 0;
//            var range = document.createRange ();
//            range.setStart (this.htmlElement.childNodes [i], 3);
//            range.collapse (true);
//            window.getSelection ().removeAllRanges ();
//            window.getSelection ().addRange (range);
//            this.htmlElement.setSelectionRange (1, 1);
            return true;
        } else {
            if (this.children [i].showCursor (cursor)) {
                break;
            }
        }
    }
}

//  OdfTextP

function OdfTextP (object)
{
    OdfElementBase.call (this, object);
}

OdfTextP.prototype = new OdfElementBase ();
OdfTextP.prototype.constructor = OdfTextP;
OdfTextP.prototype.styleName = "";
OdfTextP.prototype.htmlElement = null;
OdfTextP.prototype.children = [];
OdfTextP.prototype.render = function (htmlDocument, parentElement) {
    this.htmlElement = htmlDocument.createElement ('p');
    parentElement.appendChild (this.htmlElement);
//    this.htmlElement.contentEditable = true;

    SetCSS (this);

    for (var i = 0; i < this.children.length; i++)
    {
        if (typeof this.children [i] === 'string')
	{
            var text = htmlDocument.createTextNode (this.children [i]);
	    this.htmlElement.appendChild (text);
	}
	else
	{
            this.children [i].render (htmlDocument, this.htmlElement);
	}
    }
};

OdfTextP.prototype.showCursor = function (cursor) {
    for (var i = 0; i < this.children.length; i++)
    {
        if (typeof this.children [i] === 'string') {
            this.htmlElement.insertBefore (cursor, this.htmlElement.firstChild);
            return true;
        } else {
            if (this.children [i].showCursor (cursor)) {
                break;
            }
        }
    }
}

//  OdfTextSpan

function OdfTextSpan (object)
{
    OdfElementBase.call (this, object);
}

OdfTextSpan.prototype = new OdfElementBase ();
OdfTextSpan.prototype.constructor = OdfTextSpan;
OdfTextSpan.prototype.styleName = "";
OdfTextSpan.prototype.htmlElement = null;
OdfTextSpan.prototype.children = [];
OdfTextSpan.prototype.render = function (htmlDocument, parentElement) {
    this.htmlElement = htmlDocument.createElement ('span');
    parentElement.appendChild (this.htmlElement);
//    this.htmlElement.contentEditable = true;

    SetCSS (this);

    for (var i = 0; i < this.children.length; i++)
    {
        if (typeof this.children [i] === 'string')
	{
            var text = htmlDocument.createTextNode (this.children [i]);
	    this.htmlElement.appendChild (text);
	}
	else
	{
            this.children [i].render (htmlDocument, this.htmlElement);
	}
    }
};

OdfTextSpan.prototype.showCursor = function (cursor) {
    for (var i = 0; i < this.children.length; i++)
    {
        if (typeof this.children [i] === 'string') {
            this.htmlElement.insertBefore (cursor, this.htmlElement.firstChild);
            return true;
        } else {
            if (this.children [i].showCursor (cursor)) {
                break;
            }
        }
    }
}

//  OdfOfficeText

function OdfOfficeText (object)
{
    OdfElementBase.call (this, object);
}

OdfOfficeText.prototype = new OdfElementBase ();
OdfOfficeText.prototype.constructor = OdfOfficeText;
OdfOfficeText.prototype.children = [];
OdfOfficeText.prototype.render = function (htmlDocument, parentElement) {
    for (var i = 0; i < this.children.length; i++)
    {
        this.children [i].render (htmlDocument, parentElement);
    }
};

OdfOfficeText.prototype.showCursor = function (cursor) {
    for (var i = 0; i < this.children.length; i++)
    {
        if (this.children [i].showCursor (cursor)) {
            break;
        }
    }
}

var odfDocument;

//  OdfTextEdit

OdfTextEdit.prototype.htmlElement = null;
OdfTextEdit.prototype.odfDocument = null;

function OdfTextEdit (iframe) {
    var htmlDocument;
    var request;

    //  Create empty document inside iframe.

    htmlDocument = document;
//    htmlDocument = iframe.contentDocument;
//    htmlDocument.open();
//    htmlDocument.write
//        ('<!DOCTYPE html>'
//         + '<html xmlns="http://www.w3.org/1999/xhtml">'
//         + '<head></head>'
////         + '<body>'
////         + '<div id="OdfTextEdit"/></body></html>');
////         + '<div id="OdfTextEdit" contentEditable="true"/></body></html>');
//         + '<body id="OdfTextEdit" contentEditable="true"></body></html>');
//    htmlDocument.close();

    //  Link HTML element and OdfTextEdit.

    this.htmlElement = htmlDocument.getElementById ('OdfTextEdit');
//    this.htmlElement = htmlDocument.body;
    this.htmlElement.odfTextEdit = this;

//    iframe.focus ();
//    this.htmlElement.focus ();

    //  Load document.

    request = new XMLHttpRequest();
    request.open ('GET', 'getODF', false);
    request.send ();
    this.odfDocument = JSON.parse (request.response, function (key, value)
        {
            var type;

            if (value && typeof value === 'object')
            {
                type = value.__type;

                if (typeof type === 'string' && typeof window[type] === 'function')
                {
                    return new (window[type])(value);
                }
            }

            return value;
        });

    //  Render document.

    console.log (this.odfDocument);
    odfDocument = this.odfDocument;  //  XXX Must be removed.
//    this.htmlElement.contentEditable = true;
    this.odfDocument.content.render (htmlDocument, this.htmlElement);

    this.odfDocument.showCursor (null);
//    viewO = this.htmlElement;
//    iframe.focus ();
    this.htmlElement.focus ();

//    this.htmlElement.contentEditable = true;
    this.htmlElement.onkeydown = this.onKeyDown;
    this.htmlElement.onkeypress = this.onKeyPress;
}

OdfTextEdit.prototype.onKeyDown = function (event) {
    if (event.keyCode === 13) {
        console.log ('keyDone: body');
//        event.stopPropagation ();
        console.log (event);
//        return false;
        event.preventDefault ();
//        console.log (document.selection);
//        viewO.focus ();
//        console.log (window.getSelection ());
        console.log (window.getSelection ().getRangeAt(0));
//        console.log (window.getSelection ().getRangeAt(0).commonAncestorContainer);
//        console.log (window.getSelection ().getRangeAt(0).startContainer);
//        console.log (window.getSelection ().getRangeAt(0).startOffset);
//        console.log (window.getSelection ().getRangeAt(0).endContainer);
//        console.log (window.getSelection ().getRangeAt(0).endOffset);
//        console.log (window.getSelection ().getRangeAt(0).collapsed);
//        console.log (window.getSelection ().rangeCount);
//        console.log (window.getSelection().anchorNode.parentNode.tagName);

//        var el = document.getElementById ('OdfTextEdit');
//        console.log (document);
//        el.focus ();
//        console.log (el.selectionStart);
//        console.log (viewO);
//        viewO.focus ();
//        console.log (viewO.selectionStart);
    }
};

OdfTextEdit.prototype.onKeyPress = function (event) {
    if (event.keyCode === 13) {
//        console.log ('keyPress: body');
//        event.stopPropagation ();
//        console.log (event);
//        return false;
//        event.preventDefault ();
//        console.log (document.selection);
//        console.log (window.getSelection ());
//        console.log (window.getSelection ().getRangeAt(0));
//        console.log (window.getSelection ().rangeCount);
//        console.log (window.getSelection().anchorNode.parentNode.tagName);
    }
};

//(function ()
//{
//    var doc, body, para;
//
//    textView = document.getElementById ('textView');
//    console.log (textView);
//
//    editor = new OdfTextEdit (textView);
//})()

function setupOdfTextEdit () {
    var editor = new OdfTextEdit (document.body);
}

function SetCSS (odfElement) {
    var style;

    for (i = 0; i < odfDocument.styles.length; i++)
    {
        if (odfDocument.styles [i].name == odfElement.styleName)
	{
	    style = odfDocument.styles [i];
	}
    }

    if (style.textFontStyle !== '')
    {
        odfElement.htmlElement.style.fontStyle = style.textFontStyle;
    }

    if (style.textFontWeight !== '')
    {
        odfElement.htmlElement.style.fontWeight = style.textFontWeight;
    }

    if (style.textUnderlineStyle !== '')
    {
        odfElement.htmlElement.style.textDecoration = 'underline';
//        this.htmlElement.style.textDecorationLine = 'underline';
//        this.htmlElement.style.textDecorationStyle = style.textUnderlineStyle;
    }
}

