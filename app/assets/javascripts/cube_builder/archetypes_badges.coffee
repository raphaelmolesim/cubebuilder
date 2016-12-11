class CubeBuilder.ArchetypesBadges
  
  constructor: (@cubeId, @searchArchetypes) ->
    
  cubeArchetypes: () ->
    result = @searchArchetypes.all (archetypes) => archetypes.filter (a) => @cubeId in a.cube_ids 
    console.log(result)
    result
    
  renderCubeBadges: (archetypes) ->
    if (archetypes == undefined)
      archetypes = this.cubeArchetypes()
    text = HandlebarsTemplates['cube_builder/archetypes_badges'](archetypes)
    $('#archetypes').html text
    
    