window.Colors = ['Black', 'Blue', 'Red', 'White', 'Green', 'Colorless', 'Multicolor', 'Land']

$ ->

  getCardInfo = (card_name) ->
    $.ajax
      method: 'GET'
      url: '/card/search'
      data: card_name: card_name
  
  addCard = (cube_list, card_id, cube_id, architype_id) ->
    cube_list.push { id: card_id, architypes: [architype_id] }
    localStorage.setItem 'cube_list', JSON.stringify(cube_list)
    $.ajax(
      method: 'PUT'
      url: '/cubes/' + cube_id,
      data: JSON.stringify(cube: cards: cube_list)
      contentType: 'application/json'
      dataType: 'json'
    ).done( ->
      $('#card_list').html ''
      renderCube cube_list
      loadArchitypes()
    ).fail (e) ->
      $('#card_list').html 'Error trying to save cube!'
  
  search_card = (card_name) ->
    getCardInfo(card_name).done (response) ->
      if response == ''
        return $('#card_list').html('Not Found')
      text = HandlebarsTemplates['cards/show'](
        card: JSON.parse(response),
        architypes: Window.architypes
      )
      $('#card_list').html text
  
  $('#search_card').on 'submit', (e) ->
    e.preventDefault()
    card_name = $('#card_name').val()
    search_card card_name
  		
  $('#card_list').on 'click', 'a.add-card', (e) ->
    card_id = $(e.toElement).data('cardid')
    architype_id = $(e.toElement).data('id') 
    cubeList = []
    if localStorage.cube_list != undefined
      cubeList = JSON.parse(localStorage.cube_list)
    cards = cubeList.map (c) -> c.architypes.map (a) -> "#{c.id}&#{a}"
    console.log([].concat.apply([], cards))
    console.log("#{card_id}&#{architype_id}")
    if not("#{card_id}&#{architype_id}" in [].concat.apply([], cards))
      addCard cubeList, card_id, $("#cubeId").html(), architype_id
    else
      $('#card_list').html "Already in the cube!"
        
  loadCube = (cubeList) ->
    $.ajax
      method: 'GET'
      url: '/card/cube_load'
      data: id: parseInt($("#cubeId").html())
  
  renderCube = (cubeList) ->
    loadCube(cubeList).done (response) ->
      json_response = JSON.parse(response)
      colors_without_lands = window.Colors[0..(window.Colors.length - 2)]
      spellsLenghts = (json_response[c]['Spells'].length for c in colors_without_lands)
      creatureLenghts = (json_response[c]['Creatures'].length for c in colors_without_lands)
      array.sort((a, b) -> b - a) for array in [creatureLenghts, spellsLenghts]
      json_response['SpellsMaxLength'] = spellsLenghts[0]
      json_response['CreaturesMaxLength'] = creatureLenghts[0]
      text = HandlebarsTemplates['cards/cube'](json_response)
      $('#cube').html text
  
  if localStorage.cube_list != undefined
    renderCube JSON.parse(localStorage.cube_list)
    
  loadArchitypes = ->
    $.ajax
      method: 'GET'
      url: '/architypes.json'
     .done (response )->
       Window.architypes = response
       text = HandlebarsTemplates['cards/architype'](response)
       $('#architypes').html text
       
  loadArchitypes() 