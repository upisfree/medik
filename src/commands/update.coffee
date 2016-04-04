nightmare = require '../utils/nightmare'
auth = require '../auth'

updateApp = (id, callback) ->
  nightmare
    .goto 'https://developer.microsoft.com/en-us/dashboard/Apps/' + id
    .click "a[ng-click=\"appHub.CreateSubmission($event, '#{id}')\"]"
    .then (data) ->
      console.log 'Success! New submission created.' # nightmare.url().match(/\/([0-9]+)$/)[1]

      callback()

update = (id, callback) ->
  auth ->
    updateApp id, callback

# export
module.exports = update