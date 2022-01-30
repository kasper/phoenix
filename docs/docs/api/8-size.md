# Size

A simple 2D size object.

## Interface

```javascript
struct Size

  property double width
  property double height

end
```

## Example

```javascript
// Read size properties
const size = Window.focused().size();
Phoenix.log(size.width, size.height); // -> 1024 512
```
