# Supports loading classes observing their dependencies.
window.js ?= {} # Create JS namespace if it doesn't exist
class window.js.Script
  
  # Loads 'modules' in the correct order determined by their dependencies. 
  # 'modules' must be an object where each property specifies a module
  # and the modules which that module depends on. I.e. key of the property
  # must be the module's name and the value of the property must be an array
  # with names of modules which that module depends on.
  # If a modules doesn't depend on any other modules, but other modules
  # depend on it, it doesn't need to have a separate entry in 'modules'.
  # E.g. if there are modules M1 and M2, M1 depends on M2 and M3, and M2
  # depends on M3, 'modules' can have simply the form:
  # {M1:['M2','M3'], M2:['M3']}
  # Note that M3 occurs only in the dependencies arrays. 
  # All modules must be in JavaScript files with '.js' extention
  # located in 'javascripts' folder; their names must not have this extention.
  # It is recommended that your modules have a 'namespace'.
  Script.load = (modules, namespace) =>
    if namespace? # namespace supplied
      # add '.' if '.' isn't the last char of namespace already
      namespace += '.' unless '.' is namespace[length - 1]
    else namespace = ''
    scheduled = {}
    
    # Once a 'loaded' module has been successfully loaded
    # (or if 'loaded' is missing at the beginning), updates 'modules'
    # and initiates loading of all modules that don't depend on any
    # modules still not loaded.
    # If all modules are loaded runs onAllLoaded()
    # Shows alert if a module couldn't be found or if there are circular
    # dependencies in the modules (Note: an error should be thrown instead.)
    onNext = (loaded) ->
      # delete every mention of 'loaded' module 
      if loaded?
        delete modules[loaded]
        delete scheduled[loaded]
        (needs.splice i, 1 if need is loaded) for need, i in needs for _, needs of modules
      # request loading of all independent modules (who have no 'needs')
      for module, needs of modules
        unless scheduled[module]? or (needs.length > 0)
          scheduled[module] = module
          $.when(loadScript module).done(onNext).fail(onFail)
      # check whether there are circular dependencies, i.e., there are 
      # no modules scheduled to load but some still remain to be loaded
      if empty(scheduled) and (modules.length > 0)
        remaining = []
        remaining.push module for module in modules
        alert "Can't load module(s) '#{remaining.join(', ')}' because of circular dependencies"
    
    # Loads asynchronously a script from 'path'.
    # Obeys deferred/promise contract.
    # Note: Unlike jQuery getScript(), doesn't remove the <script> element from
    # the web page so that the loaded script is available in the browser's debugger. 
    loadScript = (module) ->
      result = $.Deferred()
      onReady = (_, isAbort) ->
        if (not script.readyState or /loaded|complete/.test(script.readyState))
          if isAbort then result.reject module else result.resolve module
      path = "./javascripts/#{namespace}#{module}.js"
      script = $('<script>').prop({type:'text/javascript', src:path, async:'async'})
      script.on('load', onReady).on('readystatechange', onReady).on('error', -> result.reject module)
      $('head')[0].appendChild script[0]
      #$('head').append script
      return result.promise()
    
    # Reports a missing module.
    # Note: an error should be thrown instead.
    onFail = (module) -> alert "Module '#{module}' couldn't be loaded"
    
    # Returns whether 'object' has no properties.
    empty = (object) ->
      return false for key of object
      true
    
    # main body of loadThenRun()
    # add all modules only mentioned as dependencies in other modules' needs
    # to 'modules', obviously, they'll have no 'needs' dependencies
    (modules[need] = [] unless modules[need]?) for need in needs for _, needs of modules
    # start loading
    onNext()