require.config({
  paths: {
    jquery: '../vendor/jquery/jquery',
    modernizr: '../vendor/modernizr/modernizr'
  },
  urlArgs: (new Date()).getTime()
});

require(['app'], function(App) {
  return App.initialize();
});
