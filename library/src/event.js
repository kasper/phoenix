'use strict';

/* Event */

(function (scope) {

  var events = {};

  scope.on = function (event, callback) {
    var eventHandler = new Event(event, callback);
    if (!eventHandler) {
      return undefined;
    }
    events[eventHandler.hash()] = eventHandler;
    return eventHandler.hash();
  }

  scope.off = function (identifier) {
    var event = events[identifier];
    if (event) {
      event.disable();
      delete events[identifier];
    }
  }

  scope.once = function (event, callback) {
    var identifier = scope.on(event, function () {
      var returnValue = callback.apply(null, arguments);
      if (returnValue === false) {
        return;
      }
      scope.off(identifier);
    });
  }
})(Event);
