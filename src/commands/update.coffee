fs = require 'fs'
auth = require './auth'
createSubmission = require './update/createSubmission'
deleteSubmission = require './update/deleteSubmission'
setPrice = require './update/setPrice'
setDescription = require './update/setDescription'
uploadPackage = require './update/uploadPackage'

currents = 
  appId: '9NBLGGH0FD6T'
  submissionId: '1152921504625158362'

update = (jsonPath, callback) ->
  json = JSON.parse fs.readFileSync jsonPath

  auth ->
    setPrice currents.appId, currents.submissionId, json.price, ->
      setDescription currents.appId, currents.submissionId, json.description, ->
        uploadPackage currents.appId, currents.submissionId, json.package, ->
          console.log 'App updated!'

# export
module.exports = update