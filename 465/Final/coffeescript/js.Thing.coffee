###
Made for Assignment 3
Extends the stage class and makes a drawing
###

window.js ?= {} # Create js namespace if it doesn't exist
class window.js.Thing extends window.js.Stage
  constructor: (canvas) ->
    super canvas
    
  