# Mouse

Use the Mouse to control the cursor.

## Interface

```javascript
class Mouse

  static Point location()
  static boolean move(Point point)

end
```

## Static Methods

- `location()` returns the cursor position
- `move(Point point)` moves the cursor to a given position, returns `true` if successful

## Example

```javascript
// Get cursor location
const location = Mouse.location();
console.log('Location:', location.x, location.y); // -> 'Location: 100 25'

// Move cursor to origo
Mouse.move({ x: 0, y: 0 });
```
