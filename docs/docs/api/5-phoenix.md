# Phoenix

Use the `Phoenix`-object for API-level tasks.

## Interface

```javascript
class Phoenix

  static void reload()
  static void set(Map<String, AnyObject> preferences)
  static void log(AnyObject... arguments)
  static void notify(String message)

end
```

## Static Methods

- `reload()` manually reloads the context and any changes in the configuration files
- `set(Map<String, AnyObject> preferences)` sets the preferences from the given key–value map, any previously set preferences with the same key will be overridden
- `log(AnyObject... arguments)` logs the arguments to the Console (app)
- `notify(String message)` delivers the message to the Notification Center
