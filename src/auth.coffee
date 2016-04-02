prompt = require 'prompt'
config = require './config'
LocalStorage = require('node-localstorage').LocalStorage
localStorage = new LocalStorage "#{config.cachePath}/localStorage"
nightmare = require './utils/nightmare'
ooo = require './utils/ooo'

first = (email, password, callback) ->
  ooo.start()

  nightmare
    .goto 'https://dev.windows.com'
    .click '.msame_TxtTrunc'
    .wait '.login_cred_field_container'
    .type 'input[type="email"]', email
    .click 'input[type="password"]'
    .wait '#rightTD'
    .type 'input[type="email"]', email # click on user, redirect to dev.microsoft.com
    .type 'input[type="password"]', password
    .click 'input[type="checkbox"]'
    .click '#idSIButton9'
    .wait '#dashboard'
    .then ->
      localStorage.setItem 'isAuth', true
      localStorage.setItem 'email', email

      callback()

usual = (email, callback) ->
  ooo.start()

  nightmare
    .goto 'https://dev.windows.com'
    .click '.msame_TxtTrunc'
    .wait '.login_cred_field_container'
    .click '.use_another_account'
    .type 'input[type="email"]', email
    .click 'input[type="password"]'
    .wait '#dashboard'
    .then ->
      callback()

auth = (callback) ->
  if not localStorage.getItem 'isAuth'
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
      first result.email, result.password, callback
  else
    usual localStorage.getItem('email'), callback

# export
module.exports = auth