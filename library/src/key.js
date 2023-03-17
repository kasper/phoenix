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
  };

  scope.off = function (identifier) {
    var key = keys[identifier];
    if (key) {
      key.disable();
      delete keys[identifier];
    }
  };

  scope.once = function (key, modifiers, callback) {
    var identifier = scope.on(key, modifiers, function () {
      var returnValue = callback.apply(null, arguments);
      if (returnValue === false) {
        return;
      }
      scope.off(identifier);
    });
  };
})(Key);
