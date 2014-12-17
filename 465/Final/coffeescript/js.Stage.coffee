# Drawings on <canvas> element via HTML5 Canvas API.
# Supports multitude of the following shapes:
#   Circle and Point (small circle)
#   Rectangle and Square
#   Polygon
#   Line (line segment to be exact)
#   MaxLine (line bounded only be the canvas area)
#
# Supports coloring a shape's inner area as well as styling
# - color and width - of its outline stroke
#
# Ensures that the canvas has the same size as defined in its CSS style rules.
# Provides for simplified functions to the 'context' of the canvas.
#
# Note: Efficiency of performance is intentionally sacrificed in order to
# improve the readability of code.
# (E.g. points are defined and passed on as in an object with 'x' and 'y' 
# properties, rather than as separate numerical values.)

window.js ?= {} # Create js namespace if it doesn't exist

class window.js.Stage extends window.js.Media
  
  # Helpful property ids (static class variables)
  Stage.xys = ['x', 'y']
  Stage.sizings = ['x', 'y', 'width', 'height']
  
  # initial values of hidden variables
  [context, shapes] = [null, []]
  
  # Makes a new Shape in a 'canvas' DOM element
  # Expects 'canvas' to have <canvas> tag.
  # Note: Ensures that the 'canvas' has the same size as defined in its CSS style rules
  constructor: (canvas) ->
    super canvas
    # make sure that the entire canvas isn't stretched when it's size is defined in CSS
    canvas.attr 'width', canvas.width()
    canvas.attr 'height', canvas.height()
    # remember the context in a private local variable
    context = canvas.get(0).getContext '2d'
  
  # Functions that return a newly created shape and add it to the drawing
  # for all the supported shape types
  
  line: -> add new js.Line(@)
  
  square: -> add new js.Square(@)
  
  rectangle: -> add new js.Rectangle(@)
  
  polygon: -> add new js.Polygon(@)
  
  maxLine: -> add new js.MaxLine(@)
  
  circle: -> add new js.Circle(@)
  
  point: -> add new js.Point(@)
  
  # Adds 'shape' to the stage.
  # The 'shape' will appear on top of the previously added shapes.
  add = (shape) ->
    shapes.push shape
    shape
  
  # Removes a shape from the stage.
  # Note: not tested
  dispose: (shape) ->
    (shapes.slice i, 1 if shape_ is shape) for shape_, i in shapes
    shape
  
  # Removes a shape from the stage.
  # Note: not implemented, yet
  reorder: (direction, allTheWay) ->
    
  # Draws all the shapes on the erased stage
  draw: ->
    # erase the stage
    context.clearRect 0, 0, context.canvas.width, context.canvas.height
    # draw all shapes
    shape.draw() for shape in shapes
    @
  
  # Returns the top shape that contains the point 'p'.
  # Returns null if no shape contains 'p'.
  hit: (p) ->
    for shape in shapes by -1  # loops through shapes in reverse order
      return shape if shape.inside p 
    null
  
  # Functions that eliminate the need to access 'context' and allow chaining.
  # (I.e. they all return this stage so that other functions can be called on it.)
  
  moveTo: (p) -> context.moveTo p.x, p.y; @
  
  lineTo: (p) -> context.lineTo p.x, p.y; @
    
  rect: (at, to) -> context.rect at.x, at.y, to.x - at.x, to.y - at.y; @
  
  circle_: (at, radius) -> context.arc at.x, at.y, radius, 0, 2 * Math.PI, true; @

  translate: (vector) -> context.translate vector.x, vector.y; @
  
  scale: (factor) -> context.scale factor.x, factor.y; @
  
  save: -> context.save(); @
  
  restore: -> context.restore(); @
  
  beginPath: -> context.beginPath(); @
  
  closePath: -> context.closePath(); @

  # Sets the context so that a shape's will be drawn in 'style_' defined
  # with properies 'color' to fill the shapes area and 'stroke' object with 
  # properies 'width' and 'color' of the stroke outline of the shape
  style: (style) ->
    if style.color?
      context.fillStyle = style.color
      context.fill()
    if style.stroke?
      context.strokeStyle = style.stroke.color if style.stroke.color?
      context.strokeWidth = style.stroke.width if style.stroke.width?
      context.stroke()
    @
    
  # Returns the context, just in case that a shape class should need it
  context: -> context

  # Returns the area of the stage with properties 'width' and 'height'
  area: -> {width:context.canvas.width, height:context.canvas.height}
  
  # Returns the description of this stage
  toString: -> 'stage'
  
# Superclass of all shapes.
# Takes care of all the menial chores, such as such as (re-)storing the context,
# performing the generic transformations (moving and scalling it), beginning and 
# ending the shape's drawing and styling it.
# A subclass doesn't need to adjust its area when it is moved or scalled, this
# Shape superclass takes care of this.
# In essence, how the Canvas API standard should have been defined to start with...
# Note: Currently there is no checking whether scalling factors are (close to) 0
# which will result in an error being thrown.
class window.js.Shape
  
  # Makes a new Shape.
  # Must be called in subclass' constructor.
  constructor: (@stage) ->
    # default transformations; note: @t is currently used only to store
    # move vector and scale factor, not for custom transformations
    @t =
      move:  {x:0, y:0}
      scale: {x:1, y:1}
      skew:  {x:0, y:0} # not used
      
  # Sets or returns the upper left corner of the bounds as the registration point.
  # The shape will be moved accordingly.
  # Note: Must be overriden by every subclass.
  at: (at) ->
    
  # Sets or returns the shape's style defined with property 'color' 
  # to fill the shapes area and property 'stroke' as an object with 
  # properies 'width' and 'color' of the shape's stroke outline 
  style: (style) ->
    if style? then @style = style; @ else @style
  
  # Moves the shape by 'vector'
  move: (vector) ->
    @t.move.x += vector.x
    @t.move.y += vector.y
    @
      
  # Scales the shape by 'factor' based on the registration point in
  # the top left corner of its bounds.
  scale: (factor) ->
    @t.scale.x *= factor.x
    @t.scale.y *= factor.y
    @
    
  # Draws the shape.
  # To be called by the subclass' draw().
  # The subclass's draw() must supply 'subDraw' argument where subDraw() is 
  # a function which draws the actual shape.
  # Note: the subclass's draw() doesn't need to do any of the menial chores
  # such as (re-)storing the context, do the generic transformations 
  # (moving and scalling it), beginning and ending the drawing and styling it.
  draw: (subDraw) ->
    bounds = @bounds()
    # the canvas has first moved so that the registration point (the upper left corner 
    # of the bounds) is in the origing of the canvas so that the subsequent scalling
    # is correct, then moved back and moved by the move vector. 
    # make the vector that combines the latter two moves 
    vectorBack = {x:@t.move.x - bounds[0].x, y:@t.move.y - bounds[0].y}
    # save canvas, move to origin, scale, do combined moves, then draw the shape,
    # restore canvas, and style the shape
    @stage.save().translate(bounds[0]).scale(@t.scale).translate(vectorBack).beginPath()
    subDraw().closePath().restore().style(@style)
    @
          
  # Returns the shape's bounds: an array of 2 point objects with properties 'x' and 'y'.
  # To be called by the subclass' bounds().
  # The subclass's bounds() must supply 'subBounds' argument where subBounds() 
  # is a function which returns the original bounds of the shape.
  # These bounds are adjusted by the movement and scalling operations.
  # Note: the original bounds aren't changed.
  bounds: (subBounds) ->
    # make a local copy of the shape's bounds so that we can mess with its values  
    box = js.Support.clone subBounds()
    # set registration point 'at'
    at = @at()
    # move, scale and then return the bounds
    [@fromOriginal(box[0], at), @fromOriginal(box[1], at)]
    
  # Returns whether point 'p' is inside this shape.
  # Every subclass must provide a subInside(p') function that returns whether
  # point p' is insite its original area.
  # Note: Throws an error if a scalling factor is (close to) 0
  # Note: Must be overriden by every subclass.
  inside: (p, subInside) -> subInside @toOriginal(p, @at())
  
  # Sets or returns the shape's label.
  # Note: good for debugging.
  label: (label) -> 
    if label? then @label_ = label; @ else @label_
  
  # Returns the description of the shape in terms of its label and 'details'
  toString: (details) => "#{@label_}: #{JSON.stringify details}"

  # Returns point resulting when point 'p' is moved and scalled with respect
  # to the registration point 'at'.
  fromOriginal: (p, at) =>
    p = 
      x: at.x + @t.move.x + (p.x - at.x) * @t.scale.x
      y: at.y + @t.move.y + (p.y - at.y) * @t.scale.y
      
  # Returns point resulting when moved and scalled point 'p' with respect 
  # to the registration point 'at' is transformed back to the shapes's original
  # coordinate system.
  toOriginal: (p, at) =>
    p_ =
      x: at.x + (p.x - at.x - @t.move.x) / @t.scale.x
      y: at.y + (p.y - at.y - @t.move.y) / @t.scale.y
      
# Defines circle around a center point with specific radius.
# Note that scalling can deform the circle to a oval (aka eclipse).
class window.js.Circle extends js.Shape
  
  # Makes a new Square initially in origin and with 50 pixels radius.
  constructor: (stage) ->
    super stage
    # intial properties
    [@center_, @radius_] = [{x:0, y:0}, 50]
    
  # Sets or returns the upper left corner of the bounts as the registration point.
  # The radius will remain unchanged; the center will be adjusted accordingly.
  at: (at) ->
    if at? then @center_ = {x: at.x + @radius_, y: at.y + @radius_}; @
    else {x: @center_.x - @radius_, y: @center_.y - @radius_}
      
  # Sets or returns the circle's center point.
  center: (center) ->
    if center? then @center_ = center; @ else @center_
  
  # Sets or returns the circle's radius.
  radius: (radius) ->
    if radius? then @radius_ = radius; @ else @radius_
  
  # Draws the circle.
  # Note: Calls the superclass' draw() and provides it with a function that
  # just draws the circle. The superclass' draw() takes care of all the other chores.
  draw: => super => @stage.circle_ @center_, @radius_
  
  # Returns the circle's bounds adjusted for motion and scalling.
  # Note: Calls the superclass' bounds() and provides it with a function that
  # just returns the original bounds. The superclass' bounds() takes care of motion and scalling.
  bounds: => 
    super => 
      [@at(), {x: @center_.x + @radius_, y: @center_.y + @radius_}]
  
  # Returns whether point 'p' is inside the circle.
  # Note: Calls the superclass' inside() and provides it with a function that
  # returns whether this circle contains a point in original coordinal system. 
  inside: (p_) => # 'p_' is moved and scalled
    super p_, (p) => # to be called with p in original coordinates
      [dx, dy] = [@center_.x - p.x, @center_.y - p.y]
      dx * dx + dy * dy < @radius_ * @radius_
    
  # Returns the description of the circle in terms of its center and radius
  toString: -> super {center:@center_, radius:@radius_}

# Defines a small circular point with 3 pixel radius and black stroke outline.
class window.js.Point extends js.Circle
  
  # Makes the point
  constructor: (stage) ->
    super stage
    @radius(3).style {stroke:{color:'black'}}

  # Returns the description of the point
  toString: -> super @p
    
# Defines a rectangle.
class window.js.Rectangle extends js.Shape
  
  # Makes a rectange initially in origin and 50 pixels wide and high.
  constructor: (stage) ->
    super stage
    [@at_, @to_] = [{x:0, y:0}, {x:50, y:50}]
  
  # Sets or returns the rectangle's top left corner which is also the registration point.
  # The width and height of the rectangle remain unchanged so that it is just repositioned.
  at: (at) ->
    if at?
      @to_ = {x:at.x + @to_.x - @at_.x, y:at.y + @to_.y - @at_.y}
      @at_ = {x:at.x, y:at.y}
      @
    else {x:@at_.x, y:@at_.y} 
  
  # Sets or returns the rectangle's bottom right corner.
  # If the corner is set to 'to', the top left corner remains unchanged,
  # i.e. the width and height of the rectangle will typically change so that
  # the rectangle will be resized.
  # Note: width() and height() can be called instead of calling to()
  to: (to) ->
    if to? then @to_ = {x:to.x, y:to.y}; @ else {x:@to_.x, y:@to_.y}
  
  # Sets or returns the width of the rectangle.
  # The top left corner remains unchanged.
  width: (width) ->
    if width? then @to_.x = @at_.x + width; @ else @to_.x - @at_.x
     
  # Sets or returns the height of the rectangle.
  # The top left corner remains unchanged.
  height: (height) ->
    if height? then @to_.y = @at_.y + height; @ else @to_.y - @at_.y
  
  # Draws the rectangle.
  # Note: Calls the superclass' draw() and provides it with a function that
  # just draws the rectangle. The superclass' draw() takes care of all the other chores.
  draw: => super => @stage.rect @at_, @to_
  
  # Returns the rectangle's bounds adjusted for motion and scalling.
  # Note: Calls the superclass' bounds() and provides it with a function that
  # just returns the original bounds. The superclass' bounds() takes care of motion and scalling.
  bounds: => super => [@at_, @to_]
     
  # Returns whether point 'p' is inside the rectangle.
  # Note: Calls the superclass' inside() and provides it with a function that
  # returns whether this rectangle contains a point in original coordinal system. 
  inside: (p_) => # 'p_' is moved and scalled
    super p_, (p) => # to be called with p in original coordinates
      (@at_.x <= p.x <= @to_.x) and (@at_.y <= p.y <= @to_.y)
    
  # Returns the description of the rectangle in terms of its diagonal corners
  toString: -> super {at: @at_, to: @to_}

# Defines a square.
# Note that scalling can deform the square to a rectangle.
class window.js.Square extends js.Rectangle
  
  # Makes a new Square initially in origin and with sides 50 pixels long.
  constructor: (stage) -> super stage
  
  # Sets or returns the height of the square.
  # The top left corner remains unchanged.
  side: (side) ->
    if side? then @width side; @height side; @
    else @width()
    
# Defines a closed polygon.
class window.js.Polygon extends js.Shape
  
  # Makes a new Polygon initially only as line from the origin to (50, 50).
  constructor: (@stage) ->
    super stage
    @ps = [{x:0, y:0}, {x:50, y:50}]

  # Sets or returns the corner points of the polygon.
  # Returns null if 'points_' isn't specified and corners haven't been set yet.
  points: (ps) -> 
    if ps? then @ps = ps; @ else @ps
  
  # Sets or returns the top left corner of the polygon's bounds which is also the registration point.
  # The shape the polygon remain unchanged so that it is just repositioned.
  at: (at) ->
    bounds = @originalBounds()
    if at?
      [dx, dy] = [at.x - bounds.x, at.y - bounds.y]
      p = {x:p.x + dx, y:p.y + dy} for p_ in @ps
      @
    else bounds[0]
  
  # Draws the polygon.
  # Note: Calls the superclass' draw() and provides it with a function that
  # just draws the polygon. The superclass' draw() takes care of all the other chores.
  draw: =>
    super =>
      # position pen at the start corner
      @stage.moveTo @ps[0]
      # keep moving pen to remaining corners
      @stage.lineTo @ps[i] for i in [1...@ps.length]
      @stage
      
  originalBounds: ->
    compare = [Math.min, Math.max]
    box = js.Support.clone [@ps[0], @ps[0]]
    for p in @ps
      for i in [0..1]
        box[i] =
          x: compare[i] box[i].x, p.x
          y: compare[i] box[i].y, p.y
    box
  
  # Returns the polygon's bounds adjusted for motion and scalling.
  # Note: Calls the superclass' bounds() and provides it with a function that
  # just returns the original bounds. The superclass' bounds() takes care of motion and scalling.
  bounds: =>
    super =>
      @originalBounds()
    
  # Returns whether point 'p' is inside the polygon.
  # Note: Calls the superclass' inside() and provides it with a function that
  #   returns whether this rectangle contains a point in original coordinal system.
  # Note: Unlike for other shapes, this function provides for subInside()
  #   provided by subclasses of Polygon - it simply passes on their subInside()
  inside: (p_, subInside) => # 'p_' is moved and scalled
    # if subclass provides 'subInside', use it, otherwise define one 
    unless subInside?
      subInside = (p) => # to be called with p in original coordinates
        box = @bounds()
        (box[0].x <= p.x <= box[1].x) and (box[0].y <= p.y <= box[1].y)
    super p_, subInside

  # Returns the description of the polygon in terms of its corners
  toString: -> super @ps

# Defines a line segment in between its end points.
# Line is tailored to support interactivity with the user: It accounts for a narrow
# strip within which a point is considered to be inside the line.
# (In strict geometric terms a line has no width, which would make selecting a line
# a very tedious endeavour.)  
class window.js.Line extends js.Polygon

  # Square of the width of the stripe around the line within which a point is
  # considered to lie on/inside the line. 
  stripLimitSquare = 4 * 4;
  
  # Makes a new Line initially from the origin to (50,50).
  constructor: (@stage) -> super stage

  # Sets or returns the 1st end point of the line segment.
  # Note: The 2nd end point will remain unchanged.
  from: (p) ->
    if p? then @points [p, @ps[1]] else @ps[0]
  
  # Sets or returns the 2nd end point of the line segment.
  # Note: The 1st end point will remain unchanged.
  to: (p) -> 
    if p? then @points [@ps[0], p] else @ps[1]
    
  # Sets or returns the end points of the line segment.
  # Note: Only the first 2 points_ will be considered.
  points: (ps) -> 
    ps = ps[0..1] if ps?
    super ps
      
  # Returns whether point 'p' is inside the 4 pixel wide strip around the line.
  # Note: Calls the superclass' inside() and provides it with a function that
  #   returns whether this rectangle contains a point in original coordinal system.
  inside: (p_) => # 'p_' is moved and scalled
    super p_, (p) => # to be called with p in original coordinates
      # line equation
      a = @ps[0].y - @ps[1].y
      b = @ps[1].x - @ps[0].x
      c = @ps[0].x * @ps[1].y - @ps[1].x * @ps[0].y
      # distance p to line
      d = a * p.x + b * p.y + c
      a2b2 = a * a + b * b
      return false if d * d > a2b2 * stripLimitSquare # beyond line limits
      if Math.abs(a) > Math.abs(b)  # compare y
        y = (a * (a * p.y - b * p.x) - b * c) / a2b2
        (y < @ps[0].y) isnt (y < @ps[1].y)
      else  # compare x
        x = (b * (b * p.x - a * p.y) - a * c) / a2b2
        (x < @ps[0].x) isnt (x < @ps[1].x)
     
# Defines a line bounded by the area of the canvas.
class window.js.MaxLine extends js.Line

  # Makes a new MaxLine initially from the origin to (50,50).
  constructor: (@stage) -> super stage

  # Sets or returns the end points of the line.
  # When 'ps' points are set, the end points are computed to be on the edges
  # of the stage area. 
  # Limitation note: Moving or scalling the line is bound to make it be drawn
  # so that the end point(s) are not at the boudary of the stage.
  points: (ps) ->
    if ps?
      area = @stage.area()
      points = if ps[0].x is ps[1].x
          [{x: ps[0].x, y:0}, {x:ps[0].x, y:area.height}]
        else if ps[0].y is ps[1].y
          [{x: 0, y:ps[0].y}, {x:area.width, y:ps[0].y}]
        else
          [c, m] = Geometry.lineCoefficientsY ps
          x2 = area.width
          [{x: 0, y:c}, {x:x2, y:m * x2 + c}]
      super points
      @
    else @ps
  
# Provides basic geometry support
# Not used, yet.
class window.js.Geometry
  
  # Precision limit for determining whether lines are parallel to an axis.
  Geometry.limit = 1e-5
  
  # Returns the coefficients of the line allowing to compute x given y
  #   defined by points ps (array of 2 objects with 'x' and 'y' properties)
  # x = m * y + c
  # Returns null if y1 ~= y2 and not x1 ~= x2
  Geometry.lineCoefficientsX = (ps) ->
    dx = ps[0].x - ps[1].x
    dy = ps[0].y - ps[1].y
    if Math.abs(dy) > Geometry.limit
      m = dx / dy
      [ps[0].x - m * ps[0].y, m]
    else if Math.abs(dx) < Geometry.limit then [ps[0].x]
    else null
    
  # Returns the coefficients (constant and slope) of the line
  #   defined by points ps (array of 2 objects with 'x' and 'y' properties)
  # y = m * x + c
  # returns null if x1 ~= x2 and not y1 ~= y2
  Geometry.lineCoefficientsY = (ps) ->
    dx = ps[0].x - ps[1].x
    dy = ps[0].y - ps[1].y
    if Math.abs(dx) > Geometry.limit
      m = dy / dx
      [ps[0].y - m * ps[0].x, m]
    else if Math.abs(dy) < Geometry.limit then [ps[0].y]
    else null