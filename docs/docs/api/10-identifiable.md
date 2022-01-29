# Identifiable

Objects that implement `Identifiable` can be identified and compared.

## Interface

```javascript
interface Identifiable

  int hash()
  boolean isEqual(AnyObject object)

end
```

## Instance Methods

- `hash()` returns the hash value for the object
- `isEqual(AnyObject object)` returns `true` if the given object is equal with this object
