# Miscellaneous support functions
class Support
  
  # Returns either the object or the array described by 'string'
  # possible separators are ' ', ';' and ','
  # Note: This algorithm assumes that the only ':' within the 'string' are such ':'
  # which indicate that the preceding word is a property key,
  # i.e. it will not work for a string that has ':' which is within a property value,
  # such as within a property substring or a url
  Support.parse = (string, keys) ->
    # Returns the long key for abbreviated key
    equivalent = (key) ->
      for key_ in keys
        return key_ if key_.startsWith key
      key_
    [object, keys_] = [{}, []]
    # does string contain properties with a key?
    # a key must be substring of word characters and dashes followed by ':'
    string = string.replace(/\s+\:/g, ':')
    pattern = /([\w-]+):/g
    match = pattern.exec string
    while match?
      keys_.push match[1]
      match = pattern.exec string
    if keys_.length > 0  # string with keys; convert to objects
      # go through string splitting off values till the next property key_
      # and allocating each value to the preceding key_
      lastKey = null # preceding key_ (unabbreviated)
      for key_, index in keys_
        # pattern without separator for 1st key_
        pattern = new RegExp("#{if index is 0 then '' else '[\\s;,]'}#{key_}:")
        # chop off value from 'string'
        [value, string] = string.split(pattern, 2)
        # associate the 'value' with preceding property key_
        object[lastKey] = value unless index is 0
        # remember next key_ in unabbreviated form
        lastKey = equivalent key_
      # string is now the last value, associate it 'value' with last property key_
      object[lastKey] = string
      object
    else # string has no keys, convert to an array
      leftParent = string.index '('
      rightParent = string.index ')'
      separator = {index:-1} # initially empty
      for char in [' ', ',', ';'] # possible separators
        index = string.index char
        if index?
          index = string.indexOf(char, rightParent) if index? and leftParent? and (index > leftParent)
          separator = {char:char, index:index} if index? and (index > separator.index)
      if separator.char? then string.split separator.char else [string]
    
  # Returns textual representation of 'object'
  Support.toString = (object) ->
    JSON.stringify(object).replace(/\{(.*)\}/g, '$1').replace(/"/g, '').replace(/\s/g, ',')

  # Returns an object filled with properties in 
  Support.filled = (keys, filler) ->
    object = {}
    object[key] = filler key, index for key, index in keys
    object
  
  Support.type = (value) ->
    if value isnt undefined and value isnt null
      type_ = Object::toString.call value
      type_ = type_.substring 8, type_.length - 1
      if (type_ is 'Number') and isNaN value then 'NaN' else type_
    else String value

  # Variant of String's indexOf that returns null if there is no such substring
  String::index = (substring) ->
    index = @indexOf(substring)
    if index < 0 then null else index
  
  # Polyfill for browsers that don't support startsWith() of String
  unless typeof String::startsWith is 'function'
    String::startsWith = (substring) -> @lastIndexOf(substring, 0) is 0

window.JS = {} unless window.JS
window.JS.Support = Support

###
cd "/Users/jan/Documents/workspace/465/2_image/"
coffee -cwo javascripts/ coffeescripts/
###