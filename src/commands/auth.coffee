prompt = require 'prompt'
config = require '../config'
cache = require '../utils/cache'
nightmare = require '../utils/nightmare'

first = (email, password, callback) ->
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
      cache.set 'isAuth', true
      cache.set 'email', email

      callback()

usual = (email, callback) ->
  nightmare
    .goto 'https://developer.microsoft.com/en-us/dashboard/overview'
    .click '.use_another_account'
    .type 'input[type="email"]', email
    .click 'input[type="password"]'
    .wait '#dashboard'
    .then ->
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
      first result.email, result.password, callback
  else
    usual cache.get('email'), callback

# export
module.exports = auth

# _auth = (email, password, callback) ->
#   nightmare
#     .goto 'https://developer.microsoft.com/en-us/dashboard/overview'
#     # .evaluate ->
#     #   if document.getElementById('#login_user_chooser').children.length
#     #     document.getElementByClassName('.use_another_account')[0].click()
#     .type 'input[type="email"]', email
#     .click 'input[type="password"]'
#     .wait '#rightTD'
#     .type 'input[type="email"]', email # click on user, redirect to dev.microsoft.com
#     .type 'input[type="password"]', password
#     .click 'input[type="checkbox"]'
#     .click '#idSIButton9'
#     .wait '#dashboard'
#     .then ->
#       if not cache.get 'isAuth'
#         cache.set 'isAuth', true
#         cache.set 'email', email
#         cache.set 'password', password

#       callback()

# auth = (callback) ->
#   if not cache.get 'isAuth'
#     schema =
#       properties:
#         email:
#           required: true
#         password:
#           required: true
#           hidden: true

#     prompt.message = ''
#     prompt.colors = false
#     prompt.start()

#     prompt.get schema, (err, result) ->
#       _auth result.email, result.password, callback
#   else
#     _auth cache.get('email'), cache.get('password'), callback

# # export
# module.exports = auth