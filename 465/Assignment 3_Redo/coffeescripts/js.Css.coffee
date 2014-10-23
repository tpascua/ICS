# Management of style based on the functionality of CSS rules
# Supports simple style UI as well as UI according to CSS standards
# Supports setting and getting styles of DOM elements according to this UI
#
# Note: Assumes that all parameters for setting properties have valid values,
# i.e., no validation is supported, yet.
window.js ?= {} # Create js namespace if it doesn't exist
class window.js.Css
  
  # directions around an element in order according to CSS standard
  Css.arounds = ['top', 'right', 'bottom', 'left']
  
  # CSS rules that have directional components around an element
  Css.aroudRules = ['margin', 'padding', 'border-width', 'border-color']
  
  # CSS rule types
  Css.rules =
    numeric: ['top', 'left', 'margin', 'padding', 'border-width']
    colors:  ['color', 'background-color', 'border-color']
  
  # Returns 'pixels' without the 'px' suffix
  Css.noPx = (pixels) -> Math.round pixels.replace('px', '')
  
  # Returns 'pixels' appended by 'px' if needed by CSS standard
  Css.addPx = (pixels) -> "#{pixels}#{if pixels is 0 then '' else 'px'}"
  
  # Returns the same 'value'
  Css.same = (value) -> value
  
  # Returns color in the pound-sign hex format from the 'rgb()' format
  Css.hexColor = (value) ->
    # extract the color conponents and make an array of 3 hex-bytes
    bytes = for number in value.match(/(\d+) *, *(\d+) *, *(\d+)/)[1..3]
      number = Number number 
      "#{if number < 16 then '0' else ''}#{number.toString(16)}"
    # return the concatenation
    "##{bytes.join ''}"
  
  # Conversions of values to and from the CSS standard to simpler form
  Css.from = {}
  Css.to = {}
  for key in Css.rules.numeric
    Css.from[key] = Css.noPx
    Css.to[key] = Css.addPx
  for key in Css.rules.colors
    Css.from[key] = Css.hexColor # note: we rely on all browsers returnig rgb format
    Css.to[key] = Css.same
    
  # Sets or returns the CSS value(s) of the 'key' properties of the 'element'
  Css.css = (element, key, values) =>
    # Make prefix and suffix based on key
    split = =>
      [prefix, suffix] = key.split '-'
      suffix = if suffix? then "-#{suffix}" else ''
      [prefix, suffix]
    if values? # set values
      toCss = Css.to[key]
      if key in Css.aroudRules # set styles in all 4 directions
        [prefix, suffix] = split()
        # set element's CSS properties to values
        for key_ in Css.arounds
          element.css "#{prefix}-#{key_}#{suffix}", toCss(values[key_])
          lAdd "#{prefix}-#{key_}#{suffix}", toCss(values[key_])
        log "#{element.attr 'id'} set"
        element
      else element.css key, toCss(values)
    else # get and return values
      fromCss = Css.from[key]
      if key in Css.aroudRules # get styles in all 4 directions
        [prefix, suffix] = split()
        # make and return values object corresponding to element's CSS properties
        property = (key_) ->
          #lAdd "get #{prefix}-#{key_}#{suffix}", fromCss(element.css "#{prefix}-#{key_}#{suffix}")
          fromCss(element.css "#{prefix}-#{key_}#{suffix}")
        log "#{element.attr 'id'} get", js.Support.filled(Css.arounds, property)
        js.Support.filled Css.arounds, property
      else fromCss(element.css key)
        
  # If all directions have the same value returns this value otherwise returns 'values' 
  Css.shrink = (values) ->
    value = values.top
    for key_, value_ of values
      return values if value_ isnt value
    value
  
  # If 'values' is an array returns an object with top, right, bottom, left properties
  # The items of 'values' array have the following semantics (as in the CSS standard):
  #   item 0: for top, also for bottom if there is no item 2, and 
  #           for all properties if there are no other items
  #   item 1: for right; also for left if there is no item 3
  #   item 2: for bottom
  #   item 3: for left
  # If 'values' is an empty array, returns object where all properties are 0.
  # Returns 'values' if 'values' isn't an array.
  Css.toArounds = (values) ->
    if js.Support.type(values) is 'Array'
      values = switch values.length
        when 0 then [0, 0, 0, 0]
        when 1 then values[0] for i in [1..4]
        when 2 then values.concat values
        when 3 then values.concat values[1]
        else values
      js.Support.filled Css.arounds, (key, index) -> values[index]
    else values
      
  # Returns an object where all the directions have the same 'value'
  Css.expand = (value) -> js.Support.filled Css.arounds, -> value

###
cd "/Users/jan/Documents/workspace/465/3_media/"
coffee -cwo javascripts/ coffeescripts/
###