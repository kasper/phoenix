var consoleLogFn = console.log; // eslint-disable-line no-console
var logFn = Phoenix.log;

function prettifyError(error) {
  var stack = '';
  if (error.stack) {
    stack = error.stack
      .trim()
      .split('\n')
      .map(function (line) {
        return '\tat ' + line;
      })
      .join('\n');
  }
  return error.name + ': ' + error.message + '\n' + stack;
}

Phoenix.log = function () {
  var isError = arguments[0] instanceof Error;
  if (isError) {
    logFn.call(Phoenix, prettifyError(arguments[0]));
    return;
  }
  logFn.apply(Phoenix, arguments);
};

// eslint-disable-next-line no-console
console.log = function () {
  consoleLogFn.apply(console, arguments);
  Phoenix.log.apply(Phoenix, arguments);
};
