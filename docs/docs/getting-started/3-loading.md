# Loading

Your configuration file is loaded when the app launches. All functions are evaluated (and executed if necessary) when this happens. Phoenix also reloads the configuration when any changes are detected to the file(s). You may also reload the configuration manually from the status bar or programmatically from your script.

The following locations are valid configuration paths and the first existing file will be used. You may also use these paths for the debug-configuration (`.debug.js`). Whilst loading, all symlinks will be resolved, so in the end your configuration can also be a symlink to any desired destination.

1. `~/.phoenix.js`
2. `~/Library/Application Support/Phoenix/phoenix.js`
3. `~/.config/phoenix/phoenix.js`
