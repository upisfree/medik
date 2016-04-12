fs = require 'fs'
config = require '../config'
cache = require '../utils/cache'
nightmare = require '../utils/nightmare'
auth = require './auth'

print = (apps) ->
  apps = JSON.parse apps # after load we use data directly without cache and JSON.parse, that's why

  for i in apps
    console.log "#{i.name}, #{i.statusText}, id: #{i.bigId}"

loadList = (callback) ->
  nightmare
    .goto 'https://developer.microsoft.com/en-us/overview/'
    .wait '.appName'
    .evaluate ->
      xhr = new XMLHttpRequest()

      xhr.open 'GET', 'https://developer.microsoft.com/en-us/engagementapi/apps', false
      xhr.send()

      return xhr.responseText
    .then (data) ->
      cache.set 'apps', data

      callback data

list = (callback) ->
  apps = cache.get 'apps'

  if apps
    print apps

    callback()
  else
    auth ->
      loadList (data) ->
        print data

        callback()

# export
module.exports = list