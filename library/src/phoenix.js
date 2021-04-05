var consoleFn = console.log; // eslint-disable-line no-console
// eslint-disable-next-line no-console
console.log = function () {
  consoleFn.apply(console, arguments);
  Phoenix.log.apply(Phoenix, arguments);
};
