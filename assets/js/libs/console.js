(function() {
  var console, length, method, methods, noop, _results;
  methods = ['assert', 'clear', 'count', 'debug', 'dir', 'dirxml', 'error', 'exception', 'group', 'groupCollapsed', 'groupEnd', 'info', 'log', 'markTimeline', 'profile', 'profileEnd', 'table', 'time', 'timeEnd', 'timeStamp', 'trace', 'warn'];
  length = methods.length;
  console = (window.console = window.console || {});
  noop = function() {};
  _results = [];
  while (length--) {
    method = methods[length];
    if (!console[method]) {
      _results.push(console[method] = noop);
    } else {
      _results.push(void 0);
    }
  }
  return _results;
})();
