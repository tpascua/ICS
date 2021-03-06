window.js ?= {} # Create js namespace if it doesn't exist
class window.js.Color
  
  Color.colors = [
    {hex: "#f0f8ff" , name: "AliceBlue"}
    {hex: "#faebd7" , name: "AntiqueWhite"}
    {hex: "#00ffff" , name: "Aqua"}
    {hex: "#7fffd4" , name: "Aquamarine"}
    {hex: "#f0ffff" , name: "Azure"}
    {hex: "#f5f5dc" , name: "Beige"}
    {hex: "#ffe4c4" , name: "Bisque"}
    {hex: "#000000" , name: "Black"}
    {hex: "#ffebcd" , name: "BlanchedAlmond"}
    {hex: "#0000ff" , name: "Blue"}
    {hex: "#8a2be2" , name: "BlueViolet"}
    {hex: "#a52a2a" , name: "Brown"}
    {hex: "#deb887" , name: "BurlyWood"}
    {hex: "#5f9ea0" , name: "CadetBlue"}
    {hex: "#7fff00" , name: "Chartreuse"}
    {hex: "#d2691e" , name: "Chocolate"}
    {hex: "#ff7f50" , name: "Coral"}
    {hex: "#6495ed" , name: "CornflowerBlue"}
    {hex: "#fff8dc" , name: "Cornsilk"}
    {hex: "#dc143c" , name: "Crimson"}
    {hex: "#00ffff" , name: "Cyan"}
    {hex: "#00008b" , name: "DarkBlue"}
    {hex: "#008b8b" , name: "DarkCyan"}
    {hex: "#b8860b" , name: "DarkGoldenrod"}
    {hex: "#a9a9a9" , name: "DarkGray"}
    {hex: "#006400" , name: "DarkGreen"}
    {hex: "#bdb76b" , name: "DarkKhaki"}
    {hex: "#8b008b" , name: "DarkMagenta"}
    {hex: "#556b2f" , name: "DarkOliveGreen"}
    {hex: "#ff8c00" , name: "DarkOrange"}
    {hex: "#9932cc" , name: "DarkOrchid"}
    {hex: "#8b0000" , name: "DarkRed"}
    {hex: "#e9967a" , name: "DarkSalmon"}
    {hex: "#8fbc8f" , name: "DarkSeaGreen"}
    {hex: "#483d8b" , name: "DarkSlateBlue"}
    {hex: "#2f4f4f" , name: "DarkSlateGray"}
    {hex: "#00ced1" , name: "DarkTurquoise"}
    {hex: "#9400d3" , name: "DarkViolet"}
    {hex: "#ff1493" , name: "DeepPink"}
    {hex: "#00bfff" , name: "DeepSkyBlue"}
    {hex: "#696969" , name: "DimGray"}
    {hex: "#1e90ff" , name: "DodgerBlue"}
    {hex: "#b22222" , name: "FireBrick"}
    {hex: "#fffaf0" , name: "FloralWhite"}
    {hex: "#228b22" , name: "ForestGreen"}
    {hex: "#ff00ff" , name: "Fuchsia"}
    {hex: "#dcdcdc" , name: "Gainsboro"}
    {hex: "#f8f8ff" , name: "GhostWhite"}
    {hex: "#ffd700" , name: "Gold"}
    {hex: "#daa520" , name: "Goldenrod"}
    {hex: "#808080" , name: "Gray"}
    {hex: "#008000" , name: "Green"}
    {hex: "#adff2f" , name: "GreenYellow"}
    {hex: "#f0fff0" , name: "Honeydew"}
    {hex: "#ff69b4" , name: "HotPink"}
    {hex: "#cd5c5c" , name: "IndianRed"}
    {hex: "#4b0082" , name: "Indigo"}
    {hex: "#fffff0" , name: "Ivory"}
    {hex: "#f0e68c" , name: "Khaki"}
    {hex: "#e6e6fa" , name: "Lavender"}
    {hex: "#fff0f5" , name: "LavenderBlush"}
    {hex: "#7cfc00" , name: "LawnGreen"}
    {hex: "#fffacd" , name: "LemonChiffon"}
    {hex: "#add8e6" , name: "LightBlue"}
    {hex: "#f08080" , name: "LightCoral"}
    {hex: "#e0ffff" , name: "LightCyan"}
    {hex: "#fafad2" , name: "LightGoldenrodYellow"}
    {hex: "#90ee90" , name: "LightGreen"}
    {hex: "#d3d3d3" , name: "LightGrey"}
    {hex: "#ffb6c1" , name: "LightPink"}
    {hex: "#ffa07a" , name: "LightSalmon"}
    {hex: "#20b2aa" , name: "LightSeaGreen"}
    {hex: "#87cefa" , name: "LightSkyBlue"}
    {hex: "#778899" , name: "LightSlateGray"}
    {hex: "#b0c4de" , name: "LightSteelBlue"}
    {hex: "#ffffe0" , name: "LightYellow"}
    {hex: "#00ff00" , name: "Lime"}
    {hex: "#32cd32" , name: "LimeGreen"}
    {hex: "#faf0e6" , name: "Linen"}
    {hex: "#ff00ff" , name: "Magenta"}
    {hex: "#800000" , name: "Maroon"}
    {hex: "#66cdaa" , name: "MediumAquamarine"}
    {hex: "#0000cd" , name: "MediumBlue"}
    {hex: "#ba55d3" , name: "MediumOrchid"}
    {hex: "#9370db" , name: "MediumPurple"}
    {hex: "#3cb371" , name: "MediumSeaGreen"}
    {hex: "#7b68ee" , name: "MediumSlateBlue"}
    {hex: "#00fa9a" , name: "MediumSpringGreen"}
    {hex: "#48d1cc" , name: "MediumTurquoise"}
    {hex: "#c71585" , name: "MediumVioletRed"}
    {hex: "#191970" , name: "MidnightBlue"}
    {hex: "#f5fffa" , name: "MintCream"}
    {hex: "#ffe4e1" , name: "MistyRose"}
    {hex: "#ffe4b5" , name: "Moccasin"}
    {hex: "#ffdead" , name: "NavajoWhite"}
    {hex: "#000080" , name: "Navy"}
    {hex: "#fdf5e6" , name: "OldLace"}
    {hex: "#808000" , name: "Olive"}
    {hex: "#6b8e23" , name: "OliveDrab"}
    {hex: "#ffa500" , name: "Orange"}
    {hex: "#ff4500" , name: "OrangeRed"}
    {hex: "#da70d6" , name: "Orchid"}
    {hex: "#eee8aa" , name: "PaleGoldenrod"}
    {hex: "#98fb98" , name: "PaleGreen"}
    {hex: "#afeeee" , name: "PaleTurquoise"}
    {hex: "#db7093" , name: "PaleVioletRed"}
    {hex: "#ffefd5" , name: "PapayaWhip"}
    {hex: "#ffdab9" , name: "PeachPuff"}
    {hex: "#cd853f" , name: "Peru"}
    {hex: "#ffc0cb" , name: "Pink"}
    {hex: "#dda0dd" , name: "Plum"}
    {hex: "#b0e0e6" , name: "PowderBlue"}
    {hex: "#800080" , name: "Purple"}
    {hex: "#ff0000" , name: "Red"}
    {hex: "#bc8f8f" , name: "RosyBrown"}
    {hex: "#4169e1" , name: "RoyalBlue"}
    {hex: "#8b4513" , name: "SaddleBrown"}
    {hex: "#fa8072" , name: "Salmon"}
    {hex: "#f4a460" , name: "SandyBrown"}
    {hex: "#2e8b57" , name: "SeaGreen"}
    {hex: "#fff5ee" , name: "Seashell"}
    {hex: "#a0522d" , name: "Sienna"}
    {hex: "#c0c0c0" , name: "Silver"}
    {hex: "#87ceeb" , name: "SkyBlue"}
    {hex: "#6a5acd" , name: "SlateBlue"}
    {hex: "#708090" , name: "SlateGray"}
    {hex: "#fffafa" , name: "Snow"}
    {hex: "#00ff7f" , name: "SpringGreen"}
    {hex: "#4682b4" , name: "SteelBlue"}
    {hex: "#d2b48c" , name: "Tan"}
    {hex: "#008080" , name: "Teal"}
    {hex: "#d8bfd8" , name: "Thistle"}
    {hex: "#ff6347" , name: "Tomato"}
    {hex: "#40e0d0" , name: "Turquoise"}
    {hex: "#ee82ee" , name: "Violet"}
    {hex: "#f5deb3" , name: "Wheat"}
    {hex: "#ffffff" , name: "White"}
    {hex: "#f5f5f5" , name: "WhiteSmoke"}
    {hex: "#ffff00" , name: "Yellow"}
    {hex: "#9acd32" , name: "YellowGreen"}
  ]

  assign = (color) ->
    add = (color_) ->
      
    Color[color].name = (name_) ->
      if name_?
        for color_ in Color.colors 
          return Color[color_] if color_.name is name_
        null
      else color.name
    Color[color].hex = (hex_) ->
      if hex_?
        for color_ in Color.colors 
          return Color[color_] if color_.hex is hex_
        add {name:hex_, hex:hex_}
      else color.hex
    Color[color].rgb = (red, green, blue, opacity) ->
      if green? or (red? and (js.Support.type(red) is 'String'))
        if js.Support.type(red) is 'String'
        else  # assume red, green, blue are integers, opacity is decimal
      else
        rgbValues = "#{red},#{green},#{blue}"
        if opacity? then "rgba(#{rgbValues},#{opacity})" else "rgb(#{rgbValues})"
        
      assign color for color in Color.colors
          
        hexColor = ((256 + value.red) * 256 + value.green) * 256 + value.blue
        hexColor.toString(16).setCharAt 0, '#'
      value.hex = Color[color].toHex()
      Color.hexColors[value.hex] = color
      
      Color[color].toRgba = (opacity) ->
        
    Color.get = (value) -> 
      if value.startsWith '#'
        pattern = ///
         \#           # pound sign
         ([\w\d]{2})  # 2 hex digits for red
         ([\w\d]{2})  # 2 hex digits for green
         ([\w\d]{2})  # 2 hex digits for blue
        ///
        hexColors = value.match(pattern)[1..3]
        js.Support.fill hexColors, (number) -> parseInt number, 16
      else
        pattern = ///
         rgb[a]        # prefix
         \(            # (
         (\d+)         # digits for red
         ,(\d+)        # comma and digits for green
         ,(\d+)        # comma and digits for blue
         (?:           # begin optional group
         ,(\d*[\.]\d*) #  comma and decimal number for opacity
         )             # end optional group
         \)            # )
        ///
        rgba_
        
  init()
  console.log "#{JSON.stringify Color.hexColors, null, '  '}"
  test = ->
    console.log "Silver #{JSON.stringify Color.Silver}"
    console.log "SkyBlue #{JSON.stringify Color.SkyBlue}"
    console.log "SaddleBrown #{JSON.stringify Color.SaddleBrown}"
    for color, value of Color.colors
      #return if color is 'Black'
      rgb = Color[color].toRgba()
      opacity = Math.floor(100 * Math.random()) / 100
      rgba = Color[color].toRgba opacity
      #console.log "#{color} #{rgb} #{rgba}"
      console.log "name: \"#{color}\": hex: \"#{value.hex}\""
  test()
