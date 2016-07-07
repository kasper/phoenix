JavaScript API
==============

This documentation is an overview of the JavaScript API provided by Phoenix. Use this as a guide for writing your window management script. Your script should reside in `~/.phoenix.js`. Alternatively — if you prefer — you may also have your script in `~/Library/Application Support/Phoenix/phoenix.js` or `~/.config/phoenix/phoenix.js`. Phoenix includes [Underscore.js](http://underscorejs.org) (1.8.3) — you can use its features in your configuration. Underscore provides useful helpers for handling JavaScript functions and objects. You may also use JavaScript [preprocessing](#preprocessing) and languages such as CoffeeScript to write your Phoenix-configuration.

## API

1. [Keys](#1-keys)
2. [Events](#2-events)
3. [Preferences](#3-preferences)
4. [Require](#4-require)
5. [Phoenix](#5-phoenix)
6. [Storage](#6-storage)
7. [Point](#7-point)
8. [Size](#8-size)
9. [Rectangle](#9-rectangle)
10. [Identifiable](#10-identifiable)
11. [Iterable](#11-iterable)
12. [Key](#12-key)
13. [Event](#13-event)
14. [Timer](#14-timer)
15. [Task](#15-task)
16. [Modal](#16-modal)
17. [Screen](#17-screen)
18. [Space](#18-space)
19. [Mouse](#19-mouse)
20. [App](#20-app)
21. [Window](#21-window)

## Getting Started

This documentation uses *pseudocode* to outline the API. Many of the classes represent global objects in the script’s context — functions that are marked as static can be accessed through these global objects. All other functions are instance functions. Instance objects can be accessed through the global objects or constructed with relevant constructors.

For example, to bind a key to a function, you construct a `Key`-object. Notice that *you must keep a reference to the handler*, otherwise your callback will not get called.

```javascript
var handler = new Key('q', [ 'ctrl', 'shift' ], function () {});
```

To move the focused window to a new coordinate, you can call the `setTopLeft`-function for a `Window`-instance. To get a `Window`-instance, you can for example get the focused window with the `focusedWindow`-function for the global `Window`-object.

```javascript
Window.focusedWindow().setTopLeft({ x: 0, y: 0 });
```

To combine, bind a key to move the focused window.

```javascript
var handler = new Key('q', [ 'ctrl', 'shift' ], function () {
  Window.focusedWindow().setTopLeft({ x: 0, y: 0 });
});
```

As an other example, to bind an event to a function, you construct an `Event`-object. Again notice that *you must keep a reference to the handler*, otherwise your callback will not get called.

```javascript
var handler = new Event('screensDidChange', function () {});
```

## Managing Handlers

As you probably have already noticed that you must keep a reference to your handlers, otherwise your callbacks will not get called. In return, if you release the reference to the handler, it will also be disabled eventually. This gives you full control over the lifecycle of your handlers. This can be especially useful when you want to dynamically create handlers.

Obviously, in most cases you do not want to worry about the lifecycle of your handlers. This is why Phoenix also provides managed handlers that are held for you. You can use these managed handlers to set keys, events, timers and tasks, but also to disable them. Basically, when you create a managed handler, the handler is constructed and its reference is stored. You will get an identifier for the handler which you can use then to disable it. When you disable the handler, Phoenix will take care of releasing it for you.

For example, to bind a key to a function.

```javascript
Key.on('q', [ 'ctrl', 'shift' ], function () {});
```

You can disable the handler with its identifier.

```javascript
var identifier = Key.on('q', [ 'ctrl', 'shift' ], function () {});
Key.off(identifier);
```

## Loading

Your configuration file is loaded when the app launches. All functions are evaluated (and executed if necessary) when this happens. Phoenix also reloads the configuration when any changes are detected to the file(s). You may also reload the configuration manually from the status bar or programmatically from your script.

The following locations are valid configuration paths and the first existing file will be used. You may also use these paths for the debug-configuration (`-debug.js`). Whilst loading, all symlinks will be resolved, so in the end your configuration can also be a symlink to any desired destination.

1. `~/.phoenix.js`
2. `~/Library/Application Support/Phoenix/phoenix.js`
3. `~/.config/phoenix/phoenix.js`

## Preprocessing

You may add JavaScript preprocessing to your configuration by adding a [Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))-directive to the beginning of your file. It must be the first statement in your file. Phoenix should support all popular JavaScript compilers, but be aware that you need to have the compiler installed on your setup and accessible through your shell’s `PATH` for Phoenix to find it. You also need to ask the compiler to output to the standard output so Phoenix is able to evaluate the result. For example, use [CoffeeScript](http://coffeescript.org) to write your configuration:

```coffeescript
#!/usr/bin/env coffee -p

Key.on 's', [ 'ctrl', 'shift' ], ->
  App.launch('Safari').focus()
```

Or use [Babel](http://babeljs.io) to use ECMAScript 6 JavaScript:

```javascript
#!/usr/bin/env babel

Key.on('s', [ 'ctrl', 'shift' ], () => {
  App.launch('Safari').focus();
});
```

## 1. Keys

All valid keys for binding are as follows:

- Modifiers: `cmd`, `alt`, `ctrl` and `shift` (case insensitive)
- Keys: case insensitive character or case sensitive special key including function keys, arrow keys, keypad keys etc. as listed below
- You can bind any key on your local keyboard layout, for instance an `å`-character if your keyboard has one
- If you use multiple keyboard layouts, Phoenix will use the active layout when the context is loaded

### Special Keys

- Action: `return`, `tab`, `space`, `delete`, `escape`, `help`, `home`, `pageUp`, `forwardDelete`, `end`, `pageDown`, `left`, `right`, `down` and `up`
- Function: `f1` – `f19`
- Keypad: `keypad.`, `keypad*`, `keypad+`, `keypadClear`, `keypad/`, `keypadEnter`, `keypad-`, `keypad=`, `keypad0`, `keypad1`, `keypad2`, `keypad3`, `keypad4`, `keypad5`, `keypad6`, `keypad7`, `keypad8` and `keypad9`

## 2. Events

Phoenix supports the following (case sensitive) events:

### Phoenix

- `start` triggered once when Phoenix has started and the context is ready

### Screen

- `screensDidChange` triggered when screens (i.e. displays) are added, removed, or dynamically reconfigured

### Space

- `spaceDidChange` triggered when the active space has changed

### Mouse

- `mouseDidMove` triggered when the mouse has moved
- `mouseDidLeftClick` triggered when the mouse did left click
- `mouseDidRightClick` triggered when the mouse did right click

### App

All of the following app events receive the corresponding `App`-instance as the first argument for the callback function.

- `appDidLaunch` triggered when an app has launched
- `appDidTerminate` triggered when an app has terminated
- `appDidActivate` triggered when an app has activated
- `appDidHide` triggered when an app becomes hidden
- `appDidShow` triggered when an app is shown (becomes unhidden)

### Window

All of the following window events receive the corresponding `Window`-instance as the first argument for the callback function.

- `windowDidOpen` triggered when a window has opened
- `windowDidClose` triggered when a window has closed
- `windowDidFocus` triggered when a window was focused within an app
- `windowDidMove` triggered when a window has moved
- `windowDidResize` triggered when a window has resized
- `windowDidMinimize` triggered when a window has minimised
- `windowDidUnminimize` triggered when a window has unminimised

## 3. Preferences

Phoenix supports the following (case sensitive) preferences:

- `daemon` (boolean): if set `true` Phoenix will run completely in the background, this also removes the status bar menu, defaults to `false`
- `openAtLogin` (boolean): if set `true` Phoenix will automatically open at login, defaults to `false`

Set the preferences using the `Phoenix`-object — for example:

```javascript
Phoenix.set({
  daemon: true,
  openAtLogin: true
});
```

## 4. Require

You can modularise your configuration using the `require`-function. It will load the referenced JavaScript-file and reload it if any changes are detected. If the path is relative, it is resolved relatively to the absolute location of the `.phoenix.js`-file. If this file is a symlink, it will be resolved before resolving the location of the required file. If the file does not exist, `require` will throw an error.

```javascript
require('path/to/file.js');
```

## 5. Phoenix

Use the `Phoenix`-object for API-level tasks.

```java
class Phoenix

  static void reload()
  static void set(Map<String, AnyObject> preferences)
  static void log(String message)
  static void notify(String message)

end
```

- `reload()` manually reloads the context and any changes in the configuration files
- `set(Map<String, AnyObject> preferences)` sets the preferences from the given key–value map, any previously set preferences with the same key will be overridden
- `log(String message)` logs the message to the Console
- `notify(String message)` delivers the message to the Notification Center

## 6. Storage

Use the `Storage`-object to store values accross reloads and reboots as JSON.

```java
class Storage

  static void set(String key, AnyObject value)
  static AnyObject get(String key)
  static void remove(String key)

end
```

- `set(String key, AnyObject value)` stores the value for the key, any previously set value with the same key will be overridden
- `get(String key)` retrieves and returns the value for the key (`undefined` if no value has been set)
- `remove(String key)` removes the key and the value associated with it

## 7. Point

A simple point object for 2D-coordinates.

```java
class Point

  property double x
  property double y

end
```

## 8. Size

A simple 2D-size object.

```java
class Size

  property double width
  property double height

end
```

## 9. Rectangle

A 2D-rectangle representation of a `Point` and `Size`.

```java
class Rectangle

  property double x
  property double y
  property double width
  property double height

end
```

## 10. Identifiable

Objects that implement `Identifiable` can be identified and compared.

```java
interface Identifiable

  int hash()
  boolean isEqual(AnyObject object)

end
```

- `hash()` returns the hash value for the object
- `isEqual(AnyObject object)` returns `true` if the given object is equal with this object

## 11. Iterable

Objects that implement `Iterable` can be traversed.

```java
interface Iterable

  Object next()
  Object previous()

end
```

- `next()` returns the next object or the first object when on the last one
- `previous()` returns the previous object or the last object when on the first one

## 12. Key

Use the `Key`-object to enable or disable keys. You can have multiple handlers for a single key combination, however only one can be enabled at a time. A key is disabled automatically when you release your reference to the handler. Keys are always reset on context reload. Enabling a key combination that has been exclusively registered by another app will fail.

```java
class Key implements Identifiable

  static int on(String key, Array<String> modifiers, Function callback)
  static void off(int identifier)

  property String key
  property Array<String> modifiers

  constructor Key Key(String key, Array<String> modifiers, Function callback)
  boolean isEnabled()
  boolean enable()
  boolean disable()

end
```

- `on(String key, Array<String> modifiers, Function callback)` constructs a managed handler for a key and returns the identifier for the handler, for arguments see `new Key(...)`
- `off(int identifier)` disables the managed handler for a key with the given identifier
- `key` read-only property for the key character in lower case or case sensitive special key
- `modifiers` read-only property for the key modifiers in lower case
- `new Key(String key, Array<String> modifiers, Function callback)` constructs and binds the key character with the specified modifiers (can be an empty list) to a callback function and returns the handler (`undefined` if not supported), you must keep a reference to the handler in order for your callback to get called, you can have multiple handlers for a single key combination, however only one can be enabled at a time, any previous handler for the same key combination will automatically be disabled, the callback function receives its handler as the only argument
- `isEnabled()` returns `true` if the key handler is enabled, by default `true`
- `enable()` enables the key handler, any previous handler for the same key combination will automatically be disabled, returns `true` if successful
- `disable()` disables the key handler, returns `true` if successful

## 13. Event

Use the `Event`-object to access event properties. You can have multiple handlers for a single event. To disable an event, release your reference to the handler. Events are always reset on context reload.

```java
class Event implements Identifiable

  static int on(String event, Function callback)
  static void off(int identifier)

  property String name

  constructor Event Event(String event, Function callback)
  void disable()

end
```

- `on(String event, Function callback)` constructs a managed handler for an event and returns the identifier for the handler, for arguments see `new Event(...)`
- `off(int identifier)` disables the managed handler for an event with the given identifier
- `name` read-only property for the event name
- `new Event(String event, Function callback)` constructs and binds an event to a callback function and returns the handler (`undefined` if not supported), you must keep a reference to the handler in order for your callback to get called, you can have multiple handlers for a single event, the callback function receives its handler as the last argument, for any additional arguments see [events](#2-events)
- `disable()` disables the event handler

## 14. Timer

Use the `Timer`-object to control timers. A timer can fire only once or be repeating. To release a timer, release your reference to the handler. Timers are always reset on context reload.

```java
class Timer implements Identifiable

  static int after(double interval, Function callback)
  static int every(double interval, Function callback)
  static void off(int identifier)

  constructor Timer Timer(double interval, boolean repeats, Function callback)
  void stop()

end
```

- `after(double interval, Function callback)` constructs a managed handler for a timer that fires only once and returns the identifier for the handler, for arguments see `new Timer(...)`
- `every(double interval, Function callback)` constructs a managed handler for a timer that fires repeatedly and returns the identifier for the handler, for arguments see `new Timer(...)`
- `off(int identifier)` disables the managed handler for a timer with the given identifier
- `new Timer(double interval, boolean repeats, Function callback)` constructs a timer that fires the callback once or repeatedly until stopped with the given interval (in seconds) and returns the handler, you must keep a reference to the handler in order for your callback to get called, the callback function receives its handler as the only argument
- `stop()` stops the timer immediately

## 15. Task

Use the `Task`-object to access task properties. To terminate a task, release your reference to the handler. Tasks are always reset on context reload. Beware that some task properties are only set after the task has completed.

```java
class Task implements Identifiable

  static int run(String path, Array arguments, Function callback)
  static void terminate(int identifier)

  property int status
  property String output
  property String error

  constructor Task Task(String path, Array arguments, Function callback)
  void terminate()

end
```

- `run(String path, Array arguments, Function callback)` constructs a managed handler for a task and returns the identifier for the handler, for arguments see `new Task(...)`
- `terminate(int identifier)` terminates the managed handler for a task with the given identifier
- `status` read-only property for the termination status
- `output` read-only property for the standard output
- `error` read-only property for the standard error
- `new Task(String path, Array arguments, Function callback)` constructs a task that asynchronously executes an absolute path with the given arguments and returns the handler, you must keep a reference to the handler in order for your callback to get called, the callback function receives its handler as the only argument
- `terminate()` terminates the task immediately

## 16. Modal

Use the `Modal`-object to display messages as modal windows.

```java
class Modal implements Identifiable

  property Point origin
  property double duration
  property String message

  constructor Modal Modal()
  Rectangle frame()
  void show()
  void close()

end
```

- `origin` property for the origin for the modal, the enclosed properties are read-only so you must pass an object for this property, by default `(0, 0)`
- `duration` property for the duration (in seconds) for the modal, if the duration is set to `0` the modal will remain open until closed, by default `0`
- `message` property for the message for the modal, required for the modal to be displayed
- `new Modal()` constructs and returns a new modal
- `frame()` returns the frame for the modal, the frame is adjusted for the current message, therefor you must first set the message to get an accurate frame
- `show()` shows the modal
- `close()` closes the modal

## 17. Screen

Use the `Screen`-object to access frame sizes and other screens on a multi-screen setup. Get the current screen for a window through the `Window`-object. Beware that a screen can get stale if you keep a reference to it and it is for instance disconnected while you do so.

```java
class Screen implements Identifiable, Iterable

  static Screen mainScreen()
  static Array<Screen> screens()

  String identifier()
  Rectangle frameInRectangle()
  Rectangle visibleFrameInRectangle()
  Array<Space> spaces() // OS X 10.11+
  Array<Window> windows()
  Array<Window> visibleWindows()

end
```

- `mainScreen()` returns the screen containing the window with the keyboard focus
- `screens()` returns all screens, the first screen in this array corresponds to the primary screen for the system
- `identifier()` returns the UUID for the screen
- `frameInRectangle()` returns the whole frame for the screen
- `visibleFrameInRectangle()` returns the visible frame for the screen subtracting the Dock and Menu from the frame when visible
- `spaces()` returns all spaces for the screen (OS X 10.11+, returns an empty list otherwise)
- `windows()` returns all windows for the screen
- `visibleWindows()` returns all visible windows for the screen

## 18. Space

Use the `Space`-object to control spaces. *These features are only supported on El Capitan (10.11) and upwards.* A single window can be in multiple spaces at the same time. To move a window to a different space, remove it from any existing spaces and add it to a new one. You can switch to a space by focusing on a window in that space. Beware that a space can get stale if you keep a reference to it and it is for instance closed while you do so.

```java
class Space implements Identifiable, Iterable

  static Space activeSpace() // OS X 10.11+
  static Array<Space> spaces() // OS X 10.11+

  boolean isNormal()
  boolean isFullScreen()
  Screen screen()
  Array<Window> windows()
  Array<Window> visibleWindows()
  void addWindows(Array<Window> windows)
  void removeWindows(Array<Window> windows)

end
```

- `activeSpace()` returns the space containing the window with the keyboard focus (OS X 10.11+, returns `undefined` otherwise)
- `spaces()` returns all spaces, the first space in this array corresponds to the primary space (OS X 10.11+, returns an empty list otherwise)
- `isNormal()` returns `true` if the space is a normal space
- `isFullScreen()` returns `true` if the space is a full screen space
- `screen()` returns the screen to which the space belongs to
- `windows()` returns all windows for the space
- `visibleWindows()` returns all visible windows for the space
- `addWindows(Array<Window> windows)` adds the given windows to the space
- `removeWindows(Array<Window> windows)` removes the given windows from the space

## 19. Mouse

Use the `Mouse`-object to control the cursor.

```java
class Mouse

  static Point location()
  static boolean moveTo(Point point)

end
```

- `location()` returns the cursor position
- `moveTo(Point point)` moves the cursor to a given position, returns `true` if successful

## 20. App

Use the `App`-object to control apps. Beware that an app can get stale if you keep a reference to it and it is for instance terminated while you do so, see `isTerminated()`.

```java
class App implements Identifiable

  static App get(String appName)
  static App launch(String appName)
  static App focusedApp()
  static Array<App> runningApps()

  int processIdentifier()
  String bundleIdentifier()
  String name()
  boolean isActive()
  boolean isHidden()
  boolean isTerminated()
  Window mainWindow()
  Array<Window> windows()
  Array<Window> visibleWindows()
  boolean activate()
  boolean focus()
  boolean show()
  boolean hide()
  boolean terminate()
  boolean forceTerminate()

end
```

- `get(String appName)` returns the running app with the given name, returns `undefined` if the app is not currently running
- `launch(String appName)` launches to the background and returns the app with the given name, returns `undefined` if unsuccessful
- `focusedApp()` returns the focused app
- `runningApps()` returns all running apps
- `processIdentifier()` returns the process identifier (PID) for the app, returns `-1` if the app does not have a PID
- `bundleIdentifier()` returns the bundle identifier for the app
- `name()` returns the name for the app
- `isActive()` returns `true` if the app is currently frontmost
- `isHidden()` returns `true` if the app is hidden
- `isTerminated()` returns `true` if the app has been terminated
- `mainWindow()` returns the main window for the app
- `windows()` returns all windows for the app
- `visibleWindows()` returns all visible windows for the app
- `activate()` activates the app and brings its windows forward, returns `true` if successful
- `focus()` activates the app and brings its windows to focus, returns `true` if successful
- `show()` shows the app, returns `true` if successful
- `hide()` hides the app, returns `true` if successful
- `terminate()` terminates the app, returns `true` if successful
- `forceTerminate()` force terminates the app, returns `true` if successful

## 21. Window

Use the `Window`-object to control windows. Every screen (i.e. display) combines to form a large rectangle. Every window lives within this rectangle and their position can be altered by giving coordinates inside this rectangle. To position a window to a specific display, you need to calculate its position within the large rectangle. To figure out the coordinates for a given screen, use the functions in `Screen`. Beware that a window can get stale if you keep a reference to it and it is for instance closed while you do so.

```java
class Window implements Identifiable

  static Window focusedWindow()
  static Array<Window> windows()
  static Array<Window> visibleWindows()
  static Array<Window> visibleWindowsInOrder()

  Array<Window> otherWindowsOnSameScreen()
  Array<Window> otherWindowsOnAllScreens()
  String title()
  boolean isMain()
  boolean isNormal()
  boolean isFullScreen()
  boolean isMinimized()
  boolean isVisible()
  App app()
  Screen screen()
  Array<Space> spaces() // OS X 10.11+
  Point topLeft()
  Size size()
  Rectangle frame()
  boolean setTopLeft(Point point)
  boolean setSize(Size size)
  boolean setFrame(Rectangle frame)
  boolean setFullScreen(boolean value)
  boolean maximize()
  boolean minimize()
  boolean unminimize()
  Array<Window> windowsToWest()
  Array<Window> windowsToEast()
  Array<Window> windowsToNorth()
  Array<Window> windowsToSouth()
  boolean focus()
  boolean focusClosestWindowInWest()
  boolean focusClosestWindowInEast()
  boolean focusClosestWindowInNorth()
  boolean focusClosestWindowInSouth()

end
```

- `focusedWindow()` returns the focused window for the currently active app, can be `undefined` if no window is focused currently
- `windows()` returns all windows in screens
- `visibleWindows()` returns all visible windows in screens
- `visibleWindowsInOrder()` returns all visible windows in the order as they appear on the screen (from front to back), essentially returning them in the most-recently-used order
- `otherWindowsOnSameScreen()` returns all other windows on the same screen as the window
- `otherWindowsOnAllScreens()` returns all other windows on all screens
- `title()` returns the title for the window
- `isMain()` returns `true` if the window is the main window for its app
- `isNormal()` returns `true` if the window is a normal window
- `isFullScreen()` returns `true` if the window is a full screen window
- `isMinimized()` returns `true` if the window is minimised
- `isVisible()` returns `true` if the window is a normal and unminimised window that belongs to an unhidden app
- `app()` returns the app for the window
- `screen()` returns the screen where most or all of the window is currently present
- `spaces()` returns the spaces where the window is currently present (OS X 10.11+, returns an empty list otherwise)
- `topLeft()` returns the top left point for the window
- `size()` returns the size for the window
- `frame()` returns the frame for the window
- `setTopLeft(Point point)` sets the top left point for the window, returns `true` if successful
- `setSize(Size size)` sets the size for the window, returns `true` if successful
- `setFrame(Rectangle frame)` sets the frame for the window, returns `true` if successful
- `setFullScreen(boolean value)` sets whether the window is full screen, returns `true` if successful
- `maximize()` resizes the window to fit the whole visible frame for the screen, returns `true` if successful
- `minimize()` minimises the window, returns `true` if successful
- `unminimize()` unminimises the window, returns `true` if successful
- `windowsToWest()` returns windows to the west of the window
- `windowsToEast()` returns windows to the east of the window
- `windowsToNorth()` returns windows to the north the window
- `windowsToSouth()` returns windows to the south the window
- `focus()` focuses the window, returns `true` if successful
- `focusClosestWindowInWest()` focuses the closest window to the west of the window, returns `true` if successful
- `focusClosestWindowInEast()` focuses the closest window to the east of the window, returns `true` if successful
- `focusClosestWindowInNorth()` focuses the closest window to the north of the window, returns `true` if successful
- `focusClosestWindowInSouth()` focuses the closest window to the south of the window, returns `true` if successful
