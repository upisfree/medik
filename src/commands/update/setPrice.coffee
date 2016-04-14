nightmare = require '../../utils/nightmare'
priceList = require './lists/prices'

setPrice = (appId, submissionId, price, callback) ->
  if not priceList[price]
    console.log 'Error! Strange price, I don\'t understand it, realy.'

    return callback()

  priceValue = priceList[price]

  # doesn't work(((
  nightmare
    .goto "https://developer.microsoft.com/en-us/dashboard/apps/#{appId}/submissions/#{submissionId}/Pricing"
    .evaluate (priceValue) ->
      document.getElementById('idPriceTier').value = priceValue
    , priceValue
    .click '#saveButtonPricing'
    .then ->
      callback()

# export
module.exports = setPrice