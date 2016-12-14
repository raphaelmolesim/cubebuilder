class CubeBuilder.SearchCard  
  
  constructor: (@archetypesBadges, @searchArchetypes) ->
    $('#search_card').on 'submit', (e) =>
      e.preventDefault()
      card_name = $('#card_name').val()
      this.search_card card_name
  
  search_card: (card_name) ->
    self = this
    getCardInfo(card_name).done (response) ->
      result = JSON.parse(response)
      self.searchArchetypes.renderCard(result, false)
  
  getCardInfo = (card_name) ->
    $.ajax
      method: 'GET'
      url: '/card/search'
      data: card_name: card_name
  
  