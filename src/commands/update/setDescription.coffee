nightmare = require '../../utils/nightmare'

isUrl = /^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i
isEmail = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/

setDescription = (appId, submissionId, languageId, input, callback) ->
  output = {}

  # description
  if input.description? and input.description.length <= 10000
    output.description = input.description
  else
    console.log 'So long description... It must be shorter than 10k symbols. Or where\'s description?'

  # release notes
  if input.releaseNotes? and input.releaseNotes.length <= 1500
    output.releaseNotes = input.releaseNotes
  else
    console.log 'So long release notes... It must be shorter than 1.5k symbols.'

  # features
  if input.features? and input.features.length <= 20
    output.features = []

    for i in [0...20]
      if input.features[i]? and input.features[i].length <= 200
        output.features.push input.features[i]
      else
        output.features.push null

        if input.features[i]? # no future, no log
          console.log "So long app feature \##{i + 1}! It must be shorter than 200 symbols."
  else
    console.log 'Too much app features! Up to 20.'

  # hardware
  if input.hardware? and input.hardware.length <= 11
    output.hardware = []

    for i in [0...11]
      if input.hardware[i]? and input.hardware[i].length <= 200
        output.hardware.push input.hardware[i]
      else
        output.hardware.push null

        if input.hardware[i]? # no future, no log
          console.log "So long recommended hardware \##{i + 1}! It must be shorter than 200 symbols."
  else
    console.log 'Too much recommended hardware! Up to 11.'

  # trademark
  if input.trademark? and input.trademark.length <= 200
    output.trademark = input.trademark
  else
    console.log 'So long trademark... It must be shorter than 200 symbols.'

  # license terms
  if input.licenseTerms? and input.licenseTerms.length <= 10000
    output.licenseTerms = input.licenseTerms
  else
    console.log 'So long license terms... It must be shorter than 10k symbols.'

  # website
  if input.website? and input.website.length <= 2048 and isUrl.test input.website
    output.website = input.website
  else
    console.log 'Check, is your website URL too long or is this *realy* URL?'

  # support contact
  if input.supportContact? and input.supportContact.length <= 2048 and (isUrl.test(input.supportContact) or isEmail.test(input.supportContact))
    output.supportContact = input.supportContact
  else
    console.log 'Check, is your support contact too long or is this *realy* URL? Or email???'

  # privacy policy
  if input.privacyPolicy? and input.privacyPolicy.length <= 2048 and isUrl.test input.privacyPolicy
    output.privacyPolicy = input.privacyPolicy
  else
    console.log 'Check, is your privacy policy url too long or is this *realy* URL?'

  nightmare
    .goto "https://developer.microsoft.com/en-us/dashboard/apps/#{appId}/submissions/#{submissionId}/Listings?languageId=#{languageId}"
    .evaluate (output) ->
      if output.description?
        document.querySelector('textarea[name="ListingModels[0].Listing.Description"]').value = output.description

      if output.releaseNotes?
        document.querySelector('textarea[name="ListingModels[0].Listing.ReleaseNotes"]').value = output.releaseNotes

      if output.features?
        for i in [0...20]
          document.querySelector("input[name=\"ListingModels[0].Listing.Features[#{i}]\"]").value = output.features[i]

      if output.hardware?
        for i in [0...11]
          document.querySelector("input[name=\"ListingModels[0].Listing.HardwareNotes.RecommendedHardwareNotesList[#{i}]\"]").value = output.hardware[i]

      if output.trademark?
        document.querySelector('input[name="AppListing.Trademark"]').value = output.trademark

      if output.licenseTerms?
        document.querySelector('textarea[name="AppListing.LicenseTerm"]').value = output.licenseTerms

      if output.website?
        document.querySelector('input[name="AppListing.WebsiteUrl"]').value = output.website

      if output.supportContact?
        document.querySelector('input[name="AppListing.SupportContact"]').value = output.supportContact

      if output.privacyPolicy?
        document.querySelector('input[name="AppListing.PrivatePolicyUrl"]').value = output.privacyPolicy

    , output
    .click '.page-bottom-buttons button[data-command="save"]'
    .then ->
      callback()

# export
module.exports = setDescription