
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
OdfStyleStyle.prototype.paragraphTextAlign = "";
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
OdfTableTable.prototype.render = function (parentElement) {
    var tableElement = parentElement.ownerDocument.createElement ('table');
    var tbodyElement = parentElement.ownerDocument.createElement ('tbody');
    parentElement.appendChild (tableElement);
    tableElement.appendChild (tbodyElement);

    for (var i = 0; i < this.children.length; i++)
    {
        this.children [i].render (tbodyElement);
    }
};

//  OdfTableTableCell

function OdfTableTableCell (object)
{
    OdfElementBase.call (this, object);
}

OdfTableTableCell.prototype = new OdfElementBase ();
OdfTableTableCell.prototype.constructor = OdfTableTableCell;
OdfTableTableCell.prototype.children = [];
OdfTableTableCell.prototype.render = function (parentElement) {
    var element = parentElement.ownerDocument.createElement ('td');
    parentElement.appendChild (element);

    for (var i = 0; i < this.children.length; i++)
    {
        this.children [i].render (element);
    }
};

//  OdfTableTableRow

function OdfTableTableRow (object)
{
    OdfElementBase.call (this, object);
}

OdfTableTableRow.prototype = new OdfElementBase ();
OdfTableTableRow.prototype.constructor = OdfTableTableRow;
OdfTableTableRow.prototype.children = [];
OdfTableTableRow.prototype.render = function (parentElement) {
    var element = parentElement.ownerDocument.createElement ('tr');
    parentElement.appendChild (element);

    for (var i = 0; i < this.children.length; i++)
    {
        this.children [i].render (element);
    }
};

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
OdfTextH.prototype.render = function (parentElement) {
    this.htmlElement = parentElement.ownerDocument.createElement ('p');
    parentElement.appendChild (this.htmlElement);
//    this.htmlElement.contentEditable = true;

    SetCSS (this);

    for (var i = 0; i < this.children.length; i++)
    {
        if (typeof this.children [i] === 'string')
	{
            var text = parentElement.ownerDocument.createTextNode (this.children [i]);
	    this.htmlElement.appendChild (text);
	}
	else
	{
            this.children [i].render (this.htmlElement);
	}
    }
};

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
OdfTextP.prototype.render = function (parentElement) {
    this.htmlElement = parentElement.ownerDocument.createElement ('p');
    parentElement.appendChild (this.htmlElement);
//    this.htmlElement.contentEditable = true;

    SetCSS (this);

    for (var i = 0; i < this.children.length; i++)
    {
        if (typeof this.children [i] === 'string')
	{
            var text = parentElement.ownerDocument.createTextNode (this.children [i]);
	    this.htmlElement.appendChild (text);
	}
	else
	{
            this.children [i].render (this.htmlElement);
	}
    }
};

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
OdfTextSpan.prototype.render = function (parentElement) {
    this.htmlElement = parentElement.ownerDocument.createElement ('span');
    parentElement.appendChild (this.htmlElement);
//    this.htmlElement.contentEditable = true;

    SetCSS (this);

    for (var i = 0; i < this.children.length; i++)
    {
        if (typeof this.children [i] === 'string')
	{
            var text = parentElement.ownerDocument.createTextNode (this.children [i]);
	    this.htmlElement.appendChild (text);
	}
	else
	{
            this.children [i].render (this.htmlElement);
	}
    }
};

//  OdfOfficeText

function OdfOfficeText (object)
{
    OdfElementBase.call (this, object);
}

OdfOfficeText.prototype = new OdfElementBase ();
OdfOfficeText.prototype.constructor = OdfOfficeText;
OdfOfficeText.prototype.children = [];
OdfOfficeText.prototype.render = function (parentElement) {
    for (var i = 0; i < this.children.length; i++)
    {
        this.children [i].render (parentElement);
    }
};

var odfDocument;

//  OdfTextEdit

OdfTextEdit.prototype.htmlElement = null;
OdfTextEdit.prototype.odfDocument = null;

function OdfTextEdit (rootElement) {
    var request;

    //  Link HTML element and OdfTextEdit.

    this.htmlElement = rootElement;
    this.htmlElement.odfTextEdit = this;

    //  Load ODF document.

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
    this.odfDocument.content.render (this.htmlElement);

    //  Move focus into editor.

    this.htmlElement.focus ();

    //  Setup even handlers.

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

function setupOdfTextEdit (id) {
    var editor = new OdfTextEdit (document.getElementById (id));
}

function SetCSS (odfElement) {
    function lookupStyle (name) {
        for (i = 0; i < odfDocument.styles.length; i++)
        {
            if (odfDocument.styles [i].name == name)
            {
                return odfDocument.styles [i];
            }
        }
    }

    function lookupProperty (styles, name) {
        for (style = null, i = 0; i < styles.length; i++) {
            //  Check whether given property is defined and non-empty.
            if (styles [i][name] && styles [i][name] !== '') {
                return styles [i][name];
            }
        }
    }

    var style = lookupStyle (odfElement.styleName);
    var styles = new Array;
    var value;

    while (style) {
        styles.push (style);
        style = lookupStyle (style.parentStyleName)
    }

    //  Apply text style.

    if (styles [0].family === 'text' || styles [0].family === 'paragraph') {
        //  Construct 'font-style' property.

        value = lookupProperty (styles, 'textFontStyle');

        if (value) {
            odfElement.htmlElement.style.fontStyle = value;
        }

        //  Construct 'font-weight' property.

        value = lookupProperty (styles, 'textFontWeight');

        if (value) {
            odfElement.htmlElement.style.fontWeight = value;
        }

        //  Construct 'textDecoration' property.

        value = lookupProperty (styles, 'textUnderlineStyle');

        if (value)
        {
            odfElement.htmlElement.style.textDecoration = 'underline';
    //        this.htmlElement.style.textDecorationLine = 'underline';
    //        this.htmlElement.style.textDecorationStyle = style.textUnderlineStyle;
        }
    }

    //  Apply paragraph style.

    if (styles [0].family === 'paragraph') {
        //  Analyze 'fo:text-align' attribute.

        value = lookupProperty (styles, 'paragraphTextAlign');

        if (!value) {
            //  Default value is 'start'.

            value = 'start';
        }

        if (value === 'start') {
            //  XXX LTR language assumed.

            odfElement.htmlElement.style.textAlign = 'left';
        } else if (value === 'end') {
            //  XXX LTR language assumed.

            odfElement.htmlElement.style.textAlign = 'right';
        } else {
            odfElement.htmlElement.style.textAlign = value;
        }
    }
}

