Handlebars.registerHelper 'json', (context) ->
  JSON.stringify context
	
cubeSafeGet = (cube, color, type, index) -> 
  if color == 'Land'
    if cube[color].length > index
      cube[color][index].name 
    else 
      ''
  else if cube[color][type].length > index
    new Handlebars.SafeString(HandlebarsTemplates['cards/cell'](cube[color][type][index]))
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