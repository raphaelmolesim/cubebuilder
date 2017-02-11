class CubeView.CardShow
  
  constructor: (@archetypesBadges, @searchArchetypes, @cubeView, @cubeId, @wishlistView) ->
    obj = this
    $('#card_list').on 'click', 'a.show_card', (e) -> obj.showCard(e)
  
  showCard: (e) ->    
    card_id = $(e.toElement).data('id')
    $.ajax
      method: 'GET'
      url: "/card/#{card_id}.json",
      dataType: "json"
    .done (response) => 
      response["wishlist"] = (response["id"] in @wishlistView.wishlist_ids)
      this.renderCard([response], deleteOption)

  renderCard: (cards, deleteOption) ->
    self = this
    if cards == '' or cards == 'null'
      return $('#card_list').html('Not Found')
    other_cards = cards.filter (c) -> c["id"] != cards[0]["id"]
    cards[0]["wishlist"] = (cards[0]["id"] in @wishlistView.wishlist_ids)
    self.archetypesBadges.cubeArchetypes (archetypes) => 
      text = HandlebarsTemplates['cube_builder/card_show'](
        card: cards[0],
        archetypes: archetypes,
        others: other_cards,
        delete_option: deleteOption
      )
      $('#card_list').html text