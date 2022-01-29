# Events

Phoenix supports the following (case sensitive) events:

## Phoenix

- `didLaunch` triggered once when Phoenix has launched and the context is ready
- `willTerminate` triggered when Phoenix will terminate, use this event to perform any tasks before the application terminates

## Screen

- `screensDidChange` triggered when screens (i.e. displays) are added, removed, or dynamically reconfigured

## Space

- `spaceDidChange` triggered when the active space has changed

## Mouse

All of the following mouse events receive the corresponding `Point`-object as the first argument for the callback function. This object is also enhanced with a `modifiers` array which contains the key modifiers pressed when the mouse event is triggered.

- `mouseDidMove` triggered when the mouse has moved
- `mouseDidLeftClick` triggered when the mouse did left click
- `mouseDidRightClick` triggered when the mouse did right click
- `mouseDidLeftDrag` triggered when the mouse did left drag
- `mouseDidRightDrag` triggered when the mouse did right drag

## App

All of the following app events receive the corresponding `App`-instance as the first argument for the callback function.

- `appDidLaunch` triggered when an app has launched
- `appDidTerminate` triggered when an app has terminated
- `appDidActivate` triggered when an app has activated
- `appDidHide` triggered when an app becomes hidden
- `appDidShow` triggered when an app is shown (becomes unhidden)

## Window

All of the following window events receive the corresponding `Window`-instance as the first argument for the callback function.

- `windowDidOpen` triggered when a window has opened
- `windowDidClose` triggered when a window has closed
- `windowDidFocus` triggered when a window was focused within an app
- `windowDidMove` triggered when a window has moved
- `windowDidResize` triggered when a window has resized
- `windowDidMinimise` or `windowDidMinimize` triggered when a window has minimised
- `windowDidUnminimise` or `windowDidUnminimize` triggered when a window has unminimised
