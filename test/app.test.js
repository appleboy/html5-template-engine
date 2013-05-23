define(function(require) {
    var assert = require('chai').assert;

    suite('App', function() {
        test('Should be present', function() {
            assert.ok(window.html5App);
        });
    });
});
