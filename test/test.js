(function() {
  var assert, fs;

  assert = require("assert");

  fs = require('fs');

  describe('html5 template generator test', function() {
    return it('creates expected files in AMD mode', function() {
      var expected, item, _i, _len;

      expected = ['output/favicon.ico', 'output/.htaccess', 'output/index.html', 'output/404.html', 'output/robots.txt', 'output/assets/js/require.js', 'output/assets/css/print.css', 'output/assets/css/screen.css', 'output/assets/css/ie.css'];
      for (_i = 0, _len = expected.length; _i < _len; _i++) {
        item = expected[_i];
        assert.equal(true, fs.existsSync(item));
      }
      return null;
    });
  });

}).call(this);
