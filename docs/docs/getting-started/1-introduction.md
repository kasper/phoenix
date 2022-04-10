# Introduction

Many of the API classes represent global objects in the script’s context — methods that are marked as static can be accessed through these global objects. All other functions are instance methods. Instance objects can be accessed through the global objects or constructed with the relevant constructors.

For example, to bind a key to a function, you construct a `Key` object. Notice that *you must keep a reference to the handler*, otherwise your callback will not get called, because the handler will be released from memory.

```javascript
const handler = new Key('q', ['control', 'shift'], () => {});
```

To move the focused window to a new coordinate, you can call the `setTopLeft` method for a `Window` instance. To get a `Window` instance, you can for example get the focused window with the `focused` method for the global `Window` object.

```javascript
Window.focused().setTopLeft({ x: 0, y: 0 });
```

To combine, bind a key to move the focused window.

```javascript
const handler = new Key('q', ['control', 'shift'], () => {
  Window.focused().setTopLeft({ x: 0, y: 0 });
});
```

As an other example, to bind an event to a function, you construct an `Event` object. Again notice that *you must keep a reference to the handler*, otherwise your callback will not get called. The callback will get triggered when the event with the specified name occurs.

```javascript
const handler = new Event('screensDidChange', () => {});
```

:::tip Managed Handlers
You most likely do not want to handle the references manually. Therefore Phoenix supports “[Managed Handlers](managing-handlers)”. This way you can let Phoenix take care of the state management for you.

```javascript
Key.on('q', ['control', 'shift'], () => {});
```
:::

## Supported APIs

See below for an overview of the supported APIs. To read more, check the respective API documentation pages.

| API | Description |
|-----|-------------|
| [Keys](/api/keys) | Lists all the available keys for binding callbacks to |
| [Events](/api/events) | Lists all the available events for binding callbacks to |
| [Preferences](/api/preferences) | Configure the behaviour of Phoenix |
| [Require](/api/require) | Separate your configuration into multiple files |
| [Phoenix](/api/phoenix) | Access global APIs and actions |
| [Storage](/api/storage) | Use Storage to store values across reloads and reboots as JSON |
| [Point](/api/point) | A simple point object for 2D coordinates |
| [Size](/api/size) | A simple 2D size object |
| [Rectangle](/api/rectangle) | A 2D rectangle representation of a `Point` and `Size` |
| [Identifiable](/api/identifiable) | Objects that implement `Identifiable` can be identified and compared |
| [Iterable](/api/iterable) | Objects that implement `Iterable` can be traversed relatively to the current object |
| [Key](/api/key) | Use Key to construct keys, bind callbacks, access their properties, and enable or disable them |
| [Event](/api/event) | Use Event to construct events, bind callbacks, access their properties or disable them |
| [Timer](/api/timer) | Use Timer to construct and control timers |
| [Task](/api/task) | Use Task to construct external tasks (such as running scripts), access their properties or terminate them |
| [Image](/api/image) | Use Image to load images from the file system |
| [Modal](/api/modal) | Use Modal to display content as modal windows (in front of all other windows). Modals can be used to display icons and/or text for visual cues. |
| [Screen](/api/screen) | Use Screen to access frame sizes and other screens on a multi-screen setup |
| [Space](/api/space) | Use the Space to control spaces |
| [Mouse](/api/mouse) | Use the Mouse to control the cursor |
| [App](/api/app) | Use App to control apps |
| [Window](/api/window) | Use Window to control app windows |
