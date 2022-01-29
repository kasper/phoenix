# Preprocessing

You may add JavaScript preprocessing to your configuration by adding a [Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))-directive to the beginning of your file. It must be the first statement in your file. Phoenix should support all popular JavaScript compilers, but be aware that you need to have the compiler installed on your setup and accessible through your shell’s `PATH` for Phoenix to find it. You also need to ask the compiler to output to the standard output so Phoenix is able to evaluate the result. For example, use [CoffeeScript](http://coffeescript.org) to write your configuration:

```coffeescript
#!/usr/bin/env coffee -p

Key.on 's', ['control', 'shift'], ->
  App.launch('Safari').focus()
```

Or use [Babel](http://babeljs.io) to use ECMAScript 6 JavaScript in macOS versions prior to Sierra:

```javascript
#!/usr/bin/env babel

Key.on('s', ['control', 'shift'], () => {
  App.launch('Safari').focus();
});
```
