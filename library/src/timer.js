'use strict';

/* Timer */

(function (scope) {
  var timers = {};

  scope.after = function (interval, callback) {
    var timer = new Timer(interval, false, function (handler) {
      callback(handler);
      Timer.off(handler.hash());
    });
    timers[timer.hash()] = timer;
    return timer.hash();
  };

  scope.every = function (interval, callback) {
    var timer = new Timer(interval, true, callback);
    timers[timer.hash()] = timer;
    return timer.hash();
  };

  scope.off = function (identifier) {
    var timer = timers[identifier];
    if (timer) {
      timer.stop();
      delete timers[identifier];
    }
  };
}(Timer));

/* Global Timing */

this.clearTimeout = Timer.off;
this.clearInterval = Timer.off;

this.setTimeout = function (callback, milliseconds) {
  return Timer.after(milliseconds / 1000, callback);
};

this.setInterval = function (callback, milliseconds) {
  return Timer.every(milliseconds / 1000, callback);
};
