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

## Example

```javascript
// Get the hash value for a window
const hash = Window.focused().hash();
Phoenix.log(hash); // -> 1668246523

// Compare equality of two windows
const focusedWindow = Window.focused();
const mainSafariWindow = App.get('Safari').mainWindow();
Phoenix.log(focusedWindow.isEqual(mainSafariWindow)); // -> true or false
```
