Handlebars.registerHelper 'json', (context) ->
  JSON.stringify context
	
cubeSafeGet = (cube, color, type, index) -> 
  if color == 'Land'
    first_half = (type == "Spells")
    index = if (first_half) then index else Math.floor((cube[color].length / 2)) + index
    console.log(index)
    if cube[color].length > index
      new Handlebars.SafeString(HandlebarsTemplates['cube_builder/cell_view'](cube[color][index]))      
    else 
      ''
  else if cube[color][type].length > index
    if (cube[color][type][index] != undefined and cube[color][type][index] != null)
      id = cube[color][type][index]["id"]
    new Handlebars.SafeString(HandlebarsTemplates['cube_builder/cell_view'](cube[color][type][index]))
  else
    ''
	
Handlebars.registerHelper 'cubeIterator', (from, to, incr, type, block) ->
  html = ''
  data = Handlebars.createFrame(block.data)
  i = from
  while i < to
    data.index = i
    data.row = {} 
    data.row[c] = cubeSafeGet(this, c, type, i) for c in window.Colors
    html += block.fn(this, data: data)
    i += incr
  html