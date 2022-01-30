# Image

Use Image to load images from the file system.

## Interface

```javascript
class Image implements Identifiable

  static Image fromFile(String path)

end
```

## Static Methods

- `fromFile(String path)` loads an image from the given path, the path is resolved before attempting to load the image, returns `undefined` if unsuccessful

## Example

```javascript
// Load image from the file system
const image = Image.fromFile('~/Pictures/image.png');
```
