# Filename: app.js
define [
    'jquery',
    'modernizr',
    'libs/console'], ($) ->
    initialize = ->
        # show welcome message.
        console.info 'Welcome to Html5 Template Engine.'
        # detect device support.
        if (Modernizr.canvas)
            console.info 'Your browser support canvas.'
        if (Modernizr.touch)
            console.info 'Your device support touch event.'
        if (!Modernizr.canvas)
            console.warn 'Your browser don\'t support canvas.'
        if (!Modernizr.touch)
            console.warn 'Your device don\'t support touch event.'

    initialize: initialize
