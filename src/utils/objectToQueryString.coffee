objectToQueryString = (obj) ->
  str = '?'
  
  for k, v of obj
    str += "#{k}=#{encodeURIComponent v}&"

  return str.slice 0, -1

# export
module.exports = objectToQueryString