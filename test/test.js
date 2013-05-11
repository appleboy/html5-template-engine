var assert = require("assert");
var fs = require('fs');

describe('html5 template generator test', function() {
    it('creates expected files in AMD mode', function() {
        var expected = [
            'output/favicon.ico',
            'output/.htaccess',
            'output/index.html',
            'output/404.html',
            'output/robots.txt',
            'output/assets/js/require.js',
            'output/assets/css/print.css',
            'output/assets/css/screen.css',
            'output/assets/css/ie.css'
        ];
        for(var key in expected) {
            assert.equal(true, fs.existsSync(expected[key]));
        }
    })
})
