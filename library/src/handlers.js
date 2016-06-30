'use strict';

/* exported Key, Event, Timer, Task */

/* Keys */

var Key = (function () {

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

var Event = (function () {

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

var Timer = (function () {

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

/* Tasks */

var Task = (function () {

  var module = {};
  var tasks = {};

  module.run = function (path, args, callback) {
    var task = Phoenix.run(path, args, function (handler) {
      callback(handler);
      Task.off(handler.hash());
    });
    tasks[task.hash()] = task;
    return task.hash();
  }

  module.off = function (identifier) {
    delete tasks[identifier];
  }

  return module;
})();
