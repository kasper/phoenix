'use strict';

/* Modal */

Modal.prototype.setTextColour = Modal.prototype.setTextColor;

Modal.build = function (properties) {
  var modal = new Modal();
  _(properties)
    .omit('origin')
    .each(function (value, key) {
      modal[key] = value;
    });
  if (_(properties.origin).isFunction()) {
    modal.origin = properties.origin(modal.frame());
    modal.didResize = function () {
      modal.origin = properties.origin(modal.frame());
    };
  }
  return modal;
};
