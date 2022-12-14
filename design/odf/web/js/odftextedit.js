
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
OdfStyleStyle.prototype.paragraphMarginBottom = "";
OdfStyleStyle.prototype.paragraphMarginLeft = "";
OdfStyleStyle.prototype.paragraphMarginRight = "";
OdfStyleStyle.prototype.paragraphMarginTop = "";
OdfStyleStyle.prototype.paragraphTextAlign = "";
OdfStyleStyle.prototype.cellBackgroundColor = "";
OdfStyleStyle.prototype.cellPaddingBottom = "";
OdfStyleStyle.prototype.cellPaddingLeft = "";
OdfStyleStyle.prototype.cellPaddingRight = "";
OdfStyleStyle.prototype.cellPaddingTop = "";
OdfStyleStyle.prototype.columnWidth = "";
OdfStyleStyle.prototype.textFontSize = "";
OdfStyleStyle.prototype.textFontStyle = "";
OdfStyleStyle.prototype.textFontWeight = "";
OdfStyleStyle.prototype.textUnderlineStyle = "";

//  OdfDomText

function OdfDomText (object) {
    OdfElementBase.call (this, object);
}

OdfDomText.prototype = new OdfElementBase ();
OdfDomText.prototype.constructor = OdfDomText;
OdfDomText.prototype.identifier = 0;
OdfDomText.prototype.htmlElement = null;
OdfDomText.prototype.characters = "";
OdfDomText.prototype.render = function (parentElement) {
    this.htmlElement = parentElement.ownerDocument.createTextNode (this.characters);
    this.htmlElement.odfElement = this;
    parentElement.appendChild (this.htmlElement);
}

//  OdfTableTable

function OdfTableTable (object)
{
    OdfElementBase.call (this, object);

    for (var i = 0; i < this.children.length; i++) {
        this.children [i].parentElement = this;
    }
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

    for (var i = 0; i < this.children.length; i++) {
        this.children [i].parentElement = this;
    }
}

OdfTableTableCell.prototype = new OdfElementBase ();
OdfTableTableCell.prototype.constructor = OdfTableTableCell;
OdfTableTableCell.prototype.htmlElement = null;
OdfTableTableCell.prototype.children = [];
OdfTableTableCell.prototype.styleName = "";
OdfTableTableCell.prototype.columnsSpanned = 1;
OdfTableTableCell.prototype.render = function (parentElement) {
    this.htmlElement = parentElement.ownerDocument.createElement ('td');
    this.htmlElement.setAttribute ('colspan', this.columnsSpanned);
    parentElement.appendChild (this.htmlElement);

    SetCSS (this);

    for (var i = 0; i < this.children.length; i++)
    {
        this.children [i].render (this.htmlElement);
    }
};

//  OdfTableTableColumn

function OdfTableTableColumn (object)
{
    OdfElementBase.call (this, object);
}

OdfTableTableColumn.prototype = new OdfElementBase ();
OdfTableTableColumn.prototype.constructor = OdfTableTableColumn;
//OdfTableTableCell.prototype.htmlElement = null;
//OdfTableTableCell.prototype.children = [];
OdfTableTableColumn.prototype.styleName = "";
OdfTableTableColumn.prototype.render = function (parentElement) {};

//  OdfTableTableRow

function OdfTableTableRow (object)
{
    OdfElementBase.call (this, object);

    for (var i = 0; i < this.children.length; i++) {
        this.children [i].parentElement = this;
    }
}

OdfTableTableRow.prototype = new OdfElementBase ();
OdfTableTableRow.prototype.constructor = OdfTableTableRow;
OdfTableTableRow.prototype.children = [];
OdfTableTableRow.prototype.render = function (parentElement) {
    var element = parentElement.ownerDocument.createElement ('tr');
    parentElement.appendChild (element);

    for (var i = 0; i < this.children.length; i++) {
        this.children [i].render (element);
    }
};

//  OdfTextH

function OdfTextH (object)
{
    OdfElementBase.call (this, object);

    for (var i = 0; i < this.children.length; i++) {
        this.children [i].parentElement = this;
    }
}

OdfTextH.prototype = new OdfElementBase ();
OdfTextH.prototype.constructor = OdfTextH;
OdfTextH.prototype.styleName = "";
OdfTextH.prototype.htmlElement = null;
OdfTextH.prototype.children = [];
OdfTextH.prototype.render = function (parentElement) {
    this.htmlElement = parentElement.ownerDocument.createElement ('p');
    parentElement.appendChild (this.htmlElement);
    SetCSS (this);

    for (var i = 0; i < this.children.length; i++) {
        this.children [i].render (this.htmlElement);
    }
};

//  OdfTextP

function OdfTextP (object)
{
    OdfElementBase.call (this, object);

    for (var i = 0; i < this.children.length; i++) {
        this.children [i].parentElement = this;
    }
}

OdfTextP.prototype = new OdfElementBase ();
OdfTextP.prototype.constructor = OdfTextP;
OdfTextP.prototype.styleName = "";
OdfTextP.prototype.htmlElement = null;
OdfTextP.prototype.children = [];
OdfTextP.prototype.render = function (parentElement) {
    this.htmlElement = parentElement.ownerDocument.createElement ('p');
    parentElement.appendChild (this.htmlElement);
    SetCSS (this);

    for (var i = 0; i < this.children.length; i++) {
        this.children [i].render (this.htmlElement);
    }

    if (this.children.length == 0) {
        //  When paragraph doesn't have any children insert dummy non-break
        //  space character to save formatting of the paragraph.

        text = parentElement.ownerDocument.createTextNode ('\u00A0');
        this.htmlElement.appendChild (text);
    }
};

//  OdfTextSpan

function OdfTextSpan (object)
{
    OdfElementBase.call (this, object);

    for (var i = 0; i < this.children.length; i++) {
        this.children [i].parentElement = this;
    }
}

OdfTextSpan.prototype = new OdfElementBase ();
OdfTextSpan.prototype.constructor = OdfTextSpan;
OdfTextSpan.prototype.styleName = "";
OdfTextSpan.prototype.htmlElement = null;
OdfTextSpan.prototype.children = [];
OdfTextSpan.prototype.render = function (parentElement) {
    this.htmlElement = parentElement.ownerDocument.createElement ('span');
    parentElement.appendChild (this.htmlElement);
    SetCSS (this);

    for (var i = 0; i < this.children.length; i++)
    {
        this.children [i].render (this.htmlElement);
    }
};

//  OdfOfficeText

function OdfOfficeText (object)
{
    OdfElementBase.call (this, object);

    for (var i = 0; i < this.children.length; i++) {
        this.children [i].parentElement = this;
    }
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

    //  Disable table cell controls.

    document.execCommand("enableInlineTableEditing", false, false);

    //  Disable resize controls.

    document.execCommand("enableObjectResizing", false, false);

    //  Setup even handlers.

    this.htmlElement.onkeypress = this.onKeyPress;

    //  Move focus into editor.

    this.htmlElement.focus ();
}

OdfTextEdit.prototype.onKeyPress = function (event) {
    if (event.keyCode === 8) {
        var htmlElement, position;

        event.preventDefault ();

        htmlElement = window.getSelection ().getRangeAt (0).startContainer;
        position = window.getSelection ().getRangeAt (0).startOffset;

        //  Insert character into display data.

        htmlElement.deleteData (position - 1, 1);

        //  Set text cursor position after inserted character.

        var selection = window.getSelection ();
        var range = selection.getRangeAt (0);
        range.setStart (range.startContainer, position - 1);
        range.setEnd (range.startContainer, position - 1);
        selection.addRange (range);

        //  Notify server.

        var change = new OdfTextChanged ({
            identifier: htmlElement.odfElement.identifier,
            start: position - 1,
            length: 1,
            characters: ""});
        var request = new XMLHttpRequest();
        request.open ('POST', 'changeODF', false);
        request.send (JSON.stringify (change));

    } else if (event.keyCode === 13) {
        //  Enter key.

        event.preventDefault ();
        console.log ('keyPress');
//        event.stopPropagation ();
//        console.log (event);
//        return false;
//        console.log (document.selection);
//        console.log (window.getSelection ());
//        console.log (window.getSelection ().getRangeAt(0));
//        console.log (window.getSelection ().rangeCount);
//        console.log (window.getSelection().anchorNode.parentNode.tagName);
    } else if (event.keyCode == 35) {
        //  Move cursor end - let browser to handle it.

    } else if (event.keyCode == 36) {
        //  Move cursor home - let browser to handle it.

    } else if (event.keyCode == 37) {
        //  Move cursor left - let browser to handle it.

    } else if (event.keyCode == 38) {
        //  Move cursor up - let browser to handle it.

    } else if (event.keyCode == 39) {
        //  Move cursor right - let browser to handle it.

    } else if (event.keyCode == 40) {
        //  Move cursor down - let browser to handle it.

    } else if (event.keyCode == 46) {
        //  Delete key.

        var htmlElement, position;

        event.preventDefault ();

        htmlElement = window.getSelection ().getRangeAt (0).startContainer;
        position = window.getSelection ().getRangeAt (0).startOffset;

        //  Delete character from display data.

        htmlElement.deleteData (position, 1);

        //  Set text cursor position after inserted character.

        var selection = window.getSelection ();
        var range = selection.getRangeAt (0);
        range.setStart (range.startContainer, position);
        range.setEnd (range.startContainer, position);
        selection.addRange (range);

        //  Notify server.

        var change = new OdfTextChanged ({
            identifier: htmlElement.odfElement.identifier,
            start: position,
            length: 1,
            characters: ""});
        var request = new XMLHttpRequest();
        request.open ('POST', 'changeODF', false);
        request.send (JSON.stringify (change));

    } else if (event.keyCode == 0 && !event.ctrlKey && !event.altKey) {
        var htmlElement, position;

        event.preventDefault ();

        htmlElement = window.getSelection ().getRangeAt (0).startContainer;
        position = window.getSelection ().getRangeAt (0).startOffset;

        //  Insert character into display data.

        htmlElement.insertData (position, String.fromCharCode (event.charCode));

        //  Set text cursor position after inserted character.

        var selection = window.getSelection ();
        var range = selection.getRangeAt (0);
        range.setStart (range.startContainer, position + 1);
        range.setEnd (range.startContainer, position + 1);
        selection.addRange (range);

        //  Notify server.

        var change = new OdfTextChanged ({
            identifier: htmlElement.odfElement.identifier,
            start: position,
            length: 0,
            characters: String.fromCharCode (event.charCode)});
        var request = new XMLHttpRequest();
        request.open ('POST', 'changeODF', false);
        request.send (JSON.stringify (change));

    } else {
        console.log (event);
        //console.log (window.getSelection ());
//        console.log (window.getSelection ().anchorNode);
        event.preventDefault ();
    }
};

function setupOdfTextEdit (id) {
    var editor = new OdfTextEdit (document.getElementById (id));
}

function SetCSS (odfElement) {
    function lookupStyle (name) {
        if (name == '') {
            //  Return when name of the style is not specified, thus where are
            //  no more styles in chain.

            return;
        }

        for (i = 0; i < odfDocument.styles.length; i++)
        {
            if (odfDocument.styles [i].name == name)
            {
                return odfDocument.styles [i];
            }
        }
    }

    function lookupDefaultStyle (family) {
        for (i = 0; i < odfDocument.styles.length; i++)
        {
            if (odfDocument.styles [i].kind == 'default' && odfDocument.styles [i].family == family)
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

    var value;
    var style = lookupStyle (odfElement.styleName);
    var styles = new Array;

    //  Construct styles list starting from element's style and adding all
    //  parent styles.

    while (style) {
        styles.push (style);
        style = lookupStyle (style.parentStyleName);
    }

    //  Process other styles depending of style's family.

    if (styles [0].family == 'text') {
        style = lookupStyle (odfElement.parentElement.styleName);

        //  Append style and its parent styles of nearest enclosing element
        //  with 'text' family or 'paragraph' family.

        if (style.family == 'text') {
            while (style) {
                styles.push (style);
                style = lookupStyle (style.parentStyleName);
            }
        } else if (style.family == 'paragraph') {
            while (style) {
                styles.push (style);
                style = lookupStyle (style.parentStyleName);
            }
        }
    } else if (styles [0].family == 'paragraph') {
        //  Append style and its parent styles of enclosing table-cell element.

        if (odfElement.parentElement instanceof OdfTableTableCell) {
            style = lookupStyle (odfElement.parentElement.styleName);

            while (style) {
                styles.push (style);
                style = lookupStyle (style.parentStyleName);
            }

            //  XXX Lookup of styles from 'table:default-cell-style-name' in
            //  'table:table-row' and 'table:table-column' elements is not
            //  implemented.
        }
    }

    //  Add default style for family of original style.

    style = lookupDefaultStyle (styles [0].family);

    if (style) {
        //  Default styles must be provided for all style families used in
        //  document, but sometimes they are missing. In this case we don't
        //  want to include 'null' into the list of styles.

        styles.push (style);
    }

    //  Apply text style.

    if (styles [0].family === 'text' || styles [0].family === 'paragraph') {
        //  Analyze 'fo:font-size' attribute.

        value = lookupProperty (styles, 'textFontSize');

        if (value) {
            odfElement.htmlElement.style.fontSize = value;
        }

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
            //  Default value is 'start' (reqired by specification).

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

        //  Analyze 'fo:margin-bottom' attribute.
        //
        //  XXX Percent value doesn't supported.

        value = lookupProperty (styles, 'paragraphMarginBottom');

        if (value) {
            odfElement.htmlElement.style.marginBottom = value;
        }

        //  Analyze 'fo:margin-left' attribute.
        //
        //  XXX Percent value doesn't supported.

        value = lookupProperty (styles, 'paragraphMarginLeft');

        if (value) {
            odfElement.htmlElement.style.marginLeft = value;
        }

        //  Analyze 'fo:margin-right' attribute.
        //
        //  XXX Percent value doesn't supported.

        value = lookupProperty (styles, 'paragraphMarginRight');

        if (value) {
            odfElement.htmlElement.style.marginRight = value;
        }

        //  Analyze 'fo:margin-top' attribute.
        //
        //  XXX Percent value doesn't supported.

        value = lookupProperty (styles, 'paragraphMarginTop');

        if (value) {
            odfElement.htmlElement.style.marginTop = value;
        }
    }

    //  Apply cell style.

    if (styles [0].family === 'table-cell') {
        //  Analyze 'fo:background-color' attribute.

        value = lookupProperty (styles, 'cellBackgroundColor');

        if (value) {
            odfElement.htmlElement.style.backgroundColor = value;
        }

        //  Analyze 'fo:padding-bottom' attribute.

        value = lookupProperty (styles, 'cellPaddingBottom');

        if (value) {
            odfElement.htmlElement.style.paddingBottom = value;
        }

        //  Analyze 'fo:padding-left' attribute.

        value = lookupProperty (styles, 'cellPaddingLeft');

        if (value) {
            odfElement.htmlElement.style.paddingLeft = value;
        }

        //  Analyze 'fo:padding-right' attribute.

        value = lookupProperty (styles, 'cellPaddingRight');

        if (value) {
            odfElement.htmlElement.style.paddingRight = value;
        }

        //  Analyze 'fo:padding-top' attribute.

        value = lookupProperty (styles, 'cellPaddingTop');

        if (value) {
            odfElement.htmlElement.style.paddingTop = value;
        }

        var index = odfElement.parentElement.children.indexOf (odfElement);
        var table = odfElement.parentElement.parentElement;
        var current = 0;
        var column;

        for (var i = 0; i < table.children.length; i++) {
            if (table.children [i] instanceof OdfTableTableColumn) {
                if (current == index) {
                    column = table.children [i];
                    break;
                }
                current += 1;
            }
        }

        styles = new Array;
        styles.push (lookupStyle (column.styleName));
        value = lookupProperty (styles, 'columnWidth');
    }

    //  Apply column style.

    if (styles [0].family === 'table-column') {
        //  Analyze 'style:column-width' attribute.

        value = lookupProperty (styles, 'columnWidth');

        if (value) {
            odfElement.htmlElement.style.width = value;
        }
    }
}

//  OdfTextChanged

function OdfTextChanged (object) {
    OdfElementBase.call (this, object);
}

OdfTextChanged.prototype = new OdfElementBase ();
OdfTextChanged.prototype.constructor = OdfTextChanged;
OdfTextChanged.prototype.identifier = 0;
OdfTextChanged.prototype.start = 0;
OdfTextChanged.prototype.length = 0;
OdfTextChanged.prototype.characters = "";
