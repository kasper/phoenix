# Space

Use the `Space`-object to control spaces. *These features are only supported on El Capitan (10.11) and upwards.* A single window can be in multiple spaces at the same time. To move a window to a different space, remove it from any existing spaces and add it to a new one. You can switch to a space by focusing on a window in that space. Beware that a space can get stale if you keep a reference to it and it is for instance closed while you do so.

## Interface

```javascript
class Space implements Identifiable, Iterable

  static Space active() // macOS 10.11+
  static Array<Space> all() // macOS 10.11+

  boolean isNormal()
  boolean isFullScreen()
  Array<Screen> screens()
  Array<Window> windows(Map<String, AnyObject> optionals)
  void addWindows(Array<Window> windows)
  void removeWindows(Array<Window> windows)

end
```

## Static Methods

- `active()` returns the space containing the window with the keyboard focus (macOS 10.11+, returns `undefined` otherwise)
- `all()` returns all spaces, the first space in this array corresponds to the primary space (macOS 10.11+, returns an empty list otherwise)

## Instance Methods

- `isNormal()` returns `true` if the space is a normal space
- `isFullScreen()` returns `true` if the space is a full screen space
- `screens()` returns all screens to which the space belongs to
- `windows(Map<String, AnyObject> optionals)` returns all windows for the space if no optionals are given
- `addWindows(Array<Window> windows)` adds the given windows to the space
- `removeWindows(Array<Window> windows)` removes the given windows from the space

### Optionals

- `visible` (boolean): if set `true` returns all visible windows for the space, if set `false` returns all hidden windows for the space
