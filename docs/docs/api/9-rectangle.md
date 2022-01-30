# Rectangle

A 2D rectangle representation of a `Point` and `Size`.

## Interface

```javascript
struct Rectangle

  property double x
  property double y
  property double width
  property double height

end
```

## Example

```javascript
// Read rectangle properties
const frame = Window.focused().frame();
Phoenix.log(frame.x, frame.y, frame.width, frame.height); // -> 100 0 1024 512
```

