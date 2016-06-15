fs = require 'fs'
path = require 'path'
nightmare = require '../../utils/nightmare'
emulateFileDrop = require '../../utils/emulateFileDrop'

uploadPackage = (appId, submissionId, pathToFile, callback) ->  
  fs.readFile pathToFile, (err, buffer) ->
    if err
      console.log 'Can\'t read package file :(('
      return callback()

    filename = path.basename pathToFile
    type = 'application/zip'
    selector = '#dropzone'

    nightmare
      .goto "https://developer.microsoft.com/en-us/dashboard/apps/#{appId}/submissions/#{submissionId}/Packages"
      .evaluate (buffer, filename, type, selector, emulateFileDrop) ->
        eval emulateFileDrop
      , buffer, filename, type, selector, emulateFileDrop
      .then ->
        callback()

# export
module.exports = uploadPackage