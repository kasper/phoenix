'use strict';

/* Modal */

Modal.build = function (properties) {
  var modal = new Modal();
  _(properties).omit('origin').each(function (value, key) {
    modal[key] = value;
  });
  if (_(properties.origin).isFunction()) {
    modal.origin = properties.origin(modal.frame());
  }
  return modal;
}
