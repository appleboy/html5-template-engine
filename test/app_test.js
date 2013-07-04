define(function(require) {
  var assert;
  assert = require('chai').assert;
  return suite('App', function() {
    return test('Should be present', function() {
      return assert.ok(window.html5App);
    });
  });
});
