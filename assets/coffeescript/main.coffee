# Filename: main.js
require.config
    paths:
        jquery: "vendor/jquery/jquery"

require ["app"], (App) ->
    App.initialize()
