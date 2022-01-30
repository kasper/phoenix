# Require

You can modularise your configuration using the `require` function. It will load the referenced JavaScript file and reload it if any changes are detected. If the path is relative, it is resolved relatively to the absolute location of the primary configuration file. If this file is a symlink, it will be resolved before resolving the location of the required file. If the file does not exist, `require` will throw an error.

```javascript
require('path/to/file.js');
```

All required code is executed in the same namespace. Be careful about the execution order and polluting properties.
