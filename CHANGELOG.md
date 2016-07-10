Changelog
=========

2.2 (master)
------------

Release: dd.mm.yyyy

### New

- Adds support for mouse events ([#90](https://github.com/kasper/phoenix/issues/90)).
- Phoenix now has a key–value storage that can be used to store values accross reloads and reboots as JSON, see [Storage](https://github.com/kasper/phoenix/blob/2.2/API.md#6-storage) ([#97](https://github.com/kasper/phoenix/issues/97)).
- You can now run tasks asynchronously and retrieve their status, standard output and standard error. A new `Task`-object has been created to access task properties, see its [API](https://github.com/kasper/phoenix/blob/2.2/API.md#15-task) ([#98](https://github.com/kasper/phoenix/issues/98)).
- Keys, events and timers are now constructed with relevant constructors instead of creating them through the global `Phoenix`-object ([#109](https://github.com/kasper/phoenix/issues/109)).
- Add support for British alternatives to API ([#113](https://github.com/kasper/phoenix/issues/113)).

### Changes

- Breaking: Global `Command`-object has been removed, use `Task` instead as a direct replacement ([#98](https://github.com/kasper/phoenix/issues/98)).
- Breaking: You can now have multiple `Key`s for a single key combination. However, only one can be enabled at a time. Previously binding would only change the callback for an existing handler if a previously bound key combination was used again. Now, binding a key combination will always return a new unique handler. As before, this new handler is always enabled by default. Subsequently, any previous handler for the key combination will therefor be automatically disabled ([#99](https://github.com/kasper/phoenix/issues/99)).
- Breaking: Name and stylistic changes to the API ([#108](https://github.com/kasper/phoenix/issues/108)).
- Breaking: `KeyHandler` has been renamed to `Key`, `EventHandler` to `Event` and `TimerHandler` to `Timer` ([#109](https://github.com/kasper/phoenix/issues/109)).
- Debug configuration file suffix has changed from `-debug.js` to `.debug.js`.

### API

#### Events

- New: Event `mouseDidMove` is triggered when the mouse has moved ([#90](https://github.com/kasper/phoenix/issues/90)).
- New: Event `mouseDidLeftClick` is triggered when the mouse did left click ([#90](https://github.com/kasper/phoenix/issues/90)).
- New: Event `mouseDidRightClick` is triggered when the mouse did right click ([#90](https://github.com/kasper/phoenix/issues/90)).

#### Phoenix

- Deprecation: Function `bind(String key, Array<String> modifiers, Function callback)` has been removed, use constructor `new Key(String key, Array<String> modifiers, Function callback)` instead ([#109](https://github.com/kasper/phoenix/issues/109)).
- Deprecation: Function `on(String event, Function callback)` has been removed, use constructor `new Event(String event, Function callback)` instead ([#109](https://github.com/kasper/phoenix/issues/109)).
- Deprecation: Function `after(double interval, Function callback)` has been removed, use constructor `new Timer(double interval, boolean repeats, Function callback)` instead ([#109](https://github.com/kasper/phoenix/issues/109)).
- Deprecation: Function `every(double interval, Function callback)` has been removed, use constructor `new Timer(double interval, boolean repeats, Function callback)` instead ([#109](https://github.com/kasper/phoenix/issues/109)).

#### Key

- Change: Function `enable()` will disable any previous handler for the same key combination automatically ([#99](https://github.com/kasper/phoenix/issues/99)).

#### Event

- New: Function `disable()` disables the event handler.

#### Screen

- Change: Function `mainScreen()` is now simply `main()` ([#108](https://github.com/kasper/phoenix/issues/108)).
- Change: Function `screens()` is now `all()` ([#108](https://github.com/kasper/phoenix/issues/108)).
- Change: Function `windows()` now takes optionals `windows(Map<String, AnyObject> optionals)` ([#108](https://github.com/kasper/phoenix/issues/108)).
- Deprecation: Function `visibleWindows()` has been removed, use `windows({ visible: true })` instead ([#108](https://github.com/kasper/phoenix/issues/108)).

#### Space

- Change: Function `activeSpace()` is now simply `active()` ([#108](https://github.com/kasper/phoenix/issues/108)).
- Change: Function `spaces()` is now `all()` ([#108](https://github.com/kasper/phoenix/issues/108)).
- Change: Function `windows()` now takes optionals `windows(Map<String, AnyObject> optionals)` ([#108](https://github.com/kasper/phoenix/issues/108)).
- Deprecation: Function `visibleWindows()` has been removed, use `windows({ visible: true })` instead ([#108](https://github.com/kasper/phoenix/issues/108)).

#### Mouse

- Change: Function `moveTo()` is now simply `move()` ([#108](https://github.com/kasper/phoenix/issues/108)).

#### App

- Change: Function `focusedApp()` is now simply `focused()` ([#108](https://github.com/kasper/phoenix/issues/108)).
- Change: Function `runningApps()` is now `all()` ([#108](https://github.com/kasper/phoenix/issues/108)).
- Change: Function `windows()` now takes optionals `windows(Map<String, AnyObject> optionals)` ([#108](https://github.com/kasper/phoenix/issues/108)).
- Change: Function `terminate()` now takes optionals `terminate(Map<String, AnyObject> optionals)` ([#108](https://github.com/kasper/phoenix/issues/108)).
- Deprecation: Function `visibleWindows()` has been removed, use `windows({ visible: true })` instead ([#108](https://github.com/kasper/phoenix/issues/108)).
- Deprecation: Function `forceTerminate()` has been removed, use `terminate({ force: true })` instead ([#108](https://github.com/kasper/phoenix/issues/108)).

#### Window

- New: Function `neighbors(String direction)` returns windows to the direction (`west|east|north|south`) of the window ([#108](https://github.com/kasper/phoenix/issues/108)).
- New: Function `focusClosestNeighbor(String direction)` focuses the closest window to the direction (`west|east|north|south`) of the window, returns `true` if successful ([#108](https://github.com/kasper/phoenix/issues/108)).
- Change: Function `focusedWindow()` is now simply `focused()` ([#108](https://github.com/kasper/phoenix/issues/108)).
- Change: Function `windows()` is now `all(Map<String, AnyObject> optionals)` ([#108](https://github.com/kasper/phoenix/issues/108)).
- Change: Function `visibleWindowsInOrder()` is now `recent()` ([#108](https://github.com/kasper/phoenix/issues/108)).
- Change: Function `otherWindowsOnAllScreens()` is now `others(Map<String, AnyObject> optionals)` ([#108](https://github.com/kasper/phoenix/issues/108)).
- Deprecation: Function `visibleWindows()` has been removed, use `all({ visible: true })` instead ([#108](https://github.com/kasper/phoenix/issues/108)).
- Deprecation: Function `otherWindowsOnSameScreen()` has been removed, use `others({ screen: window.screen() })` instead ([#108](https://github.com/kasper/phoenix/issues/108)).
- Deprecation: Functions `windowsToWest()`, `windowsToEast()`, `windowsToNorth()` and `windowsToSouth()` have been removed, use instead `neighbors('west')`, `neighbors('east')`, `neighbors('north')` and `neighbors('south')` respectively ([#108](https://github.com/kasper/phoenix/issues/108)).
- Deprecation: Functions `focusClosestWindowInWest()`, `focusClosestWindowInEast()`, `focusClosestWindowInNorth()` and `focusClosestWindowInSouth()` have been removed, use instead `focusClosestNeighbor('west')`, `focusClosestNeighbor('east')`, `focusClosestNeighbor('north')` and `focusClosestNeighbor('south')` respectively ([#108](https://github.com/kasper/phoenix/issues/108)).

2.1.2
-----

Release: 27.6.2016

### New

- Phoenix can now manage handlers for you. Instead of `Phoenix.bind`, `Phoenix.on`, `Phoenix.after` or `Phoenix.every` — use `Key.on`, `Event.on`, `Timer.after` and `Timer.every`. For more, see the [API](https://github.com/kasper/phoenix/blob/2.1.2/API.md#managing-handlers) ([#107](https://github.com/kasper/phoenix/issues/107)).

### Improvements

- Implement `setTimeout`, `setInterval`, `clearTimeout` and `clearInterval`. This also adds support for timing related functions from Underscore ([#92](https://github.com/kasper/phoenix/issues/92)).
- Make require throw an error if a file cannot be resolved ([#93](https://github.com/kasper/phoenix/issues/93)).
- Add support for ISO section `§`-key ([#102](https://github.com/kasper/phoenix/pull/102)).

### Bug Fixes

- Disable key handlers immediately to ensure that keys are unregistered before setting up a new context ([#94](https://github.com/kasper/phoenix/issues/94)).
- Fix crash caused by moving or deleting configuration directory while app is running ([#105](https://github.com/kasper/phoenix/issues/105)).

2.1.1
-----

Release: 29.4.2016

### Improvements

- Notify when preprocessing failed.

### Bug Fixes

- Fix an issue that prevented preprocessing due to incompatible paths between different shells ([#88](https://github.com/kasper/phoenix/issues/88)).

2.1
---

Release: 25.4.2016

### New

- Phoenix now supports Spaces! *These features are only supported on El Capitan (10.11) and upwards.* A new global `Space`-object has been created to control spaces, see the [API](https://github.com/kasper/phoenix/blob/2.1/API.md#17-space) ([#60](https://github.com/kasper/phoenix/issues/60)).
- Preferences can now be set programmatically through the API ([#67](https://github.com/kasper/phoenix/issues/67)).
- Phoenix can be run completely in the background, this also removes the status bar menu, see the `daemon`-preference in the [API](https://github.com/kasper/phoenix/blob/2.1/API.md#3-preferences) ([#68](https://github.com/kasper/phoenix/issues/68)).
- You can now create timers to achieve delays and timed events. A new `TimerHandler`-object has been created to control timers, see its [API](https://github.com/kasper/phoenix/blob/2.1/API.md#13-timerhandler). See the functions `Phoenix.after(double interval, Function callback)` and `Phoenix.every(double interval, Function callback)` in the [API](https://github.com/kasper/phoenix/blob/2.1/API.md#5-phoenix) to create timers ([#77](https://github.com/kasper/phoenix/issues/77)).

### Changes

- Upgrade Sparkle to 1.14.0. This also fixes the HTTP MITM-vulnerability discovered in Sparkle — though Phoenix was never vulnerable since we use HTTPS to secure updates.

### Improvements

- Adjust latency of context reloads on configuration file changes to limit race conditions ([#83](https://github.com/kasper/phoenix/issues/83)).
- Objects that implement `Iterable` can be traversed. Namely, `Screen` and `Space`.
- All handlers now receive their handlers as the last argument for the callback function.
- Improvements to memory management and other small improvements.

### Bug Fixes

- Improve error handling in preprocessing ([#65](https://github.com/kasper/phoenix/issues/65)).
- Fix an issue that prevented an exception raised in a handler callback to be caught and reported ([#70](https://github.com/kasper/phoenix/issues/70)).
- Fix an issue that prevented setting the frame for a window correctly while moving it to a smaller screen ([#84](https://github.com/kasper/phoenix/issues/84)).

### API

#### Events

- New: Event `spaceDidChange` is triggered when the active space has changed.

#### Phoenix

- New: Function `after(double interval, Function callback)` creates a timer that fires the callback once after the given interval (in seconds) and returns the handler, you must keep a reference to the handler in order for your callback to get called, the callback function receives its handler as the only argument.
- New: Function `every(double interval, Function callback)` creates a timer that fires the callback repeatedly until stopped using the given interval (in seconds) and returns the handler, you must keep a reference to the handler in order for your callback to get called, the callback function receives its handler as the only argument.
- New: Function `set(Map<String, AnyObject> preferences)` sets the preferences from the given key–value map, any previously set preferences with the same key will be overridden.
- Change: The callback for function `bind(String key, Array<String> modifiers, Function callback)` now receives its handler as the only argument, previously the callback received no arguments.
- Change: The callback for function `on(String event, Function callback)` now receives its handler as the last argument.

#### Screen

- New: Function `identifier()` returns the UUID for the screen ([#79](https://github.com/kasper/phoenix/issues/79)).
- New: Function `spaces()` returns all spaces for the screen (OS X 10.11+, returns an empty list otherwise).

#### Window

- New: Function `isFullScreen()` returns `true` if the window is a full screen window ([#60](https://github.com/kasper/phoenix/issues/60), [#80](https://github.com/kasper/phoenix/issues/80)).
- New: Function `spaces()` returns the spaces where the window is currently present (OS X 10.11+, returns an empty list otherwise).
- New: Function `setFullScreen(boolean value)` sets whether the window is full screen ([#60](https://github.com/kasper/phoenix/issues/60), [#80](https://github.com/kasper/phoenix/issues/80)).

2.0.1
-----

Release: 12.12.2015

### Changes

- Amend license regarding the Phoenix icon assets contributed by Jason Milkins for not being under the MIT License ([#61](https://github.com/kasper/phoenix/pull/61)).

### Bug Fixes

- Fix issue where `Mouse.location()` and `Mouse.moveTo(Point point)` used different coordinate origins. Both now correctly use top-left as the origin ([#58](https://github.com/kasper/phoenix/issues/58)).
- Support shells (e.g. Fish) that do not support `-cl` option shorthand in preprocessing ([#57](https://github.com/kasper/phoenix/pull/57)).

2.0
---

Release: 28.11.2015

### New

- Phoenix now supports events! See the [API](https://github.com/kasper/phoenix/blob/2.0/API.md#2-events). To bind an event to a callback function, you call the `on`-function for the `Phoenix`-object.
- You may now use JavaScript [preprocessing](https://github.com/kasper/phoenix/blob/2.0/API.md#preprocessing) and languages such as CoffeeScript to write your Phoenix-configuration ([#45](https://github.com/kasper/phoenix/pull/45)). Thanks [@shayne](https://github.com/shayne/)!
- Updates are now delivered and installed through Sparkle ([#50](https://github.com/kasper/phoenix/issues/50)).
- Phoenix now supports additional configuration locations. In addition to `~/.phoenix.js`, you may also use `~/Library/Application Support/Phoenix/phoenix.js` or `~/.config/phoenix/phoenix.js` if you prefer to do so ([#52](https://github.com/kasper/phoenix/issues/52)).

### Changes

- Phoenix has been rewritten and refactored from the ground up. This also means that Phoenix now requires OS X Yosemite (10.10) or higher. Xcode 7 is now required for building.
- Supports OS X El Capitan (10.11).
- Underscore.js is upgraded to 1.8.3 (from 1.5.2). This may change existing behaviour related to Underscore.
- Global `api`-object is now called `Phoenix`.
- Global `MousePosition`-object is now called `Mouse`.
- `Hotkey`-object is now called `KeyHandler` and its properties have changed. See the [API](https://github.com/kasper/phoenix/blob/2.0/API.md#9-keyhandler).
- The concept of `Alerts` has been deprecated. A new global `Modal`-object has been created to display messages as modals. See the [API](https://github.com/kasper/phoenix/blob/2.0/API.md#11-modal).
- A new `EventHandler`-object has been created to handle events. See the [API](https://github.com/kasper/phoenix/blob/2.0/API.md#10-eventhandler).
- A new global `Command`-object has been created to run UNIX-commands. See the [API](https://github.com/kasper/phoenix/blob/2.0/API.md#12-command).

### Improvements

- A new subtler status item icon.
- Alerts are now delivered through Notification Center and logged to Console for easier debugging.
- Now reloading the context gives no alert unless an error is encountered.
- Objects that implement `Identifiable` can be identified and compared.

### Bug Fixes

- Support non-unicode keyboards ([#34](https://github.com/kasper/phoenix/issues/34)).
- Support relative requires with symlinks in configuration ([#42](https://github.com/kasper/phoenix/pull/42)).

### API

#### Phoenix

- New: Function `on(String event, Function callback)` binds an event to a callback function.
- New: Function `notify(String message)` delivers a message to the Notification Center.
- Change: Function `launch(String appName)` has moved to the global `App`-object.
- Change: Function `runCommand(String commandPath, Array arguments)` has moved to a new global `Command`-object and is now called `run(String path, Array arguments)`.
- Deprecation: Function `alert(String message, double durationInSeconds)` has been removed, use `Modal` to display messages as modals.
- Deprecation: Function `cancelAlerts()` has been removed, you must keep references to modals yourself to close them.
- Deprecation: Function `setTint(Array<double> red, Array<double> green, Array<double> blue)` has been removed with no replacement.

#### KeyHandler

- New: KeyHandler now implements `Identifiable`.
- Change: *You must now keep a reference to the handler*, otherwise your callback will not get called.
- Change: Special keys are now camelCased (case sensitive) instead of underscored. See changed [keys](https://github.com/kasper/phoenix/blob/2.0/API.md#special-keys).
- Change: Keys for keypad are now prefix with `keypad` instead of `pad`.

#### Screen

- New: Screen now implements `Identifiable`.
- New: Function `mainScreen()` returns the screen containing the window with the keyboard focus.
- New: Function `screens()` returns all screens.
- New: Function `windows()` returns all windows for the screen.
- New: Function `visibleWindows()` returns all visible windows for the screen.
- Change: For clarity, functions `frameIncludingDockAndMenu()` and `frameWithoutDockOrMenu()` are now `frameInRectangle()` and `visibleFrameInRectangle()`, respectively.
- Change: Functions `nextScreen()` and `previousScreen()` are now simply `next()` and `previous()`.

#### Mouse

- New: Function `moveTo(Point point)` returns a boolean value for determining success.
- Change: Functions `capture()` and `restore(Point point)` are now called `location()` and `moveTo(Point point)`.

#### App

- New: App now implements `Identifiable`.
- New: All actions return a boolean value for determining success.
- New: Function `get(String appName)` returns the running app with the given name.
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
- New: Function `isVisible()` returns whether the window is a normal and unminimised window that belongs to an unhidden app.
- Change: Function `allWindows()` is now simply `windows()`.
- Change: Function `visibleWindowsMostRecentFirst()` is renamed to `visibleWindowsInOrder()` for clarity.
- Change: Function `isNormalWindow()` is now simply `isNormal()`.
- Change: Function `isWindowMinimized()` is now simply `isMinimized()`.
- Change: Function `unMinimize()` is now `unminimize()`.
- Change: Function `focusWindow()` is now `focus()`.
- Change: Alignment functions `windowsToWest(), windowsToEast(), windowsToNorth(), windowsToSouth()` now correctly return windows relative to the window and not relative to the focused window. To achieve the previous behaviour you need chain these with the `focusedWindow()`-accessor. This also affects `focusClosestWindowInWest(), focusClosestWindowInEast(), focusClosestWindowInNorth(), focusClosestWindowInSouth()`-functions.
- Change: Functions `focusWindowLeft(), focusWindowRight(), focusWindowUp(), focusWindowDown()` are now `focusClosestWindowInWest(), focusClosestWindowInEast(), focusClosestWindowInNorth(), focusClosestWindowInSouth()`, respectively.
