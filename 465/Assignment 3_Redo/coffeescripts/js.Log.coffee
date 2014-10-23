window.js ?= {} # Create js namespace if it doesn't exist
class window.js.Log
  
  constructor: -> @texts = []
  
  add: (name, value, indent) =>
    #triplets = Array::slice.call arguments
    type = js.Support.type arguments[0]
    if type is 'Array'
      triplets = Array::slice.call arguments
    else triplets = [[name, value, indent]] 
    for triplet in triplets
      [name, value, indent] = triplet
      if js.Support.type value in ['Object', 'Array']
        if indent? then value = JSON.stringify value, null, indent
        else value = JSON.stringify value
        @texts.push "#{name}=#{value.replace /\"([\w-]+?)\":/g, '$1:'}"
    @
    
  log: (name, value, indent) =>
    if name?
      if value?
        if indent? then lAdd name, value, indent else lAdd name, value
      else
        @texts[i] = "  #{text}" for text, i in @texts
        @texts.unshift "#{name}="
    console.log @texts.join '\n'
    @texts = []

  log = new Log()
  [window.log, window.lAdd] = [log.log, log.add]