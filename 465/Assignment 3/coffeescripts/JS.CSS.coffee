# Management of style based on the functionality of CSS rules
# Simple style UI as well as UI according to CSS standards
# Setting and getting styles of DOM elements according to this UI
class CSS
  
  # directions around an element in order according to CSS standard
  CSS.arounds = ['top', 'right', 'bottom', 'left']
  
  # CSS rules that have directional components around an element
  CSS.aroudRules = ['margin', 'padding', 'border-width', 'border-color']
  
  # CSS rule types
  CSS.rules =
    numeric: ['top', 'left', 'margin', 'padding', 'border-width']
    colors:  ['color', 'background-color', 'border-color']
  
  # Returns 'pixels' without the 'px' suffix
  CSS.noPx = (pixels) -> Math.round pixels.replace('px', '')
  
  # Returns 'pixels' appended by 'px' if needed by CSS standard
  CSS.addPx = (pixels) -> "#{pixels}#{if pixels is 0 then '' else 'px'}"
  
  # Returns the same 'value'
  CSS.same = (value) -> value
  
  # Returns color in the pound-sign hex format from the 'rgb()' format
  CSS.hexColor = (value) ->
    # extract the color conponents and make an array of 3 hex-bytes
    bytes = for number in value.match(/(\d+).*(\d+).*(\d+)/)[1..3]
      number = Number(number)
      "#{if number < 16 then '0' else ''}#{number.toString(16)}"
    # return the concatenation
    "##{bytes.join ''}"
  
  # Conversions of values to and from the CSS standard to simpler form
  CSS.from = {}
  CSS.to = {}
  for key in CSS.rules.numeric
    CSS.from[key] = CSS.noPx
    CSS.to[key] = CSS.addPx
  for key in CSS.rules.colors
    CSS.from[key] = CSS.hexColor
    CSS.to[key] = CSS.same
    
  # Sets or returns the CSS value(s) of the 'key' properties of the 'element'
  CSS.css = (element, key, values) =>
    # Make prefix and suffix based on key
    split = =>
      [prefix, suffix] = key.split '-'
      suffix = if suffix? then "-#{suffix}" else ''
      [prefix, suffix]
    if values? # set values
      toCss = CSS.to[key]
      if key in CSS.aroudRules # set styles in all 4 directions
        [prefix, suffix] = split()
        # set element's CSS properties to values
        element.css "#{prefix}-#{key_}#{suffix}", toCss(values[key_]) for key_ in CSS.arounds
        null # avoid comprehensions
      else element.css key, toCss(values)
    else # get and return values
      fromCss = CSS.from[key]
      if key in CSS.aroudRules # get styles in all 4 directions
        [prefix, suffix] = split()
        # make and return values object corresponding to element's CSS properties
        property = (key_) -> fromCss(element.css "#{prefix}-#{key_}#{suffix}")
        JS.Support.filled CSS.arounds, property
      else fromCss(element.css key)
        
  # If all directions have the same value returns this value otherwise returns 'values' 
  CSS.shrink = (values) ->
    value = values.top
    for key_, value_ of values
      return values if value_ isnt value
    value
    
  CSS.toArounds = (values) ->
    if JS.Support.type(values) is 'Array'
      values = switch values.length
        when 0 then [0, 0, 0, 0]
        when 1 then values[0] for i in [1..4]
        when 2 then values.concat values
        when 3 then values.concat [values[1]]
        else values
      JS.Support.filled CSS.arounds, (key, index) -> values[index]
    else values
      
  # Returns an object where all the directions have the same 'value'
  CSS.expand = (value) -> JS.Support.filled CSS.arounds, -> value
    
window.JS = {} unless window.JS
window.JS.CSS = CSS

###
cd "/Users/jan/Documents/workspace/465/2_image/"
coffee -cwo javascripts/ coffeescripts/
###