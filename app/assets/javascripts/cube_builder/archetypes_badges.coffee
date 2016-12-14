class CubeBuilder.ArchetypesBadges
  
  constructor: (@cubeId, @searchArchetypes, @cubeView) ->
    self = this
    $('#archetypes').on 'click', 'a.remove-archetype', (e) -> self.removeArchetype(e)
    
  cubeArchetypes: () ->
    @searchArchetypes.all (archetypes) => archetypes.filter (a) => @cubeId in a.cube_ids 
    
  renderCubeBadges: (archetypes) ->
    if (archetypes == undefined)
      archetypes = this.cubeArchetypes()
    text = HandlebarsTemplates['cube_builder/archetypes_badges'](archetypes)
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
         cubeArchetypes = allArchetypes.filter (a) => @cubeId in a.cube_ids
         self.renderCubeBadges(cubeArchetypes)
         self.cubeView.render()