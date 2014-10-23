# Bitmap mage media element.
# Note: Currently no image-specific functionality is supported.
# Later on, URL should be supported.
# Potential future image-specific functionality:
# URL property, preloading of images, sprites, cropping, coloring, ...

window.js ?= {} # Create js namespace if it doesn't exist
class window.js.Image extends js.Media

  # Makes a new image.
  constructor: (element) -> super element
    
  # Returns the description of this stage.
  toString: -> 'image'
