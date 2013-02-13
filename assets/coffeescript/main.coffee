# Filename: main.js
require.config
    paths:
        jquery: "../vendor/jquery/jquery"
    # for development
    urlArgs: (new Date()).getTime()

require ["app"], (App) ->
    App.initialize()
