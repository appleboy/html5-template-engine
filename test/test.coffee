assert = require("assert")
fs = require('fs')

describe 'html5 template generator test', () ->
    it 'creates expected files', () ->
        expected = [
            'output/favicon.ico',
            'output/.htaccess',
            'output/index.html',
            'output/404.html',
            'output/robots.txt',
            'output/assets/js/require.js',
            'output/assets/css/print.css',
            'output/assets/css/screen.css',
            'output/assets/css/ie.css'
        ]
        for item in expected
            assert.equal(true, fs.existsSync(item))

    it 'delete expected files', () ->
        not_expected = [
            'output/assets/vendor/',
            'output/assets/coffeescript/',
            'output/assets/sass/'
        ]
        for item in not_expected
            assert.equal(false, fs.existsSync(item))
    null
