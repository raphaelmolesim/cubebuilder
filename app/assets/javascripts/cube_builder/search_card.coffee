class CubeBuilder.SearchCard  
  
  constructor: (@archetypesBadges) ->
    $('#search_card').on 'submit', (e) =>
      e.preventDefault()
      card_name = $('#card_name').val()
      this.search_card card_name
  
  search_card: (card_name) ->
    self = this
    getCardInfo(card_name).done (response) ->
      result = JSON.parse(response)
      self.renderCard(result)
    
  renderCard: (cards) ->
    self = this
    if cards == '' or cards == 'null'
      return $('#card_list').html('Not Found')
    text = HandlebarsTemplates['cards/show'](
      card: cards[0],
      archetypes: self.archetypesBadges.cubeArchetypes(),
      others: cards.filter (c) -> c["id"] != cards[0]["id"]
    )
    $('#card_list').html text
  
  getCardInfo = (card_name) ->
    $.ajax
      method: 'GET'
      url: '/card/search'
      data: card_name: card_name
  
  