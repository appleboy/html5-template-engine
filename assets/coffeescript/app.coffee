# Filename: app.js
define [
    "jquery",
    "libs/console",
    "../vendor/modernizr/modernizr"], ($) ->
    initialize = ->
        console.info 'Welcome to Html5 Template Engine'
        console.info 'Your browser support canvas' if (Modernizr.canvas)
        console.info 'Your device support touch event' if (Modernizr.touch)

    initialize: initialize
