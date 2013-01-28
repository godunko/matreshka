
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

//  OdfTableTable

function OdfTableTable (object)
{
    OdfElementBase.call (this, object);
}

OdfTableTable.prototype = new OdfElementBase ();
OdfTableTable.prototype.constructor = OdfTableTable;
OdfTableTable.prototype.render = function (htmlDocument, parentElement) {
    var element = htmlDocument.createElement ('table');
    parentElement.appendChild (element);

//    for (var i = 0; i < this.children.length; i++)
//    {
//        this.children [i].render (htmlDocument, element);
//    }
};

//  OdfTextP

function OdfTextP (object)
{
    OdfElementBase.call (this, object);
}

OdfTextP.prototype = new OdfElementBase ();
OdfTextP.prototype.constructor = OdfTextP;
OdfTextP.prototype.children = [];
OdfTextP.prototype.render = function (htmlDocument, parentElement) {
    var element = htmlDocument.createElement ('p');
    parentElement.appendChild (element);

    for (var i = 0; i < this.children.length; i++)
    {
        if (typeof this.children [i] === 'string')
	{
            var text = htmlDocument.createTextNode (this.children [i]);
	    element.appendChild (text);
	}
	else
	{
            this.children [i].render (htmlDocument, element);
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
OdfTextSpan.prototype.children = [];
OdfTextSpan.prototype.render = function (htmlDocument, parentElement) {
    var element = htmlDocument.createElement ('span');
    parentElement.appendChild (element);

    for (var i = 0; i < this.children.length; i++)
    {
        if (typeof this.children [i] === 'string')
	{
            var text = htmlDocument.createTextNode (this.children [i]);
	    element.appendChild (text);
	}
	else
	{
            this.children [i].render (htmlDocument, element);
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

(function ()
{
    var doc, body, para, text;

    textView = document.getElementById ('textView');

    //  Create empty document inside iframe.

    doc = textView.contentDocument;
    doc.open();
    doc.write ('<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml"></head><body></body></html>');
    doc.close();

    //  Load document.

    request = new XMLHttpRequest();
    request.open ('GET', 'getODF', false);
    request.send ();
    text = JSON.parse (request.response, function (key, value)
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
    console.log (text);
    text.render (doc, doc.body);
})()
