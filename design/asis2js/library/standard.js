//  This code is placeholder for Standard Ada package
define('standard', [], function(){
    var standard = {};
    standard._nested = function (){};
    standard._nested.prototype = standard;
    standard = standard;

    //  This function used as abstract methods of tagged types.
    standard._abstract = function (){
        var error = new Error();
        error.message = "Call of abstract function";
        throw error;
    }

    //  Constructor for tags
    standard._tag = function (tag_name, parent_name){
        this._external_tag = tag_name;
    }
    standard._tag.prototype = {}

    return standard;
});
