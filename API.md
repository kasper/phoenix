JavaScript API
==============

This documentation is an overview of the JavaScript API provided by Phoenix. Use this as a guide for writing your window management script. Your script should reside in `~/.phoenix.js`. Phoenix includes [Underscore.js](http://underscorejs.org) (1.8.3) — you can use its features in your configuration. Underscore provides useful helpers for handling JavaScript functions and objects.

## API

1. [Keys](#1-keys)
2. [Events](#2-events)
3. [Require](#3-require)
4. [Phoenix](#4-phoenix)
5. [Point](#5-point)
6. [Size](#6-size)
7. [Rectangle](#7-rectangle)
8. [Identifiable](#8-identifiable)
9. [KeyHandler](#9-keyhandler)
10. [EventHandler](#10-eventhandler)
11. [Modal](#11-modal)
12. [Command](#12-command)
13. [Screen](#13-screen)
14. [Mouse](#14-mouse)
15. [App](#15-app)
16. [Window](#16-window)

## Getting Started

This documentation uses *pseudocode* to outline the API. Many of the classes represent global objects in the script’s context — functions that are marked as static can be accessed through these global objects. All other functions are instance functions. Instance objects can be accessed through the global objects.

For example, to bind a key to a function, you call the `bind`-function for the `Phoenix`-object. Notice that *you must keep a reference to the handler*, otherwise your callback will not get called.

```javascript
var handler = Phoenix.bind('q', [ 'ctrl', 'shift' ], function () {});
```

To move the focused window to a new coordinate, you can call the `setTopLeft`-function for a `Window`-instance. To get a `Window`-instance, you can for example get the focused window with the `focusedWindow`-function for the global `Window`-object.

```javascript
Window.focusedWindow().setTopLeft({ x: 0, y: 0 });
```

To combine, bind a key to move the focused window.

```javascript
var handler = Phoenix.bind('q', [ 'ctrl', 'shift' ], function () {

    Window.focusedWindow().setTopLeft({ x: 0, y: 0 });
});
```

As an other example, to bind an event to a function, you call the `on`-function for the `Phoenix`-object. Notice that *you must keep a reference to the handler*, otherwise your callback will not get called.

```javascript
var handler = Phoenix.on('screensDidChange', function () {});
```

## Loading

Your configuration file is loaded when the app launches. All functions are evaluated (and executed if necessary) when this happens. Phoenix also reloads the configuration when any changes are detected to the file. You may also reload the configuration manually from the status bar or programmatically from your script.

## 1. Keys

All valid keys for binding are as follows:

- Modifiers: `cmd`, `alt`, `ctrl` and `shift` (case insensitive)
- Keys: case insensitive character or case sensitive special key including function keys, arrow keys, keypad keys etc. as listed below
- You can bind any key on your local keyboard layout, for instance an `å`-character if your keyboard has one

### Special Keys

- Action: `return`, `tab`, `space`, `delete`, `escape`, `help`, `home`, `pageUp`, `forwardDelete`, `end`, `pageDown`, `left`, `right`, `down` and `up`
- Function: `f1` – `f19`
- Keypad: `keypad.`, `keypad*`, `keypad+`, `keypadClear`, `keypad/`, `keypadEnter`, `keypad-`, `keypad=`, `keypad0`, `keypad1`, `keypad2`, `keypad3`, `keypad4`, `keypad5`, `keypad6`, `keypad7`, `keypad8` and `keypad9`

## 2. Events

Phoenix supports the following (case sensitive) events:

### Phoenix

- `start` triggered once when Phoenix has started and the context is ready, the callback function receives no arguments

### Screen

- `screensDidChange` triggered when screens (i.e. displays) are added, removed, or dynamically reconfigured, the callback function receives no arguments

### App

All of the following app events receive the corresponding `App`-instance as the only argument for the callback function.

- `appDidLaunch` triggered when an app has launched
- `appDidTerminate` triggered when an app has terminated
- `appDidActivate` triggered when an app has activated
- `appDidHide` triggered when an app becomes hidden
- `appDidShow` triggered when an app is shown (becomes unhidden)

### Window

All of the following window events receive the corresponding `Window`-instance as the only argument for the callback function.

- `windowDidOpen` triggered when a window has opened
- `windowDidClose` triggered when a window has closed
- `windowDidFocus` triggered when a window was focused within an app
- `windowDidMove` triggered when a window has moved
- `windowDidResize` triggered when a window has resized
- `windowDidMinimize` triggered when a window has minimised
- `windowDidUnminimize` triggered when a window has unminimised

## 3. Require

You can modularise your configuration using the `require`-function. It will load the referenced JavaScript-file and reload it if any changes are detected. If the path is relative, it is resolved relatively to the absolute location of the `.phoenix.js`-file. If this file is a symlink, it will be resolved before resolving the location of the required file.

```javascript
require('path/to/file.js');
```

## 4. Phoenix

Use the `Phoenix`-object for API-level tasks.

```java
class Phoenix

    static void reload()
    static KeyHandler bind(String key, Array<String> modifiers, Function callback)
    static EventHandler on(String event, Function callback)
    static void log(String message)
    static void notify(String message)

end
```

- `reload()` manually reloads the context and any changes in the configuration files
- `bind(String key, Array<String> modifiers, Function callback)` binds the key character with the specified modifiers (can be an empty list) to a callback function and returns the handler (`undefined` if not supported), you must keep a reference to the handler in order for your callback to get called, the callback function receives no arguments, binding overrides any previous handlers for the same key combination
- `on(String event, Function callback)` binds an event to a callback function and returns the handler (`undefined` if not supported), you must keep a reference to the handler in order for your callback to get called, you can have multiple handlers for a single event
- `log(String message)` logs the message to the Console
- `notify(String message)` delivers the message to the Notification Center

## 5. Point

A simple point object for 2D-coordinates.

```java
class Point

    property double x
    property double y

end
```

## 6. Size

A simple 2D-size object.

```java
class Size

    property double width
    property double height

end
```

## 7. Rectangle

A 2D-rectangle representation of a `Point` and `Size`.

```java
class Rectangle

    property double x
    property double y
    property double width
    property double height

end
```

## 8. Identifiable

Objects that implement `Identifiable` can be identified and compared.

```java
interface Identifiable

    int hash()
    boolean isEqual(AnyObject object)

end
```

- `hash()` returns the hash value for the object
- `isEqual(AnyObject object)` returns `true` if the object is equal to this object

## 9. KeyHandler

Use the `KeyHandler`-object to enable or disable keys. To change a previous handler, bind the key again. A key is disabled automatically when you release your reference to the handler. KeyHandlers are always reset on context reload. Enabling a key combination that has been exclusively registered by another app will fail.

```java
class KeyHandler implements Identifiable

    property String key
    property Array<String> modifiers

    boolean isEnabled()
    boolean enable()
    boolean disable()

end
```

- `key` read-only property for the key character in lower case or case sensitive special key
- `modifiers` read-only property for the key modifiers in lower case
- `isEnabled()` returns `true` if the key handler is enabled, by default `true`
- `enable()` enables the key handler, returns `true` if successful
- `disable()` disables the key handler, returns `true` if successful

## 10. EventHandler

Use the `EventHandler`-object to access event properties. You can have multiple handlers for a single event. To disable an event, release your reference to the handler. EventHandlers are always reset on context reload.

```java
class EventHandler implements Identifiable

    property String name

end
```

- `name` read-only property for the event name

## 11. Modal

Use the `Modal`-object to display messages as modal windows.

```java
class Modal

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
- `new Modal()` initialises and returns a new modal
- `frame()` returns the frame for the modal, the frame is adjusted for the current message, therefor you must first set the message to get an accurate frame
- `show()` shows the modal
- `close()` closes the modal

## 12. Command

Use the `Command`-object to run UNIX-commands.

```java
class Command

    static boolean run(String path, Array arguments)

end
```

- `run(String path, Array arguments)` executes a UNIX-command in a absolute path with the passed arguments and waits until completion, returns `true` if the execution was successful

## 13. Screen

Use the `Screen`-object to access frame sizes and other screens on a multi-screen setup. Get the current screen for a window through the `Window`-object. Beware that a screen can get stale if you keep a reference to it and it is for instance disconnected while you do so.

```java
class Screen implements Identifiable

    static Screen mainScreen()
    static Array<Screen> screens()

    Rectangle frameInRectangle()
    Rectangle visibleFrameInRectangle()
    Screen next()
    Screen previous()
    Array<Window> windows()
    Array<Window> visibleWindows()

end
```

- `mainScreen()` returns the screen containing the window with the keyboard focus
- `screens()` returns all screens, the first screen in this array corresponds to the primary screen for the system
- `frameInRectangle()` returns the whole frame for the screen
- `visibleFrameInRectangle()` returns the visible frame for the screen subtracting the Dock and Menu from the frame when visible
- `next()` returns the next screen or the first screen when on the last one
- `previous()` returns the previous screen or the last screen when on the first one
- `windows()` returns all windows for the screen
- `visibleWindows()` returns all visible windows for the screen

## 14. Mouse

Use the `Mouse`-object to control the cursor.

```java
class Mouse

    static Point location()
    static boolean moveTo(Point point)

end
```

- `location()` returns the cursor position
- `moveTo(Point point)` moves the cursor to a given position, returns `true` if successful

## 15. App

Use the `App`-object to control apps. Beware that an app can get stale if you keep a reference to it and it is for instance terminated while you do so, see `isTerminated()`.

```java
class App implements Identifiable

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

- `launch(String appName)` (launches to the background and) returns the app with the given name, returns `undefined` if unsuccessful
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

## 16. Window

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
    boolean isMinimized()
    boolean isVisible()
    App app()
    Screen screen()
    Point topLeft()
    Size size()
    Rectangle frame()
    boolean setTopLeft(Point point)
    boolean setSize(Size size)
    boolean setFrame(Rectangle frame)
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
- `isMinimized()` returns `true` if the window is minimised
- `isVisible()` returns `true` if the window is a normal and unminimised window that belongs to an unhidden app
- `app()` returns the app for the window
- `screen()` returns the screen where most or all of the window is currently present
- `topLeft()` returns the top left point for the window
- `size()` returns the size for the window
- `frame()` returns the frame for the window
- `setTopLeft(Point point)` sets the top left point for the window, returns `true` if successful
- `setSize(Size size)` sets the size for the window, returns `true` if successful
- `setFrame(Rectangle frame)` sets the frame for the window, returns `true` if successful
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
