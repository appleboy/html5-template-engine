require.config({
  paths: {
    jquery: '../app/assets/vendor/jquery/jquery',
    modernizr: '../app/assets/vendor/modernizr/modernizr',
    consolejs: '../app/assets/js/libs/console',
    chai: '../node_modules/chai/chai',
    mocha: '../node_modules/mocha/mocha'
  },
  urlArgs: (new Date()).getTime()
});

define(['jquery', 'require', 'mocha', 'modernizr', 'consolejs'], function($, require) {
    mocha.setup({
        ui: 'tdd',
        globals: ['html5App']
    });

    window.html5App = {};
     require([
        'app.test',
    ], function(require) {
        if (window.mochaPhantomJS) {
            mochaPhantomJS.run();
        } else {
            mocha.run();
        }
    });
});