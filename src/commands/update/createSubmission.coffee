nightmare = require '../../utils/nightmare'
objectToQueryString = require '../../utils/objectToQueryString'

createSubmission = (id, callback) ->
  params = objectToQueryString { appId: id }

  nightmare
    .goto "https://developer.microsoft.com/en-us/dashboard/Apps/#{id}"
    .evaluate (params) ->
      tokenRegex = /__RequestVerificationToken[a-z"\s=]+value="([a-zA-Z0-9_\-]+)"/
      token = document.querySelector('#pageMainContent').innerHTML.match(tokenRegex)[1]

      xhr = new XMLHttpRequest()
      xhr.open 'POST', "#{Url.Action(ApplicationController.CreateSubmissionJsonActionName, ApplicationController.ControllerName)}#{params}", false
      xhr.withCredentials = true
      xhr.setRequestHeader '__RequestVerificationToken', token
      xhr.send()

      return xhr.response
    , params
    .then (data) ->
      data = JSON.parse data

      callback data.AppId, data.InProgressSubmission.Id

# export
module.exports = createSubmission