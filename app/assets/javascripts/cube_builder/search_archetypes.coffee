class CubeBuilder.SearchArchetypes

  constructor: (@cubeId, @cubeView) ->
    
  load: (callback) ->
    self = this
    self.all (archetypes) ->
      $( "#archetype_search" ).autocomplete
        select: (event, ui) ->
          archetypeId = parseInt(ui.item.value)
          self.add_archetype(archetypeId, self.cubeId)
          $( "#archetype_search" ).val ""
          false 
        source: archetypes.map (item) -> value: item.id, label: item.name
      callback()
  
  all: (action) ->
    self = this
    if (@allArchetypes == undefined)
      $.ajax
        method: 'GET'
        url: '/archetypes.json'
      .done (response) ->
        self.allArchetypes = response
        action(self.allArchetypes)
    else
      action(self.allArchetypes)  
  
  add_archetype: (archetypeId, cubeId) ->
    self = this
    $.ajax
      method: 'PUT'
      url: "/cubes/#{cubeId}/add_archetype"
      data: archetype_id: archetypeId
      dataType: "json"
     .done (response) ->
       self.allArchetypes = undefined
       self.all (allArchetypes) =>
         myArchetypes = allArchetypes.filter (a) => self.cubeId in a.cube_ids
         self.archetypesBadges.loadArchetype(myArchetypes)
         self.cubeView.render()
       
  refresh_archetype: (archetype) ->
    index = @allArchetypes.findIndex (a) => a.id == archetype.id
    @allArchetypes[index] = archetype
    