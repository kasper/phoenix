# Key

Use Key to construct keys, bind callbacks, access their properties, and enable or disable them. You can have multiple handlers for a single key combination, however only one can be enabled at a time. Enabling a key combination that has been exclusively registered by another app will fail.

See [Keys](keys) for a list available keys for binding.

## Interface

```javascript
class Key implements Identifiable

  static int on(String key, Array<String> modifiers, Function callback)
  static void once(String key, Array<String> modifiers, Function callback)
  static void off(int identifier)

  property String key
  property Array<String> modifiers

  constructor Key Key(String key, Array<String> modifiers, Function callback)
  boolean isEnabled()
  boolean enable()
  boolean disable()

end
```

## Static Methods

- `on(String key, Array<String> modifiers, Function callback)` constructs a managed handler for a key and returns the identifier for the handler, for arguments see `new Key(...)`
- `once(String key, Array<String> modifiers, Function callback)` constructs a managed handler for a key that is by default only triggered one time and then disabled, for more control you can explicitly return `false` from the callback function and the handler will not be disabled until you return something else, for arguments see `new Key(...)`
- `off(int identifier)` disables the managed handler for a key with the given identifier

## Instance Properties

- `key` read-only property for the key character in lower case or case sensitive special key
- `modifiers` read-only property for the key modifiers in lower case

## Constructor

- `new Key(String key, Array<String> modifiers, Function callback)` constructs and binds the key character with the specified modifiers (can be an empty list) to a callback function and returns the handler, you must keep a reference to the handler in order for your callback to get called, you can have multiple handlers for a single key combination, only one can be enabled at a time, any previous handler for the same key combination will automatically be disabled, the callback function receives its handler as the first argument and as the second argument a boolean that indicates if the key was repeated (key combination is held down)

## Instance Methods

- `isEnabled()` returns `true` if the key handler is enabled, by default `true`
- `enable()` enables the key handler, any previous handler for the same key combination will automatically be disabled, returns `true` if successful
- `disable()` disables the key handler, returns `true` if successful

## Example

```javascript
// Bind Control + Shift + Q to a callback function
Key.on('q', ['control', 'shift'], () => {
  console.log('Key combination pressed.');
});
```
