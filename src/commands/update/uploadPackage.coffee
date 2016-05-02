fs = require 'fs'
path = require 'path'
nightmare = require '../../utils/nightmare'

uploadPackage = (appId, submissionId, pathToFile, callback) ->  
  fs.readFile pathToFile, (err, buffer) ->
    if err
      console.log 'Can\'t read package file :(('
      return callback()

    filename = path.basename pathToFile

    nightmare
      .goto "https://developer.microsoft.com/en-us/dashboard/apps/#{appId}/submissions/#{submissionId}/Packages"
      .evaluate (buffer, filename) ->
        # helpers
        createEvent = (type) ->
          event = document.createEvent 'CustomEvent'
          event.initCustomEvent type, true, true, null
          event.dataTransfer =
            files: []

          return event

        dispatchEvent = (elem, type, event) ->
          if elem.dispatchEvent
            elem.dispatchEvent event
          else if elem.fireEvent
            elem.fireEvent "on#{type}", event

        toArrayBuffer = (buffer) ->
          data = buffer.data
          ab = new ArrayBuffer data.length
          view = new Uint8Array ab

          i = 0
          while i < data.length
            view[i] = data[i]
            ++i

          return ab

        # create file
        buffer = toArrayBuffer buffer
        file = new File [buffer], filename,
          type: 'application/zip'
          # lastModified: Date.now()

        # emulate events
        drop = document.getElementById 'dropzone'

        # drag enter
        type = 'dragenter'
        event = createEvent type
        dispatchEvent file, type, event

        # drop
        type = 'drop'
        dropEvent = createEvent type, {}
        dropEvent.dataTransfer = event.dataTransfer
        dropEvent.dataTransfer.files.push file
        dispatchEvent drop, type, dropEvent
      , buffer, filename
      .then ->
        callback()

# export
module.exports = uploadPackage