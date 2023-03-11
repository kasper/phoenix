# Screen

Use Screen to access frame sizes and other screens on a multi-screen setup. Beware that a screen can get stale if you keep a reference to it and it is for instance disconnected while you do so.

## Interface

```javascript
class Screen implements Identifiable, Iterable

  static Screen main()
  static Array<Screen> all()

  String identifier()
  Rectangle frame()
  Rectangle visibleFrame()
  Rectangle flippedFrame()
  Rectangle flippedVisibleFrame()
  Space currentSpace() // macOS 10.11+
  Array<Space> spaces() // macOS 10.11+
  Array<Window> windows(Map<String, AnyObject> optionals)

end
```

## Static Methods

- `main()` returns the screen containing the window with the keyboard focus
- `all()` returns all screens, the first screen in this array corresponds to the primary screen for the system

## Instance Methods

- `identifier()` returns the UUID for the screen
- `frame()` returns the whole frame for the screen, bottom left based origin
- `visibleFrame()` returns the visible frame for the screen subtracting the Dock and Menu from the frame when visible, bottom left based origin
- `flippedFrame()` returns the whole frame for the screen, top left based origin
- `flippedVisibleFrame()` returns the visible frame for the screen subtracting the Dock and Menu from the frame when visible, top left based origin
- `currentSpace()` returns the current space for the screen (macOS 10.11+, returns `undefined` otherwise)
- `spaces()` returns all spaces for the screen (macOS 10.11+, returns an empty list otherwise)
- `windows(Map<String, AnyObject> optionals)` returns all windows for the screen if no optionals are given

### Optionals

- `visible` (boolean): if set `true` returns all visible windows for the screen, if set `false` returns all hidden windows for the screen

## Events

See [Events](events#screen) for a list of available events for Screen.

## Example

```javascript
// Get all available screens
const screens = Screen.all();

// Get visible frame for the main screen
const frame = Screen.main().visibleFrame();

// Get all windows on the main screen
Screen.main().windows();

// Get all visible windows on the main screen
Screen.main().windows({ visible: true });
```
