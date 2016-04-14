argv = require('minimist')(process.argv.slice(2))
nightmare = require './utils/nightmare'
auth = require './commands/auth'
list = require './commands/list'
update = require './commands/update'
reset = require './commands/reset'
help = require './commands/help'

end = ->
  nightmare.end().then()

terminal = ->
  switch argv._[0]
    when 'auth'
      auth ->
        console.log 'Success auth!'

        end()
    when 'update'
      update argv.json, ->
        end()
    when 'list'
      list ->
        end()
    when 'reset'
      reset ->
        console.log 'Yeah, fresh start!'
    when 'help'
      help()

      end()
    else
      console.log 'Unknown command! Use \'help\' command to solve this.'

      end()

# export
module.exports = terminal