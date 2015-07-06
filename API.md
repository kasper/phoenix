JavaScript API
==============

This documentation is an overview of the JavaScript API provided by Phoenix. Use this as a guide for writing your window management script. Your script should reside in `~/.phoenix.js`. Phoenix includes [Underscore.js](http://underscorejs.org) (1.5.2) — you can use its features in your configuration. Underscore provides useful helpers for handling JavaScript functions and objects.

## Getting Started

This documentation uses *pseudocode* to outline the API. Many of the classes represent global objects in the script’s context — functions that are marked as static can be accessed through these global objects. All other functions are instance functions. Instance objects can be accessed through the global objects.

For example, to bind a key to a function, you call the `bind`-function for the `api`-object.

```javascript
api.bind('q', [ 'ctrl', 'shift' ], function () {});
```

To move the focused window to a new coordinate, you can call the `setTopLeft`-function for a `Window`-instance. To get a `Window`-instance, you can for example get the focused window with the `focusedWindow`-function for the global `Window`-object.

```javascript
Window.focusedWindow().setTopLeft({ x: 0, y: 0 });
```

To combine, bind the hot key to move the focused window.

```javascript
api.bind('q', [ 'ctrl', 'shift' ], function () {

    Window.focusedWindow().setTopLeft({ x: 0, y: 0 }); 
});
```

## Valid Keys

All valid keys for binding hot keys are as follows:

- Modifiers: `cmd`, `alt`, `ctrl` and `shift` (case insensitive)
- Keys: case insensitive character or special key including function keys, numpad, arrow keys, etc. as [listed](https://github.com/kasper/phoenix/blob/master/Phoenix/PHHotKey.m#L75-L131)

## Require

You can modularise your configuration using the `require`-function. It will load the referenced JavaScript-file and reload it if any changes are detected. If the path is relative, it is resolved relatively to the absolute location of the `.phoenix.js`-file. If this file is a symlink, it will be resolved before resolving the location of the required file.

```javascript
require('path/to/file.js');
```

## API

Use the `api`-object for general tasks. 

```java
class api
    static void reload(String path)
    static void launch(String appName)
    static void alert(String message, double durationInSeconds)
    static void cancelAlerts()
    static void log(String message)
    static Hotkey bind(String key, Array<String> modifiers, Function callback)
    static void runCommand(String commandPath, Array arguments)
    static void setTint(Array<double> red, Array<double> green, Array<double> blue)
end
```

## Window

Use the `Window`-object to control windows.

```java
class Window
    static Array<Window> allWindows()
    static Array<Window> visibleWindows()
    static Window focusedWindow()
    static Array<Window> visibleWindowsMostRecentFirst()
    Array<Window> otherWindowsOnSameScreen()
    Array<Window> otherWindowsOnAllScreens()
```

Every screen (i.e. display) combines to form a large rectangle. Every window lives within this rectangle and their position can be altered by giving coordinates inside this rectangle. To position a window to a specific display, you need to calculate its position within the large rectangle. To figure out the coordinates for a given screen, use the functions in `Screen`.

```java
    Rect frame()
    Point topLeft()
    Size size()
    void setFrame(Rect frame)
    void setTopLeft(Point point)
    void setSize(Size size)
    void maximize()
    void minimize()
    void unMinimize()
    Screen screen()
    App app()
    boolean isNormalWindow()
    boolean focusWindow()
    void focusWindowLeft()
    void focusWindowRight()
    void focusWindowUp()
    void focusWindowDown()
    Array<Window> windowsToWest()
    Array<Window> windowsToEast()
    Array<Window> windowsToNorth()
    Array<Window> windowsToSouth()
    String title()
    boolean isWindowMinimized()
end
```

## App

Use the `App`-object to control apps.

```java
class App
    static Array<App> runningApps()
    Array<Window> allWindows()
    Array<Window> visibleWindows()
    String title()
    String bundleIdentifier()
    boolean isHidden()
    void show()
    void hide()
    void activate()
    int pid()
    void kill()
    void kill9()
end
```

## Screen

Use the `Screen`-object to access frame sizes and other screens on a multi-screen setup. Get the current screen for a window through the `Window`-object.

```java
class Screen
    Rect frameIncludingDockAndMenu()
    Rect frameWithoutDockOrMenu()
    Screen nextScreen()
    Screen previousScreen()
end
```

## HotKey

Use the `HotKey`-object to enable or disable hot keys.

```java
class Hotkey
    String key()
    Array<String> mods()
    boolean enable()
    void disable()
end
```

## Mouse Position

Use the `MousePosition`-object to capture and restore the mouse position to and from a given `Point`.

```java
class MousePosition
    static Point capture()
    static void restore(Point point)
end
```

## Point

A simple point object for 2D-coordinates.

```java
class Point
    property double x
    property double y
end
```

## Size

A simple 2D-size object.

```java
class Size
    property double width
    property double height
end
```

## Rectangle

A 2D-rectangle representation of a `Point` and `Size`.

```java
class Rect
    property double x
    property double y
    property double width
    property double height
end
```
