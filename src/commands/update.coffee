# arguments
# id, string
#
request = require 'request'
nightmare = require '../utils/nightmare'
auth = require './auth'


# checkParams = 
# https://developer.microsoft.com/en-us/dashboard/AppSubmission/DeleteSubmission
# .wait "a[ng-click=\"appHub.CreateSubmission($event, '#{id}')]\""

createSubmission = (id, callback) ->
  nightmare
    .goto "https://developer.microsoft.com/en-us/dashboard/Apps/#{id}"
    .evaluate (id) ->
      tokenRegex = /__RequestVerificationToken[a-z"\s=]+value="([a-zA-Z0-9_\-]+)"/
      token = document.querySelector('#pageMainContent').innerHTML.match(tokenRegex)[1]

      xhr = new XMLHttpRequest()
      xhr.open 'POST', "/en-us/dashboard/Application/CreateSubmissionJson?appId=#{id}", false
      xhr.withCredentials = true
      xhr.setRequestHeader '__RequestVerificationToken', token
      xhr.send()

      return xhr.response
      # return Url.Action(AppSubmissionController.DeleteSubmissionActionName, AppSubmissionController.ControllerName)
    , id
    .then (data) ->
      console.log data
      # console.log 'Success! New submission created.' # nightmare.url().match(/\/([0-9]+)$/)[1]

      # callback()

update = (id, callback) ->
  auth ->
    createSubmission id, callback

# export
module.exports = update