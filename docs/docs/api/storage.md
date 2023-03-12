# Storage

Use Storage to store values across reloads and reboots as JSON.

## Interface

```javascript
class Storage

  static void set(String key, AnyObject value)
  static AnyObject get(String key)
  static void remove(String key)

end
```

## Static Methods

- `set(String key, AnyObject value)` stores the value for the key, any previously set value with the same key will be overridden
- `get(String key)` retrieves and returns the value for the key (`undefined` if no value has been set)
- `remove(String key)` removes the key and the value associated with it

## Example

```javascript
// Set a value
Storage.set('key', 'value');
Storage.set('height', 100);
Storage.set('isEnabled', true);
Storage.set('settings', { isEnabled: true });

// Get a value
const value = Storage.get('key');
Phoenix.log(value); // -> 'value'

// Remove a value
Storage.remove('key');
```
