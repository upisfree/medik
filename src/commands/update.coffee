nightmare = require '../utils/nightmare'
auth = require './auth'
createSubmission = require './update/createSubmission'
deleteSubmission = require './update/deleteSubmission'

currents = 
  appId: null
  submissionId: null

update = (id, callback) ->
  auth ->

# export
module.exports = update