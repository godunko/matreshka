//  This code is placeholder for Standard Ada package
define('standard', [], function(){
    var standard = {};
    standard._nested = function (){};
    standard._nested.prototype = standard;
    standard.standard = standard;

    //  This function used as abstract methods of tagged types.
    standard._abstract = function (){
        var error = new Error();
        error.message = "Call of abstract function";
        throw error;
    };

    //  Constructor for tags
    standard._tag = function (tag_name, parent_name){
        this._external_tag = tag_name;
    };
    standard._tag.prototype = {};

    //  T'Pos(x) for discrete type T
    standard._pos = function (x){
        switch(typeof(x)){
            case 'boolean': return +x;
            case 'string': return x.charCodeAt(0);
            default: return x;
        }
    };

    //  T'Succ(x) for discrete type T
    standard._succ = function (x){
        switch(typeof(x)){
            case 'boolean': return !x;
            case 'string': return String.fromCharCode (x.charCodeAt(0)+1);
            default: return x+1;
        }
    };

    standard._image = function (x){
        return x.toString();
    };

    return standard;
});
