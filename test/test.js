var assert, fs;

assert = require("assert");

fs = require('fs');

describe('html5 template generator test', function() {
  it('creates expected files', function() {
    var expected, item, _i, _len, _results;
    expected = ['output/favicon.ico', 'output/.htaccess', 'output/index.html', 'output/404.html', 'output/robots.txt', 'output/assets/js/require.js', 'output/assets/css/print.css', 'output/assets/css/screen.css', 'output/assets/css/ie.css'];
    _results = [];
    for (_i = 0, _len = expected.length; _i < _len; _i++) {
      item = expected[_i];
      _results.push(assert.equal(true, fs.existsSync(item)));
    }
    return _results;
  });
  it('delete expected files', function() {
    var item, not_expected, _i, _len, _results;
    not_expected = ['output/assets/vendor/', 'output/assets/coffeescript/', 'output/assets/sass/'];
    _results = [];
    for (_i = 0, _len = not_expected.length; _i < _len; _i++) {
      item = not_expected[_i];
      _results.push(assert.equal(false, fs.existsSync(item)));
    }
    return _results;
  });
  return null;
});
