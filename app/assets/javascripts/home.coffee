window.Colors = ['Black', 'Blue', 'Red', 'White', 'Green', 'Colorless', 'Multicolor', 'Land']

$ ->

  getCardInfo = (card_name) ->
    $.ajax
      method: 'GET'
      url: '/card/search'
      data: card_name: card_name
  
  addCard = (cubeList, cubeId) ->
    localStorage.setItem 'cube_list', JSON.stringify(cubeList)
    $.ajax(
      method: 'PUT'
      url: '/cubes/' + cubeId,
      data: JSON.stringify(cube: cards: cubeList)
      contentType: 'application/json'
      dataType: 'json'
    ).done( ->
      $('#card_list').html ''
      renderCube cubeList
    ).fail (e) ->
      $('#card_list').html 'Error trying to save cube!'
  
  search_card = (card_name) ->
    getCardInfo(card_name).done (response) ->
      if response == ''
        return $('#card_list').html('Not Found')
      text = HandlebarsTemplates['cards/show'](JSON.parse(response))
      $('#card_list').html text
  
  $('#search_card').on 'submit', (e) ->
    e.preventDefault()
    card_name = $('#card_name').val()
    search_card card_name
  		
  $('#card_list').on 'click', 'a.add-card', (e) ->
    card_id = $(e.toElement).data('id')
    cubeList = []
    if localStorage.cube_list != undefined
      cubeList = JSON.parse(localStorage.cube_list)
    if not(card_id in cubeList)
      cubeList.push card_id 
      addCard cubeList, $("#cubeId").html()
  
  loadCube = (cubeList) ->
    $.ajax
      method: 'GET'
      url: '/card/cube_load'
      data: cards_ids: cubeList
  
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
    
  loadArchitypes = () ->
    $.ajax
      method: 'GET'
      url: '/architypes.json'
     .done (response )->
       text = HandlebarsTemplates['cards/architype'](response)
       $('#architypes').html text
       
  loadArchitypes()