'use strict';

(function (scope) {

  /* Clearing */

  scope.clearTimeout = Timer.off;
  scope.clearInterval = Timer.off;

  /* Timeout */

  scope.setTimeout = function (callback, milliseconds) {
    return Timer.after(milliseconds / 1000, callback);
  }

  /* Interval */

  scope.setInterval = function (callback, milliseconds) {
    return Timer.every(milliseconds / 1000, callback);
  }
})(this);
