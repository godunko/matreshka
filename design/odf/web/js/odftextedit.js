
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
OdfStyleStyle.prototype.name = "";
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

    //  Construct CSS

    var style;

    for (i = 0; i < odfDocument.styles.length; i++)
    {
        if (odfDocument.styles [i].name == this.styleName)
	{
	    style = odfDocument.styles [i];
	}
    }

    if (style.textFontStyle !== '')
    {
        this.htmlElement.style.fontStyle = style.textFontStyle;
    }

    if (style.textFontWeight !== '')
    {
        this.htmlElement.style.fontWeight = style.textFontWeight;
    }

    if (style.textUnderlineStyle !== '')
    {
        this.htmlElement.style.textDecoration = 'underline';
//        this.htmlElement.style.textDecorationLine = 'underline';
//        this.htmlElement.style.textDecorationStyle = style.textUnderlineStyle;
    }

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

    //  Construct CSS

    var style;

    for (i = 0; i < odfDocument.styles.length; i++)
    {
        if (odfDocument.styles [i].name == this.styleName)
	{
	    style = odfDocument.styles [i];
	}
    }

    if (style.textFontStyle !== '')
    {
        this.htmlElement.style.fontStyle = style.textFontStyle;
    }

    if (style.textFontWeight !== '')
    {
        this.htmlElement.style.fontWeight = style.textFontWeight;
    }

    if (style.textUnderlineStyle !== '')
    {
        this.htmlElement.style.textDecoration = 'underline';
//        this.htmlElement.style.textDecorationLine = 'underline';
//	this.htmlElement.style.textDecorationStyle = style.textUnderlineStyle;
    }

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

    //  Construct CSS

    var style;

    for (i = 0; i < odfDocument.styles.length; i++)
    {
        if (odfDocument.styles [i].name == this.styleName)
	{
	    style = odfDocument.styles [i];
	}
    }

    if (style.textFontStyle !== '')
    {
        this.htmlElement.style.fontStyle = style.textFontStyle;
    }

    if (style.textFontWeight !== '')
    {
        this.htmlElement.style.fontWeight = style.textFontWeight;
    }

    if (style.textUnderlineStyle !== '')
    {
        this.htmlElement.style.textDecoration = 'underline';
//        this.htmlElement.style.textDecorationLine = 'underline';
//        this.htmlElement.style.textDecorationStyle = style.textUnderlineStyle;
    }

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

var odfDocument;

//  OdfTextEdit

OdfTextEdit.prototype.htmlElement = null;
OdfTextEdit.prototype.odfDocument = null;

function OdfTextEdit (iframe) {
    var htmlDocument;
    var request;

    //  Create empty document inside iframe.

    htmlDocument = iframe.contentDocument;
    htmlDocument.open();
    htmlDocument.write ('<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml"></head><body></body></html>');
    htmlDocument.close();

    //  Link HTML element and OdfTextEdit.

    this.htmlElement = htmlDocument.body;
    this.htmlElement.odfTextEdit = this;

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
    this.odfDocument.content.render (htmlDocument, htmlDocument.body);
}

(function ()
{
    var doc, body, para;

    textView = document.getElementById ('textView');

    editor = new OdfTextEdit (textView);
})()
