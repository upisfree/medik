nightmare = require '../utils/nightmare'
auth = require './auth'
createSubmission = require './update/createSubmission'
deleteSubmission = require './update/deleteSubmission'
setPrice = require './update/setPrice'
setDescription = require './update/setDescription'

currents = 
  appId: '9NBLGGH0FD6T'
  submissionId: '1152921504625157469'

update = (jsonPath, callback) ->
  auth ->

# export
module.exports = update