class CubeBuilder.SearchCard  
  
  constructor: (@archetypesBadges) ->
    $('#search_card').on 'submit', (e) =>
      e.preventDefault()
      card_name = $('#card_name').val()
      this.search_card card_name
  
  search_card: (card_name) ->
    self = this
    getCardInfo(card_name).done (response) ->
      if response == ''
        return $('#card_list').html('Not Found')
      result = JSON.parse(response)
      text = HandlebarsTemplates['cards/show'](
        card: result[0],
        archetypes: self.archetypesBadges.cubeArchetypes(),
        others: result.filter (c) -> c["id"] != result[0]["id"]
      )
      $('#card_list').html text
  
  getCardInfo = (card_name) ->
    $.ajax
      method: 'GET'
      url: '/card/search'
      data: card_name: card_name
  
  