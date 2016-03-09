argv = require('minimist')(process.argv.slice(2))
nightmare = require './nightmare.js'
ooo = require './ooo.js'
auth = require './auth.js'
list = require './list.js'
reset = require './reset.js'

switch argv._[0]
  when 'list'
    ooo.start()

    list ->
      nightmare.end().then ->
  when 'reset'
    reset ->
      console.log 'Yeah, fresh start!'
  else
    nightmare.end().then ->
      console.log 'Unknown command! Use help command to solve this.'