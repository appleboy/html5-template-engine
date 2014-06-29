assert = require("assert")
fs = require('fs')

describe 'html5 template generator test', ->
  it 'creates expected files', ->
    expected = [
      'dist/favicon.ico'
      'dist/.htaccess'
      'dist/index.html'
      'dist/404.html'
      'dist/robots.txt'
      'dist/assets/js/require.js'
      'dist/assets/css/main.css'
      'dist/assets/images/chrome.png'
    ]
    for item in expected
      assert.equal(true, fs.existsSync(item))

  it 'delete expected files', ->
    not_expected = [
      'dist/assets/vendor/'
      'dist/assets/coffee/'
      'dist/assets/sass/'
      'dist/assets/css/ie.css'
      'dist/assets/css/print.css'
    ]
    for item in not_expected
      assert.equal(false, fs.existsSync(item))
  null
