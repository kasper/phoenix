# Modal

Use Modal to display content as modal windows (in front of all other windows). Modals can be used to display icons and/or text for visual cues. An input modal can be used to input text for example to give commands. Properties defined as dynamic can be altered while the modal is displayed.

![Example icon modal](/img/modal/icon-modal.png#example)
**Above:** Light modal with icon

![Example text modal](/img/modal/text-modal.png#example)
**Above:** Dark modal with icon and text

![Example input modal](/img/modal/input-modal.png#example)
**Above:** Light input modal with icon

## Interface

```javascript
class Modal implements Identifiable

  static Modal build(Map<String, AnyObject> properties)

  property Point origin
  property double duration
  property double animationDuration
  property double weight
  property String appearance
  property boolean hasShadow
  property Image icon
  property String text
  property String textAlignment
  property String font
  property boolean isInput
  property String inputPlaceholder
  property Function textDidChange

  constructor Modal Modal()
  void setTextColour(double red, double green, double blue, double alpha) // or setTextColor(...)
  Rectangle frame()
  void show()
  void close()

end
```

## Static Methods

- `build(Map<String, AnyObject> properties)` builds a modal with the specified properties and returns it, `origin` should be a function that receives the frame for the modal as the only argument and returns a `Point` object which will be set as the origin for the modal

## Instance Properties

- `origin` dynamic property for the origin of the modal, the enclosed properties are read-only so you must pass an object for this property, bottom left based origin, by default `(0, 0)`
- `duration` property for the duration (in seconds) before automatically closing the modal, if the duration is set to `0` the modal will remain open until closed, by default `0`
- `animationDuration` property for the animation duration (in seconds) for showing and closing the modal, if the duration is set to `0` the animation will be disabled, by default `0.2`
- `weight` dynamic property for the weight of the modal (in points), by default `24`
- `appearance` property for the appearance of the modal (`dark|light|transparent`), by default `dark`
- `icon` dynamic property for the icon displayed in the modal
- `text` dynamic property for the text displayed in the modal

### 3.0.0+

- `hasShadow` property for whether the modal has a shadow, by default `true`
- `textAlignment` property for the alignment of the text (`left|right|centre|center`), by default `left`
- `font` dynamic property for the font name used for the text, by default `System`
- `isInput` property for whether the modal behaves as an input modal, by default `false`
- `inputPlaceholder` property for the placeholder string that will be displayed when the input is empty, by default empty
- `textDidChange` callback function to call when the input modal’s text field value changes, receives the value as the first argument for the callback

## Constructor

- `new Modal()` constructs and returns a new modal

## Instance Methods

- `frame()` returns the frame for the modal, the frame is adjusted for the current content, therefore you must first set the weight, icon and text to get an accurate frame, an input modal has a fixed width of 600, bottom left based origin
- `show()` shows the modal, you must set at least an icon or text for the modal to be displayed
- `close()` closes the modal

### 3.0.0+

- `setTextColour(double red, double green, double blue, double alpha)` or `setTextColor(...)` sets a custom text colour with the given RGBA values, for example `setTextColor(34, 139, 34, 1)`

## Example

```javascript
// Build and show a modal for half a second
Modal.build({
  duration: 0.5,
  weight: 48,
  appearance: 'dark',
  icon: App.get('Phoenix').icon(),
  text: 'Hello World!',
}).show();

// Show an input modal in the middle of the main screen
const screenFrame = Screen.main().flippedVisibleFrame();
const modal = new Modal();
modal.isInput = true;
modal.appearance = 'light';
modal.origin = {
  x: screenFrame.width / 2 - modal.frame().width / 2,
  y: screenFrame.height / 2 - modal.frame().height / 2,
};
modal.textDidChange = (value) => {
  console.log('Text did change:', value);
};
modal.show();
```
