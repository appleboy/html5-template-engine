define(['jquery', 'modernizr', 'libs/console'], function($) {
  var initialize;

  initialize = function() {
    console.info('Welcome to Html5 Template Engine');
    if (Modernizr.canvas) {
      console.info('Your browser support canvas');
    }
    if (Modernizr.touch) {
      console.info('Your device support touch event');
    }
    if (!Modernizr.canvas) {
      console.warn('Your browser don\'t support canvas');
    }
    if (!Modernizr.touch) {
      return console.warn('Your device don\'t support touch event');
    }
  };
  return {
    initialize: initialize
  };
});
