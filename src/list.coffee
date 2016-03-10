fs = require 'fs'
nightmare = require './nightmare.js'
ooo = require './ooo.js'
auth = require './auth.js'

loadList = (callback) ->
  nightmare
    .goto 'https://dev.windows.com/ru-ru/overview/'
    .wait '.appName'
    .evaluate ->
      xhr = new XMLHttpRequest()

      xhr.open 'GET', 'https://dev.windows.com/ru-RU/engagementapi/apps', false
      xhr.send()

      return xhr.responseText
    .then (data) ->
      fs.writeFile 'tmp/localStorage/apps', data, (err) ->
        callback()

printList = (callback) ->
  fs.readFile 'tmp/localStorage/apps', (err, data) ->
    if not err
      ooo.stop()

      l = JSON.parse data.toString 'utf-8'

      for i in l
        console.log "#{i.name}, #{i.statusText}, id: #{i.bigId}"

      callback()
    else
      loadList ->
        fs.readFile 'tmp/localStorage/apps', (err, data) ->
          ooo.stop()

          l = JSON.parse data.toString 'utf-8'

          for i in l
            console.log "#{i.name}, #{i.statusText}, id: #{i.bigId}"

          callback()

list = (callback) ->
  auth ->
    printList callback

# export
module.exports = list



# loadList = (callback) ->
#   nightmare
#     .goto 'https://dev.windows.com/ru-ru/overview/'
#     .wait '.appName'
#     .evaluate ->
#       apps = []
#       links = document.querySelectorAll '.appMenuItem:not(.addApp):not(.bottomlink)'
      
#       for link in links
#         id = link.href.match(/([A-Za-z0-9]+)\/$/)[1]
#         title = link.title

#         apps.push { id, title }

#       return apps
#     .then (data) ->
#       console.log data
#       localStorage.setItem 'apps', JSON.stringify data

#       callback()