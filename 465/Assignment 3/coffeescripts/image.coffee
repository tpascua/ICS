# Media Class
# Defines Media
# Only border, margin, and padding stayed in Image
# Everything else went into here 
# Added for Assignment 2 Problem 3: Classes in Coffeescript
class Media  
  # Makes a new image initialized with the properties of the '@element'
  constructor: (@element) ->
    @top Math.round JS.CSS.css @element, 'top'
    @left Math.round JS.CSS.css @element, 'left'
    @width Math.round(@element.width())
    @height Math.round(@element.height())
    border =
      width: JS.CSS.css @element, 'border-width'
      color: JS.CSS.css @element, 'border-color'
    @border border
    @margin JS.CSS.css @element, 'margin'
    @padding JS.CSS.css @element, 'padding'
    @link ''

  # Sets or returns the top position of the image
  top: (top_) ->
    return @top_ if arguments.length is 0
    @top_ = top_
    JS.CSS.css @element, 'top', @top_
    @
    
  # Sets or returns the left position of the image
  # Added for Assignment 2 Problem 1: Extend Editing Functionality
  left: (left_) ->
    return @left_ if arguments.length is 0
    @left_ = left_
    JS.CSS.css @element, 'left', @left_
    @
    
  # Sets or returns the width of the image
  width: (width_) ->
    return @width_ if arguments.length is 0
    @width_ = width_
    @element.width @width_
    @
    
  # Sets or returns the height of the image
  height: (height_) ->
    return @height_ if arguments.length is 0
    @height_ = height_
    @element.height @height_
    @
     

  # Sets or returns the width and the color of the border around the image
  border: (border_) ->
    return @border_ if arguments.length is 0
    @border_ = border_
    JS.CSS.css(@element, 'border-width', @border_.width)
    JS.CSS.css(@element, 'border-color', @border_.color)
    @
    
  # Sets or returns the margin around the image
  margin: (margin_) ->
    return @margin_ if arguments.length is 0
    @margin_ = margin_
    JS.CSS.css(@element, 'margin', @margin_)
    @
  
  # Sets or returns the padding around the image
  padding: (padding_) ->
    return @padding_ if arguments.length is 0
    @padding_ = padding_
    JS.CSS.css(@element, 'padding', @padding_)
    @
         
  # Sets or returns the link where to go when the user clicks on the image
  # If 'link_' is null or '' or just white space clicks will be ignored
  # otherwise the clicks will direct the browser to display the target page
  # Added for Assignment 2 Problem 2: Adding Links
  link: (link_) -> 
    return @link_ if arguments.length is 0
    if link_?
      # Get rid of extra white space
      link_ = link_.trim()
      # If blank then its also null
      link_ = null if link_ is ""
    @link_ = link_
    # If @link has some link in it, go to it
    if @link_?
      @element.click =>
        window.location = @link_
    # Do nothing if @link has nothing in it
    else @element.click ->  
    @

# Image Class
# Moved most of the things in here into the new Media class
# Only border, margin, and padding stayed because I think those
# are image specific
# Edited for Assignment 2 Part 3: Classes in Coffeescript
class Image extends Media
  constructor: (@element) ->
    super

###
Canvas class
  Taken from http://www2.hawaii.edu/~janst/465/installation/canvas/canvas.coffee
###
class Canvas
  
  supported = false
  defaultStroke = 
    width:1, color:"#000000"
  # make Canvas class accessible by outside programs
  # so that the can instantiate a canvas with canvas = new Canvas()
  window.Canvas = Canvas
  
  # Creates a canvas for <canvas> with id 'id'
  constructor: (id) ->
    canvas = $("##{id}").get 0
    supported = canvas and canvas.getContext isnt null
    @context = canvas.getContext '2d' if supported
  
  # Draws a line between 'from' and 'to' points 
  line: (from, to, stroke) ->
    return if not supported
    stroke = defaultStroke if not stroke
    @context.strokeStyle = stroke.color
    @context.lineWidth = stroke.width
    @context.beginPath()
    @context.moveTo from.x, from.y
    @context.lineTo to.x, to.y
    @context.stroke()



window.JS = {} unless window.JS
window.JS.Image = Image

$ -> # called when page is ready
  # establish all the DOM elements of our web page that we need
  dom = {}
  ids = ['image', 'top', 'left', 'position',
    'width', 'height', 'resize', 'link',
    'border_width', 'border_color', 'set_border', 'get_border',
    'margin', 'set_margin', 'padding', 'set_padding', 'set_link',
    'stickman']
  dom[id] = $("##{id}") for id in ids
  image = new JS.Image(dom.image)
  stickman = new JS.Image(dom.stickman)
  # fill the entry fields with default values
  dom.top.val image.top()
  dom.left.val image.left()
  dom.width.val image.width()
  dom.height.val image.height()
  border = image.border()
  dom.border_width.val JS.Support.toString JS.CSS.shrink(border.width)
  dom.border_color.val JS.Support.toString JS.CSS.shrink(border.color)
  dom.margin.val JS.Support.toString JS.CSS.shrink image.margin()
  dom.padding.val JS.Support.toString JS.CSS.shrink image.padding()
  # Changes the image width and height when the user clicks "Position"
  # Edited for Assignment 2 Problem 1: Extend Editing Functionality
  dom.position.click ->
    image.top(Number dom.top.val()).left(Number dom.left.val())
  # Changes the image width and height when the user clicks "Resize"
  dom.resize.click ->
    image.width(dom.width.val()).height(dom.height.val())
  # Changes the width and the color of the border around the image when the user clicks "Set Border"
  dom.set_border.click ->
    border = 
      width: JS.Support.parse dom.border_width.val(), JS.CSS.arounds
      color: JS.Support.parse dom.border_color.val(), JS.CSS.arounds
    image.border border
  # Changes the margin around the image when the user clicks "Set Margin"
  dom.set_margin.click ->
    values = JS.Support.parse dom.margin.val(), JS.CSS.arounds
    image.margin JS.CSS.toArounds values
  # Changes the padding around the image when the user clicks "Set Padding"
  # Edited for Assignment 2 Problem 1: Extend Editing Functionality
  dom.set_padding.click ->
    values = JS.Support.parse dom.padding.val(), JS.CSS.arounds
    image.padding JS.CSS.toArounds values
  # Changes the link for the picture
  # Added for Assignment 2 Problem 2: 
  dom.set_link.click ->
    image.link dom.link.val()
  
  # Once the page is constructed, draw a line
  $().ready(->
    new Canvas('stickman').line {x:150, y:1}, {x:69, y:250}
)
  
###
cd "C:/Users/Tyler/Documents/Aptana Studio 3 Workspace/Assignment 2/"
coffee -cwo javascripts/ coffeescripts/
###
