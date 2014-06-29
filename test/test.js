var assert, fs;

assert = require("assert");

fs = require('fs');

describe('html5 template generator test', function() {
  it('creates expected files', function() {
    var expected, item, _i, _len, _results;
    expected = ['dist/favicon.ico', 'dist/.htaccess', 'dist/index.html', 'dist/404.html', 'dist/robots.txt', 'dist/assets/js/require.js', 'dist/assets/css/main.css', 'dist/assets/images/chrome.png'];
    _results = [];
    for (_i = 0, _len = expected.length; _i < _len; _i++) {
      item = expected[_i];
      _results.push(assert.equal(true, fs.existsSync(item)));
    }
    return _results;
  });
  it('delete expected files', function() {
    var item, not_expected, _i, _len, _results;
    not_expected = ['dist/assets/vendor/', 'dist/assets/coffee/', 'dist/assets/sass/', 'dist/assets/css/ie.css', 'dist/assets/css/print.css'];
    _results = [];
    for (_i = 0, _len = not_expected.length; _i < _len; _i++) {
      item = not_expected[_i];
      _results.push(assert.equal(false, fs.existsSync(item)));
    }
    return _results;
  });
  return null;
});
