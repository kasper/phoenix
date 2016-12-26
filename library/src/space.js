'use strict';

/* Space */

// TODO: Deprecated and will be removed in later versions, use Space#screens() instead
Space.prototype.screen = function () {
  Phoenix.log('Deprecated: Function Space#screen() is deprecated and will be removed in later versions, use Space#screens() instead.');
  return _.first(this.screens());
}
