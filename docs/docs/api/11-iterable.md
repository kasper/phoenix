# Iterable

Objects that implement `Iterable` can be traversed relatively to the current object.

## Interface

```javascript
interface Iterable

  Object next()
  Object previous()

end
```

## Instance Methods

- `next()` returns the next object or the first object when on the last one
- `previous()` returns the previous object or the last object when on the first one

## Example

```javascript
// Traverse between screens starting from the main screen
const nextScreen = Screen.main().next();
const previousScreen = Screen.main().previous();
```
