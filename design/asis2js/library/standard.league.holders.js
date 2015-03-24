define('standard.league.holders', ['standard.league'], function(_parent) {
    var _ec = new _parent._nested();
    _parent.standard.league.holders = _ec;
    _ec._nested = function() {};
    _ec._nested.prototype = _ec;
    _ec.to_holder = function(value) {
        return value;
    };
    _ec.element = function(value) {
        return value;
    };
    return _ec;
});
