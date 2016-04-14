nightmare = require '../utils/nightmare'
auth = require './auth'
createSubmission = require './update/createSubmission'
deleteSubmission = require './update/deleteSubmission'
setPrice = require './update/setPrice'

currents = 
  appId: '9NBLGGH0FD6T'
  submissionId: '1152921504625157139'

update = (jsonPath, callback) ->
  auth ->
    setPrice currents.appId, currents.submissionId, '0.99 USD', ->
      console.log 'price saved'

# export
module.exports = update