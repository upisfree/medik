fs = require 'fs'
auth = require './auth'
createSubmission = require './update/submission/create'
deleteSubmission = require './update/submission/delete'
setPrice = require './update/setPrice'
setDescription = require './update/description/set'
uploadPackage = require './update/uploadPackage'

currents = 
  appId: '9NBLGGH0FD6T'
  submissionId: '1152921504625337049'

update = (jsonPath, callback) ->
  json = JSON.parse fs.readFileSync jsonPath

  auth ->
    # uploadPackage currents.appId, currents.submissionId, json.package, ->
    #   console.log 'App updated!'

    # setPrice currents.appId, currents.submissionId, json.price, ->
    #   setDescription currents.appId, currents.submissionId, json.description, ->

    setDescription currents.appId, currents.submissionId, json.description.languageId, json.description, ->
      console.log 'done)))0'

# export
module.exports = update