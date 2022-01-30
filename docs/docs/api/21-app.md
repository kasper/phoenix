# App

Use App to control apps. Beware that an app can get stale if you keep a reference to it and it is for instance terminated while you do so, refer to `isTerminated()`.

## Interface

```javascript
class App implements Identifiable

  static App get(String appName)
  static App launch(String appName, Map<String, AnyObject> optionals)
  static App focused()
  static Array<App> all()

  int processIdentifier()
  String bundleIdentifier()
  String name()
  Image icon()
  boolean isActive()
  boolean isHidden()
  boolean isTerminated()
  Window mainWindow()
  Array<Window> windows(Map<String, AnyObject> optionals)
  boolean activate()
  boolean focus()
  boolean show()
  boolean hide()
  boolean terminate(Map<String, AnyObject> optionals)

end
```

## Static Methods

- `get(String appName)` returns the running app with the given name, returns `undefined` if the app is not currently running
- `launch(String appName, Map<String, AnyObject> optionals)` launches and returns the app with the given name, returns `undefined` if unsuccessful
- `focused()` returns the focused app
- `all()` returns all running apps

### Launch Optionals

- `focus` (boolean): if set `true` the app will automatically be focused on launch, by default the app launches to the background

## Instance Methods

- `processIdentifier()` returns the process identifier (PID) for the app, returns `-1` if the app does not have a PID
- `bundleIdentifier()` returns the bundle identifier for the app
- `name()` returns the name for the app
- `icon()` returns the icon for the app
- `isActive()` returns `true` if the app is currently frontmost
- `isHidden()` returns `true` if the app is hidden
- `isTerminated()` returns `true` if the app has been terminated
- `mainWindow()` returns the main window for the app, returns `undefined` if the app does not currently have a main window
- `windows(Map<String, AnyObject> optionals)` returns all windows for the app if no optionals are given
- `activate()` activates the app and brings its windows forward, returns `true` if successful
- `focus()` activates the app and brings its windows to focus, returns `true` if successful
- `show()` shows the app, returns `true` if successful
- `hide()` hides the app, returns `true` if successful
- `terminate(Map<String, AnyObject> optionals)` terminates the app, returns `true` if successful

### Window Optionals

- `visible` (boolean): if set `true` returns all visible windows for the app, if set `false` returns all hidden windows for the app

### Terminate Optionals

- `force` (boolean): if set `true` force terminates the app

## Example

```javascript
// Launch Safari with focus
App.launch('Safari', { focus: true });

// Get the focused app
const focused = App.focused();

// Get all windows for the focused app
const windows = focused.windows();

// Get Safari
const safari = App.get('Safari');
```
