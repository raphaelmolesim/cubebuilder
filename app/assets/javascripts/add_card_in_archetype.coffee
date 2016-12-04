class AddCardInArchetype
  
  constructor: () ->
    @archetypes = Window.archetypes.mapArchetypes()
    obj = this
    $('#card_list').on 'click', 'a.add-card', (e) -> obj.addCard(e)
  
  addCard: (e) ->
    $element = $(e.toElement)
    cardId = parseInt $element.data('card')
    archetypeId = $element.data('id') 
    console.log("oioio")
    console.log(@archetypes)
    cardList = @archetypes[archetypeId] or []
    
    if not (cardId in cardList)
      this.save(cardId, archetypeId)
    else
      $('#card_list').html "Already in #{$element.html()}"
  
  save: (cardId, archetypeId) ->
    $.ajax(
      method: 'PUT'
      url: "/archetypes/#{archetypeId}/add_card"
      data: JSON.stringify(card_id: cardId)
      contentType: 'application/json'
      dataType: 'json'
    ).done( ->
      @archetypes[archetypeId] ||= []
      @archetypes[archetypeId].push(cardId)
      $('#card_list').html ''
      #renderCube cube_list
      #loadArchitypes()
    ).fail (e) ->
      $('#card_list').html 'Error trying to save!'

Window.AddCardInArchetype = AddCardInArchetype