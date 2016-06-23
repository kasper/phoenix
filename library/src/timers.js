'use strict';

(function (scope) {

  var timers = {};

  /* Clearing */

  function clear(identifier) {
    var timer = timers[identifier];
    if (timer) {
      timer.stop();
      delete timers[identifier];
    }
  }

  scope.clearTimeout = clear;
  scope.clearInterval = clear;

  /* Timeout */

  scope.setTimeout = function (callback, milliseconds) {
    var timer = Phoenix.after(milliseconds / 1000, function () {
      callback();
      clear(timer.hash());
    });
    timers[timer.hash()] = timer;
    return timer.hash();
  }

  /* Interval */

  scope.setInterval = function (callback, milliseconds) {
    var timer = Phoenix.every(milliseconds / 1000, callback);
    timers[timer.hash()] = timer;
    return timer.hash();
  }
})(this);
