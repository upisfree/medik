nightmare = require '../../../utils/nightmare'
validate = require './validate'

set = (appId, submissionId, languageId, input, callback) ->
  output = validate input

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

      if output.keywords?
        for i in [0...7]
          document.querySelector("input[name=\"AppListing.Keywords[#{i}]\"]").value = output.keywords[i]

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
module.exports = set