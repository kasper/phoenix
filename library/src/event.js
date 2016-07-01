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
    delete events[identifier];
  }
})(Event);
