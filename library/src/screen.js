'use strict';

/* Screen */

// TODO: Deprecated and will be removed in later versions, use Screen#flippedFrame() instead
Screen.prototype.frameInRectangle = function () {
  Phoenix.log(
    'Deprecated: Function Screen#frameInRectangle() is deprecated and will be removed in later versions, use Screen#flippedFrame() instead.',
  );
  return this.flippedFrame();
};

// TODO: Deprecated and will be removed in later versions, use Screen#flippedVisibleFrame() instead
Screen.prototype.visibleFrameInRectangle = function () {
  Phoenix.log(
    'Deprecated: Function Screen#visibleFrameInRectangle() is deprecated and will be removed in later versions, use Screen#flippedVisibleFrame() instead.',
  );
  return this.flippedVisibleFrame();
};
