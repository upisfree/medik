# cause i can't send function through ipc
# if you wanna use it, in page context must be these vars: buffer, filename, type, selector
emulateFileDrop = "var buffer, createEvent, dispatchEvent, drop, dropEvent, event, file, toArrayBuffer, type;
  createEvent = function(type) {
    var event;
    event = document.createEvent('CustomEvent');
    event.initCustomEvent(type, true, true, null);
    event.dataTransfer = {
      files: []
    };
    return event;
  };

  dispatchEvent = function(elem, type, event) {
    if (elem.dispatchEvent) {
      return elem.dispatchEvent(event);
    } else if (elem.fireEvent) {
      return elem.fireEvent('on' + type, event);
    }
  };

  toArrayBuffer = function(buffer) {
    var ab, data, i, view;
    data = buffer.data;
    ab = new ArrayBuffer(data.length);
    view = new Uint8Array(ab);
    i = 0;
    while (i < data.length) {
      view[i] = data[i];
      ++i;
    }
    return ab;
  };

  buffer = toArrayBuffer(buffer);
  file = new File([buffer], filename, {
    type: type
  });

  drop = document.querySelector(selector);
  type = 'dragenter';
  event = createEvent(type);
  dispatchEvent(file, type, event);

  type = 'drop';
  dropEvent = createEvent(type, {});
  dropEvent.dataTransfer = event.dataTransfer;
  dropEvent.dataTransfer.files.push(file);
  dispatchEvent(drop, type, dropEvent);"

# export
module.exports = emulateFileDrop