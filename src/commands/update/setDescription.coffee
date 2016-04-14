# name="ListingModels[0].Listing.Description"
# name="ListingModels[0].Listing.ReleaseNotes"
# name="AppListing.WebsiteUrl"
# name="AppListing.SupportContact"

nightmare = require '../../utils/nightmare'

isUrl = new RegExp '(http|ftp|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?'
isEmail = new RegExp '^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'

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
  if params.website? and params.website.length < 2048 and params.website.match isUrl
    website = params.website
  else
    console.log 'Check, is your URL too long or is this *realy* URL?'

  # supportContact
  if params.supportContact? and params.supportContact.length < 2048 and (params.supportContact.match(isUrl) or params.supportContact.match(isEmail))
    supportContact = supportContact.website
  else
    console.log 'Check, is your support contact too long or is this *realy* URL? Or email???'

  nightmare
    .goto "https://developer.microsoft.com/en-us/dashboard/apps/#{appId}/submissions/#{submissionId}/Listings?languageId=#{languageId}"
    .evaluate (description, releaseNotes, website, supportContact) ->
      if description?
        document.querySelector('textarea[name="ListingModels[0].Listing.Description"]').value = description

      if releaseNotes?
        document.querySelector('textarea[name="ListingModels[0].Listing.ReleaseNotes"]').value = releaseNotes

      if website?
        document.querySelector('textarea[name="AppListing.WebsiteUrl"]').value = website

      if supportContact?
        document.querySelector('textarea[name="AppListing.SupportContact"]').value = supportContact

    , description, releaseNotes, website, supportContact
    .click '.page-bottom-buttons button[data-command="save"]'
    .then ->
      callback()

# export
module.exports = setDescription