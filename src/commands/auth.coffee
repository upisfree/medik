prompt = require 'prompt'
config = require '../config'
cache = require '../utils/cache'
nightmare = require '../utils/nightmare'

_auth = (email, password, callback) ->
  nightmare
    .goto 'https://developer.microsoft.com/en-us/dashboard/overview'
    .type 'input[type="email"]', email
    .click 'input[type="password"]'
    .wait '#rightTD'
    .type 'input[type="email"]', email # click on user, redirect to dev.microsoft.com
    .type 'input[type="password"]', password
    .click 'input[type="checkbox"]'
    .click '#idSIButton9'
    .wait '#dashboard'
    .then ->
      if not cache.get 'isAuth'
        cache.set 'isAuth', true
        cache.set 'email', email
        cache.set 'password', password

      callback()

auth = (callback) ->
  if not cache.get 'isAuth'
    schema =
      properties:
        email:
          required: true
        password:
          required: true
          hidden: true

    prompt.message = ''
    prompt.colors = false
    prompt.start()

    prompt.get schema, (err, result) ->
      _auth result.email, result.password, callback
  else
    _auth cache.get('email'), cache.get('password'), callback

# export
module.exports = auth