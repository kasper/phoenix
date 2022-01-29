# Introduction

This documentation uses *pseudocode* to outline the API. Many of the classes represent global objects in the script’s context — functions that are marked as static can be accessed through these global objects. All other functions are instance functions. Instance objects can be accessed through the global objects or constructed with relevant constructors.

For example, to bind a key to a function, you construct a `Key`-object. Notice that *you must keep a reference to the handler*, otherwise your callback will not get called.

```javascript
var handler = new Key('q', [ 'control', 'shift' ], function () {});
```

To move the focused window to a new coordinate, you can call the `setTopLeft`-function for a `Window`-instance. To get a `Window`-instance, you can for example get the focused window with the `focused`-function for the global `Window`-object.

```javascript
Window.focused().setTopLeft({ x: 0, y: 0 });
```

To combine, bind a key to move the focused window.

```javascript
var handler = new Key('q', [ 'control', 'shift' ], function () {
  Window.focused().setTopLeft({ x: 0, y: 0 });
});
```

As an other example, to bind an event to a function, you construct an `Event`-object. Again notice that *you must keep a reference to the handler*, otherwise your callback will not get called.

```javascript
var handler = new Event('screensDidChange', function () {});
```
