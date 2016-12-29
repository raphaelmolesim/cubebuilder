class CubeBuilder.ArchetypesBadges
  
  constructor: (@cubeId, @searchArchetypes, @cubeView) ->
    self = this
    $('#archetypes').on 'click', 'a.remove-archetype', (e) -> self.removeArchetype(e)
    
  cubeArchetypes: (callback) ->
    self = this
    @searchArchetypes.all (archetypes) -> 
      myArchetypes = archetypes.filter (a) -> self.cubeId in a.cube_ids 
      callback(myArchetypes)
  
  loadArchetype: (archetypes) ->
    self = this
    if (archetypes == undefined)
      this.cubeArchetypes( (archetypes) -> self.renderCubeBadges(archetypes) )
    else
      self.renderCubeBadges(archetypes)
    
  renderCubeBadges: (archetypes) ->
    archetypesByPlayers = {}
    archetypes.forEach (archetype) =>
      archetype_config = archetype.cubes_config.filter (config) => config["cube_id"] == @cubeId
      archetypesByPlayers[archetype_config[0]["cube_players"]] ||= []
      archetypesByPlayers[archetype_config[0]["cube_players"]].push(archetype)
    text = HandlebarsTemplates['cube_builder/archetypes_badges'](archetypesByPlayers)
    $('#archetypes').html text
  
  removeArchetype: (e) ->
    self = this
    archetypeId = $(e.target).data("id")
    $.ajax
      method: 'PUT'
      url: "/cubes/#{@cubeId}/remove_archetype"
      data: archetype_id: archetypeId
      dataType: "json"
     .done (response) =>
       @searchArchetypes.allArchetypes = undefined
       @searchArchetypes.all (allArchetypes) =>
         myArchetypes = allArchetypes.filter (a) => @cubeId in a.cube_ids
         self.renderCubeBadges(myArchetypes)
         self.cubeView.render()
  
  refresh: () ->
    @searchArchetypes.allArchetypes = undefined