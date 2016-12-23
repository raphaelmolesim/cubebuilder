class CubeBuilder.CubeView

  constructor: (@cubeId, @wishlistView) ->

  loadCube: (cubeId) ->
    $.ajax
      method: 'GET'
      url: "cubes/#{cubeId}/view"
      dataType: "json"

  renderCube: (json_response) -> 
    colors_without_lands = window.Colors[0..(window.Colors.length - 2)]
    
    spellsLenghts = (json_response[c]['Spells'].length for c in colors_without_lands)
    spellsLenghts.push(Math.floor(json_response['Land'].length / 2))
    
    creatureLenghts = (json_response[c]['Creatures'].length for c in colors_without_lands)
    creatureLenghts.push(Math.ceil(json_response['Land'].length / 2))
    
    array.sort((a, b) -> b - a) for array in [creatureLenghts, spellsLenghts]
    
    json_response['SpellsMaxLength'] = spellsLenghts[0]
    json_response['CreaturesMaxLength'] = creatureLenghts[0]
    
    text = HandlebarsTemplates['cube_builder/cube_view'](json_response)
    $('#cube').html text
    
  render: () ->
    this.loadCube(@cubeId).done (response) =>
      @cubeView = response
      this.renderCube(@cubeView)
      @wishlistView.addClassInWishlist(@wishlistView.wishlist_ids)
    