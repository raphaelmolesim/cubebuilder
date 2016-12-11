class CubeBuilder.CardShow
  
  constructor: (@archetypesBadges, @searchArchetypes, @searchCard) ->
    obj = this
    $('#card_list').on 'click', 'a.add-card', (e) -> obj.addCard(e)
    $('#card_list').on 'click', 'a.show_card', (e) -> obj.show_card(e)
  
  createHashMap: (archetypesList) ->
    archetypesHashMap = {}
    archetypesList.forEach (archetype) ->
      archetype.cards.forEach (card) ->
        archetypesHashMap[archetype.id] ||= []
        archetypesHashMap[archetype.id].push card.id
    archetypesHashMap

  addCard: (e) ->
    @archetypes = this.createHashMap(@archetypesBadges.cubeArchetypes())
    $element = $(e.toElement)
    cardId = parseInt $element.data('card')
    archetypeId = $element.data('id') 
    console.log("oioio")
    console.log(@archetypes)
    Window.element = @archetypes
    cardList = @archetypes[archetypeId] or []
    
    if not (cardId in cardList)
      this.save(cardId, archetypeId)
    else
      $('#card_list').html "Already in #{$element.html()}"
  
  save: (cardId, archetypeId) ->
    $.ajax
      method: 'PUT'
      url: "/archetypes/#{archetypeId}/add_card"
      data: JSON.stringify(card_id: cardId)
      contentType: 'application/json'
      dataType: 'json'
    .done (response) =>
      @searchArchetypes.refresh_archetype(response)
      $('#card_list').html ''
      #renderCube cube_list
      #loadArchitypes()
    .fail (e) ->
      $('#card_list').html 'Error trying to save!'

  show_card: (e) ->    
    card_id = $(e.toElement).data('id')
    $.ajax
      method: 'GET'
      url: "/card/#{card_id}.json",
      dataType: "json"
    .done (response) => 
      @searchCard.renderCard ([response])
