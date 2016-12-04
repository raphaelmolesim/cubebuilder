class Archetypes
    
  fetch: (action) ->
    obj = this
    if (@archetypes == undefined)
      $.ajax
        method: 'GET'
        url: '/archetypes.json'
       .done (response) ->
         obj.archetypes = response
         action(obj.archetypes)
    else
      console.log("Already defined!!")
      action(obj.archetypes)
      
  mapArchetypes: ->
    hash = {}
    this.fetch (archetypes) ->
      archetypes.forEach (a) -> hash[a.id] = a.cards.map((c) -> c.id)
    hash

class CubeEditorPage
  
  constructor: () ->
    Window.archetypes = new Archetypes()
    @addCard = new Window.AddCardInArchetype()
    
  renderArchetypes: () ->
    Window.archetypes.fetch (archetypes) ->
      text = HandlebarsTemplates['cards/archetype'](archetypes)
      $('#archetypes').html text
      
$().ready ->
  Window.cube = new CubeEditorPage()
  Window.cube.renderArchetypes()