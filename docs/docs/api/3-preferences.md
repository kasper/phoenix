# Preferences

Phoenix supports the following (case sensitive) preferences:

- `daemon` (boolean): if set `true` Phoenix will run completely in the background, this also removes the status bar menu, defaults to `false`
- `openAtLogin` (boolean): if set `true` Phoenix will automatically open at login, defaults to `false` if no value has been previously set

Set the preferences using the `Phoenix`-object — for example:

```javascript
Phoenix.set({
  daemon: true,
  openAtLogin: true
});
```
