# Managing Handlers

As previously mentioned you must keep a reference to your handlers, otherwise your callbacks will not get called. In return, if you release the reference to the handler, it will also be disabled eventually. Beware that this can be rather delayed and you are always safer to manually disable the handlers before letting the reference go. This gives you full control over the lifecycle of your handlers and can be especially useful when you want to dynamically create handlers.

Obviously, in most cases you do not want to worry about the lifecycle of your handlers. This is why Phoenix also provides managed handlers that are held for you. You can use these managed handlers to set keys, events, timers and tasks, but also to disable them. Basically, when you create a managed handler, the handler is constructed and its reference is stored. You will get an identifier for the handler which you can then use to disable it. When you disable the handler, Phoenix will take care of properly disposing it for you.

For example, to bind a key to a function.

```javascript
Key.on('q', [ 'control', 'shift' ], function () {});
```

You can disable the handler with its identifier.

```javascript
var identifier = Key.on('q', [ 'control', 'shift' ], function () {});
Key.off(identifier);
```
