assert = require("assert")
fs = require('fs')

describe 'html5 template generator test', () ->
    it 'creates expected files', () ->
        expected = [
            'dist/favicon.ico',
            'dist/.htaccess',
            'dist/index.html',
            'dist/404.html',
            'dist/robots.txt',
            'dist/assets/js/require.js',
            'dist/assets/css/print.css',
            'dist/assets/css/screen.css',
            'dist/assets/css/ie.css',
            'dist/assets/images/chrome.png'
        ]
        for item in expected
            assert.equal(true, fs.existsSync(item))

    it 'delete expected files', () ->
        not_expected = [
            'dist/assets/vendor/',
            'dist/assets/coffeescript/',
            'dist/assets/sass/'
        ]
        for item in not_expected
            assert.equal(false, fs.existsSync(item))
    null
