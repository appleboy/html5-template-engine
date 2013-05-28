require.config
    paths:
        jquery: '../app/assets/vendor/jquery/jquery'
        modernizr: '../app/assets/vendor/modernizr/modernizr'
        consolejs: '../app/assets/js/libs/console'
        chai: '../node_modules/chai/chai'
        mocha: '../node_modules/mocha/mocha'
        # for development
    urlArgs: (new Date()).getTime()

define ['jquery', 'require', 'mocha', 'modernizr', 'consolejs'], ($, require) ->
    mocha.setup
        ui: 'tdd',
        globals: ['html5App']

    window.html5App = {}
    require ['app_test'], (require) ->
        if (window.mochaPhantomJS)
            mochaPhantomJS.run()
        else
            mocha.run()
