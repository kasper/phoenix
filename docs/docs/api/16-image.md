# Image

Use the `Image`-object to construct images.

## Interface

```javascript
class Image implements Identifiable

  static Image fromFile(String path)

end
```

## Static Methods

- `fromFile(String path)` loads an image from the given path, the path is resolved before attempting to load the image, returns `undefined` if unsuccessful
