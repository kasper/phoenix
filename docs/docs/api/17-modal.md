# Modal

Use the `Modal`-object to display content as modal windows (in front of all other windows). Modals can be used to display icons and/or text for visual cues. Properties defined as dynamic can be altered while the modal is displayed.

## Interface

```javascript
class Modal implements Identifiable

  static Modal build(Map<String, AnyObject> properties)

  property Point origin
  property double duration
  property double animationDuration
  property double weight
  property String appearance
  property Image icon
  property String text

  constructor Modal Modal()
  Rectangle frame()
  void show()
  void close()

end
```

## Static Methods

- `build(Map<String, AnyObject> properties)` builds a modal with the specified properties and returns it, `origin` should be a function that receives the frame for the modal as the only argument and returns a `Point`-object which will be set as the origin for the modal

## Instance Properties

- `origin` dynamic property for the origin of the modal, the enclosed properties are read-only so you must pass an object for this property, bottom-left based origin, by default `(0, 0)`
- `duration` property for the duration (in seconds) before automatically closing the modal, if the duration is set to `0` the modal will remain open until closed, by default `0`
- `animationDuration` property for the animation duration (in seconds) for showing and closing the modal, if the duration is set to `0` the animation will be disabled, by default `0.2`
- `weight` dynamic property for the weight of the modal (in points), by default `24`
- `appearance` property for the appearance of the modal (`dark|light|transparent`), by default `dark`
- `icon` dynamic property for the icon displayed in the modal
- `text` dynamic property for the text displayed in the modal

## Constructor

- `new Modal()` constructs and returns a new modal

## Instance Methods

- `frame()` returns the frame for the modal, the frame is adjusted for the current content, therefor you must first set the weight, icon and text to get an accurate frame, bottom-left based origin
- `show()` shows the modal, you must set at least an icon or text for the modal to be displayed
- `close()` closes the modal
