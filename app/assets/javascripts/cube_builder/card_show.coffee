class CubeBuilder.CardShow
  
  constructor: (@archetypesBadges, @searchArchetypes, @cubeView, @cubeId, @wishlistView) ->
    obj = this
    $('#card_list').on 'click', 'a.add-card', (e) -> obj.addCard(e)
    $('#card_list').on 'click', 'a.show_card', (e) -> obj.showCard(e)
    $('#card_list').on 'click', 'a.remove-card', (e) -> obj.removeCard(e)
    $('#cube').on 'click', 'a.show_card', (e) -> obj.showCard(e, true)
    $('#card_list').on 'click', 'a.show_card', (e) -> obj.showCard(e, true)
    $('#card_list').on 'change', '.add-wishlist', (e) -> obj.addWishlist(e)
  
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
      @cubeView.render()
      @archetypesBadges.renderCubeBadges()
    .fail (e) ->
      $('#card_list').html 'Error trying to save!'

  showCard: (e, deleteOption) ->    
    card_id = $(e.toElement).data('id')
    $.ajax
      method: 'GET'
      url: "/card/#{card_id}.json",
      dataType: "json"
    .done (response) => 
      this.renderCard([response], deleteOption)

  renderCard: (cards, deleteOption) ->
    self = this
    if cards == '' or cards == 'null'
      return $('#card_list').html('Not Found')
    other_cards = cards.filter (c) -> c["id"] != cards[0]["id"]
    text = HandlebarsTemplates['cube_builder/card_show'](
      card: cards[0],
      archetypes: self.archetypesBadges.cubeArchetypes(),
      others: other_cards,
      delete_option: deleteOption
    )
    $('#card_list').html text
      
  removeCard: (e) ->    
   card_id = $(e.toElement).data('card')
   archetype_id = $(e.toElement).data('archetype')
   $.ajax
     method: 'DELETE'
     url: "/archetypes/#{archetype_id}/remove_card"
     data: JSON.stringify(card_id: card_id)
     contentType: 'application/json'
     dataType: 'json'
   .done =>
     @cubeView.render()
     @archetypesBadges.refresh()
     @archetypesBadges.renderCubeBadges()
     $('#card_list').html "Removed from group"
   .fail (e) ->
     $('#card_list').html 'Error trying to save cube!'

  addWishlist: (e) ->
    card_id = $(e.target).data('id')
    remove = not e.target.checked
    $.ajax
      method: 'POST'
      url: "/cubes/#{@cubeId}/set_wishlist"
      data: { "card_id" : card_id, "remove" : remove }
      dataType: 'json'
    .done (response) =>
      cell = $("a.show_card[data-id=#{card_id}]")
      @wishlistView.wishlist_ids.push (card_id)
      if (remove)
        cell.removeClass("wishlist")
      else
        cell.addClass("wishlist")    
