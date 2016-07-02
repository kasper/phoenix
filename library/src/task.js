'use strict';

/* Task */

(function (scope) {

  var tasks = {};

  scope.run = function (path, args, callback) {
    var task = new Task(path, args, function (handler) {
      callback(handler);
      Task.terminate(handler.hash());
    });
    tasks[task.hash()] = task;
    return task.hash();
  }

  scope.terminate = function (identifier) {
    delete tasks[identifier];
  }
})(Task);
