define (require) ->
  assert = require('chai').assert

  suite 'App', ->
    test 'Should be present', ->
      assert.ok window.html5App
