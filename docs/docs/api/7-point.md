# Point

A simple point object for 2D coordinates.

## Interface

```javascript
struct Point

  property double x
  property double y

end
```

## Example

```javascript
// Read point properties
const point = Window.focused().topLeft();
Phoenix.log(point.x, point.y); // -> 100 0
```
