window.Colors = ['Black', 'Blue', 'Red', 'White', 'Green', 'Colorless', 'Multicolor', 'Land']

$ ->

  getCardInfo = (card_name) ->
    $.ajax
      method: 'GET'
      url: '/card/search'
      data: card_name: card_name
      
  getCardInfoByID = (id) ->
    $.ajax
      method: 'GET'
      url: "/card/#{id}.js"
  
  search_card = (card_name) ->
    getCardInfo(card_name).done (response) ->
      if response == ''
        return $('#card_list').html('Not Found')
      result = JSON.parse(response)
      result.forEach (c) -> c["types_list"] = JSON.parse(c["types_list"])
      console.log(Window.archetypes.archetypes)
      text = HandlebarsTemplates['cards/show'](
        card: result[0],
        archetypes: Window.archetypes.archetypes,
        others: result.filter (c) -> c["id"] != result[0]["id"]
      )
      $('#card_list').html text
  
  #$('#search_card').on 'submit', (e) ->
  #  e.preventDefault()
  #  card_name = $('#card_name').val()
  #  search_card card_name
  
  #$('#card_list').on 'click', 'a.show_card', (e) ->
  #  card_id = $(e.toElement).data('id')
  #  $.ajax
  #    method: 'GET'
  #    url: "/card/#{card_id}.js",
  #    dataType: "json"
  #  .done (response) ->
  #    if response == ''
  #      return $('#card_list').html('Not Found')  
  #    response["types_list"] = JSON.parse(response["types_list"])
  #    console.log(Window.archetypes.archetypes)
  #    text = HandlebarsTemplates['cards/show'](
  #      card: response,
  #      archetypes: Window.archetypes.archetypes
  #    )
  #    $('#card_list').html text
  
  $('#cube').on 'click', 'a.show_card', (e) ->
    card_id = $(e.toElement).data('id')
    $.ajax
      method: 'GET'
      url: "/card/#{card_id}.js",
      dataType: "json"
    .done (response) ->
      if response == ''
        return $('#card_list').html('Not Found')  
      response["types_list"] = JSON.parse(response["types_list"])
      text = HandlebarsTemplates['cards/show'](
        card: response,
        archetypes: Window.archetypes.archetypes
        delete_option: true
      )
      $('#card_list').html text
  
  removeCard = (cube_id, cube_list, card_id) ->
    console.log(" --> #{card_id} ")
    cube_list = cube_list.filter (item) -> 
        item.id != card_id;    
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
  
  $('#card_list').on 'click', 'a.remove-card', (e) ->
    cube_list = JSON.parse(localStorage.cube_list)
    card_id = $(e.toElement).data('cardid')
    cube_id = $("#cubeId").html()
    removeCard(cube_id, cube_list, card_id).done ->
      renderCube(cube_list)
      $('#card_list').html "Removed from group"
    
  addToWishlist = (card_id, remove) ->
    $.ajax
      method: 'POST'
      url: '/cubes/set_wishlist'
      data: { "card_id" : card_id, "remove" : remove }
      dataType: 'json'
  
  $('#card_list').on 'change', '.add-wishlist', (e) ->
    card_id = $(e.target).data('id')
    remove = not this.checked
    addToWishlist(card_id, remove)
    .done (response) ->
      cell = $("a.show_card[data-id=#{card_id}]")
      if (remove)
        cell.removeClass("wishlist")
      else
        cell.addClass("wishlist")
    
    
  $('#archetypes').on 'click', 'a.list-archetype', (e) ->  
    el = $(e.toElement)  
    archetype_id = parseInt(el.data('id'))
    cubeList = JSON.parse(localStorage.cube_list)
    list_cmc = {}
    list_type = { "Creatures" : [], "Spells" : [], "Lands" : [] }
    cubeList.forEach (card) ->
      if (archetype_id in card["archetypes"])
        cell = $("a.show_card[data-id=#{card["id"]}]")
        card_name = cell.html()
        cmc = cell.next().html()
        type = cell.data("type")
        if cmc == undefined
          cmc = 0
        list_cmc[cmc] ||= []
        list_cmc[cmc].push(card_name)
        if ("Creature" in type)
          list_type["Creatures"].push(card_name)
        else if ("Land" in type)
          list_type["Lands"].push(card_name)
        else
          list_type["Spells"].push(card_name)
    text = HandlebarsTemplates['archetypes/list']({ archetype: el.html(), cards_by_cmc: list_cmc, cards_by_type: list_type })
    $('#dialog').html text
    $('#archetype_list').modal({})
  
  $("#show_wishlist").click ->
    wishlist = []
    Window.wishlist.forEach (id) ->
      cell = $("a.show_card[data-id=#{id}]")
      card_name = cell.html()
      console.log(card_name)
      wishlist.push(card_name)
    text = HandlebarsTemplates['cards/wishlist']({ wishlist:  wishlist})
    $('#dialog').html text
    $('#wishlist').modal({})
    
        
  loadCube = (cubeList) ->
    $.ajax
      method: 'GET'
      url: '/card/cube_load'
      data: id: parseInt($("#cubeId").html())
  
  renderCube = (cubeList) ->
    loadCube(cubeList).done (response) ->
      loadWishlist ->
        json_response = JSON.parse(response)
        colors_without_lands = window.Colors[0..(window.Colors.length - 2)]
        spellsLenghts = (json_response[c]['Spells'].length for c in colors_without_lands)
        spellsLenghts.push(Math.floor(json_response['Land'].length / 2))
        creatureLenghts = (json_response[c]['Creatures'].length for c in colors_without_lands)
        creatureLenghts.push(Math.ceil(json_response['Land'].length / 2))
        array.sort((a, b) -> b - a) for array in [creatureLenghts, spellsLenghts]
        json_response['SpellsMaxLength'] = spellsLenghts[0]
        json_response['CreaturesMaxLength'] = creatureLenghts[0]
        text = HandlebarsTemplates['cards/cube'](json_response)
        $('#cube').html text
  
  restoreCube = ->
    $.ajax
      method: 'GET'
      url: '/home/restore_LocalStorage'
    .done (response) ->
      localStorage.setItem 'cube_list', JSON.stringify(response)
      renderCube()
  
  restoreCube()
  
  loadWishlist = (func) ->
    $.ajax
      method: 'GET'
      url: '/cubes/wishlist'
      data: id: parseInt($("#cubeId").html())
     .done (response )->
       Window.wishlist = response
       func.call()
