# The superclass of all media elements
#
# Supports positioning and sizing of the element,
# setting the color and width of its border,
# margins outside and padding inside on all four sides,
# as well as linking it to another web page when clicked.
# 
# The numeric parameters are assumed to be in pixels and 
# must be passed as numbers. (Rather than as strings, 
# e.g. as 12 and not as '12px'). Color values must be passed
# as a string in the format '#rrggbb' where 'rr' are the 2 hex
# digits digits of the color's red component, 'gg' are the 2 hex
# of the its green component, and 'bb' are the 2 hex digits of  
# its blue component.
# It is assumed that the values passed as parameters are
# valid, i.e. no validation is performed. 
#
# The formatting is patterned on CSS standards
# The element's initial CSS properties are used as defaults
#
# The design of the interface of Media class follows jQuery
# standards so that a developer can reuse her experience:
# 1) For each property, there is only one function that is used
#    for both setting and getting the property; if the function
#    is called with a parameter value it will set the property
#    and if called without any parameters, it will return the 
#    property's current value
# 2) The functions in setting mode (i.e. w/out parameters) can
#    be chained. (I.e., they return the media element itself,
#    so that another function can be called on the element)
window.js ?= {} # Create js namespace if it doesn't exist
class window.js.Media
    
  # Makes a new media initialized with the properties of the '@element'
  constructor: (@element) ->
    @top Math.round js.Css.css @element, 'top'
    @left Math.round js.Css.css @element, 'left'
    @width Math.round(@element.width())
    @height Math.round(@element.height())
    border =
      width: js.Css.css @element, 'border-width'
      color: js.Css.css @element, 'border-color'
    @border border
    @margin js.Css.css @element, 'margin'
    @padding js.Css.css @element, 'padding'
    @link ''

  # Sets or returns the top position of the media element
  top: (top_) ->
    if top_?
      @top_ = top_
      js.Css.css @element, 'top', @top_
      @
    else @top_
    
  # Sets or returns the left position of the media element
  left: (left_) ->
    if left_?
      @left_ = left_
      js.Css.css @element, 'left', @left_
      @
    else @left_
    
  # Sets or returns the width of the media element
  width: (width_) ->
    if width_?
      @width_ = width_
      @element.width @width_
      @
    else @width_
    
  # Sets or returns the height of the media element
  height: (height_) ->
    if height_?
      @height_ = height_
      @element.height @height_
      @
    else @height_
    
  # Sets or returns the width and the color of the border around the media element.
  # border.color must be in the format #rrggbb where rr are the 2 hex digits of
  # the color's red component, gg are the 2 hex digits of the green component and
  # bb are the 2 hex digits of the blue component.
  border: (border) ->
    if border?
      @border_ = border
      log "#{@} set border", border, '  '
      js.Css.css(@element, 'border-width', border.width)
      js.Css.css(@element, 'border-color', border.color)
      @
    else @border_
    
  # Sets or returns the margin around the media element
  margin: (margin) ->
    if margin?
      @margin_ = margin
      js.Css.css(@element, 'margin', margin)
      @
    else @margin_
  
  # Sets or returns the padding around the media element
  padding: (padding_) ->
    if padding_?
      @padding_ = padding_
      js.Css.css(@element, 'padding', @padding_)
      @
    else @padding_
    
  # Sets or returns the link where to go when the user clicks on the media element
  # If 'link_' is null of '' or just white space, the click will be ignored.
  # Otherwise the click wil display the target page within the browser.
  link: (link_) ->
    if link_?
      # Get rid of extra white space
      link_ = link_.trim()
      # If blank then its also null
      link_ = null if link_ is ""
    @link_ = link_  
    @
