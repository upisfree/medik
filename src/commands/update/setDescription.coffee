# name="ListingModels[0].Listing.Description"
# name="ListingModels[0].Listing.ReleaseNotes"
# name="AppListing.WebsiteUrl"
# name="AppListing.SupportContact"

nightmare = require '../../utils/nightmare'

isUrl = /^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i
isEmail = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/

setDescription = (appId, submissionId, languageId, params, callback) ->
  # description
  if params.description? and params.description.length < 10000
    description = params.description
  else
    console.log 'So long description... It must be shorter than 10k symbols. Or where\'s description?'

  # release notes
  if params.releaseNotes? and params.releaseNotes.length < 1500
    releaseNotes = params.releaseNotes
  else
    console.log 'So long release notes... It must be shorter than 1.5k symbols.'

  # website
  if params.website? and params.website.length < 2048 and isUrl.test params.website
    website = params.website
  else
    console.log 'Check, is your URL too long or is this *realy* URL?'

  # supportContact
  if params.supportContact? and params.supportContact.length < 2048 and (isUrl.test(params.supportContact) or isEmail.test(params.supportContact))
    supportContact = params.supportContact
  else
    console.log 'Check, is your support contact too long or is this *realy* URL? Or email???'

  # privacyPolicy
  if params.privacyPolicy? and params.privacyPolicy.length < 2048 and isUrl.test params.privacyPolicy
    privacyPolicy = params.privacyPolicy
  else
    console.log 'Check, is your privacy policy url too long or is this *realy* URL?'

  nightmare
    .goto "https://developer.microsoft.com/en-us/dashboard/apps/#{appId}/submissions/#{submissionId}/Listings?languageId=#{languageId}"
    .evaluate (description, releaseNotes, website, supportContact, privacyPolicy) ->
      if description?
        document.querySelector('textarea[name="ListingModels[0].Listing.Description"]').value = description

      if releaseNotes?
        document.querySelector('textarea[name="ListingModels[0].Listing.ReleaseNotes"]').value = releaseNotes

      if website?
        document.querySelector('input[name="AppListing.WebsiteUrl"]').value = website

      if supportContact?
        document.querySelector('input[name="AppListing.SupportContact"]').value = supportContact

      if privacyPolicy?
        document.querySelector('input[name="AppListing.PrivatePolicyUrl"]').value = privacyPolicy

    , description, releaseNotes, website, supportContact, privacyPolicy
    .click '.page-bottom-buttons button[data-command="save"]'
    .then ->
      callback()

# export
module.exports = setDescription