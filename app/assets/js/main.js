require.config({
  paths: {
    jquery: '../vendor/jquery/jquery'
  },
  urlArgs: (new Date()).getTime()
});

require(['app'], function(App) {
  return App.initialize();
});
