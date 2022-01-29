# About Coordinates

macOS has two commonly used coordinate systems: for higher level elements the origo `(0, 0)` is situated in the bottom-left corner of the screen, on the contrary for lower level elements the origo is situated in the top-left corner of the screen (flipped). This API has no distinction between these systems — `Point`s can represent both cases. The larger part of the API uses a flipped top-left based origin, unless otherwise is stated.
