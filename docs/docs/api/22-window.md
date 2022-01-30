# Window

Use Window to control app windows. Every screen (i.e. display) combines to form a large rectangle. Every window lives within this rectangle and their position can be altered by giving coordinates inside this rectangle. To position a window to a specific display, you need to calculate its position within the large rectangle. To figure out the coordinates for a given screen, use the functions in `Screen`. Beware that a window can get stale if you keep a reference to it and it is for instance closed while you do so.

## Interface

```javascript
class Window implements Identifiable

  static Window focused()
  static Window at(Point point)
  static Array<Window> all(Map<String, AnyObject> optionals)
  static Array<Window> recent()

  Array<Window> others(Map<String, AnyObject> optionals)
  String title()
  boolean isMain()
  boolean isNormal()
  boolean isFullScreen()
  boolean isMinimised() // or isMinimized()
  boolean isVisible()
  App app()
  Screen screen()
  Array<Space> spaces() // macOS 10.11+
  Point topLeft()
  Size size()
  Rectangle frame()
  boolean setTopLeft(Point point)
  boolean setSize(Size size)
  boolean setFrame(Rectangle frame)
  boolean setFullScreen(boolean value)
  boolean maximise() // or maximize()
  boolean minimise() // or minimize()
  boolean unminimise() // or unminimize()
  Array<Window> neighbours(String direction) // or neighbors(...)
  boolean raise()
  boolean focus()
  boolean focusClosestNeighbour(String direction) // or focusClosestNeighbor(...)
  boolean close()

end
```

## Static Methods

- `focused()` returns the focused window for the currently active app, can be `undefined` if no window is focused currently
- `at(Point point)` returns the topmost window at the specified point, can be `undefined` if no window is present at the given position
- `all(Map<String, AnyObject> optionals)` returns all windows in screens if no optionals are given
- `recent()` returns all visible windows in the order as they appear on the screen (from front to back), essentially returning them in the most-recently-used order

### Window Optionals

- `visible` (boolean): if set `true` returns all visible windows in screens, if set `false` returns all hidden windows in screens

## Instance Methods

- `others(Map<String, AnyObject> optionals)` returns all other windows on all screens if no optionals are given
- `title()` returns the title for the window
- `isMain()` returns `true` if the window is the main window for its app
- `isNormal()` returns `true` if the window is a normal window
- `isFullScreen()` returns `true` if the window is a full screen window
- `isMinimised()` or `isMinimized()` returns `true` if the window is minimised
- `isVisible()` returns `true` if the window is a normal and unminimised window that belongs to an unhidden app
- `app()` returns the app for the window
- `screen()` returns the screen where most or all of the window is currently present
- `spaces()` returns the spaces where the window is currently present (macOS 10.11+, returns an empty list otherwise)
- `topLeft()` returns the top left point for the window
- `size()` returns the size for the window
- `frame()` returns the frame for the window
- `setTopLeft(Point point)` sets the top left point for the window, returns `true` if successful
- `setSize(Size size)` sets the size for the window, returns `true` if successful
- `setFrame(Rectangle frame)` sets the frame for the window, returns `true` if successful
- `setFullScreen(boolean value)` sets whether the window is full screen, returns `true` if successful
- `maximise()` or `maximize()` resizes the window to fit the whole visible frame for the screen, returns `true` if successful
- `minimise()` or `minimize()` minimises the window, returns `true` if successful
- `unminimise()` or `unminimize()` unminimises the window, returns `true` if successful
- `neighbours(String direction)` or `neighbors(...)` returns windows to the direction (`west|east|north|south`) of the window
- `raise()` makes the window the frontmost window of its app (but does not focus the app itself), returns `true` if successful
- `focus()` focuses the window, returns `true` if successful
- `focusClosestNeighbour(String direction)` or `focusClosestNeighbor(...)` focuses the closest window to the direction (`west|east|north|south`) of the window, returns `true` if successful
- `close()` closes the window, returns `true` if successful

### Others Optionals

- `visible` (boolean): if set `true` returns visible windows, if set `false` returns hidden windows
- `screen` (Screen): returns all other windows on the specified screen

## Example

```javascript
// Return all windows across all screens
const windows = Window.all();

// Move the focused window to origo
Window.focused().setTopLeft({ x: 0, y: 0 });

// Resize the focused window
Window.focused().setSize({ width: 1000, height: 500 });

// Resize the focused window to fill the full screen
Window.focused().maximise();
```
