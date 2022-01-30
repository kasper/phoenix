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
// Get the cursor location
const location = Mouse.location();
console.log('Location:', location.x, location.y); // -> 'Location: 2023 301'

// Move the cursor to origo
Mouse.move({ x: 0, y: 0 });
```
