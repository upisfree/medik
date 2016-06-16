regexp = require '../../../utils/regexp'

validate = (input) ->
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

  # keywords
  if input.keywords? and input.keywords.length <= 7
    output.keywords = []

    for i in [0...7]
      if input.keywords[i]? and input.keywords[i].match(regexp.word).length <= 3 and input.keywords[i].length <= 45 # no more 3 words in keyword and shorten than 45 symbols
        output.keywords.push input.keywords[i]
      else
        output.keywords.push null

        if input.keywords[i]? # no future, no log
          console.log "Something wrong with keyword \##{i + 1}, check it."
  else
    console.log 'Too much keywords! Up to 7.'

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
  if input.website? and input.website.length <= 2048 and regexp.url.test input.website
    output.website = input.website
  else
    console.log 'Check, is your website URL too long or is this *realy* URL?'

  # support contact
  if input.supportContact? and input.supportContact.length <= 2048 and (regexp.url.test(input.supportContact) or regexp.email.test(input.supportContact))
    output.supportContact = input.supportContact
  else
    console.log 'Check, is your support contact too long or is this *realy* URL? Or email???'

  # privacy policy
  if input.privacyPolicy? and input.privacyPolicy.length <= 2048 and regexp.url.test input.privacyPolicy
    output.privacyPolicy = input.privacyPolicy
  else
    console.log 'Check, is your privacy policy url too long or is this *realy* URL?'

  return output

# export
module.exports = validate