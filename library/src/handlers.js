'use strict';

/* exported Key, Event, Timer */

/* Keys */

// jscs:disable disallowUnusedVariables

var Key = (function () {

  // jscs:enable disallowUnusedVariables

  var module = {};
  var keys = {};

  module.on = function (key, modifiers, callback) {
    var keyHandler = Phoenix.bind(key, modifiers, callback);
    if (!keyHandler) {
      return undefined;
    }
    keys[keyHandler.hash()] = keyHandler;
    return keyHandler.hash();
  }

  module.off = function (identifier) {
    var key = keys[identifier];
    if (key) {
      key.disable();
      delete keys[identifier];
    }
  }

  return module;
})();

/* Events */

// jscs:disable disallowUnusedVariables

var Event = (function () {

  // jscs:enable disallowUnusedVariables

  var module = {};
  var events = {};

  module.on = function (event, callback) {
    var eventHandler = Phoenix.on(event, callback);
    if (!eventHandler) {
      return undefined;
    }
    events[eventHandler.hash()] = eventHandler;
    return eventHandler.hash();
  }

  module.off = function (identifier) {
    delete events[identifier];
  }

  return module;
})();

/* Timers */

// jscs:disable disallowUnusedVariables

var Timer = (function () {

  // jscs:enable disallowUnusedVariables

  var module = {};
  var timers = {};

  module.after = function (interval, callback) {
    var timer = Phoenix.after(interval, function (handler) {
      callback(handler);
      Timer.off(handler.hash());
    });
    timers[timer.hash()] = timer;
    return timer.hash();
  }

  module.every = function (interval, callback) {
    var timer = Phoenix.every(interval, callback);
    timers[timer.hash()] = timer;
    return timer.hash();
  }

  module.off = function (identifier) {
    var timer = timers[identifier];
    if (timer) {
      timer.stop();
      delete timers[identifier];
    }
  }

  return module;
})();
