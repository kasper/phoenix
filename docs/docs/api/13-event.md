# Event

Use Event to construct events, bind callbacks, access their properties or disable them. You can have multiple handlers for a single event.

See [Events](events) for a list of available events for binding.

## Interface

```javascript
class Event implements Identifiable

  static int on(String event, Function callback)
  static void once(String event, Function callback)
  static void off(int identifier)

  property String name

  constructor Event Event(String event, Function callback)
  void disable()

end
```

## Static Methods

- `on(String event, Function callback)` constructs a managed handler for an event and returns the identifier for the handler, for arguments see `new Event(...)`
- `once(String event, Function callback)` constructs a managed handler for an event that is by default only triggered one time and then disabled, for more control you can explicitly return `false` from the callback function and the handler will not be disabled until you return something else, for arguments see `new Event(...)`
- `off(int identifier)` disables the managed handler for an event with the given identifier

## Instance Properties

- `name` read-only property for the event name

## Constructor

- `new Event(String event, Function callback)` constructs and binds an event to a callback function and returns the handler, you must keep a reference to the handler in order for your callback to get called, you can have multiple handlers for a single event, the callback function receives its handler as the last argument, for any additional arguments see [events](events)

## Instance Methods

- `disable()` disables the event handler

## Example

```javascript
// Bind “appDidLaunch” event to a callback function
const identifier = Event.on('appDidLaunch', (app) => {
  console.log('App did launch:', app.name()); // -> 'App did launch: Safari'
});

// Disable the handler
Event.off(identifier);
```
