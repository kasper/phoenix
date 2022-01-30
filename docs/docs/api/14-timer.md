# Timer

Use Timer to construct and control timers. A timer can fire only once or be repeating.

## Interface

```javascript
class Timer implements Identifiable

  static int after(double interval, Function callback)
  static int every(double interval, Function callback)
  static void off(int identifier)

  constructor Timer Timer(double interval, boolean repeats, Function callback)
  void stop()

end
```

## Static Methods

- `after(double interval, Function callback)` constructs a managed handler for a timer that fires only once and returns the identifier for the handler, for arguments see `new Timer(...)`
- `every(double interval, Function callback)` constructs a managed handler for a timer that fires repeatedly and returns the identifier for the handler, for arguments see `new Timer(...)`
- `off(int identifier)` disables the managed handler for a timer with the given identifier

## Constructor

- `new Timer(double interval, boolean repeats, Function callback)` constructs a timer that fires the callback once or repeatedly until stopped with the given interval (in seconds) and returns the handler, you must keep a reference to the handler in order for your callback to get called, the callback function receives its handler as the only argument

## Instance Methods

- `stop()` stops the timer immediately

## Example

```javascript
// Call callback once after 500 ms
Timer.after(0.5, () => {
  console.log('500 ms passed.');
});

// Call callback every 5 seconds
const identifier = Timer.every(5, () => {
  console.log('5 seconds passed.');
});

// Disable the handler
Timer.off(identifier);
```
