window.js ?= {} # Create js namespace if it doesn't exist
class window.js.Editor

  # establish all the DOM elements of our web page that we need
  dom = {}
  
  entryIds = ['top', 'left', 'width', 'height', 
    'margin', 'padding', 'border_width', 'border_color', 'link']
  ids = entryIds.concat ['image', 'drawing', 'playground'
    'set_area', 'set_border', 'set_layout', 'set_link', 'test_links']
  dom[id] = $("##{id}") for id in ids
  # create media elements
  image = new js.Image(dom.image)
  drawing = new js.Stage(dom.drawing)
  # no media element is selected
  selected = null;
  
  # Deselects currently selected media element (if any) and clears entry fields
  deselect = => 
    selected.element.removeClass 'selected' if selected?
    selected = null;
    dom[id].val '' for id in entryIds
    
  # Selects a media element. Fills the entry fields with the element's current style's values
  select = (media) ->
    # update selection
    selected.element.removeClass 'selected' if selected?
    selected = media
    selected.element.addClass 'selected'
    # fill entry fields with proprerties of the selected media
    dom.top.val selected.top()
    dom.left.val selected.left()
    dom.width.val selected.width()
    dom.height.val selected.height()
    dom.margin.val js.Support.toString js.Css.shrink selected.margin()
    dom.padding.val js.Support.toString js.Css.shrink selected.padding()
    border = selected.border()
    dom.border_width.val js.Support.toString js.Css.shrink(border.width)
    dom.border_color.val js.Support.toString js.Css.shrink(border.color)
    dom.link.val selected.link()
    false # needed so that click event isn't passed on to the media
  
  # main body: initialize media, define interactions
  # draw a face
  eye1 = drawing.square().style({color:'blue'}).at({x:40, y:20}).side(40).label 'eye1'
  eye2 = drawing.square().style({color:'blue'}).at({x:120, y:20}).side(40).label 'eye2'
  points = [
    {x: 100, y: 80}
    {x: 110, y:140}
    {x:  90, y:140}
  ]
  nose = drawing.polygon().style({color:'green'}).points(points).label 'nose'
  mouth = drawing.circle().center({x:100, y:180}).radius(20)
  mouth.style({color:'yellow',stroke:{color:'green'}}).label 'mouth'
  drawing.draw()
  # originally, deselected media; clear all entry fields
  deselect()
  
  # Select media if its page element is clicked and link isn't being tested
  for media in [image, drawing]
    do (media) ->
      media.element.click (event) =>
        unless dom.test_links.is ':checked'
          select media
          # make sure that clicking media doesn't activate the link,
          # i.e., the media's click handler isn't used
          event.stopImmediatePropagation()
        # otherwise let the media handle the click
  
  # assign default links
  #   note: this must be done after the 'select media' code above
  image.link 'image_target.html'
  drawing.link 'drawing_target.html'
  
  # Deselects currently selected media element (if any), when when 
  # the user clicks outside of any media element
  dom.playground.click deselect
  
  # Changes position and size of the selected media element
  # when the user clicks "Set" next to top, left, width and height entries
  dom.set_area.click =>
    selected.top(Number dom.top.val()).left(Number dom.left.val())
      .width(Number dom.width.val()).height(Number dom.height.val())
  
  # Changes the width and the color of the border around the selected media element
  # when the user clicks "Set" next to border width and color entries
  dom.set_border.click =>
    width = js.Support.parse dom.border_width.val(), js.Css.arounds
    color = js.Support.parse dom.border_color.val(), js.Css.arounds
    border = {width:js.Css.toArounds(width), color:js.Css.toArounds(color)}
    selected.border border
  
  # Changes the margin around and the padding within the selected media element
  # when the user clicks "Set" next to layout margin and padding entries
  dom.set_layout.click =>
    # Implemented as part of Assignment 3
    margin = JS.Support.parse dom.margin.val(), JS.Css.arounds
    padding = JS.Support.parse dom.padding.val(), JS.Css.arounds
    selected.padding Js.Css.toArounds padding
    selected.margin Js.Css.toArounds margin

  # Changes the target page's URL of the selected media element
  # when the user clicks clicks "Set Link"
  dom.set_link.click =>
    # Implemented as part of Assignment 3
    selected.link dom.link.val()
