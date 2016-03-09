nightmare = require './nightmare.js'
ooo = require './ooo.js'
auth = require './auth.js'

updateApp = (id, callback) ->
  nightmare
    .goto 'https://dev.windows.com/ru-ru/dashboard/Apps/' + id
    .click "a[ng-click=\"appHub.CreateSubmission($event, '#{id}')\"]"
    .then (data) ->
      ooo.stop()

      console.log 'Success! New submission created.' # nightmare.url().match(/\/([0-9]+)$/)[1]

      callback()

update = (id, callback) ->
  auth ->
    updateApp id, callback

# export
module.exports = update