'use strict';

/* Key */

(function (scope) {

  var keys = {};

  scope.on = function (key, modifiers, callback) {
    var keyHandler = new Key(key, modifiers, callback);
    if (!keyHandler) {
      return undefined;
    }
    keys[keyHandler.hash()] = keyHandler;
    return keyHandler.hash();
  }

  scope.off = function (identifier) {
    var key = keys[identifier];
    if (key) {
      key.disable();
      delete keys[identifier];
    }
  }
})(Key);
