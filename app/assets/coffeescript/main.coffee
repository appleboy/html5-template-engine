# Filename: main.js
require.config
    paths:
        jquery: '../vendor/jquery/jquery'
        modernizr: '../vendor/modernizr/modernizr'
    # for development
    urlArgs: (new Date()).getTime()

# initail app
require ['app'], (App) ->
    App.initialize()
