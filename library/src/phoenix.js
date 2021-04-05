var consoleLogFn = console.log; // eslint-disable-line no-console
// eslint-disable-next-line no-console
console.log = function () {
  consoleLogFn.apply(console, arguments);
  Phoenix.log.apply(Phoenix, arguments);
};
