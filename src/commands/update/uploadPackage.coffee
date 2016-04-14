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
        e = new Event 'drop'
        e.currentTarget = document.getElementById 'dropzone'
        e.dataTransfer.files[0] = new File new Blob([buffer.buffer]), filename

        return blob
      , buffer, filename
      .then (data) ->
        console.log blob

# export
module.exports = uploadPackage