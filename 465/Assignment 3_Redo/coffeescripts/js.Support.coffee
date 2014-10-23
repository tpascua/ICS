# # Miscellaneous DOM related support functionality
window.js ?= {} # Create js namespace if it doesn't exist
class window.js.Dom
  
  # names of area components in CSS format
  Dom.areaKeys = ['top', 'left', 'width', 'height']
  # names of dimensions in CSS format
  Dom.arounds = ['top', 'left', 'bottom', 'right']
  
  # Returns a set jQuery DOM elements (more exactly sets of elements) with 'ids'
  # 'ids' must be an array of strings 
  Dom.dom = (ids) ->
    js.Support.filled ids, (id) -> $ "##{id}"

# Miscellaneous support functionality
class window.js.Support
  
  # Names of usefull keyboard keys so that we don't use ASCII codes
  Support.keys =
    enter:  13
    escape: 27
    
  # Returns wheter the keyboard key 'id' was pressed given an 'event'
  #   Usage:
  #     if js.Support.pressed(event, 'escape') #...
  Support.pressed = (event, id) -> event.which is js.Support.keys[id]

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
    keys_ = []
    # normalize
    # get rid of extra white space
    string = string.trim().replace(/\s+/g, ' ').replace /[ ]*([:,;()'\"]) */g, '$1'
    # put parenthesized text on separate pieces
    pieces = string.replace(/\((.*?)\)/g, '\n($1)\n').split('\n')
    # separate items outside parentheses by ';', inside parentheses by ','
    for piece, index in pieces
      separator = if (index % 2) is 0 then ';' else ','
      pieces[index] = piece.replace(/[ ,;]/g, separator)
    string = pieces.join ''
    # split into properties
    pieces = string.split ';'
    # does 1st pieces contain a properties with a key?
    # a key must be substring of word characters and dashes followed by ':'
    pattern = /([\w-]+?):/g
    if pattern.test pieces[0] # strings with keys; convert to properties of an object
      object = {}
      for piece in pieces
        [key, value] = piece.split ':', 2
        object[key] = value
      object
    else # strings have no keys, return pieces
      pieces

  # Returns the clone of the 'value'.
  # Note that 'value' can be of any type (not only an object), i.e. a number, string, boolean, array
  # 'value' cannot be an object with circular references
  Support.clone = (value) -> JSON.parse JSON.stringify value
  
  # Returns textual representation of 'object'
  Support.toString = (object) ->
    JSON.stringify(object).replace(/\{(.*)\}/g, '$1').replace(/"/g, '').replace(/\s/g, ',')

  # Returns an object filled with properties whose values are determined by 
  # calling 'filler' for all 'keys' 
  # 'keys' must be an array of strings
  # Usage:
  #   object = js.Support.filled ['key1', 'key2'], (key) -> expression # that depends on 'key'
  Support.filled = (keys, filler) ->
    object = {}
    object[key] = filler key, index for key, index in keys
    object
       
  # Returns an arrar filled with 'n' items whose values are determined by
  # calling 'filler' for all indices in 0..n-1 
  # 'n' must be an integer
  # Usage:
  #   object = js.Support.filledArray 10, (index) -> expression # that depends on 'index'
  Support.filledArray = (n, filler) ->
    array = []
    array[i] = filler i for i in [0...n]
    array
  
  # Returns the type of 'value'
  # Note that the returned type starts with capital letter, e.g. Array, Object, or Boolean  
  Support.type = (value) ->
    if value isnt undefined and value isnt null
      type_ = Object::toString.call value
      type_ = type_.substring 8, type_.length - 1
      if (type_ is 'Number') and isNaN value then 'NaN' else type_
    else String value

  # Variant of String's indexOf() that returns null if there is no such substring
  # Note: the String's indexOf() returns -1 which is mostly less convenient
  String::index = (substring) ->
    index = @indexOf(substring)
    if index < 0 then null else index
  
  # Returns whether this String starts with 'substring'
  # Polyfill for browsers that don't support startsWith() of String
  unless typeof String::startsWith is 'function'
    String::startsWith = (substring) -> @lastIndexOf(substring, 0) is 0
  
  # Returns whether this String ends with 'substring'
  String::endsWith = (substring) ->
    @lastIndexOf(substring, 0) + substring.length is @length
  
  # Replaces the 'index'-th character in this string by 'char'
  String::setCharAt = (index, char) ->
    return @ if index >= @length
    "#{@substr(0, index)}#{char}#{@substr(index + 1)}"
    
  # testing
  texts = [
    "right:5;top:6"
    "top:5;right:6"
    "right: 5 , top:6"
    "right:5  top:6"
    "  right : 5 ; top  :  6  "
    "4,5,6"
    "4 , 5 , 6"
    "4;5;6"
    "4 ;  5  ; 6"
    "4 5  6"
    "right:5 top:6"
  ]
  console.log "#{text} #{JSON.stringify(Support.parse text, js.Dom.arounds)})" for text in texts

###
cd "/Users/jan/Documents/workspace/465/3_media/"
coffee -cwo javascripts/ coffeescripts/
###