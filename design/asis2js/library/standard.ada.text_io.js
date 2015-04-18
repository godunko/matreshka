define('standard.ada.text_io', ['standard.ada'], function(_ec) {
    return (function(_ec) {
        var buffer = "";
        _ec._nested = function() {};
        _ec._nested.prototype = _ec;
        _ec.put = function put(item) {
            buffer = buffer + item;
        };
        _ec.put_line = function put_line(item) {
            buffer = buffer + item;
            console.log(buffer);
            buffer = "";
        };
        return _ec;
    })(_ec.text_io = new _ec._nested());
});
