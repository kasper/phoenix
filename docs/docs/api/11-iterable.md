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
// Traverse screens
const next = Screen.main().next();
const previous = Screen.main().previous();
```
