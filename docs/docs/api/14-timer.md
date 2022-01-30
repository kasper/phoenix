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
// Call callback after 5 seconds
Timer.after(5.0, () => {
  console.log('5 seconds passed.');
});
```
