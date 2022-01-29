# Mouse

Use the `Mouse`-object to control the cursor.

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
