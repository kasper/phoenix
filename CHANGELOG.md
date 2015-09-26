Changelog
=========

2.0
---

Release: dd.mm.yyyy

### Changes

- Phoenix has been rewritten and refactored from the ground up. This also means that Phoenix now requires OS X Yosemite (10.10) or higher. Xcode 7 is now required for building.
- Supports OS X El Capitan (10.11).
- Underscore.js is upgraded to 1.8.3 (from 1.5.2). This may change existing behaviour related to Underscore.
- Global `api`-object is now called `Phoenix`.
- Global `MousePosition`-object is now called `Mouse`.
- `Hotkey`-object is now called `KeyHandler` and its properties have changed. See the [API](API.md#keyhandler).
- The concept of `Alerts` has been deprecated. A new global `Modal`-object has been created to display messages as modals. See the [API](API.md#modal).
- A new global `Command`-object has been created to run UNIX-commands. See the [API](API.md#command).

### Improvements

- Alerts are now delivered to the Notification Center and logged to the Console for easier debugging.
- Now reloading the context gives no alert unless an error is encountered.
- Objects that implement `Identifiable` can be identified and compared.

### API

#### Phoenix

- New: Function `notify(String message)` delivers the message to the Notification Center.
- Change: Function `launch(String appName)` has moved to the global `App`-object.
- Change: Function `runCommand(String commandPath, Array arguments)` has moved to a new global `Command`-object and is now called `run(String path, Array arguments)`.
- Deprecation: Function `alert(String message, double durationInSeconds)` has been removed, use `Modal` to display messages as modals.
- Deprecation: Function `cancelAlerts()` has been removed, you must keep references to modals yourself to close them.
- Deprecation: Function `setTint(Array<double> red, Array<double> green, Array<double> blue)` has been removed with no replacement.

#### KeyHandler

- New: KeyHandler now implements `Identifiable`.
- Change: *You must now keep a reference to the handler*, otherwise your callback will not get called.
- Change: Special keys are now camelCased instead of underscored and keys for keypad are now prefix with `keypad` instead of `pad`. See changed [keys](API.md#special-keys).

#### Screen

- New: Screen now implements `Identifiable`.
- New: Function `mainScreen()` returns the screen containing the window with the keyboard focus.
- New: Function `screens()` returns all screens.
- Change: For clarity, functions `frameIncludingDockAndMenu()` and `frameWithoutDockOrMenu()` are now `frameInRectangle()` and `visibleFrameInRectangle()`, respectively.
- Change: Functions `nextScreen()` and `previousScreen()` are now simply `next()` and `previous()`.

#### Mouse

- New: Function `moveTo(Point point)` returns a boolean value for determining success.
- Change: Functions `capture()` and `restore(Point point)` are now called `location()` and `moveTo(Point point)`.

#### App

- New: App now implements `Identifiable`.
- New: All actions return a boolean value for determining success.
- New: Function `launch(String appName)` now returns the launched app if successful.
- New: Function `focusedApp()` returns the focused app.
- New: Function `isActive()` returns whether the app is currently frontmost.
- New: Function `isTerminated()` returns whether the app has been terminated.
- New: Function `mainWindow()` returns the main window for the app.
- New: A new function `focus()` focuses the app and its windows.
- Change: Property `pid` is now a function called `processIdentifier()`.
- Change: Function `title()` is now called `name()`.
- Change: Function `allWindows()` is now simply `windows()`.
- Change: Functions `kill()` and `kill9()` are now `terminate()` and `forceTerminate()`, respectively.

#### Window

- New: Window now implements `Identifiable`.
- New: All actions return a boolean value for determining success.
- New: Function `isMain()` returns whether the window is the main window for its app.
- Change: Function `allWindows()` is now simply `windows()`.
- Change: Function `visibleWindowsMostRecentFirst()` is renamed to `visibleWindowsInOrder()` for clarity.
- Change: Function `isNormalWindow()` is now simply `isNormal()`.
- Change: Function `isWindowMinimized()` is now simply `isMinimized()`.
- Change: Function `unMinimize()` is now `unminimize()`.
- Change: Function `focusWindow()` is now `focus()`.
- Change: Alignment functions `windowsToWest(), windowsToEast(), windowsToNorth(), windowsToSouth()` now correctly return windows relative to the window and not relative to the focused window. To achieve the previous behaviour you need chain these with the `focusedWindow()`-accessor. This also affects `focusClosestWindowInWest(), focusClosestWindowInEast(), focusClosestWindowInNorth(), focusClosestWindowInSouth()`-functions.
- Change: Functions `focusWindowLeft(), focusWindowRight(), focusWindowUp(), focusWindowDown()` are now `focusClosestWindowInWest(), focusClosestWindowInEast(), focusClosestWindowInNorth(), focusClosestWindowInSouth()`, respectively.
