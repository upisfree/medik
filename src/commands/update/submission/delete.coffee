nightmare = require '../../utils/nightmare'
objectToQueryString = require '../../utils/objectToQueryString'

deleteSubmission = (appId, submissionId, callback) ->
  params = objectToQueryString { appId: appId, submissionId: submissionId }

  nightmare
    .goto "https://developer.microsoft.com/en-us/dashboard/Apps/#{appId}"
    .evaluate (params) ->
      tokenRegex = /__RequestVerificationToken[a-z"\s=]+value="([a-zA-Z0-9_\-]+)"/
      token = document.querySelector('#pageMainContent').innerHTML.match(tokenRegex)[1]

      xhr = new XMLHttpRequest()
      xhr.open 'POST', "#{Url.Action(AppSubmissionController.DeleteSubmissionActionName, AppSubmissionController.ControllerName)}#{params}", false
      xhr.withCredentials = true
      xhr.setRequestHeader '__RequestVerificationToken', token
      xhr.send()

      return xhr.response
    , params
    .then (data) ->
      callback()

# export
module.exports = deleteSubmission